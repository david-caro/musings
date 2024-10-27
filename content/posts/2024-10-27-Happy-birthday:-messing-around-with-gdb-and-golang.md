---
tags: ["gdb", "golang", "computer science", "programming"]
title: "Happy Birthday: Messing Around With Gdb and Golang"
date: 2024-10-27T16:37:53+01:00
draft: false
---

Some time ago (my last birthday), my nephew gave me a really nice little game as
a present :}

It's a simple and fun question-and-answer kind of game. He wrote it in golang
with my brother's help (he's father).

Point being, that in all this time, I had been able to solve all but the last
question, and /me being who I am, decided to hack it for the fun of it \o/

First , I decided to use the linux command `strings` to see if anything would
pop up easily, and well, yes it did :), though it showed way way more stuff than
what I wanted :/, and well, seemed not too elegant:

```shell
dcaro@urcuchillay$ strings --data --encoding=S elprograma | wc
  41757   46655  507317
```

So my second approach was using `gdb`, but I'm quite unfamiliar with it (though
I used it some 20+ years ago for some university exercises), so I had to brush
up.

I also don't have the source code, so that complicates things a little bit, as I
had to brush up on some assembler too. Anyhow, attaching to the running program
was easy:

```shell
dcaro@urcuchillay$ gdb elprograma
...
(gdb)
```

Then you have to run the program:

```shell
(gdb) run
```

Another option is starting the program by itself, and attaching to the running
one:

```shell
dcaro@urcuchillay$ gdb elprograma
...
(gdb) attach <pid_of_program>
```

Once started and when it's asking for an answer, you can drop to the gdb prompt
by hitting `Ctrl+Z`, or sending `SIGSTOP` using kill or similar:

```shell
^Z
Thread 1 "elprograma" received signal SIGTSTP, Stopped (user).
runtime/internal/syscall.Syscall6 () at /home/ruben/.asdf/installs/golang/1.21.4/go/src/runtime/internal/syscall/asm_linux_amd64.s:36
warning: 36	/home/ruben/.asdf/installs/golang/1.21.4/go/src/runtime/internal/syscall/asm_linux_amd64.s: No such file or directory
```

As you can see it's trying to get to the source code, but not finding it as that
was built in my brother's computer xd

Now you can check where you are in the stack, from here, you can extract the
file name and the line the code is running from (note though that as I don't
have the source code, it will not show the source code of the line):

```shell
(gdb) where
#0  runtime/internal/syscall.Syscall6 () at /home/ruben/.asdf/installs/golang/1.21.4/go/src/runtime/internal/syscall/asm_linux_amd64.s:36
#1  0x000000000040314d in syscall.RawSyscall6 (num=18446744073709551104, a1=0, a2=4206958, a3=0, a4=824634863616, a5=0, a6=0, r1=<optimized out>, r2=<optimized out>, errno=<optimized out>)
    at /home/ruben/.asdf/installs/golang/1.21.4/go/src/runtime/internal/syscall/syscall_linux.go:38
#2  0x0000000000471e46 in syscall.Syscall (trap=0, a1=0, a2=824634863616, a3=4096, r1=<optimized out>, r2=<optimized out>, err=<optimized out>) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/syscall/syscall_linux.go:82
#3  0x0000000000471858 in syscall.read (fd=<optimized out>, p=..., n=<optimized out>, err=...) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/syscall/zsyscall_linux_amd64.go:721
#4  0x000000000047320e in syscall.Read (fd=0, n=<optimized out>, err=..., p=...) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/syscall/syscall_unix.go:181
#5  internal/poll.ignoringEINTRIO (fd=0, fn=<optimized out>, p=...) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/internal/poll/fd_unix.go:736
#6  internal/poll.(*FD).Read (fd=0xc00018c000, p=..., ~r0=<optimized out>, ~r0=<optimized out>, ~r1=..., ~r1=...) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/internal/poll/fd_unix.go:160
#7  0x0000000000473a12 in os.(*File).read (f=0xc00018a000, b=..., n=<optimized out>, err=...) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/os/file_posix.go:29
#8  os.(*File).Read (f=0xc00018a000, b=..., n=<optimized out>, err=...) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/os/file.go:118
#9  0x00000000004633fb in bufio.(*Scanner).Scan (s=0xc0001a2e40, ~r0=<optimized out>) at /home/ruben/.asdf/installs/golang/1.21.4/go/src/bufio/scan.go:214
#10 0x000000000047d76f in main.presentarAdivinanza (enunciado=..., ~r0=...) at /home/ruben/Documents/elprograma/main.go:30
#11 0x000000000047d645 in main.main () at /home/ruben/Documents/elprograma/main.go:15
```

