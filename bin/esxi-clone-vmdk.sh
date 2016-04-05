#!/bin/sh

echo "Remove destination: $2"
vmkfstools --deletevirtualdisk $2

echo "Clone disk: $1 to $2"
vmkfstools --clonevirtualdisk $1 --diskformat thin $2

