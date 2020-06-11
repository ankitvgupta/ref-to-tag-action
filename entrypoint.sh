#!/bin/bash -l

echo "$1"
if  [[ $1 == refs/tags/* ]]
then
    echo "tag"
    echo "::set-output name=tag::${1/refs\/tags\//}"
elif  [[ $1 == refs/heads/* ]]
then
    echo "head"
    echo "::set-output name=tag::${1/refs\/heads\//}"
elif  [[ $1 == refs/pull/* ]]
then
    echo "pull"
    echo "::set-output name=tag::pull-${1/refs\/pull\//}"
else
    echo "::set-output name=tag::$1"
fi


