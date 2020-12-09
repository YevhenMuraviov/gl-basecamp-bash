#!/usr/bin/env bash

function pars_expression ()
{
    is_expression_valid
    operator=`echo $expression | sed -En 's/^[-]?[0-9]+[\.]?[0-9]*([\*|+|\/|-])[-]?[0-9]+[\.]?[0-9]*/\1/p'`
    operand_1=`echo $expression | sed -En 's/^([-]?[0-9]+[\.]?[0-9]*)[\*|+|\/|-][-]?[0-9]+[\.]?[0-9]*/\1/p'`
    operand_2=`echo $expression | sed -En 's/^[-]?[0-9]+[\.]?[0-9]*[\*|+|\/|-]([-]?[0-9]+[\.]?[0-9]*)/\1/p'`
}
