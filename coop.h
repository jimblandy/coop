// Co-operative threading primitives.

// A co-operative thread ("coop thread").
struct coop;

// The currently running coop thread. This is initially the 'struct coop' for
// the main thread; the 'coop_start' and 'coop_send' functions update it as
// control passes from one coop thread to another.
extern struct coop *coop_current;

// A coop thread's start function should have this type.
// |creator| is a pointer to the coop thread that created the one calling this function;
// |ptr| is the pointer passed to coop_start from |creator|, for application use.
//
// Start functions must never return; instead, they should send a value
// to some other thread.
typedef void (coop_start_fn)(struct coop *creator, void *ptr);

// Given a |size|-byte block of memory |stack| to use as a stack, create a new
// coop thread that will call |f|, passing |ptr|. As a coop_start_fn, |f| should
// never return.
//
// The call to coop_start itself returns the next value sent to the calling
// coop thread with coop_send.
void *coop_start(void *stack, size_t size, coop_start_fn *f, void *ptr);

// Transfer control to |to|, passing |ptr|. Return the next value sent to the
// calling thread.
void *coop_send(struct coop *to, void *ptr);
