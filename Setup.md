### Install Basic Software

```bash
# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Utilities
brew install git hub bash-completions

# Applications
brew cask install atom firefox slack
```

### Install ASDF

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout v0.2.1
```

Add `.asdfrc` and relevant lines to `.bash_profile`.

```bash
asdf plugin-add node https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
```

### Configure Atom

On old machine:

```bash
apm list --installed --bare
```

Save to a file.

```bash
apm install --package-file atom-packages.txt
```

Link in `config.cson`, `keymap.cson`, `init.coffee`, `snippets.cson`, `styles.less`.