#!/usr/bin/env bash

cat ./vscode-linux-installed-extensions | while read extension || [[ -n $extension ]];
do
  code --install-extension $extension --force
done

