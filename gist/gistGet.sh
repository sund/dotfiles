#!/bin/bash
# v .3

if [ -e $dotPath/gist/rawFile.conf ]
then
    source $dotPath/gist/rawFile.conf
else {
    echo "no $dotPath/gist/rawFile.conf found"
    exit 1
    }
fi

# if we haven't exited, then grab stuff

dotOut="$dotPath/gistaliases.symlink"

##
CURLPATH=`command -v curl`
WGETPATH=`command -v wget`

if [ -e "$CURLPATH" ]
then {
    echo "Found curl at "$CURLPATH"."
    echo "curling with "$CURLPATH"..."
    $CURLPATH -#L $rawLink | tar -xzv --strip-components 1
    }
    else if [ -e "$WGETPATH" ]
    then {
        echo "Found wget at "$WGETPATH"."
        echo "wgetting with "$WGETPATH"..."
        $WGETPATH $rawLink -O - | tar -xzv --strip-components 1
    }
    else
        echo "neither curl nor wget found."
        exit 1;
    fi
fi


##
mv .gistaliases $dotOut
chmod 750 $dotOut
source $dotOut

# if we find a .gitconfig file, then move
# so it can be symlinked
if [ -e ".gitconfig" ]
then
	gitOut="$dotPath/gitconfig.symlink"
	mv .gitconfig $gitOut
	chmod 744 $gitOut
fi

# if we find a sshconfig file, then move it over
if [ -e "sshconfig" ]
then
	gitOut="$HOME/.ssh/config"
	mv sshconfig $gitOut
	chmod 744 $gitOut
fi
