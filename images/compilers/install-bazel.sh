#!/bin/bash

# Copyright 2017-2020 Authors of KhulnaSoft
# SPDX-License-Identifier: Apache-2.0

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

bazel_versions=(
  "3.7.0"
  "3.7.1"
  "3.7.2"
)

# install bazel wrapper script in the path, it automatically recognises `.bazelversion` and `USE_BAZEL_VERSIONS`, if neither are set it picks latest
curl --fail --show-error --silent --location https://raw.github.com/bazelbuild/bazel/3.7.0/scripts/packages/bazel.sh --output /usr/local/bin/bazel
chmod +x /usr/local/bin/bazel

for bazel_version in "${bazel_versions[@]}" ; do
  # instead of using installer script, download binaries directly, as installer script doesn't append version suffix,
  # so for multiple versions to be usable files will need to moved around, which would be more tedious
  long_binary_name="bazel-${bazel_version}-linux-x86_64"
  curl --fail --show-error --silent --location "https://releases.bazel.build/${bazel_version}/release/${long_binary_name}" --output "/usr/local/bin/${long_binary_name}"
  chmod +x "/usr/local/bin/${long_binary_name}"
  USE_BAZEL_VERSION="${bazel_version}" bazel version # to extract all binaries properly
done
