#!/bin/bash -i
# make sure on wheezy
while read line; do
  echo "Installing $line..."
  exec apt-get install $line

done < pkgs.txt

apt-get autoremove
