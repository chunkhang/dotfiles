#!/usr/bin/env zsh

ifconfig | grep 'inet .* broadcast' | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n 1
