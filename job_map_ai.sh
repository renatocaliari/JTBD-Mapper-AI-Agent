#!/bin/bash

# ... (resto do código igual às versões anteriores)

# Cria um diretório temporário
TMP_DIR=$(mktemp -d)
if [[ -z "$TMP_DIR" ]]; then
    echo "Erro ao criar diretório temporário."
    exit 1
fi

# Inicia o download no diretório temporário
if ! download_dir "$REPO_API_URL" "$TMP_DIR"; then
    echo "Download falhou."
    rm -rf "$TMP_DIR" # Limpa o diretório temporário em caso de falha
    exit 1
fi

# Pergunta sobre o diretório de destino
read -r -p "Baixar para o diretório atual (./) ou criar um novo? [./|novo]: " resposta

if [[ "$resposta" == "novo" ]]; then
    read -r -p "Nome do novo diretório: " dir_name
    if [[ -z "$dir_name" || ! [[ "$dir_name" =~ ^[a-zA-Z0-9_-]+$ ]] ]]; then
        echo "Nome de diretório inválido."
        rm -rf "$TMP_DIR" # Limpa o diretório temporário
        exit 1
    fi
    OUTPUT_DIR="$dir_name"
    mkdir -p "$OUTPUT_DIR" # Cria o diretório de destino, se necessário
elif [[ "$resposta" == "./" ]]; then
    OUTPUT_DIR="."
else
    echo "Opção inválida. Baixando para o diretório atual."
    OUTPUT_DIR="."
fi

# Move os arquivos do diretório temporário para o destino
mv "$TMP_DIR"/* "$OUTPUT_DIR"
rm -rf "$TMP_DIR" # Limpa o diretório temporário

echo "Download concluído!"
