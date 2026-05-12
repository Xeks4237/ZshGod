<center>ZshGod - flexible, fast, asynchronous, and easy to configure and extend zsh prompt framework</center>

# Description

ZshGod is made by me [Xeks4237](https://codeberg.org/Xeks4237/ZshGod) when I was tinkering with my zsh config
I wanted some cool and flexible zsh prompt similar in look to the old and well known powerlevel10k, So I made my own prompt then made it extensible, asynchronous, configurable and in end here we are.

# Installation

ZshGod is configured conveniently with respect to zsh plugin standart, so you can install it with any plugin manager for zsh if you go by steps which your plugin manager requires, Manual installation works too.

After installing ZshGod you can just run this command to open configuration wizard:

```sh
prompt zshgod configure
```

<details>
  <summary>Manual</summary>

- 1. Clone the repository using **git**:

  ```zsh
  git clone 'https://codeberg.org/Xeks4237/ZshGod.git' "${XDG_DATA_DIR-:$HOME/.local/share/}/zshgod/"
  ```

- 2. Add the following line to the end of your `zshrc`:

  ```zsh
  source ${XDG_DATA_DIR-:$HOME/.local/share/}/zshgod/zshgod.plugin.zsh
  ```

</details>

<details>
  <summary>Oh-My-Zsh</summary>

- 1. Clone the repository using **git**:

  ```zsh
  git clone 'https://codeberg.org/Xeks4237/ZshGod.git' ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom/}/plugins/zshgod/
  ```

- 2. And add `zshgod` to your plugins list in zshrc
</details>

<details>
  <summary>Zinit</summary>

- 1. Add the following to your `zshrc`:

  ```zsh
  zinit light 'Xeks4237/ZshGod'
  ```

</details>

# LICENSE
Zshgod is licensed under MIT License respectfully.
