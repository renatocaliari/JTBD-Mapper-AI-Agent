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
  # Remove a parte "/raw/" da URL
  base_url=$(echo "$script_url" | sed 's/\/raw\///')
  # Remove o nome do script e a branch da URL, ficando só com /repos/USER/REPO/contents/
  repo_url=$(echo "$base_url" | sed "s#\(https://[^/]\+\.com/repos/[^/]\+/[^/]\+\)/contents/.*#\1/contents/#")
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
  curl -s -L "$url" -o "$path/$filename"
}

# Função para baixar recursivamente o conteúdo de uma pasta
download_dir() {
  local url="$1"
  local path="$2"

  mkdir -p "$path"

  # Obtém a lista de arquivos e pastas
  content=$(curl -s "$url")

  # Itera sobre os itens
  echo "$content" | jq -c '.[]' | while read -r item; do
    name=$(echo "$item" | jq -r '.name')
    type=$(echo "$item" | jq -r '.type')
    download_url=$(echo "$item" | jq -r '.download_url')
    dir_url=$(echo "$item" | jq -r '.url')

    # Ignora o README.md e o próprio script
    if [[ "$name" == "README.md" ]] || [[ "$name" == "$SCRIPT_NAME" ]]; then
      continue
    fi

    if [[ "$type" == "file" ]]; then
      download_file "$download_url" "$name" "$path"
    elif [[ "$type" == "dir" ]]; then
      download_dir "$dir_url" "$path/$name"
    fi
  done
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

  download_dir "$REPO_URL" "$dir_name"
else
  download_dir "$REPO_URL" "."
fi

echo "Download concluído!"
