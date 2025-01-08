#!/usr/bin/env bash

set -e

. .common

docker build -t "$TAG" .
