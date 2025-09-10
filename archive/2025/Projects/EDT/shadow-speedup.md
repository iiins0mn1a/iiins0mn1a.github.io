# From GPT-5
我将先快速查证 Shadow 的当前能力（是否支持 UDP/QUIC、如何运行真实二进制、配置示例），以便给你准确可落地的方案和限制说明。随后给出将以太坊客户端放入 Shadow 的具体步骤与配置要点。

### 结论先讲
- 二进制级离散事件网络模拟，用 Shadow 很合适，但对 Go 静态二进制（geth、prysm）兼容性差；Shadow最稳的是“动态链接到 glibc 的应用”（C/C++/Java/Node/Rust 等多数栈）。
- 想把“以太坊客户端+网络”一起放进 Shadow 做高倍速/可重放的实验，建议优先选 Java/Rust/Node 系的客户端（如 Teku/Besu、Lighthouse、Lodestar）。这能真正享受离散事件调度带来的“非实时超速+确定性重放”。
- 若坚持用 Go 客户端，需要深度改造（让所有网络/时间调用走可拦截路径），成本很高，不是 Shadow 的“即插即用”路径。

### Shadow 是什么（工作方式与能力）
- 核心机制：用预加载的“shim”库（LD_PRELOAD）拦截应用的网络/计时相关函数（connect/send/recv/epoll/clock_gettime/nanosleep 等），把它们重定向到 Shadow 的离散事件内核。应用“不知道自己在被模拟”，仍按正常 API 编程。
- 离散事件调度：不按真实时钟推进，事件队列驱动“虚拟时间”；只要 CPU 跑得动，速度可远超实时，并且可确定性重放（同一输入→同一输出）。
- 网络模型：可配置拓扑、带宽、延迟、丢包、队列；TCP/UDP 都可重定向。QUIC 在 UDP 之上，UDP I/O 会被控制，但计时器与 pacing 是否完全进入“虚拟时间”取决于计时 API 能否被拦截（与语言/运行时有关）。
- 兼容性硬约束：
  - 动态链接、走 libc/系统调用路径的应用最佳。
  - 静态链接、Go 运行时直接发 syscalls、vDSO/单调时钟绕过 libc 的情况，会显著降低可拦截性（时间与 I/O可能无法进入“虚拟时间”）。

### 放进 Shadow 跑“以太坊”的可行性矩阵
- 强推荐（易用/高成功率）
  - 共识层：Teku（Java）、Lodestar（Node.js）、Lighthouse（Rust，尽量动态链接 glibc）。
  - 执行层：Besu（Java）。或用“假/内置 Engine API stub”，避免跑完整 EL。
- 可能可行（需验证）
  - Nethermind（.NET）：通常走 libc/套接字，Shadow 能拦截，但需要确认 JIT/线程调度带来的时序非确定性如何影响重放。
- 高风险/不推荐直接上
  - geth/prysm（Go）：默认静态+Go runtime 直接 syscalls，LD_PRELOAD 很难把“时间与网络”完整拉进虚拟时间；即使部分 UDP 被控制，计时仍在真实时间，无法获得“超速+确定性”的核心价值。

### 典型接入方案（按稳定性排序）
- 路线A：CL+EL 都用 Shadow 友好的客户端（Teku+Besu 或 Lighthouse+Besu）
  - 优点：不改代码、二进制级跑、网络和时间都受控、易做 10×~100× 的非实时加速和确定性重放。
  - 做法要点：
    - 选择动态链接构建（避免静态）；在 Shadow host 中按实例数启动进程。
    - 若只做共识安全测试，可用“Mock Execution Engine”绕过真 EL，进一步提速。
- 路线B：只跑共识层（CL）+ Engine API stub
  - 优点：更轻、调度事件更少、可高倍速；对 fuzz 共识的性价比最高。
  - 要点：确保 CL 所有对时间、定时器、sleep、epoll 都能被 shim 拦到（Java/Node/Rust容易做到）。
- 路线C：试图把 Go 客户端放进 Shadow
  - 仅当你愿意改动客户端：把 net/时间调用改为可插拔（统一走 C wrapper/虚拟时钟），或强制动态链接并确保所有 clock/sleep/epoll 走 libc 路径。工作量大，且容易出现“部分走真实时间”的错位。

