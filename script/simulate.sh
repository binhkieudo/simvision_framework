#!/bin/bash

#set -Eeuo pipefail

orig=.
logs=$orig/logs

# installation path setting
bin_path=$XCPATH

if [ ! -f $orig/restore.tcl ]; then
    xmsim_opts="-64bit -logfile $logs/simulate.log -gui"
    $bin_path/xmsim $xmsim_opts xil_defaultlib.tb -input ./script/tb_simulate.do
else
    x=`grep "\# Do not remove this line" ./restore.tcl`
    if [ -z "$x" ]
    then
        f="restore.tcl"
        echo "" >> $f
        echo "# Do not remove this line" >> $f
        echo "run" >> $f
        echo "" >> $f
    fi
    xmsim_opts="-64bit -logfile $logs/simulate.log"
    $bin_path/xmsim $xmsim_opts xil_defaultlib.tb -tcl -update -input restore.tcl
fi