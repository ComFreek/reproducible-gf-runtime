GF_GIT_REPO=https://github.com/GrammaticalFramework/GF.git

# Clone
if [ -d ~/gf_win ]; then
	cd ~/gf_win
	git clean -xdf
else
	git clone --depth=1 $GF_GIT_REPO ~/gf_win
fi

cd ~/gf_win/src/runtime/c

autoreconf -i
./configure CC=x86_64-w64-mingw32-gcc-win32 CPP=/usr/bin/x86_64-w64-mingw32-cpp-win32 CFLAGS=-lm --host=x86_64-w64-mingw32 --disable-static --enable-shared
make
sudo make install
