#!/bin/bash

#env
#echo "Params: $*"
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
	echo "Adding support for http proxy ($1)"
	export http_proxy=$1
	cat >> $HOME/.gitconfig << EOF
[http]
	proxy = $1
EOF
fi
if [ "$2" != "" ]; then
	echo "Adding support for https proxy ($1)"
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

# Proxy management
opt=""
if [ "$http_proxy" != "" ]; then
	opt="--proxy $http_proxy"
fi
pip install $opt -r bifrost/requirements.txt
perl -pi -e "s|pip:(.*)|pip:\$1 extra_args=\'$opt\'|" bifrost/playbooks/roles/ironic-install/tasks/main.yml
grep pip bifrost/playbooks/roles/ironic-install/tasks/main.yml

cd bifrost
# Local modifs
git checkout docker
#sed -i 's/aSecretPassword473z/linux1/' playbooks/inventory/group_vars/all
./scripts/env-setup.sh
source env-vars
source /opt/stack/ansible/hacking/env-setup
cd playbooks
ansible-playbook -vvvv -i inventory/localhost install.yaml
