#!/bin/bash

cat >> $HOME/.gitconfig << EOF
[push]
	default = simple
[user]
	name = Bruno Cornec
	email = bruno.cornec@hp.com
[gitreview]
	username = bruno-cornec
[https]
	proxy = http://web-proxy.fra.hp.com:8080
[http]
	proxy = http://web-proxy.fra.hp.com:8080
EOF
git clone https://github.com/openstack/bifrost.git
pip install --proxy web-proxy.fra.hp.com:8080 -r bifrost/requirements.txt
cd bifrost
sed -i 's/aSecretPassword473z/linux1/' playbooks/inventory/group_vars/all
../setup-env.sh
source env-vars
source /opt/stack/ansible/hacking/env-setup
cd playbooks
ansible-playbook -vvvv -i inventory/localhost install.yaml
