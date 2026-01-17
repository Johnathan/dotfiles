#!/bin/sh
tmux list-sessions -F '#{session_name},#{session_attached}' | awk -F, '{
  if($2==1) printf "#[fg=#c0caf5,bold]"
  else printf "#[fg=#565f89,nobold]"
  printf "#[range=user|%s]%s#[norange]   ", $1, $1
}'