Ok, that's good, so the original file was
`/home/ruben/Documents/elprograma/main.go`, and I can see also that the method
I'm in is `main.presentarAdivinanza`, nice :), but I want to see the code it's
running, even if it's only the assembler code itself, so I can figure out how
it's working.

To do so, you can use the `x` command from gdb, that will show data, passing to
it the `$pc` registry (current instruction's memory address):

```shell
(gdb) x/10i $pc
=> 0x40316e <runtime/internal/syscall.Syscall6+14>:	cmp    $0xfffffffffffff001,%rax
   0x403174 <runtime/internal/syscall.Syscall6+20>:	jbe    0x40318b <runtime/internal/syscall.Syscall6+43>
   0x403176 <runtime/internal/syscall.Syscall6+22>:	neg    %rax
   0x403179 <runtime/internal/syscall.Syscall6+25>:	mov    %rax,%rcx
   0x40317c <runtime/internal/syscall.Syscall6+28>:	mov    $0xffffffffffffffff,%rax
   0x403183 <runtime/internal/syscall.Syscall6+35>:	mov    $0x0,%rbx
   0x40318a <runtime/internal/syscall.Syscall6+42>:	ret
   0x40318b <runtime/internal/syscall.Syscall6+43>:	mov    %rdx,%rbx
   0x40318e <runtime/internal/syscall.Syscall6+46>:	mov    $0x0,%rcx
   0x403195 <runtime/internal/syscall.Syscall6+53>:	ret
```

Hmm, that's the syscall internal code, let me go instead to the source code
stack almost at the top, and check there.

```shell
(gdb) up
...  as many times as needed
#10 0x000000000047d76f in main.presentarAdivinanza (enunciado=..., ~r0=...) at /home/ruben/Documents/elprograma/main.go:30
warning: 30	/home/ruben/Documents/elprograma/main.go: No such file or directory
(gdb) x/10i $pc
=> 0x47d76f <main.presentarAdivinanza+207>:	mov    0x68(%rsp),%rbx
   0x47d774 <main.presentarAdivinanza+212>:	mov    0x70(%rsp),%rcx
   0x47d779 <main.presentarAdivinanza+217>:	xor    %eax,%eax
   0x47d77b <main.presentarAdivinanza+219>:	nopl   0x0(%rax,%rax,1)
   0x47d780 <main.presentarAdivinanza+224>:	call   0x44a060 <runtime.slicebytetostring>
   0x47d785 <main.presentarAdivinanza+229>:	add    $0xc8,%rsp
   0x47d78c <main.presentarAdivinanza+236>:	pop    %rbp
   0x47d78d <main.presentarAdivinanza+237>:	ret
   0x47d78e <main.presentarAdivinanza+238>:	mov    %rax,0x8(%rsp)
   0x47d793 <main.presentarAdivinanza+243>:	mov    %rbx,0x10(%rsp)
```

That is more interesting :), I can see there also that there's a return little
after, but I'm missing the current executed function too, let's use `$pc - 0x8`,
see what we get (the 0x8 is a guess, note that the size of the assembler
instruction is variable):

