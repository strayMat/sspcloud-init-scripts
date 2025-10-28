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

#!/bin/sh

# This init script install various useful VScode extensions
# NB : only extensions from the Open VSX Registry (https://open-vsx.org/) can be installed on code-server
# Expected parameters : None

# CONFORT EXTENSIONS -----------------

# Colorizes the indentation in front of text
code-server --install-extension oderwat.indent-rainbow
# Extensive markdown integration
code-server --install-extension yzhang.markdown-all-in-one
# Integrates Excalidraw (software for sketching diagrams)
code-server --install-extension pomdtr.excalidraw-editor
# Ruff extension for fast Python linter and code formatter
code-server --install-extension charliermarsh.ruff
# Roo code for agenting coding
code-server --install-extension RooVeterinaryInc.roo-cline

# COPILOT ----------------------------

# Install Copilot (Microsoft's AI-assisted code writing tool)
copilotVersion="1.234.0"
copilotChatVersion="0.20.0" # This version is not compatible with VSCode server 1.92.2

wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/${copilotVersion}/vspackage -O copilot.vsix.gz
wget --retry-on-http-error=429 https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/${copilotChatVersion}/vspackage -O copilot-chat.vsix.gz

gzip -d copilot.vsix.gz 
gzip -d copilot-chat.vsix.gz 

code-server --install-extension copilot.vsix
code-server --install-extension copilot-chat.vsix
rm copilot.vsix copilot-chat.vsix

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

# Add aliases to .bashrc
cat << 'EOF' >> ~/.bashrc
# Some omyzsh git aliases 
# aliases for git (from omyzsh)
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
alias gl='git pull'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gclean='git clean --interactive -d'
alias gcl='git clone --recurse-submodules'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'

# cp without overwrite the cache of uv (which is loaded by default from s3 into working dir)
alias saveuv='mc mirror /home/onyxia/work/.cache/uv/ "s3/travail/user-ffgkdk/insee/uv/"'
EOF


source ~/.bashrc

# use ipdb as default debugger, pre-requirement: installed ipdb in working venv
export PYTHONBREAKPOINT=ipdb.set_trace

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
