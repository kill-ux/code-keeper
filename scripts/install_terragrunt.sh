~!#/bin/bash

curl -sSfL --proto '=https' --tlsv1.2 https://terragrunt.com/install | bash -s -- -d /home/muboutoub/.local/bin

# check if terragrunt is installed
if ! command -v terragrunt &> /dev/null; then
    echo "export PATH=\$PATH:/home/muboutoub/.local/bin" >> ~/.zshrc
    echo "source ~/.zshrc"
fi