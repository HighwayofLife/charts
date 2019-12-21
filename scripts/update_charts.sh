#!/bin/bash

mkdir tmp
cd tmp
git init
git remote add flux git@github.com:fluxcd/flux.git
git config core.sparseCheckout true
echo "chart/flux" > .git/info/sparse-checkout
git pull --depth=1 flux master
cp -r "chart/flux/" ../charts/fluxcd/
cd ..
rm -r tmp

