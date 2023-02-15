#!/bin/bash

ADDITIONAL_ARGS=""

if [ $# > 1 ]; then
	echo $1
	if [ $1 == "nocache" ]; then
		echo "Disable build cache!"
		ADDITIONAL_ARGS=" --no-cache "
	fi
fi

# build all containers with context ad git root dir
for i in play chat back map-storage ; do
	

	echo "#########################################################"
	echo "################ $i ##################################"
	echo "#########################################################"

	docker buildx build -t workadventure-$i-custom -f $i/Dockerfile . $ADDITIONAL_ARGS

done

# build containers with special instructions

echo "#########################################################"
echo "################ UPLOADER ##################################"
echo "#########################################################"

# really extra? no context specified
docker buildx build -t workadventure-uploader-custom -f uploader/Dockerfile . $ADDITIONAL_ARGS

echo "#########################################################"
echo "################ MAPS ##################################"
echo "#########################################################"

pushd maps
docker buildx build -t workadventure-maps-custom . $ADDITIONAL_ARGS
popd

echo "#########################################################"
echo "################ EJABBERD ##################################"
echo "#########################################################"

pushd xmpp
docker buildx build -t workadventure-ejabberd-custom . $ADDITIONAL_ARGS
popd
