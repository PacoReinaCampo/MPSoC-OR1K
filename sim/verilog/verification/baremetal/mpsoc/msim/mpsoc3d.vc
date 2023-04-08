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
##              Architecture                                                     ##
##              QueenField                                                       ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2019-2020 by the author(s)                                      ##
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
##   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           ##
##                                                                               ##
###################################################################################

+incdir+../../../../../../soc/pu/rtl/verilog/pkg
+incdir+../../../../../../soc/rtl/verilog/soc/bootrom
+incdir+../../../../../../soc/bench/cpp/verilator/inc
+incdir+../../../../../../soc/bench/cpp/glip

../../../../../../soc/dma/rtl/verilog/code/pkg/core/peripheral_dma_pkg.sv

../../../../../../soc/rtl/verilog/pkg/arbiter/soc_arbiter_rr.sv
../../../../../../soc/rtl/verilog/pkg/functions/soc_optimsoc_functions.sv
../../../../../../soc/rtl/verilog/pkg/configuration/soc_optimsoc_configuration.sv
../../../../../../soc/rtl/verilog/pkg/constants/soc_optimsoc_constants.sv

../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interfaces/common/peripheral_dbg_soc_dii_channel_flat.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interfaces/common/peripheral_dbg_soc_dii_channel.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interfaces/or1k/peripheral_dbg_soc_mor1kx_trace_exec.sv

../../../../../../soc/bench/verilog/glip/soc_glip_channel.sv

../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/buffer/peripheral_dbg_soc_dii_buffer.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/buffer/peripheral_dbg_soc_osd_fifo.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/eventpacket/peripheral_dbg_soc_osd_event_packetization_fixedwidth.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/eventpacket/peripheral_dbg_soc_osd_event_packetization.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess_demux.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess_layer.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/timestamp/peripheral_dbg_soc_osd_timestamp.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/blocks/tracesample/peripheral_dbg_soc_osd_tracesample.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_debug_ring_expand.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_debug_ring.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_demux.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway_demux.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway_mux.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_mux_rr.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_mux.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/ctm/common/peripheral_dbg_soc_osd_ctm.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/ctm/or1k/peripheral_dbg_soc_osd_ctm_mor1kx.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart_16550.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart_wb.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/him/peripheral_dbg_soc_osd_him.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/mam/common/peripheral_dbg_soc_osd_mam.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/mam/wishbone/peripheral_dbg_soc_mam_adapter_wb.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/mam/wishbone/peripheral_dbg_soc_osd_mam_if_wb.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/mam/wishbone/peripheral_dbg_soc_osd_mam_wb.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/scm/peripheral_dbg_soc_osd_scm.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/stm/common/peripheral_dbg_soc_osd_stm.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/modules/stm/or1k/mor1kx/peripheral_dbg_soc_osd_stm_mor1kx.sv
../../../../../../soc/dbg/rtl/soc/verilog/code/peripheral/top/peripheral_dbg_soc_interface.sv

../../../../../../soc/dma/rtl/verilog/code/core/peripheral_dma_initiator_nocreq.sv
../../../../../../soc/dma/rtl/verilog/code/core/peripheral_dma_packet_buffer.sv
../../../../../../soc/dma/rtl/verilog/code/core/peripheral_dma_request_table.sv
../../../../../../soc/dma/rtl/verilog/code/peripheral/wb/peripheral_dma_initiator_nocres_wb.sv
../../../../../../soc/dma/rtl/verilog/code/peripheral/wb/peripheral_dma_initiator_req_wb.sv
../../../../../../soc/dma/rtl/verilog/code/peripheral/wb/peripheral_dma_initiator_wb.sv
../../../../../../soc/dma/rtl/verilog/code/peripheral/wb/peripheral_dma_interface_wb.sv
../../../../../../soc/dma/rtl/verilog/code/peripheral/wb/peripheral_dma_target_wb.sv
../../../../../../soc/dma/rtl/verilog/code/peripheral/wb/peripheral_dma_top_wb.sv

../../../../../../soc/mpi/rtl/verilog/code/core/peripheral_mpi_buffer.sv
../../../../../../soc/mpi/rtl/verilog/code/core/peripheral_mpi_buffer_endpoint.sv
../../../../../../soc/mpi/rtl/verilog/code/peripheral/wb/peripheral_mpi_wb.sv

