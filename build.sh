#!/bin/bash

dockerRepo='jester0027/php-node-runtime'

function buildAndDeploy() {
    docker build $1 --tag $2
    docker push $2
}

buildAndDeploy '.' $dockerRepo:main
buildAndDeploy './dev/' $dockerRepo:dev
