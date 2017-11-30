GF_GIT_REPO=https://github.com/GrammaticalFramework/GF.git
GF_LOCAL_REPO=~/gf_linux
OUTPUT_DIR=/vagrant/build/linux

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Clone
if [ -d "$GF_LOCAL_REPO" ]; then
  cd "$GF_LOCAL_REPO"
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
./configure
make
sudo make install

# BUILD JAVA RUNTIME
# =========================
cd "$GF_LOCAL_REPO/src/runtime/java"

JAVA_SYMLINK_DEST=/usr/lib/jvm/default-java
JAVA_SYMLINK_SRC=/usr/lib/jvm/java-8-openjdk-amd64

# To overcome the "JNI_INCLUDES missing" error because
# the Makefile doesn't test the OpenJDK paths (see above)
if [ -L $JAVA_SYMLINK_DEST ]; then
  sudo rm $JAVA_SYMLINK_DEST
fi
sudo ln -sf $JAVA_SYMLINK_SRC $JAVA_SYMLINK_DEST

make
sudo make install

# COPY OUTPUT FILES
# =========================
cd "$GF_LOCAL_REPO/src/runtime/c/.libs"
cp * "$OUTPUT_DIR"
cp "$GF_LOCAL_REPO/src/runtime/java/jpgf.jar" "$OUTPUT_DIR"
cd "$GF_LOCAL_REPO/src/runtime/java/.libs"
cp * "$OUTPUT_DIR"
