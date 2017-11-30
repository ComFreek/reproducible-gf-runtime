# Reproducible C & Java runtime builds for the Grammatical Framework

This is an attempt to automate compilation of GF's C runtime and Java bindings.

Grammatical Framework (GF)
 - https://www.grammaticalframework.org/
 - https://github.com/GrammaticalFramework/GF/ (mirror)

Status:
 - Linux build: **working**
 - Windows build: **working**

Used software for compiling:
 - Linux & Windows build: OpenJDK 8
 - Windows build: 64-bit version cross-compiled from Ubuntu using `x86_64-w64-mingw32-gcc-win32`.
 - Linux build: (unsure whether 32- or 64-bit)

## How to install
1. Install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) (if you have Chocolatey: `cup virtualbox vagrant -y`).
2. Clone this repository.
3. Run `vagrant up`, this will produce Linux and Windows binaries in `build/`.
4. Shutdown the virtual machine with `vagrant suspend`.
5. Windows-only: If you use the Java bindings, namely any methods in `jpgf.jar`, insert the following Java code before you access any of these methods:

       System.loadLibrary("libgu-0");
       System.loadLibrary("libpgf-0");
       System.loadLibrary("libsg-0");
       System.loadLibrary("jpgf");

    This also works with any other frontend of the JVM, such as Scala.

    `System.loadLibrary("jpgf")` alone (which is called in some `static { ... }` blocks in `jpgf.jar` will fail with

    > "Can't find dependent libraries"

    The fix has been gratefully copied from https://stackoverflow.com/a/2906862.

## How to hack
- `vagrant ssh` for an SSH session
- `vagrant destroy`, `vagrant up` for a complete re-setup of the VM
