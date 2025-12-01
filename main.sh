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
# Create a roo config file (maybe too many things into it)
ROO_CONFIG_FILE="/home/onyxia/work/roo_code_model_selector_config.json"
jq '. + {
"providerProfiles":{"currentApiConfigName":"default","apiConfigs":{"default":{"openAiBaseUrl":"https://llm.lab.sspcloud.fr/api","openAiApiKey":"sk-6bddcbf962154cd181b863e434e00711","openAiModelId":"gpt-oss:120b","openAiHeaders":{},"apiProvider":"openai","id":"d4qjvwhcmvg"}},"modeApiConfigs":{"architect":"d4qjvwhcmvg","code":"d4qjvwhcmvg","ask":"d4qjvwhcmvg","debug":"d4qjvwhcmvg","orchestrator":"d4qjvwhcmvg"},"migrations":{"rateLimitSecondsMigrated":true,"diffSettingsMigrated":true,"openAiHeadersMigrated":true,"consecutiveMistakeLimitMigrated":true,"todoListEnabledMigrated":true}},"globalSettings":{"lastShownAnnouncementId":"nov-2025-v3.34.0-browser-use-2-cloud-paid","openRouterImageApiKey":"","openRouterImageGenerationSelectedModel":"","condensingApiConfigId":"","customCondensingPrompt":"","alwaysAllowReadOnly":false,"alwaysAllowReadOnlyOutsideWorkspace":false,"alwaysAllowWrite":false,"alwaysAllowWriteOutsideWorkspace":false,"alwaysAllowWriteProtected":false,"writeDelayMs":1000,"alwaysAllowBrowser":false,"alwaysApproveResubmit":false,"requestDelaySeconds":10,"alwaysAllowMcp":false,"alwaysAllowModeSwitch":false,"alwaysAllowSubtasks":false,"alwaysAllowExecute":false,"alwaysAllowFollowupQuestions":false,"followupAutoApproveTimeoutMs":60000,"alwaysAllowUpdateTodoList":false,"allowedCommands":["git log","git diff","git show"],"deniedCommands":[],"allowedMaxRequests":null,"allowedMaxCost":null,"autoCondenseContext":true,"autoCondenseContextPercent":100,"maxConcurrentFileReads":5,"includeCurrentTime":true,"includeCurrentCost":true,"maxGitStatusFiles":0,"includeDiagnosticMessages":true,"maxDiagnosticMessages":50,"browserToolEnabled":true,"browserViewportSize":"900x600","screenshotQuality":75,"remoteBrowserEnabled":false,"enableCheckpoints":true,"checkpointTimeout":15,"ttsEnabled":false,"ttsSpeed":1,"soundEnabled":false,"soundVolume":0.5,"maxOpenTabsContext":20,"maxWorkspaceFiles":200,"showRooIgnoredFiles":false,"maxReadFileLine":-1,"maxImageFileSize":5,"maxTotalImageSize":20,"terminalOutputLineLimit":500,"terminalOutputCharacterLimit":50000,"terminalShellIntegrationTimeout":5000,"terminalShellIntegrationDisabled":true,"terminalCommandDelay":0,"terminalPowershellCounter":false,"terminalZshClearEolMark":true,"terminalZshOhMy":false,"terminalZshP10k":false,"terminalZdotdir":false,"terminalCompressProgressBar":true,"diffEnabled":true,"fuzzyMatchThreshold":1,"experiments":{"powerSteering":false,"multiFileApplyDiff":false,"preventFocusDisruption":false,"imageGeneration":false,"runSlashCommand":false,"multipleNativeToolCalls":false},"codebaseIndexModels":{"openai":{"text-embedding-3-small":{"dimension":1536},"text-embedding-3-large":{"dimension":3072},"text-embedding-ada-002":{"dimension":1536}},"ollama":{"nomic-embed-text":{"dimension":768},"nomic-embed-code":{"dimension":3584},"mxbai-embed-large":{"dimension":1024},"all-minilm":{"dimension":384}},"openai-compatible":{"text-embedding-3-small":{"dimension":1536},"text-embedding-3-large":{"dimension":3072},"text-embedding-ada-002":{"dimension":1536},"nomic-embed-code":{"dimension":3584}},"gemini":{"text-embedding-004":{"dimension":768},"gemini-embedding-001":{"dimension":3072}},"mistral":{"codestral-embed-2505":{"dimension":1536}},"vercel-ai-gateway":{"openai/text-embedding-3-small":{"dimension":1536},"openai/text-embedding-3-large":{"dimension":3072},"openai/text-embedding-ada-002":{"dimension":1536},"cohere/embed-v4.0":{"dimension":1024},"google/gemini-embedding-001":{"dimension":3072},"google/text-embedding-005":{"dimension":768},"google/text-multilingual-embedding-002":{"dimension":768},"amazon/titan-embed-text-v2":{"dimension":1024},"mistral/codestral-embed":{"dimension":1536},"mistral/mistral-embed":{"dimension":1024}},"openrouter":{"openai/text-embedding-3-small":{"dimension":1536},"openai/text-embedding-3-large":{"dimension":3072},"openai/text-embedding-ada-002":{"dimension":1536},"google/gemini-embedding-001":{"dimension":3072},"mistralai/mistral-embed-2312":{"dimension":1024},"mistralai/codestral-embed-2505":{"dimension":1536},"qwen/qwen3-embedding-0.6b":{"dimension":1024},"qwen/qwen3-embedding-4b":{"dimension":2560},"qwen/qwen3-embedding-8b":{"dimension":4096}},"bedrock":{"amazon.titan-embed-text-v1":{"dimension":1536},"amazon.titan-embed-text-v2:0":{"dimension":1024},"amazon.titan-embed-image-v1":{"dimension":1024},"amazon.nova-2-multimodal-embeddings-v1:0":{"dimension":1024},"cohere.embed-english-v3":{"dimension":1024},"cohere.embed-multilingual-v3":{"dimension":1024}}},"language":"en","telemetrySetting":"enabled","mcpEnabled":true,"customModes":[],"customSupportPrompts":{},"includeTaskHistoryInEnhance":true,"reasoningBlockCollapsed":true,"profileThresholds":{}}
}'  "$ROO_CONFIG_FILE" > "$ROO_CONFIG_FILE.tmp" && mv "$ROO_CONFIG_FILE.tmp" "$ROO_CONFIG_FILE"
# Add or modify Python-related settings using jq
# We will keep the comments outside the jq block, as jq doesn't support comments inside JSON.
jq '. + {
    "workbench.colorTheme": "Default Dark Modern",  # Set the theme

    "editor.rulers": [80, 100],  # Add specific vertical rulers
    "files.trimTrailingWhitespace": true,  # Automatically trim trailing whitespace
    "files.insertFinalNewline": true,  # Ensure files end with a newline
    # Roo‑Cline – LLM model selector
    "roo-cline.autoImportSettingsPath": "/home/onyxia/work/roo_code_model_selector_config.json",
}' "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

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
