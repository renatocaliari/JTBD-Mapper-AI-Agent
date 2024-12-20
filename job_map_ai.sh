#!/bin/bash

# Script para baixar arquivos e pastas de um repositório GitHub (exceto README.md e o próprio script)

# Nome do script atual
SCRIPT_NAME=$(basename "$0")

# Obtém a URL de onde o script foi executado (se aplicável)
if [[ -n "$BASH_SOURCE" ]]; then
    # Executado localmente
    SCRIPT_URL=""
else
    SCRIPT_URL=$(curl -sI "$0" | grep -i '^location:' | sed 's/^[Ll]ocation: *//' | tr -d '\r')
fi

# Função para extrair a URL base do repositório
extract_repo_url() {
    local script_url="$1"
    echo "$script_url" | sed -E 's|^(https?://)?(raw\.githubusercontent\.com/|https://api.github.com/repos/)|https://github.com/|' | sed -E 's|/[^/]+/[^/]+.*$|/|'
}

# Define a URL da API do repositório
if [[ -n "$SCRIPT_URL" ]]; then
    REPO_URL=$(extract_repo_url "$SCRIPT_URL")
    REPO_API_URL="${REPO_URL}contents"
else
    # URLs para execução local
    USUARIO="SEU_USUARIO_GITHUB" # Substitua
    REPOSITORIO="SEU_REPOSITORIO_GITHUB" # Substitua
    if [[ -z "$USUARIO" || -z "$REPOSITORIO" ]]; then
        echo "Erro: Defina USUARIO e REPOSITORIO para execução local."
        exit 1
    fi
    REPO_URL="https://github.com/${USUARIO}/${REPOSITORIO}"
    REPO_API_URL="https://api.github.com/repos/${USUARIO}/${REPOSITORIO}/contents"
fi

# Função para baixar um arquivo
download_file() {
    local url="$1"
    local filename="$2"
    local path="$3"

    echo "Baixando: $filename para $path"
    if ! curl -sL "$url" -o "$path/$filename"; then
        echo "Erro ao baixar: $filename de $url"
        return 1
    fi
    return 0
}

# Função para baixar recursivamente o conteúdo de uma pasta (SEM jq)
download_dir() {
    local url="$1"
    local path="$2"

    mkdir -p "$path"

    content=$(curl -s "$url")
    if [[ -z "$content" ]]; then
        echo "Erro: Resposta vazia da API para $url"
        return 1
    fi

    # Usando sed e awk para processar o JSON (menos robusto que jq, mas mais portátil)
    echo "$content" | sed -e 's/[{}]/''/g' | tr ',' '\n' | grep -E '"(name|type|download_url|url)":' | while IFS=: read -r chave valor; do
      chave=$(echo "$chave" | sed 's/"//g')
      valor=$(echo "$valor" | sed 's/"//g')

        if [[ "$chave" == "name" ]]; then
            nome="$valor"
        elif [[ "$chave" == "type" ]]; then
            tipo="$valor"
        elif [[ "$chave" == "download_url" ]]; then
            download_url="$valor"
        elif [[ "$chave" == "url" ]]; then
          url_dir="$valor"
        fi
        if [[ -n "$nome" && -n "$tipo" ]]; then
            if [[ "$nome" != "README.md" && "$nome" != "$SCRIPT_NAME" ]]; then
                if [[ "$tipo" == "file" ]]; then
                  download_file "$download_url" "$nome" "$path" || return 1
                elif [[ "$tipo" == "dir" ]]; then
                  download_dir "$url_dir" "$path/$nome" || return 1
                fi
            fi
            unset nome tipo download_url url_dir
        fi
    done
    return 0
}

# Pergunta sobre o diretório de destino (mesmo código da versão anterior)
read -r -p "Baixar para o diretório atual (./) ou criar um novo? [./|novo]: " resposta
if [[ "$resposta" == "novo" ]]; then
    read -r -p "Nome do novo diretório: " dir_name
    if [[ -z "$dir_name" || ! [[ "$dir_name" =~ ^[a-zA-Z0-9_-]+$ ]] ]]; then
        echo "Nome de diretório inválido."
        exit 1
    fi
    OUTPUT_DIR="$dir_name"
else
    OUTPUT_DIR="."
fi

# Inicia o download
if ! download_dir "$REPO_API_URL" "$OUTPUT_DIR"; then
    echo "Download falhou."
    exit 1
fi

echo "Download concluído!"
