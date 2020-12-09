#!/usr/bin/env bash
source calculation.sh
source parsing.sh
source preparation.sh
source validation.sh

expression=$1

pars_expression
calculate
