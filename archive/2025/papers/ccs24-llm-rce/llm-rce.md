# CCS24: Demystifying rce vulnerabilities in llm-integrated apps
[paper](https://dl.acm.org/doi/pdf/10.1145/3658644.3690338)

Yes, RCE problem for remote Agent. Then, how to do an attack work on this issue?

## Motivation
Attack requirement: 
- uncontrolled response. Actually unstable. 
- unrestricted code execution.

Challenges:
- too many LLM-integrated frameworks / Agents
- many unexpected issue can affect the exploitability.

## Approach
A multi-step approach:
- static analysis on agent code to extract dangerous function calling. then validate its exploitability.??
- heuristic method to explore the real-world
- prompt based RCE attack

## Details:
A very good demo with some test prompts.
[Demo](https://sites.google.com/view/llmsmith)

Actually, their targets on not agent but **LLM-Integrated Frameworks**:
- e.g. 小红书的翻译功能。经常是一个使用了LLM的传统app的小功能。

Workflow:
![workflow](image.png)

Detection:
- Treat any *code execution from User Input and Model's Response* as RCE vulnerability.
![API Def](image-1.png)
- Static Call Chain Extraction from User-API to Code-Execution;
    - lighter and quicker than full data flow analysis;

Implications:
- focus on web apps;
- signature matching tools:
![App Matching](image-2.png)

Exploitation:
- basic usage test: print / 1+1 / etc.
    - pass: has functionality.
        - hallucination problem. what if they just simulate the execution?
            - some complex computations are infeasible for an LLM lacking code execution capabilities
                - do hash / base85 decoding / etc..
                    - **RCE test without escape**: basic cmds e.g. ls / env / id etc...
                        - Fail? **Escape**:
                            - LLM escape;
                            - Code escape;

Tests: ![attack tests](image-3.png)

Attack chain:
![attack chain](image-4.png)