#!/bin/sh

# by binacs

if [ $1 == "go" ]; then
    pwd=$(PWD)
    for((i=$2;i<=$3;i++));  
    do
        v1=`expr $i / 100 % 10`
        v2=`expr $i / 10 % 10`
        v3=`expr $i / 1 % 10`
        target_dir="$pwd/tmp/$v1$v2$v3.md"
        if [ ! -d $target_dir ]; then
            cp $pwd/Template.md $target_dir
            echo "cp $pwd/Template.md to ${target_dir} done"
        fi
    done  
fi


