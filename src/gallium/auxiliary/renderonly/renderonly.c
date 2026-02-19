/*
 * Copyright (C) 2016 Christian Gmeiner <christian.gmeiner@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Authors:
 *    Christian Gmeiner <christian.gmeiner@gmail.com>
 */

#include "renderonly/renderonly.h"

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>

#include "frontend/drm_driver.h"
#include "pipe/p_screen.h"
#include "util/format/u_format.h"
#include "util/u_inlines.h"
#include "util/u_memory.h"

void
renderonly_scanout_destroy(struct renderonly_scanout *scanout,
			   struct renderonly *ro)
{
   (void)scanout;
   (void)ro;
}

struct renderonly_scanout *
renderonly_create_kms_dumb_buffer_for_resource(struct pipe_resource *rsc,
                                               struct renderonly *ro,
                                               struct winsys_handle *out_handle)
{
   struct renderonly_scanout *scanout = CALLOC_STRUCT(renderonly_scanout);
   (void)rsc;
   (void)ro;
   (void)out_handle;
   return scanout;
}

struct renderonly_scanout *
renderonly_create_gpu_import_for_resource(struct pipe_resource *rsc,
                                          struct renderonly *ro,
                                          struct winsys_handle *out_handle)
{
   struct renderonly_scanout *scanout = CALLOC_STRUCT(renderonly_scanout);
   (void)rsc;
   (void)ro;
   (void)out_handle;
   return scanout;
}
