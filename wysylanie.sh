#!/bin/bash

function wysl {
mail -s $1 $2

}

echo "Podaj temat wiadomosci:"
cat "$@" | wysl $1 KaPeGie@gmail.com 
function update {
$i 0
