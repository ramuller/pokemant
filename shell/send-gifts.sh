#!/bin/bash
export PIPE=/tmp/gift-send


get_rgb()
{

    if [ $# -lt 2 ] ; then
        echo get_rgb needs  x y 
        echo "Got count $# '$@'" 
        exit 1
    fi
    printf "color:$1,$2\n" >$PIPE
    sleep 1
    values="$(tail -n 1 ${PIPE}.sh | sed "s/.*color://")"
    rgb=($(echo $values |cut -d ',' -f 3) $(echo $values |cut -d ',' -f 4) $(echo $values |cut -d ',' -f 5))
    echo RGB ${rgb[@]}
}

check_color()
{
    if [ $# -ne 6 ] ; then
        echo check_color needs  x y r g b threshold
        echo "Got count $# '$@'" 
        exit 1
    fi
    x=$1;  y=$2
    r=$3;  g=$4 ; b=$5
    t=$6
    echo "check color : ${@}"
    get_rgb $x $y
    if [[ \
          ${rgb[0]} -lt $(( r + t ))  && ${rgb[1]} -lt $(( g + t ))  && ${rgb[2]} -lt $(( b + t  )) && \
          ${rgb[0]} -gt $(( r - t ))  && ${rgb[1]} -gt $(( g - t ))  && ${rgb[2]} -gt $(( b - t  ))
       ]]
    then
        echo "Color match"
        return 0
    else
        echo "Collor miss"
        return 1
    fi

}

back_home()
{
    echo "Back home"
    get_rgb 285 916
    while [[ ${rgb[0]} -lt 255 && ${rgb[1]} -gt 100 && ${rgb[2]} -gt 100 ]]
    do
        echo Not home color ${rgb[@]}
        sleep 1
        get_rgb 285 916
        if [[ ${rgb[0]} -lt 255 && ${rgb[1]} -gt 100 && ${rgb[2]} -gt 100 ]]; then
            echo Send home screen step bak
            printf "click:290,945,3,200\n" | tee $PIPE
        fi
        get_rgb 285 916
        echo Not home color ${rgb[@]}
    done
}

receive_gift()
{
    echo Do not send gift
    printf "############# Send gift"
    printf "click:250,831,1,200\n" | tee $PIPE
    ## gift-send:color:218,831,0xFF,0xD0,0xF9
    ## gift-send:color:218,831,255,208,249
    sleep 1
    sleep 4
    echo press send
    printf "click:291,853,1,200\n" | tee $PIPE
    ## gift-send:color:291,853,0x84,0xD4,0xA5
    ## gift-send:color:291,853,132,212,165
    sleep 2
    if check_color 150 519 232 128 181 10 ; then
        echo Limit reached
        printf "click:290,945,3,200\n" | tee $PIPE
        sleep 1
        no_send="true"
        send_limit_reached="true"
    else
        printf "click:291,853,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xD4,0xFD,0xDF
        ## gift-send:color:165,885,212,253,223
        sleep 1
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 0
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xF3,0xE7,0xD0
        ## gift-send:color:165,885,243,231,208
        sleep 0
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 1
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xF3,0xE7,0xD0
        ## gift-send:color:165,885,243,231,208
        sleep 0
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 0
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xF3,0xE7,0xD0
        ## gift-send:color:165,885,243,231,208
        sleep 1
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 0
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xF3,0xE7,0xD0
        ## gift-send:color:165,885,243,231,208
        sleep 0
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 1
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xF3,0xE7,0xD0
        ## gift-send:color:165,885,243,231,208
        sleep 0
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 0
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xF3,0xE7,0xD0
        ## gift-send:color:165,885,243,231,208
        sleep 1
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 0
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xF3,0xE7,0xD0
        ## gift-send:color:165,885,243,231,208
        sleep 0
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 2
        printf "button_down:165,885,1,200\n" | tee $PIPE
        ## gift-send:color:165,885,0xFF,0xE9,0xED
        ## gift-send:color:165,885,255,233,237
        sleep 1
        printf "button_up:165,885,1,200\n" | tee $PIPE
        sleep 2
    fi
}

back_home

sleep 0
printf "button_down:75,925,1,200\n" | tee $PIPE
## gift-s7:color:75,925,0x1A,0x13,0x0A
sleep 0
printf "button_up:75,925,1,200\n" | tee $PIPE
while ! check_color 285 182 255 255 255 5 ; do
    echo Wait for tainer screen
    sleep 0.5
done

sleep 1
# Search trainer
printf "click:489,239,1,200\n" | tee $PIPE
## gift-s7:color:489,239,0x6E,0xD9,0xBE
sleep 2
printf "key:\!\n" | tee $PIPE
sleep 0
printf "key:f\n" | tee $PIPE
sleep 0
printf "key:f\n" | tee $PIPE
sleep 0.5
printf "button_down:488,583,1,200\n" | tee $PIPE
## gift-s7:color:488,583,0xFF,0xFF,0xFF
sleep 0
printf "button_up:491,582,1,200\n" | tee $PIPE
sleep 3
printf "button_down:241,415,1,200\n" | tee $PIPE
## gift-s7:color:241,415,0xFF,0xFF,0xFF
sleep 0
printf "button_up:241,415,1,200\n" | tee $PIPE
sleep 3
# Check pixel for a gift
# sleep 2
get_rgb 288 706
if [[ ${rgb[0]} -gt 200 && ${rgb[1]} -lt 100 && ${rgb[2]} -gt 175 ]]
then
    receive_gift
else
    echo no gift
    no_gift="true"
fi


echo Send gift
printf "click:117,862,1,200\n" | tee $PIPE
## gift-s7:color:117,862,0xF6,0xD0,0x68
sleep 2
echo Check if not gift can be send
if check_color 150 519 232 128 181 10 ; then
    echo Do not send gift
    no_send="true"
else
    printf "button_down:314,383,1,200\n" | tee $PIPE
    ## gift-s7:color:314,383,0xB6,0xB3,0x65
    sleep 0
    printf "button_up:314,383,1,200\n" | tee $PIPE
    sleep 3
    printf "button_down:285,843,1,200\n" | tee $PIPE
    ## gift-s7:color:285,843,0x84,0xD4,0xA5
    sleep 0
    printf "button_up:285,843,1,200\n" | tee $PIPE
    sleep 5
    printf "button_down:292,947,1,200\n" | tee $PIPE
    ## gift-s7:color:292,947,0x21,0x88,0x83
    sleep 0
    printf "button_up:292,947,1,200\n" | tee $PIPE
    sleep 2
    printf "button_down:292,947,1,200\n" | tee $PIPE
    ## gift-s7:color:292,947,0x3D,0x79,0x75
    sleep 0
    printf "button_up:292,947,1,200\n" | tee $PIPE
fi

# return 1 if nothing to send and nothing to receive
echo no_gift "$no_gift"
echo no_send "$no_send"

if [[ -n "$no_gift" && -n "$no_send"  ]] ; then
   echo Nothing to send nothing to get
   exit 1
else
    exit 0
fi
   