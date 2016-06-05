#!/bin/bash
function cf(){
    if [ $# -eq 1 ]; then
        d=$(date "+%Y-%m-%d")
        echo "---\nlayout: post\ntitle: \ncategory: \ntags: \nkeywords: \ndescription:\n---\n" >"$d-$1.md"
    else
        exit 1
    fi
}
