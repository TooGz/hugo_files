#!/bin/sh

USER=toogz
HOST=192.168.1.23
DIR=.   # the directory where your website files should go
URL=http://blog.toogz.priv

hugo --buildDrafts --baseURL $URL && rsync -avz --delete public/ ${USER}@${HOST}:${DIR} # this will delete everything on the server that's not in the local public folder 


exit 0
