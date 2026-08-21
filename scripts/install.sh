~!#/bin/bash

curl -sSfL --proto '=https' --tlsv1.2 https://terragrunt.com/install | bash -s -- -d $HOME/.local/bin

wget https://releases.hashicorp.com/vagrant/2.4.9/vagrant_2.4.9_linux_amd64.zip

unzip vagrant_2.4.9_linux_amd64.zip -d ~/.local/bin 

# check if terragrunt is installed
if ! command -v terragrunt &> /dev/null; then
    echo "export PATH=\$PATH:$HOME/.local/bin" >> ~/.zshrc
    echo "source ~/.zshrc"
fi

pip install --upgrade pip
pip install ansible