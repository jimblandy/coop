Dumb Coöperative Threading
==========================

This is an exercise I put together for a friend who was interested in learning
assembly language. I thought it might be a good first challenge.

The exercise is: implement the interface in `coop.h`, such that `use-coop.c` produces the output:

```
one
two
three
four
five
```

The `Makefile` assumes you've put your code in `coop.s`.

The primitives in `coop.h` are very similar to the POSIX `makecontext` and
`swapcontext` functions; the exercise is to figure out for yourself what those
do.

I've included my answer for the x86-64 architecture in `coop-x86_64.s.gz`,
compressed so that you won't see it by accident.

Learning Strategies
-------------------

You probably do *not* want to start this exercise by reading the GNU assembler
docs and hunting down the processor-specific ABI for your machine. That is some
serious lawyering, and I don't think the assembler manual is super.

A better way to learn what you need to know might be to write a C file that does
something very simple like declare a global variable, or define a function that
calls another function, or some other short and specific task, and then compile
it with the `-S` option, to ask the compiler to write out the assembly language
it generates:

    $ cat simple.c
    int global_int_variable;

    int set_global_variable(int new_value) {
      global_int_variable = new_value;
      return 1729;
    }
    $ gcc -S simple.c
    $ cat simple.s
        .file	"simple.c"
        .comm	global_int_variable,4,4
        .text
        ... etc. etc.

You can use this to figure out the right assembler pseudo-ops (the commands
beginning with `.`) for declaring functions and variables, and to figure out
where the compiler expects to find arguments at the entry point of a call, where
it puts return values, and so on.

To try things out, you can edit this file and assemble it. It turns out that you
can just pass `.s` files to GCC and it will assemble and link it for you like
any other source file. The `Makefile` shows an example of this.

Shout Out
---------

I cannot recommend
Matasano's [Embedded Security CTF](https://microcorruption.com/) highly enough.
It's a web site that hosts a game where you examine an assembly language program
with a simple machine-level debugger and try to exploit its bugs. It's all in
the web page, so there's nothing to install, and it's set up to let you get
hacking on the interesting parts right away. The problems get progressively
harder, but every single one has a weakness that is there for you to find, so
it's great for practicing the code review mindset.

Naturally, since Microcorruption is just a game, it doesn't help you start using
assembly in actual apps or on real machines; that requires learning the tools
and the ABIs and debuggers and a bunch of other necessary but involved steps.
But it will help you get comfortable thinking in assembly language; and in the
end, most modern machines are pretty similar.

Anyway, it's a blast. I got [my score](https://microcorruption.com/profile/8542)
up to 515 before I *cough* got distracted by other pressing business.
