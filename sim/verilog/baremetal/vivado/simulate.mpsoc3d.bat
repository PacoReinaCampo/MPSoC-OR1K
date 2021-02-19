@echo off
call ../../../../settings64_vivado.bat

xvlog -prj soc.prj \
-i ../../../../soc/pu/rtl/verilog/pkg \
-i ../../../../soc/rtl/verilog/soc/bootrom \
-i ../../../../soc/dma/rtl/verilog/wb/pkg
xelab mpsoc3d_or1k_testbench
xsim -R mpsoc3d_or1k_testbench
pause
