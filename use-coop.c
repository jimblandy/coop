#include <stdio.h>
#include <stdlib.h>

#include "coop.h"

void counter(struct coop *creator, void *ptr)
{
  // First, send ourselves to the creator.
  coop_send(creator, coop_current);

  // Now, each time someone sends use something, yield the next string.
  coop_send(creator, "one");
  coop_send(creator, "two");
  coop_send(creator, "three");
  coop_send(creator, "four");
  coop_send(creator, "five");

  // Sending a null pointer indicates that we're done.
  coop_send(NULL);
}

int main(int argc, char **argv) {
  size_t stack_size = 32 * 1024;
  void *stack = malloc(stack_size);
  if (!stack) exit(1);

  struct coop *gen = coop_start(stack, stack_size, counter, NULL);

  for (;;) {
    char *str = coop_send(gen, NULL);
    if (!str)
      break;

    printf("%s\n", str);
  }

  coop_free(gen);

  return 0;
}
