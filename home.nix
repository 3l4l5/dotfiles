{ config, pkgs, ... }:

{
  home.username = "ryusei";
  home.homeDirectory = "/Users/ryusei";
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
      vim = "nvim";
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = "^[[A";
      searchDownKey = "^[[B";
    };

    initContent = ''
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
    '';
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
    xz
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.file.".gitconfig".source = ./config/git/.gitconfig;

  xdg.configFile."starship.toml".source = ./config/starship/starship.toml;
  xdg.configFile."ghostty/config".source = ./config/ghostty/config;

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/dotfiles/config/nvim";
}
