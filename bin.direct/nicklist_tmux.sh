#!/bin/bash

T3=$(pidof irssi)

irssi_nickpane() {
    tmux setw main-pane-width $(( $(tput cols) - 12));
    tmux splitw -v "cat ~/.irssi/nicklistfifo";
    tmux selectl main-vertical;
    tmux selectw -t irssi;
    tmux selectp -t 0;
}

irssi_repair() {
    tmux selectw -t irssi
    (( $(tmux lsp | wc -l) > 1 )) && tmux killp -a -t 0
    irssi_nickpane
}

if [ -z "$T3" ]; then
    tmux new-session -d -s IM;
    tmux new-window -t IM -n irssi irssi;
    irssi_nickpane ;
fi
    tmux attach-session -d -t IM;
    irssi_repair ;
exit 
