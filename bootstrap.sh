#!/bin/bash
# v .2

OSNAME=`uname -s`
cd "$(dirname "${BASH_SOURCE}")"

function doIt() {
# exclude .vimrc since it's a little distro dependant
	rsync --exclude="Terminal" --exclude=".git/" --exclude="gist/" --exclude="init/" --exclude="info/" --exclude=".gitignore" --exclude=".gitattributes" --exclude=".DS_Store" --exclude="bootstrap.sh" --exclude=".vimrc*" --exclude=".solaris" --exclude="README.md"  --exclude=".*~" -av . ~
}

function vimrcCopy() {

 case "$OSNAME" in
    "Linux")
	cp .vimrc_linux ~/.vimrc
    if [ -f ~/.mac ]; then rm -f ~/.mac; fi
	if [ -f ~/.solaris ]; then rm -f ~/.solaris; fi
        ;;
    "Darwin")
	cp .vimrc_mac ~/.vimrc
    if [ -f ~/.linux ]; then rm -f ~/.linux; fi
    if [ -f ~/.solaris ]; then rm -f ~/.solaris; fi
        ;;
   *)
        ;;
esac

# fix missing ~/.vim/backups & ~/.vim/swaps
if [ ! -f ~/.vim/backups ]; then mkdir -p ~/.vim/backups; fi
if [ ! -f ~/.vim/swaps ]; then mkdir -p ~/.vim/swaps; fi
}

function updateRepo() {
    #on mac see if we have XCode installed and then use it
    if [ -e /Applications/Xcode.app/ ]
    then
        xcrun git pull
    else
        git pull
    fi
}

function getGist() {
    if [ -e gist/rawFile.conf ]
    then
        echo 'Found gist config!'
        bash gist/gistGet.sh
    fi
}

pwd

if ( updateRepo )
then
{
    if [ "$1" == "--force" -o "$1" == "-f" ]; then
        doIt
        getGist
    else
        read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            doIt
            getGist
        fi
    fi

   vimrcCopy
   unset doIt
   unset vimrcCopy
   unset getGist
   source ~/.bash_profile

}
fi
