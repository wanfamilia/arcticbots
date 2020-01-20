#!/bin/bash
while true
do
  git pull
  ./wilbot.rb
  echo "Press [CTRL+C] to stop.."
done
