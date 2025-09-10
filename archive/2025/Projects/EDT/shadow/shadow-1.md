# Shadow
## build & test
[link](https://shadow.github.io/docs/guide/install_shadow.html)
### 64% -> 99%
Shadow was built with PROFILE=release, OPT_LEVEL=3, DEBUG=false, RUSTFLAGS="-C force-frame-pointers=y", CFLAGS="-O0 -ggdb -fno-omit-frame-pointer -Wreturn-type -Wswitch -DNDEBUG"

Shadow was built with PROFILE=debug, OPT_LEVEL=1, DEBUG=true, RUSTFLAGS="-C force-frame-pointers=y", CFLAGS="-O0 -ggdb -fno-omit-frame-pointer -Wreturn-type -Wswitch -DDEBUG"

### Failed test within 99%
#### logs
```
123/216 Testing: socket-linux
123/216 Test: socket-linux
Command: "/usr/bin/sh" "-c" "../../../target/debug/test_socket --libc-passing"
Directory: /home/ins0/Repos/shadow/build/src/test/socket/socket
"socket-linux" start time: Sep 09 12:33 CST
Output:
----------------------------------------------------------
Testing socket(1, 1|0, 0)... ✓
Testing socket(1, 1|0, 6)... ✓
Testing socket(1, 1|0, 17)... ✓
Testing socket(1, 1|2048, 0)... ✓
Testing socket(1, 1|2048, 6)... ✓
Testing socket(1, 1|2048, 17)... ✓
Testing socket(1, 1|524288, 0)... ✓
Testing socket(1, 1|524288, 6)... ✓
Testing socket(1, 1|524288, 17)... ✓
Testing socket(1, 1|43962, 0)... ✓
Testing socket(1, 1|43962, 6)... ✓
Testing socket(1, 1|43962, 17)... ✓
Testing socket(1, 2|0, 0)... ✓
Testing socket(1, 2|0, 6)... ✓
Testing socket(1, 2|0, 17)... ✓
Testing socket(1, 2|2048, 0)... ✓
Testing socket(1, 2|2048, 6)... ✓
Testing socket(1, 2|2048, 17)... ✓
Testing socket(1, 2|524288, 0)... ✓
Testing socket(1, 2|524288, 6)... ✓
Testing socket(1, 2|524288, 17)... ✓
Testing socket(1, 2|43962, 0)... ✓
Testing socket(1, 2|43962, 6)... ✓
Testing socket(1, 2|43962, 17)... ✓
Testing socket(1, 5|0, 0)... ✓
Testing socket(1, 5|0, 6)... ✓
Testing socket(1, 5|0, 17)... ✓
Testing socket(1, 5|2048, 0)... ✓
Testing socket(1, 5|2048, 6)... ✓
Testing socket(1, 5|2048, 17)... ✓
Testing socket(1, 5|524288, 0)... ✓
Testing socket(1, 5|524288, 6)... ✓
Testing socket(1, 5|524288, 17)... ✓
Testing socket(1, 5|43962, 0)... ✓
Testing socket(1, 5|43962, 6)... ✓
Testing socket(1, 5|43962, 17)... ✓
Testing socket(1, 4|0, 0)... ✓
Testing socket(1, 4|0, 6)... ✓
Testing socket(1, 4|0, 17)... ✓
Testing socket(1, 4|2048, 0)... ✓
Testing socket(1, 4|2048, 6)... ✓
Testing socket(1, 4|2048, 17)... ✓
Testing socket(1, 4|524288, 0)... ✓
Testing socket(1, 4|524288, 6)... ✓
Testing socket(1, 4|524288, 17)... ✓
Testing socket(1, 4|43962, 0)... ✓
Testing socket(1, 4|43962, 6)... ✓
Testing socket(1, 4|43962, 17)... ✓
Testing socket(1, 43962|0, 0)... ✓
Testing socket(1, 43962|0, 6)... ✓
Testing socket(1, 43962|0, 17)... ✓
Testing socket(1, 43962|2048, 0)... ✓
Testing socket(1, 43962|2048, 6)... ✓
Testing socket(1, 43962|2048, 17)... ✓
Testing socket(1, 43962|524288, 0)... ✓
Testing socket(1, 43962|524288, 6)... ✓
Testing socket(1, 43962|524288, 17)... ✓
Testing socket(1, 43962|43962, 0)... ✓
Testing socket(1, 43962|43962, 6)... ✓
Testing socket(1, 43962|43962, 17)... ✓
Testing socket(1, 1|0, 0)... ✓
Testing socket(1, 1|0, 6)... ✓
Testing socket(1, 1|0, 17)... ✓
Testing socket(1, 1|2048, 0)... ✓
Testing socket(1, 1|2048, 6)... ✓
Testing socket(1, 1|2048, 17)... ✓
Testing socket(1, 1|524288, 0)... ✓
Testing socket(1, 1|524288, 6)... ✓
Testing socket(1, 1|524288, 17)... ✓
Testing socket(1, 1|43962, 0)... ✓
Testing socket(1, 1|43962, 6)... ✓
Testing socket(1, 1|43962, 17)... ✓
Testing socket(1, 2|0, 0)... ✓
Testing socket(1, 2|0, 6)... ✓
Testing socket(1, 2|0, 17)... ✓
Testing socket(1, 2|2048, 0)... ✓
Testing socket(1, 2|2048, 6)... ✓
Testing socket(1, 2|2048, 17)... ✓
Testing socket(1, 2|524288, 0)... ✓
Testing socket(1, 2|524288, 6)... ✓
Testing socket(1, 2|524288, 17)... ✓
Testing socket(1, 2|43962, 0)... ✓
Testing socket(1, 2|43962, 6)... ✓
Testing socket(1, 2|43962, 17)... ✓
Testing socket(1, 5|0, 0)... ✓
Testing socket(1, 5|0, 6)... ✓
Testing socket(1, 5|0, 17)... ✓
Testing socket(1, 5|2048, 0)... ✓
Testing socket(1, 5|2048, 6)... ✓
Testing socket(1, 5|2048, 17)... ✓
Testing socket(1, 5|524288, 0)... ✓
Testing socket(1, 5|524288, 6)... ✓
Testing socket(1, 5|524288, 17)... ✓
Testing socket(1, 5|43962, 0)... ✓
Testing socket(1, 5|43962, 6)... ✓
Testing socket(1, 5|43962, 17)... ✓
Testing socket(1, 4|0, 0)... ✓
Testing socket(1, 4|0, 6)... ✓
Testing socket(1, 4|0, 17)... ✓
Testing socket(1, 4|2048, 0)... ✓
Testing socket(1, 4|2048, 6)... ✓
Testing socket(1, 4|2048, 17)... ✓
Testing socket(1, 4|524288, 0)... ✓
Testing socket(1, 4|524288, 6)... ✓
Testing socket(1, 4|524288, 17)... ✓
Testing socket(1, 4|43962, 0)... ✓
Testing socket(1, 4|43962, 6)... ✓
Testing socket(1, 4|43962, 17)... ✓
Testing socket(1, 43962|0, 0)... ✓
Testing socket(1, 43962|0, 6)... ✓
Testing socket(1, 43962|0, 17)... ✓
Testing socket(1, 43962|2048, 0)... ✓
Testing socket(1, 43962|2048, 6)... ✓
Testing socket(1, 43962|2048, 17)... ✓
Testing socket(1, 43962|524288, 0)... ✓
Testing socket(1, 43962|524288, 6)... ✓
Testing socket(1, 43962|524288, 17)... ✓
Testing socket(1, 43962|43962, 0)... ✓
Testing socket(1, 43962|43962, 6)... ✓
Testing socket(1, 43962|43962, 17)... ✓
Testing socket(2, 1|0, 0)... ✓
Testing socket(2, 1|0, 6)... ✓
Testing socket(2, 1|0, 17)... ✓
Testing socket(2, 1|2048, 0)... ✓
Testing socket(2, 1|2048, 6)... ✓
Testing socket(2, 1|2048, 17)... ✓
Testing socket(2, 1|524288, 0)... ✓
Testing socket(2, 1|524288, 6)... ✓
Testing socket(2, 1|524288, 17)... ✓
Testing socket(2, 1|43962, 0)... ✓
Testing socket(2, 1|43962, 6)... ✓
Testing socket(2, 1|43962, 17)... ✓
Testing socket(2, 2|0, 0)... ✓
Testing socket(2, 2|0, 6)... ✓
Testing socket(2, 2|0, 17)... ✓
Testing socket(2, 2|2048, 0)... ✓
Testing socket(2, 2|2048, 6)... ✓
Testing socket(2, 2|2048, 17)... ✓
Testing socket(2, 2|524288, 0)... ✓
Testing socket(2, 2|524288, 6)... ✓
Testing socket(2, 2|524288, 17)... ✓
Testing socket(2, 2|43962, 0)... ✓
Testing socket(2, 2|43962, 6)... ✓
Testing socket(2, 2|43962, 17)... ✓
Testing socket(2, 5|0, 0)... ✗ (Expecting a return value of -1, received 34)
Error: "One of the tests failed."
<end of output>
Test time =   0.09 sec
----------------------------------------------------------
Test Failed.
"socket-linux" end time: Sep 09 12:33 CST
"socket-linux" time elapsed: 00:00:00
----------------------------------------------------------
```
#### description
network socket test:
rs file itself would fail at the same location too.
**not the shadow to blame**

## Hello! Basic file transfer
```yaml
general:
  # stop after 10 simulated seconds
  stop_time: 10s
  # old versions of cURL use a busy loop, so to avoid spinning in this busy
  # loop indefinitely, we add a system call latency to advance the simulated
  # time when running non-blocking system calls
  model_unblocked_syscall_latency: true

network:
  graph:
    # use a built-in network graph containing
    # a single vertex with a bandwidth of 1 Gbit
    type: 1_gbit_switch

hosts:
  # a host with the hostname 'server'
  server:
    network_node_id: 0
    processes:
    - path: python3
      args: -m http.server 80
      start_time: 3s
      # tell shadow to expect this process to still be running at the end of the
      # simulation
      expected_final_state: running
  # three hosts with hostnames 'client1', 'client2', and 'client3' using a yaml
  # anchor to avoid duplicating the options for each host
  client1: &client_host
    network_node_id: 0
    processes:
    - path: curl
      args: -s server
      start_time: 5s
  client2: *client_host
  client3: *client_host
```

### Run
test can be run under "debug" build-type, would fail under "release";

### insight
- it's event-driven! 10s' test can be done within 1s;
- **processes:** to define behaviores/**start_time**;
- using a *yaml anchor* to avoid duplicating the options for each host: &mark ==> *mark

## Hello! Traffic Gen
```yaml
general:
  stop_time: 10m
  # Needed to avoid deadlock in some configurations of tgen.
  # See below.
  model_unblocked_syscall_latency: true

network:
  graph:
    # a custom single-node graph
    type: gml
    inline: |
      graph [
        node [
          id 0
          host_bandwidth_down "140 Mbit"
          host_bandwidth_up "18 Mbit"
        ]
        edge [
          source 0
          target 0
          latency "50 ms"
          packet_loss 0.01
        ]
      ]
hosts:
  server:
    network_node_id: 0
    processes:
    # Assumes `tgen` is on your shell's `PATH`.
    # Otherwise use an absolute path here.
    - path: tgen
      # The ../../../ prefix assumes that tgen.server.graph.xml in the same
      # directory as the data directory (specified with the -d CLI argument).
      # See notes below explaining Shadow's directory structure.
      args: ../../../tgen.server.graphml.xml
      start_time: 1s
      # Tell shadow to expect this process to still be running at the end of the
      # simulation.
      expected_final_state: running
  client1: &client_host
    network_node_id: 0
    processes:
    - path: tgen
      args: ../../../tgen.client.graphml.xml
      start_time: 2s
  client2: *client_host
  client3: *client_host
  client4: *client_host
  client5: *client_host

```

### Run
success;

### Insight
- [**TGen**](https://github.com/shadow/tgen) is capable of generating basic file transfers, where you can configure how much data is transferred in each direction, how long to wait in between each transfer, and how many transfers to perform. TGen also supports more complex behavior models: you can use Markov models to configure a state machine with precise inter-packet timing characteristics. We only make use of its basic features in this example.
- 10 mins' test takes about 5s, 100x speedup;
- `$ for d in shadow.data/hosts/client*; do grep "stream-success" "${d}"/*.stdout ; done | wc -l` return 50, which is correct;

## Configurations

# End
