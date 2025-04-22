#!/bin/bash

[[ "$OSTYPE" == "darwin"* ]] && {
	echo "Fix ansible bug from https://bit.ly/3tO7ef3"
	export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
}

ansible-playbook -i inventory install-promtail.yml --vault-password-file ~/.ssh/.vault_pass.txt
