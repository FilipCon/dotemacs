#!/bin/bash

# c/c++ language server
sudo apt install -y clang-tools clang-10

# pyls
pip3 install python-language-server black

# cmake ls
pip3 install cmake-language-server

# texlab
sudo apt install cargo
cargo install --git https://github.com/latex-lsp/texlab.git

# bash language server
sudo npm i -g bash-language-server

# xml language server
git clone https://github.com/eclipse/lemminx.git
cd lemminx/
./mvnw clean verify

# nvm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
