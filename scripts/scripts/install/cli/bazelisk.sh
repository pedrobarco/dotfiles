#!/bin/bash
# Install bazelisk as bazel

if [ "$(uname)" == "Darwin" ]; then
	brew install bazelisk
else
    curl -Lo /usr/local/bin/bazelisk \
        https://github.com/bazelbuild/bazelisk/releases/download/v1.11.0/bazelisk-linux-amd64
    chmod +x /usr/local/bin/bazelisk
fi

ln -s /usr/local/bin/bazelisk /usr/local/bin/bazel