```shell
(gdb) x/10i $pc - 0x8
   0x47d767 <main.presentarAdivinanza+199>:	rex.R and $0x48,%al
   0x47d76a <main.presentarAdivinanza+202>:	call   0x462be0 <bufio.(*Scanner).Scan>
=> 0x47d76f <main.presentarAdivinanza+207>:	mov    0x68(%rsp),%rbx
   0x47d774 <main.presentarAdivinanza+212>:	mov    0x70(%rsp),%rcx
   0x47d779 <main.presentarAdivinanza+217>:	xor    %eax,%eax
   0x47d77b <main.presentarAdivinanza+219>:	nopl   0x0(%rax,%rax,1)
   0x47d780 <main.presentarAdivinanza+224>:	call   0x44a060 <runtime.slicebytetostring>
   0x47d785 <main.presentarAdivinanza+229>:	add    $0xc8,%rsp
   0x47d78c <main.presentarAdivinanza+236>:	pop    %rbp
   0x47d78d <main.presentarAdivinanza+237>:	ret
```

Oooh, so we are in `bufio.(*Scanner).Scan`, that's the one that reads the
screen, makes sense.

`gdb` has a nice command to add an expression that will be run on every prompt
refresh, let's add the one showing the current assembly code to it, so we don't
need to manually enter it every time:

```shell
(gdb) display /10i $pc - 0x8
```

Neat, now, let's try to add a breakpoint on the next instructions, so we can
follow after we enter our **wrong** solution, as I don't have the source code,
let's try putting it on the next line in the file, so first let's get the
current frame (stack level):

```shell
(gdb) frame
#10 0x000000000047d76f in main.presentarAdivinanza (enunciado=..., ~r0=...) at /home/ruben/Documents/elprograma/main.go:30
30	in /home/ruben/Documents/elprograma/main.go
```

And just breakpoint at line+1:

```shell
(gdb) b /home/ruben/Documents/elprograma/main.go:31
Breakpoint 1 at 0x47d785: file /home/ruben/Documents/elprograma/main.go, line 31.
```

And let's continue the execution :)

Here comes a first weird thing, it turns out that `continue` is not enough!

```shell
(gdb) continue
Continuing.

Thread 1 "elprograma" received signal SIGTSTP, Stopped (user).
runtime/internal/syscall.Syscall6 () at /home/ruben/.asdf/installs/golang/1.21.4/go/src/runtime/internal/syscall/asm_linux_amd64.s:36
36	in /home/ruben/.asdf/installs/golang/1.21.4/go/src/runtime/internal/syscall/asm_linux_amd64.s
1: x/10i $pc - 0x8
   0x403166 <runtime/internal/syscall.Syscall6+6>:	mov    %rcx,%rsi
   0x403169 <runtime/internal/syscall.Syscall6+9>:	mov    %rbx,%rdi
   0x40316c <runtime/internal/syscall.Syscall6+12>:	syscall
=> 0x40316e <runtime/internal/syscall.Syscall6+14>:	cmp    $0xfffffffffffff001,%rax
   0x403174 <runtime/internal/syscall.Syscall6+20>:	jbe    0x40318b <runtime/internal/syscall.Syscall6+43>
   0x403176 <runtime/internal/syscall.Syscall6+22>:	neg    %rax
   0x403179 <runtime/internal/syscall.Syscall6+25>:	mov    %rax,%rcx
   0x40317c <runtime/internal/syscall.Syscall6+28>:	mov    $0xffffffffffffffff,%rax
   0x403183 <runtime/internal/syscall.Syscall6+35>:	mov    $0x0,%rbx
   0x40318a <runtime/internal/syscall.Syscall6+42>:	ret
```

It turns out, that you need to hit `continue` **for each thread** so they get
the SIGCONT properly, so let's do that, eventually you get back to the program:

```shell
...
Continuing.

```

Now when we enter any answer, it gets to the breakpoint:

