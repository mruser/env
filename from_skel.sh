#!/bin/bash
for name in `cat skel_items.txt`; do cp -r ./skel/$name ~/; done
