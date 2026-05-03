{ config, pkgs, ... }:

{
  home.username = "ryusei";
  home.homeDirectory = "/Users/ryusei";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    gh
    jq
    ripgrep
    fd
    fzf
    neovim
  ];

  home.file.".zshrc".source = ./config/zsh/.zshrc;
  home.file.".gitconfig".source = ./config/git/.gitconfig;
  # xdg.configFile."nvim".source = ./nvim;
}