```shell
Bad answer.
[Switching to LWP 2256393]

Thread 1 "elprograma" hit Breakpoint 1, main.presentarAdivinanza (enunciado=..., ~r0=...) at /home/ruben/Documents/elprograma/main.go:31
warning: 31	/home/ruben/Documents/elprograma/main.go: No such file or directory
1: x/10i $pc - 0x8
   0x47d77d <main.presentarAdivinanza+221>:	add    %r8b,(%rax)
   0x47d780 <main.presentarAdivinanza+224>:	call   0x44a060 <runtime.slicebytetostring>
=> 0x47d785 <main.presentarAdivinanza+229>:	add    $0xc8,%rsp
   0x47d78c <main.presentarAdivinanza+236>:	pop    %rbp
   0x47d78d <main.presentarAdivinanza+237>:	ret
   0x47d78e <main.presentarAdivinanza+238>:	mov    %rax,0x8(%rsp)
   0x47d793 <main.presentarAdivinanza+243>:	mov    %rbx,0x10(%rsp)
   0x47d798 <main.presentarAdivinanza+248>:	call   0x45aa20 <runtime.morestack_noctxt>
   0x47d79d <main.presentarAdivinanza+253>:	mov    0x8(%rsp),%rax
   0x47d7a2 <main.presentarAdivinanza+258>:	mov    0x10(%rsp),%rbx
```

You can see now that the process state is in `t`, that means stopped for
debugger:

```shell
dcaro@urcuchillay$ ps aux | grep elprograma
dcaro    2256393  0.0  0.0 1226320 1604 pts/4    tl   16:52   0:00 /home/dcaro/elprograma
```

Awesome, so now let's start following the code :), note that `next/step` will
work for "source lines of code", but we don't have source code, so it's better
to move around using `nexti/stepi`, that will go to the next instruction, or
step into a call instruction instead. After a few `ni` we get to return from
that function, back to the main:

```shell
17	in /home/ruben/Documents/elprograma/main.go
1: x/10i $pc - 0x8
   0x47d63d <main.main+157>:	add    %r8b,(%rax)
   0x47d640 <main.main+160>:	call   0x47d6a0 <main.presentarAdivinanza>
=> 0x47d645 <main.main+165>:	mov    0x40(%rsp),%rcx
   0x47d64a <main.main+170>:	cmp    %rcx,%rbx
   0x47d64d <main.main+173>:	jne    0x47d664 <main.main+196>
   0x47d64f <main.main+175>:	mov    %rbx,%rcx
   0x47d652 <main.main+178>:	mov    0x48(%rsp),%rbx
   0x47d657 <main.main+183>:	call   0x402f00 <runtime.memequal>
   0x47d65c <main.main+188>:	nopl   0x0(%rax)
   0x47d660 <main.main+192>:	test   %al,%al
```

Hmm, there's an interesting jump `jne` there but what would that be?

```shell
(gdb) ni
0x000000000047d64a	17	in /home/ruben/Documents/elprograma/main.go
1: x/10i $pc - 0x8
   0x47d642 <main.main+162>:	add    %al,(%rax)
   0x47d644 <main.main+164>:	add    %cl,-0x75(%rax)
   0x47d647 <main.main+167>:	rex.WR and $0x40,%al
=> 0x47d64a <main.main+170>:	cmp    %rcx,%rbx
   0x47d64d <main.main+173>:	jne    0x47d664 <main.main+196>
   0x47d64f <main.main+175>:	mov    %rbx,%rcx
   0x47d652 <main.main+178>:	mov    0x48(%rsp),%rbx
   0x47d657 <main.main+183>:	call   0x402f00 <runtime.memequal>
   0x47d65c <main.main+188>:	nopl   0x0(%rax)
   0x47d660 <main.main+192>:	test   %al,%al

(gdb) info registers rcx rbx
rcx            0x5                 5
rbx            0xb                 11
```

Hmm, after some trial and error, I found that those are the string lengths of
the input string, and the correct answer!

It turns out that
[golang will do a first check for the lengths to be the same](https://github.com/northbright/Notes/blob/master/Golang/string/golang-string-compare-internals.md).
Awesome, first clue :)

Okok, let's then send an answer with that same length:

```shell
Tu respuesta: 12345678901

Thread 1 "elprograma" hit Breakpoint 1, main.presentarAdivinanza (enunciado=..., ~r0=...) at /home/ruben/Documents/elprograma/main.go:31
31	in /home/ruben/Documents/elprograma/main.go
1: x/10i $pc - 0x8
   0x47d77d <main.presentarAdivinanza+221>:	add    %r8b,(%rax)
   0x47d780 <main.presentarAdivinanza+224>:	call   0x44a060 <runtime.slicebytetostring>
=> 0x47d785 <main.presentarAdivinanza+229>:	add    $0xc8,%rsp
   0x47d78c <main.presentarAdivinanza+236>:	pop    %rbp
   0x47d78d <main.presentarAdivinanza+237>:	ret
...
```

