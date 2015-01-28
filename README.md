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

The primitives in `coop.h` are very similar to the POSIX `makecontext` and
`swapcontext` functions; the exercise is to figure out for yourself what those
do.

I've included my answer for the x86-64 architecture in `coop-x86_64.s.gz`,
compressed so that you won't see it by accident.

Also, I cannot recommend Matasano's
[Embedded Security CTF](https://microcorruption.com/) highly enough. That was a
blast. I got [my score](https://microcorruption.com/profile/8542) up to 515
before I *cough* got distracted by other pressing business.
