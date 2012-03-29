#!/bin/bash
for name in `cat skel_items.txt`; do cp -r $HOME/$name ./skel; done
