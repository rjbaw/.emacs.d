# Portable Spacemacs-like Emacs config
A compilation of random emacs lisp snippets around the web

![Alt text](sample.png?raw=true "Preview")

## Setup
```
cd $HOME
git clone https://github.com/rjbaw/.emacs.d.git
emacs
```

## Requirements
- Linux  
- Emacs 26.3+  

## Deploying Emacs as Server
```
# GUI Option
echo "alias em='emacsclient -c -n -a \"\"'" >> ~/.bashrc 
# Console Option
echo "alias et='emacsclient -t -nw -a \"\"'" >> ~/.bashrc 
```

## Core Packages
`evil-mode`  
`company-mode`  
`magit`  
`lsp-mode`  
`yasnippet`  

## Themes
`spacemacs-theme`  
`lsp-ui`  
`spinner`  
`helm-lsp`  
`spaceline`  