../../../../../../soc/noc/rtl/verilog/code/peripheral/main/peripheral_arbiter_rr.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/main/peripheral_noc_buffer.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/main/peripheral_noc_demux.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/main/peripheral_noc_mux.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/main/peripheral_noc_vchannel_mux.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_input.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_lookup_slice.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_lookup.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_output.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router.sv
../../../../../../soc/noc/rtl/verilog/code/peripheral/topology/peripheral_noc_mesh3d.sv

../../../../../../soc/pu/rtl/verilog/core/control/pu_or1k_cfgrs.sv
../../../../../../soc/pu/rtl/verilog/core/control/pu_or1k_ctrl_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/control/pu_or1k_pcu.sv
../../../../../../soc/pu/rtl/verilog/core/control/pu_or1k_pic.sv
../../../../../../soc/pu/rtl/verilog/core/control/pu_or1k_ticktimer.sv
../../../../../../soc/pu/rtl/verilog/core/decode/pu_or1k_decode.sv
../../../../../../soc/pu/rtl/verilog/core/execute/pu_or1k_execute_alu.sv
../../../../../../soc/pu/rtl/verilog/core/execute/pu_or1k_execute_ctrl_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/execute/pu_or1k_rf_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/execute/pu_or1k_wb_mux_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/fetch/pu_or1k_cache_lru.sv
../../../../../../soc/pu/rtl/verilog/core/fetch/pu_or1k_fetch_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/fetch/pu_or1k_icache.sv
../../../../../../soc/pu/rtl/verilog/core/fetch/pu_or1k_immu.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_branch_prediction.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_branch_predictor_gshare.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_branch_predictor_saturation_counter.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_branch_predictor_simple.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_bus_if_wb32.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_core.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_cpu_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_cpu.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_or1k_decode_execute_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/memory/pu_or1k_dcache.sv
../../../../../../soc/pu/rtl/verilog/core/memory/pu_or1k_dmmu.sv
../../../../../../soc/pu/rtl/verilog/core/memory/pu_or1k_lsu_cappuccino.sv
../../../../../../soc/pu/rtl/verilog/core/memory/pu_or1k_store_buffer.sv
../../../../../../soc/pu/rtl/verilog/core/pfpu32/pu_or1k_pfpu32_addsub.sv
../../../../../../soc/pu/rtl/verilog/core/pfpu32/pu_or1k_pfpu32_cmp.sv
../../../../../../soc/pu/rtl/verilog/core/pfpu32/pu_or1k_pfpu32_f2i.sv
../../../../../../soc/pu/rtl/verilog/core/pfpu32/pu_or1k_pfpu32_i2f.sv
../../../../../../soc/pu/rtl/verilog/core/pfpu32/pu_or1k_pfpu32_muldiv.sv
../../../../../../soc/pu/rtl/verilog/core/pfpu32/pu_or1k_pfpu32_rnd.sv
../../../../../../soc/pu/rtl/verilog/core/pfpu32/pu_or1k_pfpu32_top.sv
../../../../../../soc/pu/rtl/verilog/memory/pu_or1k_simple_dpram_sclk.sv
../../../../../../soc/pu/rtl/verilog/memory/pu_or1k_true_dpram_sclk.sv
../../../../../../soc/pu/rtl/verilog/module/pu_or1k_module.sv

../../../../../../soc/rtl/verilog/soc/adapter/soc_network_adapter_configuration.sv
../../../../../../soc/rtl/verilog/soc/adapter/soc_network_adapter_ct.sv
../../../../../../soc/rtl/verilog/soc/bootrom/soc_bootrom.sv
../../../../../../soc/rtl/verilog/soc/interconnection/bus/soc_b3_wb.sv
../../../../../../soc/rtl/verilog/soc/interconnection/decode/soc_decode_wb.sv
../../../../../../soc/rtl/verilog/soc/interconnection/mux/soc_mux_wb.sv
../../../../../../soc/rtl/verilog/soc/main/soc_or1k_tile.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_sram_sp_impl_plain.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_sram_sp.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_sram_sp_wb.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_wb2sram.sv

../../../../../../rtl/verilog/mpsoc/mpsoc3d_or1k.sv

../../../../../../bench/verilog/main/mpsoc3d_or1k_testbench.sv
