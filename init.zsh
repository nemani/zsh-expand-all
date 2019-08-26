# Environment variable: $ZSH_EXPAND_ALL_DISABLE
#
# You can optionally disable some features.
#
# Examples:
#   ZSH_EXPAND_ALL_DISABLE=             # All features are enabled
#   ZSH_EXPAND_ALL_DISABLE=alias        # Disable alias expanding
#   ZSH_EXPAND_ALL_DISABLE=word         # Disable word expanding
#   ZSH_EXPAND_ALL_DISABLE=alias,word   # Disable alias and word expanding

ZSH_EXPAND_ALL_DISABLE=('ls' 'cp' 'mv' 'cd')

--expand-internal() {
  local disable_list=("${(@s|,|)ZSH_EXPAND_ALL_DISABLE}")
  local first_word=${${(z)BUFFER}}
  [[ ${ZSH_EXPAND_ALL_DISABLE[(ie)$first_word]} -gt ${#ZSH_EXPAND_ALL_DISABLE} ]] && [[ ${disable_list[(ie)alias]} -gt ${#disable_list} ]] && zle _expand_alias
  [[ ${disable_list[(ie)word]}  -gt ${#disable_list} ]] && zle expand-word
}

expand-all() {
  --expand-internal
  zle self-insert
}

zle -N expand-all

# space expands all aliases, including global
bindkey -M emacs " " expand-all
bindkey -M viins " " expand-all

# control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
