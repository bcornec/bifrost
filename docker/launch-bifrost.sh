#!/bin/bash

cat >> $HOME/.gitconfig << EOF
[push]
	default = simple
[user]
	name = Bruno Cornec
	email = bruno.cornec@hp.com
[gitreview]
	username = bruno-cornec
EOF
if [ "$1" != "" ]; then
	export http_proxy=$1
	cat >> $HOME/.gitconfig << EOF
[http]
	proxy = $1
EOF
fi
if [ "$2" != "" ]; then
	export https_proxy=$2
	cat >> $HOME/.gitconfig << EOF
[https]
	proxy = $2
EOF
fi
export BIFROST_DOCKER=YES

# Local repo
git clone https://github.com/bcornec/bifrost.git
#git clone https://github.com/openstack/bifrost.git
# Local modifs
git checkout docker

# Proxy management
opt=""
if [ "$http_proxy" != "" ]; then
	opt="--proxy $http_proxy"
pip install $opt -r bifrost/requirements.txt
fi

cd bifrost
#sed -i 's/aSecretPassword473z/linux1/' playbooks/inventory/group_vars/all
./script/env-setup.sh
source env-vars
source /opt/stack/ansible/hacking/env-setup
cd playbooks
ansible-playbook -vvvv -i inventory/localhost install.yaml
