#!/usr/bin/env bash

function is_expression_valid ()
{
    if [[ $expression =~ ^[-]?[0-9]+[\.]?[0-9]*[+|\/|\*|\-][-]?[0-9]+[\.]?[0-9]*$ ]]
    then
        echo "Expression is valid."
    else
        echo "Incorrect input." >&2
        exit 128
    fi
}
