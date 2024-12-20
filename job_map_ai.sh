#!/bin/bash

# Script para baixar arquivos e pastas de um repositório GitHub (exceto README.md e o próprio script)

# Nome do script atual (para ser ignorado no download)
SCRIPT_NAME="${0##*/}"

# Obtém a URL de onde o script foi executado via curl
if [[ -n "$BASH_SOURCE" ]]; then
    # Executado localmente
    SCRIPT_URL=""
else
    SCRIPT_URL=$(curl -sI "$0" | grep -i '^location:' | sed 's/^[Ll]ocation: *//' | sed 's/\r$//')
fi

# Função para extrair a URL base do repositório a partir da URL do script
extract_repo_url() {
    local script_url="$1"
    # Corrigido para extrair a URL correta em todos os casos
    repo_url=$(echo "$script_url" | sed -E 's|^(https?://)?(raw\.githubusercontent\.com/|https://api.github.com/repos/|' | sed -E 's|/[^/]+/[^/]+$|/contents/|')
    echo "$repo_url"
}

# Se a URL do script foi obtida, extrai a URL do repositório.
if [[ -n "$SCRIPT_URL" ]]; then
    REPO_URL=$(extract_repo_url "$SCRIPT_URL")
else
    # URL base do repositório (usada se o script for executado localmente)
    REPO_URL="https://api.github.com/repos/USUARIO/REPOSITORIO/contents/"
    # Substitua USUARIO e REPOSITORIO pelos valores corretos se executar localmente
    USUARIO="SEU_USUARIO_GITHUB"
    REPOSITORIO="SEU_REPOSITORIO_GITHUB"
fi

# Função para baixar um arquivo
download_file() {
    local url="$1"
    local filename="$2"
    local path="$3"

    echo "Baixando: $filename para $path"
    if ! curl -s -L "$url" -o "$path/$filename"; then
        echo "Erro ao baixar: $filename"
        exit 1
    fi
}

# Função para processar JSON com Python
process_json() {
    local url="$1"
    local script_name="$2"

    python3 -c '
import sys, json

data = json.load(sys.stdin)

for item in data:
    name = item["name"]
    type = item["type"]
    if name == "README.md" or name == sys.argv[1]:
        continue

    if type == "file":
        print(f"file:{item.get(\"download_url\")}:{name}")
    elif type == "dir":
        print(f"dir:{item.get(\"url\")}:{name}")
' "$script_name"
}

# Função para baixar recursivamente o conteúdo de uma pasta
download_dir() {
    local url="$1"
    local path="$2"

    mkdir -p "$path"

    # Verifica se o Python 3 está disponível
    if ! command -v python3 &> /dev/null; then
        echo "Erro: Python 3 não encontrado. Por favor, instale-o e tente novamente."
        exit 1
    fi

    # Obtém a lista de arquivos e pastas e processa com a função Python
    content=$(curl -s "$url" | process_json "$url" "$SCRIPT_NAME")

    # Itera sobre os itens
    while IFS=':' read -r type url name; do
        if [[ "$type" == "file" ]]; then
            download_file "$url" "$name" "$path"
        elif [[ "$type" == "dir" ]]; then
            download_dir "$url" "$path/$name"
        fi
    done <<< "$content"
}

# Pergunta se deseja baixar para o diretório atual ou criar um novo subdiretório
read -r -p "Deseja baixar para o diretório atual (./) ou criar um novo subdiretório? [./ | novo]: " resposta

if [[ "$resposta" == "novo" ]]; then
    read -r -p "Digite o nome do novo subdiretório: " dir_name

    # Verifica se o nome do diretório é válido
    if [[ ! "$dir_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        echo "Nome de diretório inválido. Use apenas letras, números, _ e -."
        exit 1
    fi

    if ! download_dir "$REPO_URL" "$dir_name"; then
        echo "Erro durante o download."
        exit 1
    fi
else
    if ! download_dir "$REPO_URL" "."; then
        echo "Erro durante o download."
        exit 1
    fi
fi

echo "Download concluído!"
