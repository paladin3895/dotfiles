#!/bin/sh
command=$(zenity --entry --title "Enter command" --text "");
echo $command
case "$command" in
    ":c1") copyq tab clipboard select 1 &> /dev/null;;
    ":c2") copyq tab clipboard select 2 &> /dev/null;;
    ":c3") copyq tab clipboard select 3 &> /dev/null;;
    ":c4") copyq tab clipboard select 4 &> /dev/null;;
    ":c5") copyq tab clipboard select 5 &> /dev/null;;
    ":c6") copyq tab clipboard select 6 &> /dev/null;;
    ":c7") copyq tab clipboard select 7 &> /dev/null;;
    ":c8") copyq tab clipboard select 8 &> /dev/null;;
    ":c9") copyq tab clipboard select 9 &> /dev/null;;

    # ":n1") copyq tab notes read 0 | rev | cut -c 1- | rev;;
    # ":n2") copyq tab notes read 1 | rev | cut -c 1- | rev;;
    # ":n3") copyq tab notes read 2 | rev | cut -c 1- | rev;;
    # ":n4") copyq tab notes read 3 | rev | cut -c 1- | rev;;
    # ":n5") copyq tab notes read 4 | rev | cut -c 1- | rev;;
    # ":n6") copyq tab notes read 5 | rev | cut -c 1- | rev;;
    # ":n7") copyq tab notes read 6 | rev | cut -c 1- | rev;;
    # ":n8") copyq tab notes read 7 | rev | cut -c 1- | rev;;
    # ":n9") copyq tab notes read 8 | rev | cut -c 1- | rev;;

    ":i1") copyq tab notes insert 0;;
    ":i2") copyq tab notes insert 1;;
    ":i3") copyq tab notes insert 2;;
    ":i4") copyq tab notes insert 3;;
    ":i5") copyq tab notes insert 4;;
    ":i6") copyq tab notes insert 5;;
    ":i7") copyq tab notes insert 6;;
    ":i8") copyq tab notes insert 7;;
    ":i9") copyq tab notes insert 8;;

    ":s1") copyq tab clipboard copy "`copyq tab notes read 0 | rev | cut -c 1- | rev`";;
    ":s2") copyq tab clipboard copy "`copyq tab notes read 1 | rev | cut -c 1- | rev`";;
    ":s3") copyq tab clipboard copy "`copyq tab notes read 2 | rev | cut -c 1- | rev`";;
    ":s4") copyq tab clipboard copy "`copyq tab notes read 3 | rev | cut -c 1- | rev`";;
    ":s5") copyq tab clipboard copy "`copyq tab notes read 4 | rev | cut -c 1- | rev`";;
    ":s6") copyq tab clipboard copy "`copyq tab notes read 5 | rev | cut -c 1- | rev`";;
    ":s7") copyq tab clipboard copy "`copyq tab notes read 6 | rev | cut -c 1- | rev`";;
    ":s8") copyq tab clipboard copy "`copyq tab notes read 7 | rev | cut -c 1- | rev`";;
    ":s9") copyq tab clipboard copy "`copyq tab notes read 8 | rev | cut -c 1- | rev`";;

    # ":n") copyq_notes;;
    # ":c") copyq_clipboard;;
esac
