#!/bin/bash

if [ "$1" = "backup" ]
then
    cp -R $HOME/.config/joplin-desktop/userstyle.css ./userstyle.css
    cp -R $HOME/.config/joplin-desktop/userchrome.css ./userchrome.css
    echo File backup
fi

if [ "$1" = "restore" ]
then
    cp -R ./.vimrc $HOME/.vimrc
    echo File restore
fi

