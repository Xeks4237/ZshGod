ZshGod is the simple and flexible zsh prompt

# Instruction

ZshGod is flexible, fast, asynchronous, and easy to configure and extend zsh prompt
ZshGod is made by me Xeks4237 when I was tinkering with my zsh config
I wanted some cool and flexible zsh prompt similar to the old and well known powerlevel10k

# Installation

ZshGod is configured conveniently with respect to zsh plugin standart, so you can install it with any plugin manager for zsh if you go by steps which your plugin manager needs, Manual installation works too:

After Installing ZshGod you can just run this command or put it in end of your zshrc:

```sh
prompt zshgod
```

## Manual

Clone the Repository:

```zsh
git clone 'https://github.com/Xeks4237/ZshGod' "${XDG_DATA_DIR-:$HOME/.local/share/}/zshgod/"
```

And add the following to your `zshrc` file:

```zsh
source ${XDG_DATA_DIR-:$HOME/.local/share/}/zshgod/zshgod.plugin.zsh

```

## Oh-My-Zsh

Clone the Repository:

```zsh
git clone https://github.com/Xeks4237/ZshGod.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zshgod/
```

And add `zshgod` to your plugin list

## Zinit

Add the following to your `zshrc` file:

```zsh
zinit light Xeks4237/ZshGod
```

## Antigen

Add the following to your `zshrc` file:

```zsh
antigen bundle Xeks4237/ZshGod
```

## Zgen

Add the following to your `.zshrc` file:

```zsh
zgen load Xeks4237/ZshGod
```
