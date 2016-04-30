#!/bin/bash

set -e

docker run --rm -v $TRAVIS_BUILD_DIR:/awaitable -w /awaitable ibmcom/kitura-ubuntu:latest /awaitable/.travis/run_linux.sh
