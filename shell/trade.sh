#!/bin/bash

if [ $# -ne 2 ]; then
    echo give pipe args
    exit 1
fi

export PIPE="$1"

export PIPES="$1 $2"

source poke-lib.sh


while true
do

    for PIPE in $PIPES
    do
        timeout=10
        while ! check_color 301 946 28 135 149 16
        do
            echo "Waiting for trade complete on $PIPE"
            # Check for new biggest
            if check_color 301 946 240 240 240 16 ; then
                click 301 946
            fi
            timeout=$(( timeout - 1 ))
            echo "Countdown $timeout"
            if [ $timeout -le 0 ]; then
                echo "No trade complete $PIPE"
                exit 1
            fi
        done
        click 494,849
    done

    for PIPE in $PIPES
    do
        timeout=10
        while ! check_color 115 182 233 243 223 16
        do
            echo "Waiting for trading screen on $PIPE"
            timeout=$(( timeout - 1 ))
            echo "Countdown $timeout"
            if [ $timeout -le 0 ]; then
                echo "No trading screen on $PIPE"
                exit 1
            fi
        done
    done
    sleep 2
    for PIPE in $PIPES
    do
        click 104 357
    done

    for PIPE in $PIPES
    do
        timeout=10
        while ! check_color 199 838 150 218 149 20
        do
            echo "Waiting for send OK on $PIPE"
            timeout=$(( timeout - 1 ))
            echo "Countdown $timeout"
            if [ $timeout -le 0 ]; then
                echo "No send OK on $PIPE"
                exit 1
            fi
        done
        sleep 1
        click 199 838
    done

    for PIPE in $PIPES
    do
        timeout=10
        while ! check_color 11 521 105 208 146 20
        do
            echo "Waiting for send OK on $PIPE"
            timeout=$(( timeout - 1 ))
            echo "Countdown $timeout"
            if [ $timeout -le 0 ]; then
                echo "No send OK on $PIPE"
                exit 1
            fi
        done
        click 11 521
    done


    for PIPE in $PIPES
    do
        timeout=10
        while ! check_color 301 946 28 135 149 16
        do
            echo "Waiting for trade complete on $PIPE"
            # Check for new biggest
            if check_color 301 946 240 240 240 16 ; then
                click 301 946
            fi
            timeout=$(( timeout - 1 ))
            echo "Countdown $timeout"
            if [ $timeout -le 0 ]; then
                echo "No trade complete $PIPE"
                exit 1
            fi
        done
        click 301 946
    done
    sleep 1
done
