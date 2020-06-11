#!/bin/bash -l

# Clean the branch name by replacing / with a .
function clean {
    local cleaned=`echo $1 | sed 's,/,.,g'`
    echo "$cleaned"
}

ref=$1
head_ref=$2

# If the $head_ref is empty (i.e. pushes), use $ref. Otherwise, use $head_ref (pull requests)/
if [ -n "$head_ref" ]; then
    var_to_use=$ref
else
    var_to_use=$head_ref
fi

if  [[ $var_to_use == refs/tags/* ]]
then
    # These look something like refs/tags/<tag-name>. Extract <tag-name>.
    result="$(clean ${var_to_use/refs\/tags\//})"
    echo "::set-output name=tag::$result"
elif  [[ $var_to_use == refs/heads/* ]]
then
	# These look something like refs/heads/<branch-name>. Extract <branch-name>.
    result="$(clean ${var_to_use/refs\/heads\//})"
    echo "::set-output name=tag::$result"
elif  [[ $var_to_use == refs/pull/* ]]
then
    # These look something like refs/pull/<pr-number>/merge. Extract <pr-number>
    remove_front="${var_to_use/refs\/pull\//}"
    remove_back="${remove_front%/merge}"
    result="$(clean $remove_back)"
    echo "::set-output name=tag::pr-$result"
else
	# If it doesn't match one of those, it's just a vanilla ref. Make sure it's docker-compatible.
	result="$(clean $var_to_use)"
    echo "::set-output name=tag::$result"
fi


