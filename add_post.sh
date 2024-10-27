#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail


main() {
    local my_title \
        my_date \
        final_date \
        content_file \
        my_tags \
        use_math \
        generated_title_date

    echo -n "Title: "
    read my_title
    if [[ "$my_title" == "" ]]; then
        echo "No title passed, aborting."
        exit
    fi

    my_date=$(date +%Y-%m-%d)
    echo -n "Date for the post [$my_date]: "
    read final_date
    if [[ "$final_date" == "" ]]; then
        final_date="$my_date"
    fi

    content_file="content/posts/${final_date}-${my_title// /-}.md"
    hugo new "$content_file"

    generated_title_date=$(date "+%Y %m %d")
    sed -i -e "s/^title: \"$generated_title_date /title: \"/" "$content_file"

    echo -n "Tags as array '[\"tag one\", \"tag two\"]', empty for none: "
    read my_tags
    if [[ "$my_tags" != "" ]]; then
        sed -i -e "0,/^---/{s/^---/---\ntags: $my_tags/}" "$content_file"
    fi

    echo -n "Use math? [Yn]: "
    read use_math
    if [[ "$use_math" == "" ]] || [[ "$use_math" =~ ^[yY].* ]]; then
        sed -i -e '0,/^---/{s/^---/---\nmath: true/}' "$content_file"
    fi
}


main "$@"
