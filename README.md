# Reproducible C runtime builds for the Grammatical Framework

Grammatical Framework (GF)
 - https://www.grammaticalframework.org/
 - https://github.com/GrammaticalFramework/GF/ (mirror)

Status: **CURRENTLY NOT WORKING**

This is an attempt to ease compilation of GF's C runtime primarily Windows by cross-compiling it from withing an Ubuntu VM for Windows.

## How to hack
- Install [VirtualBox](https://www.virtualbox.org/) (if you have Chocolatey: `cup virtualbox -y`)
- Install [Vagrant](https://www.vagrantup.com/) (if you have Chocolatey: `cup vagrant -y`)
- `vagrant up` in this repo's cloned directory
- `vagrant ssh` for an SSH session
- `vagrant destroy`, `vagrant up` for a complete re-setup of the VM
