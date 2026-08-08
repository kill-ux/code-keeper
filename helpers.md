# Helpers

```sh
ssh-keyscan -t ed25519 -H 192.168.56.20 >> ~/.ssh/known_hosts
ansible-vault view roles/gitlab/vars/vault.yml --vault-password-file .vault_pass

# Route.where(path: 'killua').destroy_all
# Namespace.where(path: 'killua').destroy_all
User.find_by(username: 'killua').destroy
```
<!-- taileskls -->

```txt

cache is chaching inside the host so whe run npm install so it install node_module and catch it in /cache like so he store in time expired for all the piplines
artifacts is from stages of one pipline so each stage can download the stage before artifact 
```