#!/bin/bash

CONTAINERVERSION=custom-0.0.7

for i in play chat back map-storage uploader maps ejabberd ; do

	docker image tag workadventure-$i-custom:latest  workadventure-$i-custom:$CONTAINERVERSION

done
