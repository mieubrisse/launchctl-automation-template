#!/usr/bin/env bash

# Customizes the template repository to be specific to you
# You can remove this script after running it

set -euo pipefail
script_dirpath="$(cd "$(dirname "${0}")" && pwd)"

is_valid_filename="false"

echo "What are we going to call your main script (the one that will be called by launchctl)?"
echo "For example, 'safebrew.sh'"
while ! "${is_valid_filename}"; do
    read -p "Script name: " raw_script_filename

    if [ -z "${script_filename}" ]; then
        echo "Script name cannot be empty" >&2
        echo ""
        continue
    fi

    script_filename="${raw_script_filename// /}"
    if [ "${script_filename}" != "${raw_script_filename}" ]; then
        echo "Script name cannot contain whitespace" >&2
        echo ""
        continue
    fi

    if [ "${script_filename%%.sh}" = "${script_filename}" ]; then
        echo "Script filename must end with '.sh'" >&2
        echo "" 
        continue
    fi

    is_valid_filename="true"
done

echo "What are we going to call your main script (the one that will be called by launchctl)?"
echo "For example, 'safebrew.sh'"
while ! "${is_valid_filename}"; do
    read -p "Script name: " script_filename

    if [ -z "${script_filename}" ]; then
        echo "Script name cannot be empty" >&2
        echo ""
        continue
    fi

    script_filename="${script_filename// /}"
    if [ -z "${script_filename// /}" ]; then
        echo "Script name cannot be whitespace" >&2
        echo ""
        continue
    fi

    if [ "${script_filename%%.sh}" = "${script_filename}" ]; then
        echo "Script filename must end with '.sh'" >&2
        echo "" 
        continue
    fi

    is_valid_filename="true"
done

