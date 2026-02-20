ZshGod is the simple and flexible zsh prompt

# Instruction

ZshGod is flexible, fast, asynchronous, and easy to configure and extend zsh prompt
ZshGod is made by me Xeks4237 when I was tinkering with my zsh config
I wanted some cool and flexible zsh prompt similar to the old and well known powerlevel10k

# Installation

ZshGod is configured conveniently with respect to zsh plugin standart, so you can install it with any plugin manager for zsh if you go by steps which your plugin manager needs, Manual installation works too:

```sh
zinit light Xeks4237/ZshGod
```

And then just put this code in end of your zshrc:

```sh
autoload -Uz promptinit && promptinit
prompt zshgod
```
