# ref-to-tag Github Action

This action uses your Github context to extract your branch or tag name for use in other steps. It also formats the name to be compatible for use as the name of a docker container.

- On a pull request, this will use the "head" branch of your PR. i.e. the branch that you are merging into the base branch.
- On pushing a branch, it'll return the name of the branch you're pushing to.
- On pushing a tag, it'll return the name of the tag.

Branch -> Tag Examples:

	- PR feature/my-branch -> feature.my-branch
	- PR feature/my/weird/branchname -> feature.my.weird.branchname
	- push to feature/my-branch -> feature.my-branch
	- push to my-branch -> my-branch
	- release/push of v1.0.5 tag -> v1.0.5

Note that you should pass both the `github.ref` and `github.head_ref`, and the script is smart enough to know which to look at depending on which are filled.

## Inputs

### `ref`

**Required** The github ref. Pass `${{ github.ref }}`.

### `head_ref`

**Required** The head_ref. Pass `${{ github.head_ref }}`.
Note that if this is a push to a branch (and not a PR), the head_ref will be an empty string. That is fine, the action will know to ignore it.


## Outputs

### `tag`

The tag it parsed for you.

## Example usage

See `.github/workflows/example.yaml` for a working example in this repo.

``` yaml
on: [pull_request, push]

jobs:
  get-ref-example:
    runs-on: ubuntu-latest
    name: get-ref-example
    steps:
    - name: Get the Ref
      id: get-ref
      uses: ankitvgupta/ref-to-tag-action@master
      with:
        ref: ${{ github.ref }}
        head_ref: ${{ github.head_ref }}
    - name: Get the tag
      run: echo "The tag was ${{ steps.get-ref.outputs.tag }}"
```

