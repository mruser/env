#!/bin/sh

(ssh aws01 -o PermitLocalCommand=no  \
  ": > .irssi/fnotify ; tail -f .irssi/fnotify " |  \
while read heading message; do                      \
  echo "${heading}|${message}"
  terminal-notifier -message "${message}" -title "${heading}"  -subtitle "via irssi" -activate `osascript -e 'id of app "iTerm"'`;
done)
