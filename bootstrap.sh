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

    if [ -z "${raw_script_filename}" ]; then
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

is_valid_label="false"

echo ""
echo "What label will your script have in launchctl?"
echo "This will get filled into the <Label> key in the .plist file"
echo "For example, 'Safebrew'"
while ! "${is_valid_label}"; do
    read -p "Label: " raw_label_name

    if [ -z "${raw_label_name}" ]; then
        echo "Label cannot be empty" >&2
        echo ""
        continue
    fi

    label_name="${raw_label_name// /}"
    if [ "${label_name}" != "${raw_label_name}" ]; then
        echo "Label cannot be whitespace" >&2
        echo ""
        continue
    fi

    is_valid_label="true"
done

SHARED_CONSTS_FILEPATH="${script_dirpath}/shared-consts.env"

tmp_filepath="$(mktemp)"
sed "s/USER_SCRIPT_FILENAME/${script_filename}/g" "${SHARED_CONSTS_FILEPATH}" > "${tmp_filepath}"
sed "s/USER_LABEL/${label_name}/g" "${tmp_filepath}" > "${SHARED_CONSTS_FILEPATH}"

mv "SCRIPTNAME.sh" "${script_filename}"

echo "✅ Bootstrap successful"
echo ""
ecoh "💡 You can now remove this ${0} script"
