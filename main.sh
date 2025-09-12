#!/bin/bash

# Ce script permet de mettre à jour des paramètres dans vscode. Quelques exemples sont présentés.
# Les paramètres par défaut de vscode : https://github.com/InseeFrLab/images-datascience/blob/main/vscode/settings/User.json 

# Path to the VSCode settings.json file
SETTINGS_FILE="${HOME}/.local/share/code-server/User/settings.json"

# Check if the settings.json file exists, otherwise create a new one
if [ ! -f "$SETTINGS_FILE" ]; then
    echo "No existing settings.json found. Creating a new one."
    mkdir -p "$(dirname "$SETTINGS_FILE")"
    echo "{}" > "$SETTINGS_FILE"  # Initialize with an empty JSON object
fi

# Add or modify Python-related settings using jq
# We will keep the comments outside the jq block, as jq doesn't support comments inside JSON.
jq '. + {
    "workbench.colorTheme": "Default Dark Modern",  # Set the theme

    "editor.rulers": [80, 100],  # Add specific vertical rulers
    "files.trimTrailingWhitespace": true,  # Automatically trim trailing whitespace
    "files.insertFinalNewline": true,  # Ensure files end with a newline
}' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

# Configure des raccourcis claviers personnalisés pour vscode
# Add shortcuts
echo '[
    {
        "key": "ctrl+shift+d",
        "command": "editor.action.duplicateSelection"  # Duplicate a line
    },
    {
        "key": "ctrl+d",
        "command": "editor.action.deleteLines",  # Delete a line
        "when": "editorTextFocus"
    }
]' > "$HOME/.local/share/code-server/User/keybindings.json"

# Add some omyzsh git aliases to .bashrc 
cat << 'EOF' >> ~/.bashrc
alias g='git'
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gd='git diff'
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias glp='_git_log_prettily'
alias glg='git log --stat'
alias glog='git log --oneline --decorate --graph'
alias glgm='git log --graph --max-count=10'
alias gp='git push'
alias gpf='git push -f'
EOF

source ~/.bashrc

# use ipdb as default debugger, pre-requirement: installed ipdb in working venv
PYTHONBREAKPOINT=ipdb.set_trace

# # Installe via uv les packages contenus dans le fichier pyproject.tml
# situé à la racine du projet gitlab cloné au lancement du service
# prerequis : ajouter un projet gitlab a cloner avec un requirement.tml a la racine
# FIXME: A cause du proxy de LS3, le téléchargement de packages lors du uv sync plante régulièrement. 

# Trouver le nom du sous-dossier dans le répertoire "work"
PROJECT_DIR=$(basename "$(ls -d /home/onyxia/work/*/ | head -n 1)")

# Pour donner plus de chance au uv sync qui doit passer à travers le proxy de LS3
# export UV_CONCURRENT_DOWNLOADS=1
cd "/home/onyxia/work/${PROJECT_DIR}"
uv sync
