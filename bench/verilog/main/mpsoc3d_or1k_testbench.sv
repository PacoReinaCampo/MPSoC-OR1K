////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MPSoC-OR1K CPU                                                //
//              Multi Processor System on Chip                                //
//              Wishbone Bus Interface                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2019-2020 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

import dii_package::dii_flit;
import opensocdebug::mor1kx_trace_exec;
import optimsoc_config::*;
import optimsoc_functions::*;

module mpsoc3d_or1k_testbench;

  ////////////////////////////////////////////////////////////////
  //
  // Constans
  //

  parameter USE_DEBUG        = 0;
  parameter ENABLE_VCHANNELS = 1*1;

  parameter integer NUM_CORES = 1*1; // bug in verilator would give a warning
  parameter integer LMEM_SIZE = 32*1024*1024;

  localparam base_config_t
  BASE_CONFIG = '{NUMTILES: 8,
                  NUMCTS: 8,
                  CTLIST: {{60{16'hx}}, 16'h0, 16'h1, 16'h2, 16'h3},
                  CORES_PER_TILE: NUM_CORES,
                  GMEM_SIZE: 0,
                  GMEM_TILE: 'x,
                  NOC_ENABLE_VCHANNELS: ENABLE_VCHANNELS,
                  LMEM_SIZE: LMEM_SIZE,
                  LMEM_STYLE: PLAIN,
                  ENABLE_BOOTROM: 0,
                  BOOTROM_SIZE: 0,
                  ENABLE_DM: 1,
                  DM_BASE: 32'h0,
                  DM_SIZE: LMEM_SIZE,
                  ENABLE_PGAS: 0,
                  PGAS_BASE: 0,
                  PGAS_SIZE: 0,
                  CORE_ENABLE_FPU: 0,
                  CORE_ENABLE_PERFCOUNTERS: 0,
                  NA_ENABLE_MPSIMPLE: 1,
                  NA_ENABLE_DMA: 1,
                  NA_DMA_GENIRQ: 1,
                  NA_DMA_ENTRIES: 4,
                  USE_DEBUG: 1'(USE_DEBUG),
                  DEBUG_STM: 1,
                  DEBUG_CTM: 1,
                  DEBUG_DEM_UART: 0,
                  DEBUG_SUBNET_BITS: 6,
                  DEBUG_LOCAL_SUBNET: 0,
                  DEBUG_ROUTER_BUFFER_SIZE: 4,
                  DEBUG_MAX_PKT_LEN: 12
                  };

  localparam config_t CONFIG = derive_config(BASE_CONFIG);

  ////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  logic rst_sys;
  logic rst_cpu;

  logic cpu_stall;

  // In Verilator, we feed clk and rst from the C++ toplevel, in ModelSim & Co.
  // these signals are generated inside this testbench.
  `ifndef verilator
  reg clk;
  reg rst;
  `endif

  logic com_rst;
  logic logic_rst;

  wire [CONFIG.NUMCTS*CONFIG.CORES_PER_TILE-1:0] termination;

  // Monitor system behavior in simulation
  genvar t;
  genvar i;

  ////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  glip_channel c_glip_in  (.*);
  glip_channel c_glip_out (.*);

  or1k_mpsoc3d #(
    .CONFIG (CONFIG)
  )
  u_system (
    .clk        (clk),
    .rst        (rst | logic_rst),
    .c_glip_in  (c_glip_in),
    .c_glip_out (c_glip_out),

    .wb_ext_ack_o ('x),
    .wb_ext_err_o ('x),
    .wb_ext_rty_o ('x),
    .wb_ext_dat_o ('x),
    .wb_ext_adr_i (),
    .wb_ext_cyc_i (),
    .wb_ext_dat_i (),
    .wb_ext_sel_i (),
    .wb_ext_stb_i (),
    .wb_ext_we_i  (),
    .wb_ext_cab_i (),
    .wb_ext_cti_i (),
    .wb_ext_bte_i ()
  );
endmodule
