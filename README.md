# Reproducible C & Java runtime builds for the Grammatical Framework

This is an attempt to automate compilation of GF's C runtime and Java bindings.

Grammatical Framework (GF)
 - https://www.grammaticalframework.org/
 - https://github.com/GrammaticalFramework/GF/ (mirror)

Status:
 - Linux build: **working**
 - Windows build: **almost working** (see TODO in `build-win.sh`)

## How to install
1. Install [VirtualBox](https://www.virtualbox.org/) (if you have Chocolatey: `cup virtualbox -y`).
2. Install [Vagrant](https://www.vagrantup.com/) (if you have Chocolatey: `cup vagrant -y`).
3. Clone this repository.
4. Run `vagrant up`.
5. Find your binaries in `buid/`.
6. Shutdown the virtual machine with `vagrant suspend`.

## How to hack
- `vagrant ssh` for an SSH session
- `vagrant destroy`, `vagrant up` for a complete re-setup of the VM
