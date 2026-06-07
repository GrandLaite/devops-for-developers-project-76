.PHONY: install lint prepare deploy monitoring secrets-edit secrets-view

install:
	ansible-galaxy install -r requirements.yml

lint: install
	ansible-playbook -i inventory.ini playbook.yml --syntax-check
	ansible-lint

prepare: install
	ansible-playbook -i inventory.ini playbook.yml --tags setup

deploy:
	ansible-playbook -i inventory.ini playbook.yml --tags deploy

monitoring:
	ansible-playbook -i inventory.ini playbook.yml --tags monitoring

secrets-edit:
	ansible-vault edit group_vars/webservers/vault.yml

secrets-view:
	ansible-vault view group_vars/webservers/vault.yml
