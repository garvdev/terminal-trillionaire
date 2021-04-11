#!/bin/zsh

if ! bundle check | grep -q "The Gemfile's dependencies are satisfied" ; then
   bundle install
fi

chmod +x ./RUNME.sh
chmod +x ./terminal-trillionaire

./terminal-trillionaire $1 $2