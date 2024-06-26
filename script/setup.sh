#!/bin/bash -f

# Create design library directory paths and define design library mappings in cds.lib
create_lib_mappings()
{
  libs=(xil_defaultlib)
  file="cds.lib"
  dir="."

  if [[ -e $file ]]; then
    rm -f $file
  fi
  if [[ -e $dir ]]; then
    rm -rf $dir
  fi

  touch $file
  lib_map_path=$XCLIB
  incl_ref="INCLUDE $lib_map_path/cds.lib"
  echo $incl_ref >> $file
  for (( i=0; i<${#libs[*]}; i++ )); do
    lib="${libs[i]}"
    lib_dir="$dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
      mapping="DEFINE $lib $dir/$lib"
      echo $mapping >> $file
    fi
  done

  touch "./hdl.var"

}

# Launch script
create_lib_mappings
