#!/bin/sh
###############################
#utils                        #
#author:RwdrQP                #
###############################
rand() {
	min=$1
	max=`expr $2 - $1 + 1`
	num=`cat /proc/sys/kernel/random/uuid | cksum | awk -F' ' '{print $1}'`
	echo `expr $num % $max + $min`
}


#test
rand 1 100


