#!/bin/bash -l

# Clean the branch name by replacing / with a .
function clean {
    local cleaned=`echo $1 | sed 's,/,.,g'`
    echo "$cleaned"
}

#clean "$1"
result="$(clean $1)"
#echo $result
if  [[ $1 == refs/tags/* ]]
then
    echo "tag"
    result="$(clean ${1/refs\/tags\//})"
    echo "::set-output name=tag::$result"
elif  [[ $1 == refs/heads/* ]]
then
    echo "head"
    result="$(clean ${1/refs\/heads\//})"
    echo "::set-output name=tag::$result"
elif  [[ $1 == refs/pull/* ]]
then
    echo "pull"
    result="$(clean ${1/refs\/pull\//})"
    echo $result
    echo "::set-output name=tag::pr-$result"
else
	result="$(clean $1)"
    echo "::set-output name=tag::$result"
fi


