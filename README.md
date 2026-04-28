# My dotfiles

Dotfiles setup using Chezmoi. 

Install using:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:$jensborch/dotfiles.git -b $HOME/.local/bin
```

Apply using:

```sh
dotfiles cd
git pull
dotfiles -v apply
```
