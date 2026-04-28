# My dotfiles

Dotfiles setup using Chezmoi. 

Install using:

```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:$jensborch/dotfiles.git
```

Apply using:

```sh
dotfiles cd
git pull
dotfiles -v apply
```
