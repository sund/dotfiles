#!/bin/bash
# v .1

if [ -e rawFile.conf ]
then
    source rawFile.conf
else {
    echo "no rawFile.conf found"
    exit 1
    }
fi

# if we haven't exited, then grab stuff

dotOut="$HOME/.gistaliases"

##
CURLPATH=`which curl`
WGETPATH=`which wget`

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
        $WGETPATH $rawLink | tar -xzv --strip-components 1
    }
    else
        echo "neither curl nor wget found."
        exit 1;
    fi
fi


##
#curl $rawLink -o $HOME/$dotOut
mv .gistaliases $dotOut
chmod 755 $dotOut
