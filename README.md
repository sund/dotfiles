**dotfiles**

====

_public repo of my .bash_files_

### Instructions

### Quickly install with Git

```bash
git clone https://github.com/sund/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/sund/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```

To update later on, just run that command again.

Tip: If you have anything existing in .bash_profile or .bashrc, make a copy of it. Make a Pull Request if you think it is worthwhile to others.

Alternately, you can copy it to .extra to remain on the machine.

----

This repo was initially a shameless, slimmed-down copy of https://github.com/mathiasbynens/dotfiles

