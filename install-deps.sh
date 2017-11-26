#!/usr/bin/env bash

apt-get update
apt-get install -y git

# From https://github.com/GrammaticalFramework/GF/blob/master/src/runtime/c/INSTALL
apt-get install -y autoconf automake libtool make

# For Windows cross-compilation
apt-get install -y mingw-w64

# For Windows build
apt-get install -y unzip

# For the Java bindings: https://github.com/GrammaticalFramework/GF/blob/master/src/runtime/java/INSTALL
apt-get install -y openjdk-8-jdk
