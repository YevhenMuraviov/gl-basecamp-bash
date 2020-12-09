#!/usr/bin/env bash

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
