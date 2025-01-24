#!/bin/bash

# Repository URL
REPO_URL="https://raw.githubusercontent.com/renatocaliari/JTBD-Mapper-AI-Agent/main/"
API_URL="https://api.github.com/repos/renatocaliari/JTBD-Mapper-AI-Agent/releases/latest"

# Local directory to save files
LOCAL_DIR="JTBD-Mapper-AI-Agent"
INFO_FILE="$LOCAL_DIR/release_info.txt"

# Create the local directory if it doesn't exist
mkdir -p "$LOCAL_DIR"

# Get latest release info using GitHub API
RELEASE_INFO=$(curl -s "$API_URL")

# Extract tag name using regular expressions with grep and sed
TAG_NAME=$(echo "$RELEASE_INFO" | grep '"tag_name":' | sed 's/.*: "\(.*\)".*/\1/')

# Extract publish date using regular expressions with grep and sed
PUBLISH_DATE=$(echo "$RELEASE_INFO" | grep '"published_at":' | sed 's/.*: "\(.*\)".*/\1/')

# Save the information to a file
echo "Tag: $TAG_NAME" > "$INFO_FILE"
echo "Publish Date: $PUBLISH_DATE" >> "$INFO_FILE"

# List of files and directories to download
FILES=(
    "README.md"
    "custom_instructions.md"
    "project_roadmap.md"
    "prompts_docs/actors.md"
    "prompts_docs/job_steps.md"
    "prompts_docs/job_factors.md"
    "prompts_docs/adjacent_jobs.md"
    "prompts_docs/emotional_social_jobs.md"
    "prompts_docs/segments.md"
    "prompts_docs/actors_metrics.md"
    "prompts_docs/success_criteria_needs.md"
    "prompts_docs/switchers_quotes.md"
    "prompts_docs/solution_space_market_analysis.md"
)

# Loop to download each file
for FILE in "${FILES[@]}"; do
    FILE_URL="$REPO_URL/$FILE"
    LOCAL_FILE="$LOCAL_DIR/$FILE"

    mkdir -p "$(dirname "$LOCAL_FILE")"

    if curl -sSfLo "$LOCAL_FILE" "$FILE_URL"; then
        echo "Downloaded: $FILE"
    else
        echo "Error: $FILE"
    fi
done

echo "Download complete. Release information saved to $INFO_FILE"
