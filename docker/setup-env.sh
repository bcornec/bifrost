#!/bin/bash

u=$(whoami)
g=$(groups | awk '{print $1}')

if [ ! -d /opt/stack ]; then
    mkdir -p /opt/stack 2> /dev/null || (sudo mkdir -p /opt/stack)
fi
sudo -H chown -R $u:$g /opt/stack
cd /opt/stack

# NOTE(TheJulia): Switching to Ansible stable-1.9 branch as the development
# branch is undergoing some massive changes and we are seeing odd failures
# that we should not be seeing.  Until devel has stabilized, we should stay
# on the stable branch.
if [ ! -d ansible ]; then
    git clone https://github.com/ansible/ansible.git --recursive -b stable-1.9
else
    cd ansible
    git checkout stable-1.9
    git pull --rebase
    git submodule update --init --recursive
    git fetch
fi

echo
echo "If your using this script directly, execute the"
echo "following commands to update your shell."
echo
echo "source env-vars"
echo "source /opt/stack/ansible/hacking/env-setup"
echo
