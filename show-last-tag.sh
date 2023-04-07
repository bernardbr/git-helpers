#!/bin/bash

tag=$(git describe --tags --abbrev=0)
echo -e "\e[32mLast tag:\e[0m $tag"
