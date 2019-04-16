pushd %~dp0
mkdir webrtcBuild
cd webrtcBuild
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
set path=%~dp0webrtBuild\depot_tools;%path%
echo %path%
gclient
cd ../
fetch --nohooks webrtc
gclient sync
git checkout branch-heads/72
gn gen out/TestBuild
ninja -C out/TestBuild