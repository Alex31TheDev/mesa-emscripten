/*
 * Copyright 2020 Lag Free Games, LLC
 * Copyright 2022 Yonggang Luo
 * SPDX-License-Identifier: MIT
 */

#include <assert.h>
#include <stddef.h>
#include "rwlock.h"

#if defined(_WIN32) && !defined(HAVE_PTHREAD)
#include <windows.h>
static_assert(sizeof(struct u_rwlock) == sizeof(SRWLOCK),
   "struct u_rwlock should have equal size with SRWLOCK");
#endif

int u_rwlock_init(struct u_rwlock *rwlock)
{
   return pthread_mutex_init(&rwlock->rwlock, NULL);
}

int u_rwlock_destroy(struct u_rwlock *rwlock)
{
   return pthread_mutex_destroy(&rwlock->rwlock);
}

int u_rwlock_rdlock(struct u_rwlock *rwlock)
{
   return pthread_mutex_lock(&rwlock->rwlock);
}

int u_rwlock_rdunlock(struct u_rwlock *rwlock)
{
   return pthread_mutex_unlock(&rwlock->rwlock);
}

int u_rwlock_wrlock(struct u_rwlock *rwlock)
{
   return pthread_mutex_lock(&rwlock->rwlock);
}

int u_rwlock_wrunlock(struct u_rwlock *rwlock)
{
   return pthread_mutex_unlock(&rwlock->rwlock);
}
