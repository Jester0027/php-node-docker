#!/bin/bash

dockerRepo='jester0027/php-node-runtime'

function buildAndDeploy() {
    docker build $path --tag $repo
    docker push $repo
}

buildAndDeploy '.' $dockerRepo:main
buildAndDeploy './dev/' $dockerRepo:dev
