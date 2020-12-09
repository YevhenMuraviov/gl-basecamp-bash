#!/usr/bin/env bash

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
