# Helpers

```sh
ssh-keyscan -t ed25519 -H 192.168.56.20 >> ~/.ssh/known_hosts
ansible-vault view roles/gitlab/vars/vault.yml --vault-password-file .vault_pass

# Route.where(path: 'killua').destroy_all
# Namespace.where(path: 'killua').destroy_all
User.find_by(username: 'killua').destroy
```
