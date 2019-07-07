#!/bin/bash

echo "********************"
echo "** Pushing image ***"
echo "********************"

IMAGE="maven-project"

echo "** Logging in ***"
docker login -u hanzodarkria -p $PASS
echo "*** Tagging image ***"
docker tag $IMAGE:$BUILD_TAG hanzodarkria/$IMAGE:$BUILD_TAG
echo "*** Pushing image ***"
docker push hanzodarkria/$IMAGE:$BUILD_TAG