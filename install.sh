#!/bin/bash

# ==========================================================
# INSTALADOR VIA GITHUB ZIP - TALISMAN TOOLS
# CONFIGURADO PARA: UBUNTU 14.04 | by ELTON SOUSA
# ==========================================================

# DEFINIÇÃO DE CORES
VERDE_B='\033[1;32m'
AMARELO='\033[1;33m'
CIANO='\033[0;36m'
SEM_COR='\033[0m'

TARGET_DIR="/home/talisman/.talisman-tools"
ZIP_URL="https://github.com/eltonsousa/talisman-tools/archive/refs/heads/main.zip"

clear
echo -e "${CIANO}[*] INICIANDO INSTALAÇÃO DO TALISMAN TOOLS...${SEM_COR}"

# 1. Instalar o 'unzip' caso não tenha (comum em sistemas limpos)
echo -e "${AMARELO}[1/4] Verificando dependências...${SEM_COR}"
apt-get update -qq && apt-get install unzip -y -qq > /dev/null 2>&1

# 2. Criar diretório e baixar o ZIP
echo -e "${AMARELO}[2/4] Baixando repositório do GitHub...${SEM_COR}"
mkdir -p "$TARGET_DIR"
wget -q "$ZIP_URL" -O /tmp/talisman-tools.zip

# 3. Extrair e Limpar
echo -e "${AMARELO}[3/4] Extraindo arquivos e organizando...${SEM_COR}"
unzip -q /tmp/talisman-tools.zip -d /tmp/
# O GitHub extrai para uma pasta chamada 'talisman-tools-main', movemos o conteúdo dela
cp -r /tmp/talisman-tools-main/* "$TARGET_DIR/"
rm -rf /tmp/talisman-tools-main /tmp/talisman-tools.zip

# 4. Permissões e Alias (Atalho)
echo -e "${AMARELO}[4/4] Configurando permissões e atalhos...${SEM_COR}"
chmod +x "$TARGET_DIR"/*.sh

# Configura o comando 'menu' e 'talisman' no .bashrc do Root e do Usuário
for rc in "/root/.bashrc" "/home/talisman/.bashrc"; do
    if [ -f "$rc" ]; then
        sed -i '/alias menu=/d' "$rc"
        sed -i '/alias talisman=/d' "$rc"
        echo "alias menu='bash $TARGET_DIR/menu.sh'" >> "$rc"
        echo "alias talisman='bash $TARGET_DIR/menu.sh'" >> "$rc"
    fi
done

echo -e "\n${VERDE_B}============================================================"
echo -e "       INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
echo -e "============================================================${SEM_COR}"
echo -e "Para abrir o painel agora, digite: ${CIANO}menu${SEM_COR}"
echo -e "${AMARELO}NOTA:${SEM_COR} Se o comando 'menu' não funcionar de imediato,"
echo -e "digite 'source ~/.bashrc' ou reinicie o terminal.\n"