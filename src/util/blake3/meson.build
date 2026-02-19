files_blake3 = [
    'blake3.c',
    'blake3_dispatch.c',
    'blake3_portable.c'
]
blake3_defs = [
  '-DBLAKE3_NO_SSE2',
  '-DBLAKE3_NO_SSE41',
  '-DBLAKE3_NO_AVX2',
  '-DBLAKE3_NO_AVX512',
  '-DBLAKE3_USE_NEON=0',
]

blake3 = static_library(
  'blake3',
  files_blake3,
  c_args : blake3_defs,
  gnu_symbol_visibility : 'hidden',
)

idep_blake3 = declare_dependency(
  link_with : blake3,
)
