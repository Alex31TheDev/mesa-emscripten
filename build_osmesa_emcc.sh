#!/usr/bin/env bash
set -euo pipefail

# DEBUG="--debug"
MODE="${1:-}"

if [[ -z "$MODE" ]]; then
  echo "usage: $0 <size|performance>" >&2
  exit 1
fi

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname "$0")" && pwd)"
BUILD_DIR="${SCRIPT_DIR}/build-em"
CROSS_FILE="${BUILD_DIR}/emscripten-cross.ini"

COMMON_BUILD_ARGS="--buildtype=release -Dauto_features=disabled -Db_lto=true -Db_ndebug=true -Db_asneeded=false -Db_lundef=false"
COMMON_C_ARGS="'-flto','-DNDEBUG','-D_POSIX_C_SOURCE=200809L','-D_GNU_SOURCE'"
COMMON_RUNTIME_ARGS="'-sASSERTIONS=0','-sSAFE_HEAP=0','-sSTACK_OVERFLOW_CHECK=0','-sGL_ASSERTIONS=0','-sDEMANGLE_SUPPORT=0'"

case "$MODE" in
  size)
    MODE_BUILD_ARGS="${COMMON_BUILD_ARGS} --optimization=s"
    EM_C_ARGS="'-Oz',${COMMON_C_ARGS}"
    EM_LINK_ARGS="'-Oz','-flto',${COMMON_RUNTIME_ARGS},'-sMALLOC=emmalloc'"
    ;;
  performance)
    MODE_BUILD_ARGS="${COMMON_BUILD_ARGS} --optimization=3"
    EM_C_ARGS="'-O3',${COMMON_C_ARGS},'-ffast-math','-msimd128','-fno-math-errno','-fno-trapping-math'"
    EM_LINK_ARGS="'-O3','-ffast-math','-flto','-msimd128',${COMMON_RUNTIME_ARGS}"
    ;;
  *)
    echo "usage: $0 <size|performance>" >&2
    exit 1
    ;;
esac

echo "Configuring OSMesa build mode: $MODE"
mkdir -p "$BUILD_DIR"

cat > "$CROSS_FILE" <<EOF
[binaries]
c = 'emcc'
cpp = 'em++'
ar = 'emar'
ranlib = 'emranlib'
pkg-config = 'pkg-config'

[host_machine]
system = 'emscripten'
cpu_family = 'wasm32'
cpu = 'wasm32'
endian = 'little'

[properties]
needs_exe_wrapper = true
skip_sanity_check = true

[built-in options]
c_args = [${EM_C_ARGS}]
cpp_args = [${EM_C_ARGS}]
c_link_args = [${EM_LINK_ARGS}]
cpp_link_args = [${EM_LINK_ARGS}]
b_asneeded = false
b_lundef = false
EOF

if [ -d "$BUILD_DIR/meson-info" ]; then
  RECONFIGURE="--reconfigure"
else
  RECONFIGURE=""
fi

meson setup "$BUILD_DIR" "$SCRIPT_DIR" ${RECONFIGURE} ${DEBUG:-} $MODE_BUILD_ARGS \
  --cross-file "$CROSS_FILE" \
  -Ddefault_library=static \
  --prefix=/tmp/osmesa \
  -Dsplit-debug=disabled \
  -Dplatforms=[] \
  -Degl-native-platform=surfaceless \
  -Dandroid-stub=false \
  -Dandroid-strict=true \
  -Dandroid-libbacktrace=disabled \
  -Ddri-drivers-path='' \
  -Dvdpau-libs-path='' \
  -Dva-libs-path='' \
  -Dgallium-wgl-dll-name=libgallium_wgl \
  -Dgallium-d3d10-dll-name=libgallium_d3d10 \
  -Dd3d-drivers-path='' \
  -Dunversion-libgallium=false \
  -Dexpat=disabled \
  -Dgallium-drivers=softpipe \
  -Dgallium-extra-hud=false \
  -Dgallium-vdpau=disabled \
  -Dgallium-va=disabled \
  -Dgallium-xa=disabled \
  -Dgallium-nine=false \
  -Dgallium-d3d10umd=false \
  -Dgallium-opencl=disabled \
  -Dgallium-rusticl=false \
  -Dgallium-rusticl-enable-drivers=[] \
  -Dopencl-spirv=false \
  -Dstatic-libclc=[] \
  -Dvulkan-drivers=[] \
  -Dfreedreno-kmds=[] \
  -Dimagination-srv=false \
  -Dshader-cache=disabled \
  -Dshader-cache-default=false \
  -Dshader-cache-max-size='' \
  -Dvulkan-layers=[] \
  -Dshared-glapi=disabled \
  -Dgles1=disabled \
  -Dgles2=disabled \
  -Dopengl=true \
  -Dgbm=disabled \
  -Dgbm-backends-path='' \
  -Dglx=disabled \
  -Degl=disabled \
  -Dglvnd=disabled \
  -Dglvnd-vendor-name=mesa \
  -Degl-lib-suffix='' \
  -Dgles-lib-suffix='' \
  -Dmicrosoft-clc=disabled \
  -Dspirv-to-dxil=false \
  -Dglx-read-only-text=false \
  -Dllvm=disabled \
  -Dshared-llvm=disabled \
  -Ddraw-use-llvm=false \
  -Damd-use-llvm=false \
  -Dvalgrind=disabled \
  -Dlibunwind=disabled \
  -Dlmsensors=disabled \
  -Dbuild-tests=false \
  -Denable-glcpp-tests=false \
  -Dbuild-aco-tests=false \
  -Dinstall-intel-gpu-tests=false \
  -Dhtml-docs=disabled \
  -Dhtml-docs-path='' \
  -Dselinux=false \
  -Dexecmem=false \
  -Dosmesa=true \
  -Dtools=[] \
  -Dpower8=disabled \
  -Dxlib-lease=disabled \
  -Dglx-direct=false \
  -Dplatform-sdk-version=25 \
  -Dallow-kcmp=disabled \
  -Dzstd=disabled \
  -Dzlib=disabled \
  -Dsse2=false \
  -Dperfetto=false \
  -Ddatasources=[] \
  -Dteflon=false \
  -Dgpuvis=false \
  -Dcustom-shader-replacement='' \
  -Dvmware-mks-stats=false \
  -Dvulkan-beta=false \
  -Dvulkan-icd-dir='' \
  -Dmoltenvk-dir='' \
  -Dintel-clc=system \
  -Dinstall-intel-clc=false \
  -Dintel-rt=disabled \
  -Dradv-build-id='' \
  -Dmin-windows-version=8 \
  -Dvideo-codecs=[] \
  -Dgallium-d3d12-video=disabled \
  -Dgallium-d3d12-graphics=disabled \
  -Dxmlconfig=disabled \
  -Dlegacy-x11=none
