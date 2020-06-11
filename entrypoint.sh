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
    # These look something like refs/tags/<tag-name>. Extract <tag-name>.
    result="$(clean ${1/refs\/tags\//})"
    echo "::set-output name=tag::$result"
elif  [[ $1 == refs/heads/* ]]
then
	# These look something like refs/heads/<branch-name>. Extract <branch-name>.
    result="$(clean ${1/refs\/heads\//})"
    echo "::set-output name=tag::$result"
elif  [[ $1 == refs/pull/* ]]
then
    # These look something like refs/pull/<pr-number>/merge. Extract <pr-number>
    remove_front="${1/refs\/pull\//}"
    remove_back="${remove_front%/merge}"
    result="$(clean $remove_back)"
    echo "::set-output name=tag::pr-$result"
else
	# If it doesn't match one of those, it's just a vanilla ref. Make sure it's docker-compatible.
	result="$(clean $1)"
    echo "::set-output name=tag::$result"
fi


