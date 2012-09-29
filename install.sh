#!/bin/bash

function df_install {
    SOURCE=`readlink -f $1`
    TARGET=`readlink -f $2`

    echo "SRC:$SOURCE"
    echo "TRG:$TARGET"

    echo -n "Install '$2': ";
    if [ ! -e $TARGET ]; then
        echo "::1"
        ln -s $SOURCE $TARGET;
        echo "OK";
        return;
    fi
    if [ -L $2 ]; then
        echo "::2"
        if [ $SOURCE == $TARGET ]; then
            echo "::3"
            echo "Skip"
            return;
        fi
    fi
    echo "::4"
    mkdir -p ~/.df_backup
    mv $TARGET ~/.df_backup/
    ln -s $SOURCE $TARGET;
    echo "OK";
}

df_install bashrc ~/.bashrc
df_install gitconfig ~/.gitconfig
df_install vim ~/.vim
df_install vimrc ~/.vimrc
df_install themes ~/.themes
