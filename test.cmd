pushd %~dp0
mkdir webrtcBuild
cd webrtcBuild
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
set path=%~dp0webrtcBuild\depot_tools;%path%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_MSVS_VERSION = 2017
set GYP_MSVS_OVERRIDE_PATH = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional"
set GYP_GENERATORS=msvs-ninja,ninja
echo %path%
call gclient
@echo on
call fetch --nohooks webrtc
@echo on
call gclient sync
@echo on
cd src
call git checkout branch-heads/72
call gn gn gen out/TestBuild --args="is_debug=true is_clang=false symbol_level=2 target_cpu=\"x64\" use_custom_libcxx=false enable_iterator_debugging=true"
call ninja -C out/TestBuild
pause