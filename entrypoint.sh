#!/bin/sh -l

#echo "$1"
if  [[ $1 == refs/tags/* ]]
then
    echo "::set-output name=tag::${1/refs\/tags\//}"
elif  [[ $1 == refs/heads/* ]]
then
    echo "::set-output name=tag::${1/refs\/heads\//}"
elif  [[ $1 == refs/pull/* ]]
then
    echo "::set-output name=tag::pull"
    #echo "::set-output name=tag::pull-${1/refs\/pull\//}"
fi
#else
#    #echo "::set-output name=tag::$1"
#fi


