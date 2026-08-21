#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

# Ensure INSTALL_DIR is in PATH for this run (user still needs it in shell rc)
export PATH="$INSTALL_DIR:$PATH"

# -------------------------
# Terragrunt (official installer)
# -------------------------
echo "==> Installing Terragrunt..."
if command -v terragrunt >/dev/null 2>&1; then
  echo "    Terragrunt already installed: $(terragrunt --version)"
else
  curl -sSfL --proto '=https' --tlsv1.2 https://terragrunt.com/install | bash -s -- -d "$INSTALL_DIR"
fi

# -------------------------
# Vagrant
# -------------------------
VAGRANT_VERSION="2.4.9"
VAGRANT_ARCH="amd64"
VAGRANT_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_linux_${VAGRANT_ARCH}.zip"
VAGRANT_ZIP="vagrant_${VAGRANT_VERSION}_linux_${VAGRANT_ARCH}.zip"

echo "==> Installing Vagrant v${VAGRANT_VERSION}..."
if command -v vagrant >/dev/null 2>&1; then
  echo "    Vagrant already installed: $(vagrant --version)"
else
  if [[ ! -f "$VAGRANT_ZIP" ]]; then
    curl -fsSL "$VAGRANT_URL" -o "$VAGRANT_ZIP"
  fi
  # Extract only the 'vagrant' binary, overwrite without prompting
  unzip -o "$VAGRANT_ZIP" vagrant -d "$INSTALL_DIR"
  chmod +x "$INSTALL_DIR/vagrant"
  rm -f "$VAGRANT_ZIP"
fi

# -------------------------
# Terraform
# -------------------------
TF_VERSION="1.15.9"
TF_ARCH="386"  # change to "amd64" or "arm64" if that's your actual arch
TF_URL="https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_${TF_ARCH}.zip"
TF_ZIP="terraform_${TF_VERSION}_linux_${TF_ARCH}.zip"

echo "==> Installing Terraform v${TF_VERSION}..."
if command -v terraform >/dev/null 2>&1; then
  echo "    Terraform already installed: $(terraform version | head -n1)"
else
  if [[ ! -f "$TF_ZIP" ]]; then
    curl -fsSL "$TF_URL" -o "$TF_ZIP"
  fi
  # Extract only the 'terraform' binary, overwrite without prompting
  unzip -o "$TF_ZIP" terraform -d "$INSTALL_DIR"
  chmod +x "$INSTALL_DIR/terraform"
  rm -f "$TF_ZIP"
fi

curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash

# -------------------------
# PATH hint
# -------------------------
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo ""
  echo "==> NOTE: Add ~/.local/bin to your PATH if not already done."
  echo "    For zsh, you can run:"
  echo "    echo 'export PATH=\$HOME/.local/bin:\$PATH' >> ~/.zshrc"
  echo "    then restart your shell or run: source ~/.zshrc"
fi

echo "==> Done."