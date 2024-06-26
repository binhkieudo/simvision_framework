#!/bin/bash

reset_log()
{
logs=(compile.log xmvhdl.log xmvlog.log xmsc.log .tmp_log)
for (( i=0; i<${#logs[*]}; i++ )); do
  file="${logs[i]}"
  if [[ -e $file ]]; then
    rm -rf $file
  fi
done
}
reset_log
set -Eeuo pipefail

orig=.

mkdir -p $orig/logs

logs=$orig/logs
rtl=$orig/rtl

# installation path setting
bin_path=$XCPATH

# directory path for design sources and include directories (if any) wrt this path
origin_dir="."

rtlsrc=`ls $rtl`

# Only perform if there are rlt files
if [[ ! -z $rtlsrc ]]; then
  rm -rf ./waves.shm
  
  mkdir -p $orig/xil_defaultlib

  echo "============= Compile =============================================================== "

  xmvlog_opts="-64bit -messages -logfile $logs/.tmp_log -update"
  # compile verilog design source files
  vsrc=`ls $rtl/*.v 2>/dev/null`
  if [[ ! -z $vsrc ]]; then
    $bin_path/xmvlog $xmvlog_opts -work xil_defaultlib $vsrc \
    2>&1 | tee $logs/compile.log; cat $logs/.tmp_log > $logs/xmvlog.log 2>/dev/null
  fi

  # compile sysgtem verilog design source files
  svsrc=`ls $rtl/*.sv 2>/dev/null` 
  if [[ ! -z $svsrc ]]; then
    $bin_path/xmvlog $xmvlog_opts -sv -work xil_defaultlib $svsrc \
    2>&1 | tee $logs/compile.log; cat $logs/.tmp_log > $logs/xmvlog.log 2>/dev/null
  fi

  echo "============= Elaborate ============================================================= "

  # set design libraries
  design_libs_elab="-libname xil_defaultlib -libname unisims_ver -libname unimacro_ver -libname secureip"
  xmelab_opts="-64bit -relax -access +rwc -namemap_mixgen -messages -logfile $logs/elaborate.log"

  # run elaboration
  $bin_path/xmelab $xmelab_opts $design_libs_elab xil_defaultlib.tb xil_defaultlib.glbl
fi