Let's continue for a bit...

```shell
0x000000000047d64a	17	in /home/ruben/Documents/elprograma/main.go
1: x/10i $pc - 0x8
   0x47d642 <main.main+162>:	add    %al,(%rax)
   0x47d644 <main.main+164>:	add    %cl,-0x75(%rax)
   0x47d647 <main.main+167>:	rex.WR and $0x40,%al
=> 0x47d64a <main.main+170>:	cmp    %rcx,%rbx
   0x47d64d <main.main+173>:	jne    0x47d664 <main.main+196>
   0x47d64f <main.main+175>:	mov    %rbx,%rcx
   0x47d652 <main.main+178>:	mov    0x48(%rsp),%rbx
   0x47d657 <main.main+183>:	call   0x402f00 <runtime.memequal>
   0x47d65c <main.main+188>:	nopl   0x0(%rax)
   0x47d660 <main.main+192>:	test   %al,%al

(gdb) info registers rcx rbx
rcx            0x5                 5
rbx            0x5                 5
```

Awesome, let's continue...

```shell
1: x/10i $pc - 0x8
   0x47d64f <main.main+175>:	mov    %rbx,%rcx
   0x47d652 <main.main+178>:	mov    0x48(%rsp),%rbx
=> 0x47d657 <main.main+183>:	call   0x402f00 <runtime.memequal>
   0x47d65c <main.main+188>:	nopl   0x0(%rax)
   0x47d660 <main.main+192>:	test   %al,%al
   0x47d662 <main.main+194>:	jne    0x47d673 <main.main+211>
   0x47d664 <main.main+196>:	call   0x47d7c0 <main.defeat>
   0x47d669 <main.main+201>:	mov    0x38(%rsp),%rax
   0x47d66e <main.main+206>:	jmp    0x47d5b4 <main.main+20>
   0x47d673 <main.main+211>:	call   0x47d880 <main.victory>
```

