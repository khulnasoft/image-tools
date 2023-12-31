#!/bin/bash

# Copyright 2017-2020 Authors of KhulnaSoft
# SPDX-License-Identifier: Apache-2.0

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

if [ "$#" -ne 1 ] ; then
  echo "$0 supports exactly 1 argument"
  exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

root_dir="$(git rev-parse --show-toplevel)"

cd "${root_dir}"

image_name="${1}/image-compilers"

image_tag="$(WITHOUT_SUFFIX=1 "${script_dir}/make-image-tag.sh" images/compilers)"

image_digest="$("${script_dir}/get-image-digest.sh" "${image_name}:${image_tag}")"

# shellcheck disable=SC2207
used_by=($(git grep -l COMPILERS_IMAGE= images))

for i in "${used_by[@]}" ; do
  sed "s|\(COMPILERS_IMAGE=${image_name}\):.*\$|\1:${image_tag}@${image_digest}|" "${i}" > "${i}.sedtmp" && mv "${i}.sedtmp" "${i}"
done
