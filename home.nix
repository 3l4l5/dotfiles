{ config, pkgs, lib, ... }:

{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      la = "ls -a";
      gs = "git status";
      gbs = "git branch --show-current";
      vim = "nvim";
      vi = "nvim";
      nsync = "home-manager switch --flake ~/dotfiles#ryusei --impure";
      cdd = "cd ~/dotfiles/";
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = "^[[A";
      searchDownKey = "^[[B";
    };

    initContent = lib.optionalString pkgs.stdenv.isDarwin ''
      # Homebrew (macOS only)
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '' + ''
      # ghq + fzf
      function ghq-fzf() {
        local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
        if [ -n "$src" ]; then
          BUFFER="cd $(ghq root)/$src"
          zle accept-line
        fi
        zle -R -c
      }

      zle -N ghq-fzf
      bindkey '^g' ghq-fzf
    '' + ''
        # autosuggestionの色
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#c0c0c0"
    '';
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.zsh-autocomplete;
      }
    ];
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./config/tmux/tmux.conf;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    git
    gh
    jq
    ripgrep
    fd
    neovim
    ghq
    htop
    bat
    glow
    xz
    gron
    tree-sitter
    glow
    ripgrep
    fd

    # lunguage server
    lua-language-server
    dockerfile-language-server-nodejs
    gopls
    pyright
    nixd

    # font
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.file.".gitconfig".source = ./config/git/.gitconfig;
  home.file.".claude".source = ./config/claude/settings.json;

  xdg.configFile."starship.toml".source = ./config/starship/starship.toml;
  xdg.configFile."ghostty/config".source = ./config/ghostty/config;

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/config/nvim";
}