Hmm, it seems that is calling that `memequal`, that's promising, a quick search
reveals that that function is
[internal to golang too](https://github.com/golang/gofrontend/blob/master/libgo/runtime/go-memequal.c),
but it's just a facade for the actual architecture specific function, if we step
into it (using `stepi`) we see the actual file and line:

```shell
(gdb) si
runtime.memequal () at /home/ruben/.asdf/installs/golang/1.21.4/go/src/internal/bytealg/equal_amd64.s:14
warning: 14	/home/ruben/.asdf/installs/golang/1.21.4/go/src/internal/bytealg/equal_amd64.s: No such file or directory
1: x/10i $pc - 0x8
   0x402ef8 <memeqbody+312>:	shl    %cl,%edi
   0x402efa <memeqbody+314>:	sete   %al
   0x402efd <memeqbody+317>:	ret
   0x402efe:	int3
   0x402eff:	int3
=> 0x402f00 <runtime.memequal>:	cmp    %rbx,%rax
   0x402f03 <runtime.memequal+3>:	jne    0x402f0d <runtime.memequal+13>
   0x402f05 <runtime.memequal+5>:	mov    $0x1,%rax
   0x402f0c <runtime.memequal+12>:	ret
   0x402f0d <runtime.memequal+13>:	mov    %rax,%rsi
```

Yep, we have it
[here](https://github.com/golang/go/blob/master/src/internal/bytealg/equal_amd64.s#L10):

```asm
// memequal(a, b unsafe.Pointer, size uintptr) bool
TEXT runtime·memequal<ABIInternal>(SB),NOSPLIT,$0-25
	// AX = a    (want in SI)
	// BX = b    (want in DI)
	// CX = size (want in BX)
	CMPQ	AX, BX
	JNE	neq
	MOVQ	$1, AX	// return 1
	RET
neq:
	MOVQ	AX, SI
	MOVQ	BX, DI
	MOVQ	CX, BX
	JMP	memeqbody<>(SB)

```

There's some nice helper comments there, main ones being that it has the strings
in `AX` and `BX` registries, that was the key :), now all I have to do is to
print out the contents of those registries \o/, okok, so I'm going to the last
question, and then stopping at the breakpoint we put before, I see I got the
right string length:

```shell
(gdb) ni
0x000000000047d64a	17	in /home/ruben/Documents/elprograma/main.go
1: x/10i $pc - 0x8
   0x47d642 <main.main+162>:	add    %al,(%rax)
   0x47d644 <main.main+164>:	add    %cl,-0x75(%rax)
   0x47d647 <main.main+167>:	rex.WR and $0x40,%al
=> 0x47d64a <main.main+170>:	cmp    %rcx,%rbx
   0x47d64d <main.main+173>:	jne    0x47d664 <main.main+196>
   0x47d64f <main.main+175>:	mov    %rbx,%rcx
   0x47d652 <main.main+178>:	mov    0x48(%rsp),%rbx
   0x47d657 <main.main+183>:	call   0x402f00 <runtime.memequal>
   0x47d65c <main.main+188>:	nopl   0x0(%rax)
   0x47d660 <main.main+192>:	test   %al,%al
(gdb) info registers rbx rcx
rbx            0x1e                30
rcx            0x1e                30
```

Continuing...

```shell
runtime.memequal () at /home/ruben/.asdf/installs/golang/1.21.4/go/src/internal/bytealg/equal_amd64.s:14
warning: 14	/home/ruben/.asdf/installs/golang/1.21.4/go/src/internal/bytealg/equal_amd64.s: No such file or directory
1: x/10i $pc - 0x8
   0x402ef8 <memeqbody+312>:	shl    %cl,%edi
   0x402efa <memeqbody+314>:	sete   %al
   0x402efd <memeqbody+317>:	ret
   0x402efe:	int3
   0x402eff:	int3
=> 0x402f00 <runtime.memequal>:	cmp    %rbx,%rax
   0x402f03 <runtime.memequal+3>:	jne    0x402f0d <runtime.memequal+13>
   0x402f05 <runtime.memequal+5>:	mov    $0x1,%rax
   0x402f0c <runtime.memequal+12>:	ret
   0x402f0d <runtime.memequal+13>:	mov    %rax,%rsi


(gdb) x/30s $rax
0xc0001be000:	"123456789012345678901234567890"
```

That's my answer, and finally:

```shell
(gdb) x/s $rbx
0x49a78a:	"Escribe la respuesta correcta.227373675443232059478759765625reflect: Elem of invalid type MapIter.Key called before Nextsync: inconsistent mutex statesync: unlock of unlocked mutexSIGUSR1: user-define"...
```

Yay!! That's what we want! Just the first 30 chars of it:

```shell
(gdb) x/30c $rbx
0x49a78a:	69 'E'	115 's'	99 'c'	114 'r'	105 'i'	98 'b'	101 'e'	32 ' '
0x49a792:	108 'l'	97 'a'	32 ' '	114 'r'	101 'e'	115 's'	112 'p'	117 'u'
0x49a79a:	101 'e'	115 's'	116 't'	97 'a'	32 ' '	99 'c'	111 'o'	114 'r'
0x49a7a2:	114 'r'	101 'e'	99 'c'	116 't'	97 'a'	46 '.'
```

```
-> Nivel 12 <-

Cómo hacer que este programa explote?

Tu respuesta: Escribe la respuesta correcta.

🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂....

Perfect!!   ᕙ(`▽´)ᕗ

-> Nivel 13 <-panic: runtime error: index out of range [13] with length 13

goroutine 1 [running]:
main.main()
	/home/ruben/Documents/elprograma/main.go:14 +0xef
```

That was an awesome present, that made me have a good time for a loooong time xd

And a nice reference to a very nice movie
["The thirteenth floor"](https://www.imdb.com/title/tt0139809/)

Thanks nephew! (and brother)
