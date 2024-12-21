#!/bin/bash

# URL do repositório
REPO_URL="https://raw.githubusercontent.com/renatocaliari/joby-labs-agent/main/"

# Diretório local para salvar os arquivos
LOCAL_DIR="joby-labs-agent"

# Cria o diretório local, caso não exista
mkdir -p "$LOCAL_DIR"

# Lista de arquivos e diretórios a serem baixados (excluindo README.md e o script atual)
FILES=(
    "README.md"
    "custom_instructions.md"
    "prompts_docs/actors_roles.md"
    "prompts_docs/job_steps.md"
    "prompts_docs/job_variables.md"
    "prompts_docs/related_jobs.md"
    "prompts_docs/segments.md"
    "prompts_docs/success_criteria_needs.md"
)

# Loop para baixar cada arquivo
for FILE in "${FILES[@]}"; do
    # Constrói a URL completa do arquivo
    FILE_URL="$REPO_URL/$FILE"
    
    # Constrói o caminho local completo para o arquivo
    LOCAL_FILE="$LOCAL_DIR/$FILE"

    # Cria o diretório pai, se necessário
    mkdir -p "$(dirname "$LOCAL_FILE")"
    
    # Baixa o arquivo usando curl com tratamento de erro
    if curl -sSfLo "$LOCAL_FILE" "$FILE_URL"; then
        echo "Downloaded: $FILE"
    else
        echo "Error: $FILE"
    fi
done

echo "Download complete."
