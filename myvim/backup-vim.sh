#!/bin/bash

if [ "$1" = "backup" ]
then
    cp -R $HOME/.vimrc ./.vimrc
    echo File backup
fi

if [ "$1" = "restore" ]
then
    cp -R ./.vimrc $HOME/.vimrc
    echo File restore
fi

