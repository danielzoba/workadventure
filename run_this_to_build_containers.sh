#!/bin/bash

# build all containers with context ad git root dir
for i in play chat back map-storage ; do
	

	echo "#########################################################"
	echo "################ $i ##################################"
	echo "#########################################################"

	docker buildx build -t workadventure-$i-custom -f $i/Dockerfile .

done

# build containers with special instructions

echo "#########################################################"
echo "################ UPLOADER ##################################"
echo "#########################################################"

# really extra? no context specified
docker buildx build -t workadventure-uploader-custom -f uploader/Dockerfile .

echo "#########################################################"
echo "################ MAPS ##################################"
echo "#########################################################"

pushd maps
docker buildx build -t workadventure-maps-custom .
popd

echo "#########################################################"
echo "################ EJABBERD ##################################"
echo "#########################################################"

pushd xmpp
docker buildx build -t workadventure-ejabberd-custom .
popd
