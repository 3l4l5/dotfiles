# dotfiles

nix の install

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

既存のシンボリックリンクの削除

```sh
rm ~/.zshrc ~/.zprofile ~/.gitconfig
```

dotfilesのclone

```sh
cd ~
git clone git@github.com:3l4l5/dotfiles.git
```

環境の構築

```sh
cd ~/dotfiles
home-manager switch --flake .
```