### 极简 Shadow 配置示例（帮助你感受工作流）
```yaml
# shadow.yaml
general:
  stop_time: 600s          # 仿真虚拟时间
  bootstrap_end_time: 10s  # 初期宽松期
network:
  graph:
    type: 1_gbit_switch    # 也可用自定义拓扑
hosts:
  beacon1:
    network_node_id: 0
    processes:
      - path: /usr/bin/java
        args: ["-jar","/apps/teku.jar","--config-file=/conf/teku1.yaml"]
        start_time: 1s
  beacon2:
    network_node_id: 0
    processes:
      - path: /usr/bin/java
        args: ["-jar","/apps/teku.jar","--config-file=/conf/teku2.yaml"]
        start_time: 2s
  validator1:
    network_node_id: 0
    processes:
      - path: /usr/bin/node
        args: ["/apps/lodestar/validator.js","--config=/conf/ls1.yaml"]
        start_time: 3s
# 通过 'shadow -l debug shadow.yaml' 运行
```
- 你可以设置每个 host 的带宽、延迟、丢包；或引入复杂拓扑（Fat-tree、延迟矩阵）。
- Shadow 会把这些进程的网络与时间拉入“虚拟时间”，用于超速、可重放实验。

### 在 Shadow 中做共识 fuzz 的几种注入点
- 网络层注入：按流/主题/子网维度动态改变延迟/丢包/乱序（可通过多 host 分区 + 定时调整拓扑/链路参数近似实现）。
- 客户端前门注入：启动前注入环境变量/参数触发“恶意模式”（例如某比例 attest 随机延迟、提议冲突、聚合篡改）。
- 进程代理注入：在 shim 层或 wrapper 脚本中对特定端口/消息做变换（更复杂）。
- 时间窗扰动：在 Shadow 中以事件方式改变 host 的“本地时钟偏移/速率”（需要按照 Shadow 提供的 hook 或配置改变 host 属性；不同版本支持度不同，通常更建议直接用网络故障来触发共识边界条件）。

### 关键坑位与规避
- 动态链接与 vDSO：确保应用走可拦截路径；避免静态链接；尽量让 clock/epoll/sockets 从 libc 进入 shim。
- 线程与确定性：Java/Node/Rust 多线程可控性优于 Go 的“直接 syscalls”；为可重放，减少非确定性源（随机数固定种子、禁用 JIT 的不确定优化等）。
- QUIC 细节：Shadow 能管住 UDP 层的时延和丢包，但 QUIC 的 pacing、计时器是否完全进入虚拟时间取决于计时 API 是否被拦截。Java/Node/Rust 客户端通常问题较小；Go 客户端风险大。
- 规模与性能：Shadow 单机可跑数千进程，但 JVM/Node 进程内存占用高；建议一开始用少量节点+高倍速找问题，再扩规模。
- I/O 与监控：stdout/stderr/metrics 的时间戳位于虚拟时间域；对比外部工具时注意“时间线对齐”。

### 给你的可落地路线
- 第一步（PoC）：用 Teku +（可选）Besu 在 Shadow 中跑 2–4 个 beacon + 若干 validator，验证：
  - 能否稳定推进 slot/epoch（虚拟时间）；
  - 延迟/抖动/丢包对安全性质的影响；
  - 基本 fuzz 注入（延迟发送、漏投、错签）是否被捕捉。
- 第二步（扩大与自动化）：
  - 增加节点数，加入不同客户端组合（例如 Teku/Lighthouse/Lodestar 混部），加强异质性；
  - 集成 fuzz 编排器（AFLNet/自研），把恶意行为模板化；记录可重放种子。
- 第三步（高级实验）：
  - 引入更复杂拓扑与时间分区（分区恢复、时钟偏斜）；
  - 设计断言：finality 不破坏、活性、分叉率上界、同步耗时等；自动生成实验报告。

如果你愿意，我可以：
- 基于你当前的 Docker 版网络，给出“转 Shadow 路线”的最小示例（Teku-only，共识层 PoC 的 shadow.yaml 与启动脚本）；
- 或给出“只跑共识的 Engine API stub”方案，让 CL 在 Shadow 内高速推进而无需 EL，专注于你要 fuzz 的共识安全。

- 小结
  - Shadow 非常适合“二进制级离散事件网络”，但要避开 Go 静态二进制。用 Teku/Besu/Lodestar/Lighthouse 这样的客户端，能真正获得“高倍速+确定性重放”的科研所需。
  - 上手从小集群 PoC 开始，先把“网络与时间都被 Shadow 接管”打通，再逐步叠加 fuzz 行为与规模。

# Explore
module:
- binary harness
- interface between scheduler and binary
- scheduler:
  - context-switch
  - network/message
  - monitor/debug
