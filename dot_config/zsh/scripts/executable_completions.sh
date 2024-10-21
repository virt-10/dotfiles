#!/usr/bin/env sh


# bluebuild
eval "$(bluebuild completions zsh || true)"

# pipx
eval "$(register-python-argcomplete pipx || true)"
