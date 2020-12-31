###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              MPSoC-OR1K CPU                                                   ##
##              Synthesis Test Makefile                                          ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2018-2019 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Francisco Javier Reina Campo <frareicam@gmail.com>                          ##
##                                                                               ##
###################################################################################

read_verilog -sv ../../../rtl/verilog/pkg/arbiter/arb_rr.sv
read_verilog -sv ../../../rtl/verilog/pkg/functions/optimsoc_functions.sv
read_verilog -sv ../../../rtl/verilog/pkg/config/optimsoc_config.sv
read_verilog -sv ../../../rtl/verilog/pkg/constants/optimsoc_constants.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interfaces/or1k/mor1kx_trace_exec.sv
read_verilog -sv ../../../bench/verilog/glip/glip_channel.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interfaces/common/dii_channel_flat.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interfaces/common/dii_channel.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/debug_interface.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/buffer/dii_buffer.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/buffer/osd_fifo.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/ctm/common/osd_ctm.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/ctm/or1k/mor1kx/osd_ctm_mor1kx.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/eventpacket/osd_event_packetization_fixedwidth.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/him/osd_him.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/wishbone/mam_wb_adapter.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/wishbone/osd_mam_wb_if.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/wishbone/osd_mam_wb.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/common/osd_mam.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/eventpacket/osd_event_packetization.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/regaccess/osd_regaccess_demux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/regaccess/osd_regaccess_layer.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/regaccess/osd_regaccess.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/tracesample/osd_tracesample.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/scm/osd_scm.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/stm/common/osd_stm.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/stm/or1k/mor1kx/osd_stm_mor1kx.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/timestamp/osd_timestamp.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/dem_uart/osd_dem_uart.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/dem_uart/osd_dem_uart_16550.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/dem_uart/osd_dem_uart_wb.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/debug_ring_expand.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/debug_ring.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_demux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_gateway_demux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_gateway_mux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_gateway.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_mux_rr.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_mux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/core/mpsoc_dma_initiator_nocreq.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/core/mpsoc_dma_packet_buffer.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/core/mpsoc_dma_request_table.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/wb/mpsoc_dma_wb_initiator.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/wb/mpsoc_dma_wb_initiator_nocres.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/wb/mpsoc_dma_wb_initiator_req.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/wb/mpsoc_dma_wb_interface.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/wb/mpsoc_dma_wb_target.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/wb/wb/mpsoc_dma_wb_top.sv
read_verilog -sv ../../../soc/mpi/rtl/verilog/wb/core/mpi_buffer.sv
read_verilog -sv ../../../soc/mpi/rtl/verilog/wb/core/mpi_buffer_endpoint.sv
read_verilog -sv ../../../soc/mpi/rtl/verilog/wb/wb/mpi_wb.sv
read_verilog -sv ../../../rtl/verilog/mpsoc/or1k_mpsoc4d.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_buffer.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_demux.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_mux.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_vchannel_mux.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_input.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_lookup.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_lookup_slice.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_output.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/topology/noc_mesh4d.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/control/or1k_cfgrs.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/control/or1k_ctrl_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/control/or1k_pcu.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/control/or1k_pic.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/control/or1k_ticktimer.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/decode/or1k_decode.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/or1k_execute_alu.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/or1k_execute_ctrl_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/or1k_rf_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/or1k_wb_mux_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/pfpu32/pfpu32_addsub.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/pfpu32/pfpu32_cmp.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/pfpu32/pfpu32_f2i.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/pfpu32/pfpu32_i2f.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/pfpu32/pfpu32_muldiv.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/pfpu32/pfpu32_rnd.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/execute/pfpu32/pfpu32_top.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fetch/or1k_cache_lru.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fetch/or1k_fetch_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fetch/or1k_icache.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fetch/or1k_immu.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/memory/or1k_dcache.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/memory/or1k_dmmu.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/memory/or1k_lsu_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/memory/or1k_store_buffer.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_branch_prediction.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_branch_predictor_gshare.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_branch_predictor_saturation_counter.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_branch_predictor_simple.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_bus_if_wb32.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_core.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_cpu_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_cpu.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/or1k_decode_execute_cappuccino.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/memory/or1k_simple_dpram_sclk.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/memory/or1k_true_dpram_sclk.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/module/or1k_module.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/adapter/networkadapter_conf.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/adapter/networkadapter_ct.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/bootrom/bootrom.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/interconnection/bus/wb_bus_b3.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/interconnection/decode/wb_decode.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/interconnection/mux/wb_mux.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/spram/sram_sp_impl_plain.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/spram/sram_sp.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/spram/wb_sram_sp.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/spram/wb2sram.sv
read_verilog -sv ../../../soc/rtl/verilog/soc/or1k_tile.sv
read_verilog -sv ../../../soc/spram/rtl/verilog/wb/core/mpsoc_wb_ram_generic.sv
read_verilog -sv ../../../soc/spram/rtl/verilog/wb/core/mpsoc_wb_spram.sv

read_verilog -sv or1k_mpsoc4d_wrapper.sv

read_xdc system_4d.xdc

synth_design -part xc7z020-clg484-1 \
-include_dirs ../../../soc/pu/rtl/verilog/pkg \
-include_dirs ../../../soc/rtl/verilog/soc/bootrom \
-include_dirs ../../../bench/cpp/verilator/inc \
-include_dirs ../../../bench/cpp/glip \
-include_dirs ../../../soc/dma/rtl/verilog/wb/pkg \
-include_dirs ../../../soc/spram/rtl/verilog/wb/pkg \
-top or1k_mpsoc4d_wrapper

opt_design
place_design
route_design

report_utilization
report_timing

write_verilog -force system_4d.v
write_bitstream -force system_4d.bit
