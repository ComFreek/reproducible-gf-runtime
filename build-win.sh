GF_GIT_REPO=https://github.com/GrammaticalFramework/GF.git
GF_LOCAL_REPO=~/gf_win
OUTPUT_DIR=/vagrant/build/win

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Clone
if [ -d "$GF_LOCAL_REPO" ]; then
  cd ~/gf_win
  git clean -xdf
  git checkout .
  git pull origin master
else
  git clone --depth=1 "$GF_GIT_REPO" "$GF_LOCAL_REPO"
fi

# BUILD C RUNTIME
# =========================

cd "$GF_LOCAL_REPO/src/runtime/c"

autoreconf -i
./configure CC=x86_64-w64-mingw32-gcc-win32 CPP=/usr/bin/x86_64-w64-mingw32-cpp-win32 CFLAGS="-lm" --host=x86_64-w64-mingw32 --disable-static --enable-shared

# Fix for the following error when running 'make':
#
#  CCLD     libpgf.la
#  libtool:   error: can't build x86_64-w64-mingw32 shared library unless -no-undefined is specified
#
sed -i -e 's/CCLD = $(CC)/CCLD = $(CC) -no-undefined/' Makefile

# Fix for undefined references to some SQLite3 functions
cp /vagrant/sqlite3-fix.c sg/
echo '#include "sqlite3-fix.c"' >> sg/sg.c

sudo make install

# BUILD JAVA RUNTIME
# =========================
cd "$GF_LOCAL_REPO/src/runtime/java"

JAVA_SYMLINK_DEST=/usr/lib/jvm/default-java
JAVA_SYMLINK_SRC=/usr/lib/jvm/java-8-openjdk-amd64

# Edit Makefile to include
# JNI_INCLUDES = -I/usr/lib/jvm/java-8-openjdk-amd64/include -I/usr/lib/jvm/java-8-openjdk-amd64/include/linux
# CFLAGS = -I../c
if [ -L $JAVA_SYMLINK_DEST ]; then
  sudo rm $JAVA_SYMLINK_DEST
fi

# To overcome the "JNI_INCLUDES missing" error
sudo ln -sf $JAVA_SYMLINK_SRC $JAVA_SYMLINK_DEST

# To overcome $(LIBTOOL) in the Java Makefile to always choose
# the default gcc binary to link even when the command is
# "$(LIBTOOL) --mode=link x86_64-w64-mingw32-gcc-win32 ..."
rm -rf fake_gcc
mkdir -p fake_gcc
ln -s "$(which x86_64-w64-mingw32-gcc-win32)" fake_gcc/gcc
export _GF_BUILD_PATH_BACKUP=$PATH
export PATH=fake_gcc:$PATH

export CFLAGS=-I../c
make

export PATH=$_GF_BUILD_PATH_BACKUP
unset _GF_BUILD_PATH_BACKUP

# COPY OUTPUT FILES
# =========================
# TODO: needs fixing, maybe too few libraries copied!
cp jpgf.jar "$OUTPUT_DIR"
cp .libs/libjpgf.so.0.0.0 "$OUTPUT_DIR/libjpgf.dll"
