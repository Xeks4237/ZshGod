<center>ZshGod - flexible, fast, asynchronous, and easy to configure and extend zsh prompt framework</center>

# Instruction

ZshGod is made by me [Xeks4237](https://codeberg.org/Xeks4237/ZshGod) when I was tinkering with my zsh config
I wanted some cool and flexible zsh prompt similar in look to the old and well known powerlevel10k, So I made my own prompt then made it extensible, asynchronous, configurable and in end here we are.

# Installation

ZshGod is configured conveniently with respect to zsh plugin standart, so you can install it with any plugin manager for zsh if you go by steps which your plugin manager requires, Manual installation works too.

After installing ZshGod you can just run this command to open configuration wizard:

```sh
prompt zshgod configure
```

<!-- For more info read [Configuration]() section -->

## Manual

Clone the repository using **git**:

```zsh
git clone 'https://codeberg.org/Xeks4237/ZshGod.git' "${XDG_DATA_DIR-:$HOME/.local/share/}/zshgod/"
```

And add the following to your `zshrc` file:

```zsh
source ${XDG_DATA_DIR-:$HOME/.local/share/}/zshgod/zshgod.plugin.zsh

```

## Oh-My-Zsh

Clone the Repository:

```zsh
git clone 'https://codeberg.org/Xeks4237/ZshGod.git' ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}/plugins/zshgod/
```

And add `zshgod` to your plugins list

## Zinit

Add the following to your `zshrc` file:

```zsh
zinit light 'Xeks4237/ZshGod'
```
