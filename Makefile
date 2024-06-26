export XCLIB=/home/binhkieudo/Public/Xilinx_library
export XCPATH=/home/binhkieudo/cadence/installs/XCELIUM2303/tools.lnx86/bin

init:
	./script/setup.sh

compile:
	./script/compile.sh

simulate: restore.tcl
	./script/simulate.sh

clean:
	rm -rf ./xil_defaultlib ./logs ./hdl.var ./*.shm ./*.vcd \
	tb_simulate.do cds.lib xmsim.key ./.simvision \
	*.dsn *.trn restore.*
