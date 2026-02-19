#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>

struct util_queue_fence;

int sched_getaffinity(int pid, size_t cpusetsize, void *mask);
int __sched_cpucount(size_t setsize, const void *setp);
void util_queue_fence_signal(struct util_queue_fence *fence);
void util_queue_fence_init(struct util_queue_fence *fence);
void util_queue_fence_destroy(struct util_queue_fence *fence);
void _util_queue_fence_wait(struct util_queue_fence *fence);
bool _util_queue_fence_wait_timeout(struct util_queue_fence *fence,
                                    int64_t abs_timeout);

int
sched_getaffinity(int pid, size_t cpusetsize, void *mask)
{
   (void)pid;
   (void)cpusetsize;
   (void)mask;
   return -1;
}

int
__sched_cpucount(size_t setsize, const void *setp)
{
   (void)setsize;
   (void)setp;
   return 1;
}

void
util_queue_fence_signal(struct util_queue_fence *fence)
{
   (void)fence;
}

void
util_queue_fence_init(struct util_queue_fence *fence)
{
   (void)fence;
}

void
util_queue_fence_destroy(struct util_queue_fence *fence)
{
   (void)fence;
}

void
_util_queue_fence_wait(struct util_queue_fence *fence)
{
   (void)fence;
}

bool
_util_queue_fence_wait_timeout(struct util_queue_fence *fence,
                               int64_t abs_timeout)
{
   (void)fence;
   (void)abs_timeout;
   return true;
}
