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
//              MPSoC-or1k CPU                                                //
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

module or1k_mpsoc4d_wrapper #(
  parameter AW = 32,
  parameter DW = 32,

  parameter X = 2,
  parameter Y = 2,
  parameter Z = 2,
  parameter T = 2,

  localparam NODES = X*Y*Z*T
)
  (
    input clk,
    input rst
  );

  ////////////////////////////////////////////////////////////////
  //
  // Constans
  //

  parameter USE_DEBUG        = 0;
  parameter ENABLE_VCHANNELS = 1*1;

  parameter integer NUM_CORES = 1*1; // bug in verilator would give a warning
  parameter integer LMEM_SIZE = 32*1024*1024;

  localparam base_config_t
  BASE_CONFIG = '{NUMTILES: 16,
                  NUMCTS: 16,
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

  genvar i;

  logic [NODES-1:0][AW-1:0] spram_adr_i;
  logic [NODES-1:0][DW-1:0] spram_dat_i;
  logic [NODES-1:0][   3:0] spram_sel_i;
  logic [NODES-1:0]         spram_we_i;
  logic [NODES-1:0][   1:0] spram_bte_i;
  logic [NODES-1:0][   2:0] spram_cti_i;
  logic [NODES-1:0]         spram_cyc_i;
  logic [NODES-1:0]         spram_stb_i;

  logic [NODES-1:0]         spram_ack_o;
  logic [NODES-1:0]         spram_err_o;
  logic [NODES-1:0][DW-1:0] spram_dat_o;

  glip_channel c_glip_in  (.*);
  glip_channel c_glip_out (.*);

  ////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  generate
    for (i=0; i<NODES; i=i+1) begin : gen_ct
      mpsoc_wb_spram #(
       .DEPTH   ( 256 ),
       .MEMFILE ( ""  ),
       .AW      ( AW  ),
       .DW      ( DW  )
      )
      wb_spram (
        .wb_clk_i ( clk ),
        .wb_rst_i ( rst ),

        //WB Slave Interface
        .wb_adr_i ( spram_adr_i [i] ),
        .wb_dat_i ( spram_dat_i [i] ),
        .wb_sel_i ( spram_sel_i [i] ),
        .wb_we_i  ( spram_we_i  [i] ),
        .wb_bte_i ( spram_bte_i [i] ),
        .wb_cti_i ( spram_cti_i [i] ),
        .wb_cyc_i ( spram_cyc_i [i] ),
        .wb_stb_i ( spram_stb_i [i] ),

        .wb_ack_o ( spram_ack_o [i] ),
        .wb_err_o ( spram_err_o [i] ),
        .wb_dat_o ( spram_dat_o [i] )
      );
    end
  endgenerate

  or1k_mpsoc4d #(
    .CONFIG (CONFIG)
  )
  mpsoc4d (
    .clk        (clk),
    .rst        (rst),

    .c_glip_in  (c_glip_in),
    .c_glip_out (c_glip_out),

    .wb_ext_adr_i (spram_adr_i),
    .wb_ext_cyc_i (spram_cyc_i),
    .wb_ext_dat_i (spram_dat_i),
    .wb_ext_sel_i (spram_sel_i),
    .wb_ext_stb_i (spram_stb_i),
    .wb_ext_we_i  (spram_we_i ),
    .wb_ext_cab_i (),
    .wb_ext_cti_i (spram_cti_i),
    .wb_ext_bte_i (spram_bte_i),

    .wb_ext_ack_o (spram_ack_o),
    .wb_ext_err_o (spram_err_o),
    .wb_ext_rty_o (1'b1       ),
    .wb_ext_dat_o (spram_dat_o)
  );
endmodule
