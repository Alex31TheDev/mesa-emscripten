# Copyright © 2017 Intel Corporation
# SPDX-License-Identifier: MIT

virglrenderer_proj = subproject('virglrenderer')

virgl_test_lib_dep = virglrenderer_proj.get_variable('virgl_test_lib_dep')

libvirglvtest_include = [
    inc_include,
    inc_src,
    inc_mapi,
    inc_mesa,
    inc_gallium,
    inc_gallium_aux,
    inc_gallium_drivers,
    inc_virtio,
]

virgl_test_lib_include = virglrenderer_proj.get_variable('virgl_test_lib_include')
libvirglvtest_include += virgl_test_lib_include

libvirglvtest = static_library(
  'virglvtest',
  ['virgl_vtest_socket.c', 'virgl_vtest_winsys.c'],
  include_directories : libvirglvtest_include,
  dependencies : [dep_libvirglcommon, idep_mesautil, virgl_test_lib_dep],
  gnu_symbol_visibility : 'hidden',
)
