.PHONY: help up down destroy status ssh provision lint syntax ping deploy deploy-check clean

# Default target when running just 'make'
.DEFAULT_GOAL := help

## ----------------------------------------------------------------------
## VAGRANT COMMANDS
## ----------------------------------------------------------------------

up: ## Start and provision the Vagrant VM
	vagrant up

down: ## Stop (halt) the Vagrant VM
	vagrant halt

destroy: ## Destroy the Vagrant VM (forces wipe)
	vagrant destroy -f

status: ## Check the status of the Vagrant VM
	vagrant status

ssh: ## SSH directly into the Vagrant VM
	vagrant ssh

provision: ## Run Vagrant provisioner (re-runs Ansible via Vagrant)
	vagrant provision

## ----------------------------------------------------------------------
## ANSIBLE COMMANDS
## ----------------------------------------------------------------------

ping: ## Ping all hosts in the inventory to verify connection
	cd ansible && ansible all -m ping

syntax: ## Check Ansible playbooks for syntax errors
	cd ansible && ansible-playbook site.yml --syntax-check

lint: ## Run ansible-lint to check best practices (requires ansible-lint)
	cd ansible && ansible-lint site.yml

deploy: ## Run the main Ansible playbook
	cd ansible && ansible-playbook site.yml

deploy-check: ## Dry-run the main Ansible playbook (check mode)
	cd ansible && ansible-playbook site.yml --check --diff

vault-encrypt: ## Encrypt gitlab vault file
	cd ansible && ansible-vault encrypt roles/gitlab/vars/vault.yml

vault-decrypt: ## Decrypt gitlab vault file
	cd ansible && ansible-vault decrypt roles/gitlab/vars/vault.yml

## ----------------------------------------------------------------------
## HELP
## ----------------------------------------------------------------------

help: ## Show available commands
	@echo "Usage: make [target]"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'