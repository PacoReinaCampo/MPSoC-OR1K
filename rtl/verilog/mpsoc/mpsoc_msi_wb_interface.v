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
//              MPSoC-RISCV CPU                                               //
//              Master Slave Interface                                        //
//              Wishbone Bus Interface                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2018-2019 by the author(s)
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
 *   Francisco Javier Reina Campo <frareicam@gmail.com>
 */

module mpsoc_msi_wb_interface (
  input         wb_clk_i,
  input         wb_rst_i,

  input  [31:0] wb_or1k_d_adr_i,
  input  [31:0] wb_or1k_d_dat_i,
  input   [3:0] wb_or1k_d_sel_i,
  input         wb_or1k_d_we_i,
  input         wb_or1k_d_cyc_i,
  input         wb_or1k_d_stb_i,
  input   [2:0] wb_or1k_d_cti_i,
  input   [1:0] wb_or1k_d_bte_i,
  output [31:0] wb_or1k_d_dat_o,
  output        wb_or1k_d_ack_o,
  output        wb_or1k_d_err_o,
  output        wb_or1k_d_rty_o,

  input  [31:0] wb_or1k_i_adr_i,
  input  [31:0] wb_or1k_i_dat_i,
  input   [3:0] wb_or1k_i_sel_i,
  input         wb_or1k_i_we_i,
  input         wb_or1k_i_cyc_i,
  input         wb_or1k_i_stb_i,
  input   [2:0] wb_or1k_i_cti_i,
  input   [1:0] wb_or1k_i_bte_i,
  output [31:0] wb_or1k_i_dat_o,
  output        wb_or1k_i_ack_o,
  output        wb_or1k_i_err_o,
  output        wb_or1k_i_rty_o,

  input  [31:0] wb_dbg_adr_i,
  input  [31:0] wb_dbg_dat_i,
  input   [3:0] wb_dbg_sel_i,
  input         wb_dbg_we_i,
  input         wb_dbg_cyc_i,
  input         wb_dbg_stb_i,
  input   [2:0] wb_dbg_cti_i,
  input   [1:0] wb_dbg_bte_i,
  output [31:0] wb_dbg_dat_o,
  output        wb_dbg_ack_o,
  output        wb_dbg_err_o,
  output        wb_dbg_rty_o,

  output [31:0] wb_mem_adr_o,
  output [31:0] wb_mem_dat_o,
  output  [3:0] wb_mem_sel_o,
  output        wb_mem_we_o,
  output        wb_mem_cyc_o,
  output        wb_mem_stb_o,
  output  [2:0] wb_mem_cti_o,
  output  [1:0] wb_mem_bte_o,
  input  [31:0] wb_mem_dat_i,
  input         wb_mem_ack_i,
  input         wb_mem_err_i,
  input         wb_mem_rty_i,

  input  [31:0] wbm_dma_adr_i,
  input  [31:0] wbm_dma_dat_i,
  input   [3:0] wbm_dma_sel_i,
  input         wbm_dma_we_i,
  input         wbm_dma_cyc_i,
  input         wbm_dma_stb_i,
  input   [2:0] wbm_dma_cti_i,
  input   [1:0] wbm_dma_bte_i,
  output [31:0] wbm_dma_dat_o,
  output        wbm_dma_ack_o,
  output        wbm_dma_err_o,
  output        wbm_dma_rty_o,

  output [31:0] wbs_dma_adr_o,
  output [31:0] wbs_dma_dat_o,
  output  [3:0] wbs_dma_sel_o,
  output        wbs_dma_we_o,
  output        wbs_dma_cyc_o,
  output        wbs_dma_stb_o,
  output  [2:0] wbs_dma_cti_o,
  output  [1:0] wbs_dma_bte_o,
  input  [31:0] wbs_dma_dat_i,
  input         wbs_dma_ack_i,
  input         wbs_dma_err_i,
  input         wbs_dma_rty_i,

  output [ 5:0] wb_mpi_adr_o,
  output [31:0] wb_mpi_dat_o,
  output [ 3:0] wb_mpi_sel_o,
  output        wb_mpi_we_o,
  output        wb_mpi_cyc_o,
  output        wb_mpi_stb_o,
  output  [2:0] wb_mpi_cti_o,
  output  [1:0] wb_mpi_bte_o,
  input  [31:0] wb_mpi_dat_i,
  input         wb_mpi_ack_i,
  input         wb_mpi_err_i,
  input         wb_mpi_rty_i,

  output [31:0] wb_gpio_adr_o,
  output [31:0] wb_gpio_dat_o,
  output  [3:0] wb_gpio_sel_o,
  output        wb_gpio_we_o,
  output        wb_gpio_cyc_o,
  output        wb_gpio_stb_o,
  output  [2:0] wb_gpio_cti_o,
  output  [1:0] wb_gpio_bte_o,
  input  [31:0] wb_gpio_dat_i,
  input         wb_gpio_ack_i,
  input         wb_gpio_err_i,
  input         wb_gpio_rty_i,

  output [31:0] wb_uart_adr_o,
  output  [7:0] wb_uart_dat_o,
  output  [3:0] wb_uart_sel_o,
  output        wb_uart_we_o,
  output        wb_uart_cyc_o,
  output        wb_uart_stb_o,
  output  [2:0] wb_uart_cti_o,
  output  [1:0] wb_uart_bte_o,
  input   [7:0] wb_uart_dat_i,
  input         wb_uart_ack_i,
  input         wb_uart_err_i,
  input         wb_uart_rty_i
);

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //
  wire [31:0] wb_m2s_or1k_d_mem_adr;
  wire [31:0] wb_m2s_or1k_d_mem_dat;
  wire  [3:0] wb_m2s_or1k_d_mem_sel;
  wire        wb_m2s_or1k_d_mem_we;
  wire        wb_m2s_or1k_d_mem_cyc;
  wire        wb_m2s_or1k_d_mem_stb;
  wire  [2:0] wb_m2s_or1k_d_mem_cti;
  wire  [1:0] wb_m2s_or1k_d_mem_bte;
  wire [31:0] wb_s2m_or1k_d_mem_dat;
  wire        wb_s2m_or1k_d_mem_ack;
  wire        wb_s2m_or1k_d_mem_err;
  wire        wb_s2m_or1k_d_mem_rty;

  wire [31:0] wb_m2s_or1k_i_mem_adr;
  wire [31:0] wb_m2s_or1k_i_mem_dat;
  wire  [3:0] wb_m2s_or1k_i_mem_sel;
  wire        wb_m2s_or1k_i_mem_we;
  wire        wb_m2s_or1k_i_mem_cyc;
  wire        wb_m2s_or1k_i_mem_stb;
  wire  [2:0] wb_m2s_or1k_i_mem_cti;
  wire  [1:0] wb_m2s_or1k_i_mem_bte;
  wire [31:0] wb_s2m_or1k_i_mem_dat;
  wire        wb_s2m_or1k_i_mem_ack;
  wire        wb_s2m_or1k_i_mem_err;
  wire        wb_s2m_or1k_i_mem_rty;

  wire [31:0] wb_m2s_dbg_mem_adr;
  wire [31:0] wb_m2s_dbg_mem_dat;
  wire  [3:0] wb_m2s_dbg_mem_sel;
  wire        wb_m2s_dbg_mem_we;
  wire        wb_m2s_dbg_mem_cyc;
  wire        wb_m2s_dbg_mem_stb;
  wire  [2:0] wb_m2s_dbg_mem_cti;
  wire  [1:0] wb_m2s_dbg_mem_bte;
  wire [31:0] wb_s2m_dbg_mem_dat;
  wire        wb_s2m_dbg_mem_ack;
  wire        wb_s2m_dbg_mem_err;
  wire        wb_s2m_dbg_mem_rty;

  wire [31:0] wbm_m2s_dma_mem_adr;
  wire [31:0] wbm_m2s_dma_mem_dat;
  wire  [3:0] wbm_m2s_dma_mem_sel;
  wire        wbm_m2s_dma_mem_we;
  wire        wbm_m2s_dma_mem_cyc;
  wire        wbm_m2s_dma_mem_stb;
  wire  [2:0] wbm_m2s_dma_mem_cti;
  wire  [1:0] wbm_m2s_dma_mem_bte;
  wire [31:0] wbm_s2m_dma_mem_dat;
  wire        wbm_s2m_dma_mem_ack;
  wire        wbm_s2m_dma_mem_err;
  wire        wbm_s2m_dma_mem_rty;

  wire [31:0] wbs_m2s_dma_mem_adr;
  wire [31:0] wbs_m2s_dma_mem_dat;
  wire  [3:0] wbs_m2s_dma_mem_sel;
  wire        wbs_m2s_dma_mem_we;
  wire        wbs_m2s_dma_mem_cyc;
  wire        wbs_m2s_dma_mem_stb;
  wire  [2:0] wbs_m2s_dma_mem_cti;
  wire  [1:0] wbs_m2s_dma_mem_bte;
  wire [31:0] wbs_s2m_dma_mem_dat;
  wire        wbs_s2m_dma_mem_ack;
  wire        wbs_s2m_dma_mem_err;
  wire        wbs_s2m_dma_mem_rty;

  wire [31:0] wb_m2s_resize_mpi_adr;

  wire [31:0] wb_m2s_resize_uart_adr;
  wire [31:0] wb_m2s_resize_uart_dat;
  wire  [3:0] wb_m2s_resize_uart_sel;
  wire        wb_m2s_resize_uart_we;
  wire        wb_m2s_resize_uart_cyc;
  wire        wb_m2s_resize_uart_stb;
  wire  [2:0] wb_m2s_resize_uart_cti;
  wire  [1:0] wb_m2s_resize_uart_bte;
  wire [31:0] wb_s2m_resize_uart_dat;
  wire        wb_s2m_resize_uart_ack;
  wire        wb_s2m_resize_uart_err;
  wire        wb_s2m_resize_uart_rty;

  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //
  mpsoc_msi_wb_mux #(
    .NUM_SLAVES (5),
    .MATCH_ADDR ({32'h00000000, 32'h90000000, 32'h90000000, 32'h90000000, 32'h90000000}),
    .MATCH_MASK ({32'hfe000000, 32'hfffffff8, 32'hfffffff8, 32'hfffffff8, 32'hfffffff8})
  )
  wb_mux_or1k_d (
    .wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k_d_adr_i),
    .wbm_dat_i (wb_or1k_d_dat_i),
    .wbm_sel_i (wb_or1k_d_sel_i),
    .wbm_we_i  (wb_or1k_d_we_i),
    .wbm_cyc_i (wb_or1k_d_cyc_i),
    .wbm_stb_i (wb_or1k_d_stb_i),
    .wbm_cti_i (wb_or1k_d_cti_i),
    .wbm_bte_i (wb_or1k_d_bte_i),
    .wbm_dat_o (wb_or1k_d_dat_o),
    .wbm_ack_o (wb_or1k_d_ack_o),
    .wbm_err_o (wb_or1k_d_err_o),
    .wbm_rty_o (wb_or1k_d_rty_o),
    .wbs_adr_o ({wb_m2s_or1k_d_mem_adr, wb_m2s_resize_uart_adr, wbs_dma_adr_o, wb_m2s_resize_mpi_adr, wb_gpio_adr_o}),
    .wbs_dat_o ({wb_m2s_or1k_d_mem_dat, wb_m2s_resize_uart_dat, wbs_dma_dat_o, wb_mpi_dat_o,          wb_gpio_dat_o}),
    .wbs_sel_o ({wb_m2s_or1k_d_mem_sel, wb_m2s_resize_uart_sel, wbs_dma_sel_o, wb_mpi_sel_o,          wb_gpio_sel_o}),
    .wbs_we_o  ({wb_m2s_or1k_d_mem_we,  wb_m2s_resize_uart_we,  wbs_dma_we_o,  wb_mpi_we_o,           wb_gpio_we_o}),
    .wbs_cyc_o ({wb_m2s_or1k_d_mem_cyc, wb_m2s_resize_uart_cyc, wbs_dma_cyc_o, wb_mpi_cyc_o,          wb_gpio_cyc_o}),
    .wbs_stb_o ({wb_m2s_or1k_d_mem_stb, wb_m2s_resize_uart_stb, wbs_dma_stb_o, wb_mpi_stb_o,          wb_gpio_stb_o}),
    .wbs_cti_o ({wb_m2s_or1k_d_mem_cti, wb_m2s_resize_uart_cti, wbs_dma_cti_o, wb_mpi_cti_o,          wb_gpio_cti_o}),
    .wbs_bte_o ({wb_m2s_or1k_d_mem_bte, wb_m2s_resize_uart_bte, wbs_dma_bte_o, wb_mpi_bte_o,          wb_gpio_bte_o}),
    .wbs_dat_i ({wb_s2m_or1k_d_mem_dat, wb_s2m_resize_uart_dat, wbs_dma_dat_i, wb_mpi_dat_i,          wb_gpio_dat_i}),
    .wbs_ack_i ({wb_s2m_or1k_d_mem_ack, wb_s2m_resize_uart_ack, wbs_dma_ack_i, wb_mpi_ack_i,          wb_gpio_ack_i}),
    .wbs_err_i ({wb_s2m_or1k_d_mem_err, wb_s2m_resize_uart_err, wbs_dma_err_i, wb_mpi_err_i,          wb_gpio_err_i}),
    .wbs_rty_i ({wb_s2m_or1k_d_mem_rty, wb_s2m_resize_uart_rty, wbs_dma_rty_i, wb_mpi_rty_i,          wb_gpio_rty_i})
  );

  mpsoc_msi_wb_mux #(
    .NUM_SLAVES (1),
    .MATCH_ADDR ({32'h00000000}),
    .MATCH_MASK ({32'hfe000000})
  )
  wb_mux_or1k_i (
    .wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k_i_adr_i),
    .wbm_dat_i (wb_or1k_i_dat_i),
    .wbm_sel_i (wb_or1k_i_sel_i),
    .wbm_we_i  (wb_or1k_i_we_i),
    .wbm_cyc_i (wb_or1k_i_cyc_i),
    .wbm_stb_i (wb_or1k_i_stb_i),
    .wbm_cti_i (wb_or1k_i_cti_i),
    .wbm_bte_i (wb_or1k_i_bte_i),
    .wbm_dat_o (wb_or1k_i_dat_o),
    .wbm_ack_o (wb_or1k_i_ack_o),
    .wbm_err_o (wb_or1k_i_err_o),
    .wbm_rty_o (wb_or1k_i_rty_o),
    .wbs_adr_o (wb_m2s_or1k_i_mem_adr),
    .wbs_dat_o (wb_m2s_or1k_i_mem_dat),
    .wbs_sel_o (wb_m2s_or1k_i_mem_sel),
    .wbs_we_o  (wb_m2s_or1k_i_mem_we),
    .wbs_cyc_o (wb_m2s_or1k_i_mem_cyc),
    .wbs_stb_o (wb_m2s_or1k_i_mem_stb),
    .wbs_cti_o (wb_m2s_or1k_i_mem_cti),
    .wbs_bte_o (wb_m2s_or1k_i_mem_bte),
    .wbs_dat_i (wb_s2m_or1k_i_mem_dat),
    .wbs_ack_i (wb_s2m_or1k_i_mem_ack),
    .wbs_err_i (wb_s2m_or1k_i_mem_err),
    .wbs_rty_i (wb_s2m_or1k_i_mem_rty)
  );

  mpsoc_msi_wb_mux #(
    .NUM_SLAVES (1),
    .MATCH_ADDR ({32'h00000000}),
    .MATCH_MASK ({32'hfe000000})
  )
  wb_mux_dbg (
    .wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_dbg_adr_i),
    .wbm_dat_i (wb_dbg_dat_i),
    .wbm_sel_i (wb_dbg_sel_i),
    .wbm_we_i  (wb_dbg_we_i),
    .wbm_cyc_i (wb_dbg_cyc_i),
    .wbm_stb_i (wb_dbg_stb_i),
    .wbm_cti_i (wb_dbg_cti_i),
    .wbm_bte_i (wb_dbg_bte_i),
    .wbm_dat_o (wb_dbg_dat_o),
    .wbm_ack_o (wb_dbg_ack_o),
    .wbm_err_o (wb_dbg_err_o),
    .wbm_rty_o (wb_dbg_rty_o),
    .wbs_adr_o (wb_m2s_dbg_mem_adr),
    .wbs_dat_o (wb_m2s_dbg_mem_dat),
    .wbs_sel_o (wb_m2s_dbg_mem_sel),
    .wbs_we_o  (wb_m2s_dbg_mem_we),
    .wbs_cyc_o (wb_m2s_dbg_mem_cyc),
    .wbs_stb_o (wb_m2s_dbg_mem_stb),
    .wbs_cti_o (wb_m2s_dbg_mem_cti),
    .wbs_bte_o (wb_m2s_dbg_mem_bte),
    .wbs_dat_i (wb_s2m_dbg_mem_dat),
    .wbs_ack_i (wb_s2m_dbg_mem_ack),
    .wbs_err_i (wb_s2m_dbg_mem_err),
    .wbs_rty_i (wb_s2m_dbg_mem_rty)
  );

  mpsoc_msi_wb_mux #(
    .NUM_SLAVES (1),
    .MATCH_ADDR ({32'h00000000}),
    .MATCH_MASK ({32'hfe000000})
  )
  wb_mux_dma (
    .wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wbm_dma_adr_i),
    .wbm_dat_i (wbm_dma_dat_i),
    .wbm_sel_i (wbm_dma_sel_i),
    .wbm_we_i  (wbm_dma_we_i),
    .wbm_cyc_i (wbm_dma_cyc_i),
    .wbm_stb_i (wbm_dma_stb_i),
    .wbm_cti_i (wbm_dma_cti_i),
    .wbm_bte_i (wbm_dma_bte_i),
    .wbm_dat_o (wbm_dma_dat_o),
    .wbm_ack_o (wbm_dma_ack_o),
    .wbm_err_o (wbm_dma_err_o),
    .wbm_rty_o (wbm_dma_rty_o),
    .wbs_adr_o (wbm_m2s_dma_mem_adr),
    .wbs_dat_o (wbm_m2s_dma_mem_dat),
    .wbs_sel_o (wbm_m2s_dma_mem_sel),
    .wbs_we_o  (wbm_m2s_dma_mem_we),
    .wbs_cyc_o (wbm_m2s_dma_mem_cyc),
    .wbs_stb_o (wbm_m2s_dma_mem_stb),
    .wbs_cti_o (wbm_m2s_dma_mem_cti),
    .wbs_bte_o (wbm_m2s_dma_mem_bte),
    .wbs_dat_i (wbm_s2m_dma_mem_dat),
    .wbs_ack_i (wbm_s2m_dma_mem_ack),
    .wbs_err_i (wbm_s2m_dma_mem_err),
    .wbs_rty_i (wbm_s2m_dma_mem_rty)
  );

  mpsoc_msi_wb_arbiter #(
    .NUM_MASTERS (3)
  )
  wb_arbiter_mem (
    .wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_i_mem_adr, wb_m2s_or1k_d_mem_adr, wb_m2s_dbg_mem_adr}),
    .wbm_dat_i ({wb_m2s_or1k_i_mem_dat, wb_m2s_or1k_d_mem_dat, wb_m2s_dbg_mem_dat}),
    .wbm_sel_i ({wb_m2s_or1k_i_mem_sel, wb_m2s_or1k_d_mem_sel, wb_m2s_dbg_mem_sel}),
    .wbm_we_i  ({wb_m2s_or1k_i_mem_we,  wb_m2s_or1k_d_mem_we,  wb_m2s_dbg_mem_we}),
    .wbm_cyc_i ({wb_m2s_or1k_i_mem_cyc, wb_m2s_or1k_d_mem_cyc, wb_m2s_dbg_mem_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_i_mem_stb, wb_m2s_or1k_d_mem_stb, wb_m2s_dbg_mem_stb}),
    .wbm_cti_i ({wb_m2s_or1k_i_mem_cti, wb_m2s_or1k_d_mem_cti, wb_m2s_dbg_mem_cti}),
    .wbm_bte_i ({wb_m2s_or1k_i_mem_bte, wb_m2s_or1k_d_mem_bte, wb_m2s_dbg_mem_bte}),
    .wbm_dat_o ({wb_s2m_or1k_i_mem_dat, wb_s2m_or1k_d_mem_dat, wb_s2m_dbg_mem_dat}),
    .wbm_ack_o ({wb_s2m_or1k_i_mem_ack, wb_s2m_or1k_d_mem_ack, wb_s2m_dbg_mem_ack}),
    .wbm_err_o ({wb_s2m_or1k_i_mem_err, wb_s2m_or1k_d_mem_err, wb_s2m_dbg_mem_err}),
    .wbm_rty_o ({wb_s2m_or1k_i_mem_rty, wb_s2m_or1k_d_mem_rty, wb_s2m_dbg_mem_rty}),
    .wbs_adr_o (wb_mem_adr_o),
    .wbs_dat_o (wb_mem_dat_o),
    .wbs_sel_o (wb_mem_sel_o),
    .wbs_we_o  (wb_mem_we_o),
    .wbs_cyc_o (wb_mem_cyc_o),
    .wbs_stb_o (wb_mem_stb_o),
    .wbs_cti_o (wb_mem_cti_o),
    .wbs_bte_o (wb_mem_bte_o),
    .wbs_dat_i (wb_mem_dat_i),
    .wbs_ack_i (wb_mem_ack_i),
    .wbs_err_i (wb_mem_err_i),
    .wbs_rty_i (wb_mem_rty_i)
  );

  assign wb_m2s_resize_mpi_adr = {26'b0, wb_mpi_adr_o};

  mpsoc_msi_wb_data_resize #(
    .AW  (32),
    .MDW (32),
    .SDW (8)
  )
  wb_data_resize_uart (
    .wbm_adr_i (wb_m2s_resize_uart_adr),
    .wbm_dat_i (wb_m2s_resize_uart_dat),
    .wbm_sel_i (wb_m2s_resize_uart_sel),
    .wbm_we_i  (wb_m2s_resize_uart_we),
    .wbm_cyc_i (wb_m2s_resize_uart_cyc),
    .wbm_stb_i (wb_m2s_resize_uart_stb),
    .wbm_cti_i (wb_m2s_resize_uart_cti),
    .wbm_bte_i (wb_m2s_resize_uart_bte),
    .wbm_dat_o (wb_s2m_resize_uart_dat),
    .wbm_ack_o (wb_s2m_resize_uart_ack),
    .wbm_err_o (wb_s2m_resize_uart_err),
    .wbm_rty_o (wb_s2m_resize_uart_rty),
    .wbs_adr_o (wb_uart_adr_o),
    .wbs_dat_o (wb_uart_dat_o),
    .wbs_we_o  (wb_uart_we_o),
    .wbs_cyc_o (wb_uart_cyc_o),
    .wbs_stb_o (wb_uart_stb_o),
    .wbs_cti_o (wb_uart_cti_o),
    .wbs_bte_o (wb_uart_bte_o),
    .wbs_dat_i (wb_uart_dat_i),
    .wbs_ack_i (wb_uart_ack_i),
    .wbs_err_i (wb_uart_err_i),
    .wbs_rty_i (wb_uart_rty_i)
  );
endmodule
