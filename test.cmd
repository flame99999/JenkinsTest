pushd %~dp0
mkdir webrtcBuild
cd webrtcBuild
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
set path=%~dp0webrtcBuild\depot_tools;%path%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
set GYP_MSVS_VERSION = 2017
set GYP_MSVS_OVERRIDE_PATH = C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise
set GYP_GENERATORS=msvs-ninja,ninja
echo %path%
call gclient
call fetch --nohooks webrtc
call gclient sync
cd src
call git checkout branch-heads/72
call gn gen out/TestBuild
call ninja -C out/TestBuild
pause