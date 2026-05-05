{ config, pkgs, ... }:

{
  home.username = "ryusei";
  home.homeDirectory = "/Users/ryusei";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      la = "ls -a";
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
    zsh
    git
    gh
    jq
    ripgrep
    fd
    fzf
    neovim
    ghq
    htop
    direnv
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.enable = true;
  home.file.".gitconfig".source = ./config/git/.gitconfig;
  xdg.configFile."starship.toml".source = ./config/starship/starship.toml;
  xdg.configFile."ghostty/config".source = ./config/ghostty/config;

  # xdg.configFile."nvim".source = ./nvim;
}
