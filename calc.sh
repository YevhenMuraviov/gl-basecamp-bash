#!/usr/bin/env bash

expression=$1

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

function pars_expression ()
{
    is_expression_valid
    operator=`echo $expression | sed -En 's/^[-]?[0-9]+[\.]?[0-9]*([\*|+|\/|-])[-]?[0-9]+[\.]?[0-9]*/\1/p'`
    operand_1=`echo $expression | sed -En 's/^([-]?[0-9]+[\.]?[0-9]*)[\*|+|\/|-][-]?[0-9]+[\.]?[0-9]*/\1/p'`
    operand_2=`echo $expression | sed -En 's/^[-]?[0-9]+[\.]?[0-9]*[\*|+|\/|-]([-]?[0-9]+[\.]?[0-9]*)/\1/p'`
}

function get_floating_point_precision ()
{
    operand_first=$1
    operand_second=$2
    mantissa_first=`echo $operand_first | sed -En 's/^[-]?[0-9]+[\.]?([0-9]*)/\1/p'`
    significand_first=`echo $operand_first | sed -En 's/^([-]?[0-9]+)[\.]?([0-9]*)/\1\2/p'`
    power_of_ten_first=`echo ${#mantissa_first}`

    mantissa_second=`echo $operand_second | sed -En 's/^[-]?[0-9]+[\.]?([0-9]*)/\1/p'`
    significand_second=`echo $operand_second | sed -En 's/^([-]?[0-9]+)[\.]?([0-9]*)/\1\2/p'`
    power_of_ten_second=`echo ${#mantissa_second}`

    if [[ $power_of_ten_first -gt $power_of_ten_second ]]; 
        then
            power_of_ten=$power_of_ten_first
            power_of_ten_diff=$(( power_of_ten_first - power_of_ten_second ))
            significand_second=$(( significand_second * 10**power_of_ten_diff ))
        elif [[ $power_of_ten_first -lt $power_of_ten_second ]]; then
            power_of_ten=$power_of_ten_second
            power_of_ten_diff=$(( power_of_ten_second - power_of_ten_first ))
            significand_first=$(( significand_first * 10**power_of_ten_diff ))
        elif [[ $power_of_ten_first -eq "0" ]]; then
            power_of_ten=0
        else
            power_of_ten=$power_of_ten_first
    fi
}

function calculate ()
{
    get_floating_point_precision $operand_1 $operand_2
    multiplier=$(( 10**$power_of_ten ))
    case $operator in
        "+")
            echo "addition of "$operand_1" and "$operand_2
            result=$(( significand_first + significand_second ))
            ;;
        "-")
            echo "subtraction of "$operand_1" and "$operand_2
            result=$(( significand_first - significand_second ))
            ;;
        "*")
            echo "multiplication of "$operand_1" and "$operand_2
            result=$(( significand_first * significand_second ))
            power_of_ten=$(( $power_of_ten*2 ))
            ;;
        "/")
            echo "division of "$operand_1" and "$operand_2
            power_of_ten=$(( $power_of_ten + 1 ))
            multiplier=$(( 10**$power_of_ten ))
            result=$(( multiplier*significand_first / significand_second ))
            ;;
    esac

    echo "Result is:"
    printf %.2f "$(( result ))e-$power_of_ten"
}

pars_expression
calculate