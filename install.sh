#!/bin/bash
# INSTALADOR AUTOMÁTICO - TALISMAN TOOLS

BASE_DIR="/home/talisman/.talisman-tools"
REPO_URL="https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPO/main"

echo "Instalando Talisman Tools em $BASE_DIR..."
mkdir -p $BASE_DIR

# Lista de arquivos para baixar (ajuste os nomes se necessário)
FILES=("menu.sh" "install-server-talisman.sh" "uinstall-server-talisman.sh" "install-hamachi-ubuntu14.sh" "uinstall-hamachi-ubuntu14.sh" "config_ip_e_senha_server_talisman.sh" "email.sh" "criar_gm.sh" "ligar_server_ubuntu_14.sh" "desligar_server_ubuntu_14.sh")

for file in "${FILES[@]}"; do
    wget -q "$REPO_URL/$file" -O "$BASE_DIR/$file"
done

chmod +x $BASE_DIR/*.sh

# Configura o Alias no .bashrc
sed -i '/alias menu=/d' ~/.bashrc
echo "alias menu='bash $BASE_DIR/menu.sh'" >> ~/.bashrc
source ~/.bashrc

echo "Instalação concluída! Digite 'menu' para começar."