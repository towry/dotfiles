# dotfiles

towry's dotfiles.

* source - some config to append to zshrc
* link - some config to link to home.
* install - scripts to install dotfiles.
* conf - some configurations.
* backup - backup files before do things dangerously.
* vendor - third party repos etc.

## Getting Started

### Installation

#### via curl

```bash
bash <(curl -s https://raw.githubusercontent.com/towry/dotfiles/master/install/boot.sh)
```

### Usage

#### Add a dotfile

```bash
cd ~/.dotfiles/install
./add.sh ~/.your-dot-file
```

#### Remove a dotfile

```bash
cd ~/.dotfiles/install
./remove.sh ../link/.your-dot-file
```

#### Sync all dotfiles

```bash
cd ~/.dotfiles/install
./sync.sh -y
```


------------------------
Tue Jun  7 00:29:59 2016
~~~~~~~~
