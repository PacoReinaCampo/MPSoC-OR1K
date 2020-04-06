module or1k_mpsoc #(
  parameter X = 2,
  parameter Y = 2,
  parameter Z = 2,

  parameter CORES_PER_TILE = 8,
  parameter MEM_SIZE       = 32'h02000000
)
  (
    input  wb_clk_i,
    input  wb_rst_i,
    output [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tdo_pad_o,
    input  [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tms_pad_i,
    input  [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tck_pad_i,
    input  [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tdi_pad_i
  );

  localparam wb_aw = 32;
  localparam wb_dw = 32;

  genvar i,j,k,t;

  ////////////////////////////////////////////////////////////////////////
  //
  // Wishbone interconnect
  //
  ////////////////////////////////////////////////////////////////////////
  wire wb_clk = wb_clk_i;
  wire wb_rst = wb_rst_i;

  wire [31:0] wb_m2s_or1k_d_adr [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_or1k_d_dat [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_or1k_d_sel [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_d_we  [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_d_cyc [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_d_stb [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_or1k_d_cti [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_or1k_d_bte [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_or1k_d_dat [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_d_ack [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_d_err [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_d_rty [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_or1k_i_adr [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_or1k_i_dat [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_or1k_i_sel [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_i_we  [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_i_cyc [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_i_stb [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_or1k_i_cti [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_or1k_i_bte [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_or1k_i_dat [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_i_ack [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_i_err [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_i_rty [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_dbg_adr    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_dbg_dat    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_dbg_sel    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_dbg_we     [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_dbg_cyc    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_dbg_stb    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_dbg_cti    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_dbg_bte    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_dbg_dat    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_dbg_ack    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_dbg_err    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_dbg_rty    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_mem_adr    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_mem_dat    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_mem_sel    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_mem_we     [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_mem_cyc    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_mem_stb    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_mem_cti    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_mem_bte    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_mem_dat    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_mem_ack    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_mem_err    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_mem_rty    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_uart_adr   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [7:0] wb_m2s_uart_dat   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_uart_sel   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_uart_we    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_uart_cyc   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_m2s_uart_stb   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_uart_cti   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_uart_bte   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire  [7:0] wb_s2m_uart_dat   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_uart_ack   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_uart_err   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        wb_s2m_uart_rty   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];

  generate
    for (i=0; i<X; i=i+1) begin
      for (j=0; j<Y; j=j+1) begin
        for (k=0; k<Z; k=k+1) begin
          for (t=0; t<CORES_PER_TILE; t=t+1) begin
            mpsoc_msi_wb_interface wb_interface0 (
              .wb_clk_i        (wb_clk),
              .wb_rst_i        (wb_rst),
              .wb_or1k_d_adr_i (wb_m2s_or1k_d_adr [i][j][k][t] ),
              .wb_or1k_d_dat_i (wb_m2s_or1k_d_dat [i][j][k][t] ),
              .wb_or1k_d_sel_i (wb_m2s_or1k_d_sel [i][j][k][t] ),
              .wb_or1k_d_we_i  (wb_m2s_or1k_d_we  [i][j][k][t] ),
              .wb_or1k_d_cyc_i (wb_m2s_or1k_d_cyc [i][j][k][t] ),
              .wb_or1k_d_stb_i (wb_m2s_or1k_d_stb [i][j][k][t] ),
              .wb_or1k_d_cti_i (wb_m2s_or1k_d_cti [i][j][k][t] ),
              .wb_or1k_d_bte_i (wb_m2s_or1k_d_bte [i][j][k][t] ),
              .wb_or1k_d_dat_o (wb_s2m_or1k_d_dat [i][j][k][t] ),
              .wb_or1k_d_ack_o (wb_s2m_or1k_d_ack [i][j][k][t] ),
              .wb_or1k_d_err_o (wb_s2m_or1k_d_err [i][j][k][t] ),
              .wb_or1k_d_rty_o (wb_s2m_or1k_d_rty [i][j][k][t] ),
              .wb_or1k_i_adr_i (wb_m2s_or1k_i_adr [i][j][k][t] ),
              .wb_or1k_i_dat_i (wb_m2s_or1k_i_dat [i][j][k][t] ),
              .wb_or1k_i_sel_i (wb_m2s_or1k_i_sel [i][j][k][t] ),
              .wb_or1k_i_we_i  (wb_m2s_or1k_i_we  [i][j][k][t] ),
              .wb_or1k_i_cyc_i (wb_m2s_or1k_i_cyc [i][j][k][t] ),
              .wb_or1k_i_stb_i (wb_m2s_or1k_i_stb [i][j][k][t] ),
              .wb_or1k_i_cti_i (wb_m2s_or1k_i_cti [i][j][k][t] ),
              .wb_or1k_i_bte_i (wb_m2s_or1k_i_bte [i][j][k][t] ),
              .wb_or1k_i_dat_o (wb_s2m_or1k_i_dat [i][j][k][t] ),
              .wb_or1k_i_ack_o (wb_s2m_or1k_i_ack [i][j][k][t] ),
              .wb_or1k_i_err_o (wb_s2m_or1k_i_err [i][j][k][t] ),
              .wb_or1k_i_rty_o (wb_s2m_or1k_i_rty [i][j][k][t] ),
              .wb_dbg_adr_i    (wb_m2s_dbg_adr    [i][j][k][t] ),
              .wb_dbg_dat_i    (wb_m2s_dbg_dat    [i][j][k][t] ),
              .wb_dbg_sel_i    (wb_m2s_dbg_sel    [i][j][k][t] ),
              .wb_dbg_we_i     (wb_m2s_dbg_we     [i][j][k][t] ),
              .wb_dbg_cyc_i    (wb_m2s_dbg_cyc    [i][j][k][t] ),
              .wb_dbg_stb_i    (wb_m2s_dbg_stb    [i][j][k][t] ),
              .wb_dbg_cti_i    (wb_m2s_dbg_cti    [i][j][k][t] ),
              .wb_dbg_bte_i    (wb_m2s_dbg_bte    [i][j][k][t] ),
              .wb_dbg_dat_o    (wb_s2m_dbg_dat    [i][j][k][t] ),
              .wb_dbg_ack_o    (wb_s2m_dbg_ack    [i][j][k][t] ),
              .wb_dbg_err_o    (wb_s2m_dbg_err    [i][j][k][t] ),
              .wb_dbg_rty_o    (wb_s2m_dbg_rty    [i][j][k][t] ),
              .wb_mem_adr_o    (wb_m2s_mem_adr    [i][j][k][t] ),
              .wb_mem_dat_o    (wb_m2s_mem_dat    [i][j][k][t] ),
              .wb_mem_sel_o    (wb_m2s_mem_sel    [i][j][k][t] ),
              .wb_mem_we_o     (wb_m2s_mem_we     [i][j][k][t] ),
              .wb_mem_cyc_o    (wb_m2s_mem_cyc    [i][j][k][t] ),
              .wb_mem_stb_o    (wb_m2s_mem_stb    [i][j][k][t] ),
              .wb_mem_cti_o    (wb_m2s_mem_cti    [i][j][k][t] ),
              .wb_mem_bte_o    (wb_m2s_mem_bte    [i][j][k][t] ),
              .wb_mem_dat_i    (wb_s2m_mem_dat    [i][j][k][t] ),
              .wb_mem_ack_i    (wb_s2m_mem_ack    [i][j][k][t] ),
              .wb_mem_err_i    (wb_s2m_mem_err    [i][j][k][t] ),
              .wb_mem_rty_i    (wb_s2m_mem_rty    [i][j][k][t] ),
              .wb_uart_adr_o   (wb_m2s_uart_adr   [i][j][k][t] ),
              .wb_uart_dat_o   (wb_m2s_uart_dat   [i][j][k][t] ),
              .wb_uart_sel_o   (wb_m2s_uart_sel   [i][j][k][t] ),
              .wb_uart_we_o    (wb_m2s_uart_we    [i][j][k][t] ),
              .wb_uart_cyc_o   (wb_m2s_uart_cyc   [i][j][k][t] ),
              .wb_uart_stb_o   (wb_m2s_uart_stb   [i][j][k][t] ),
              .wb_uart_cti_o   (wb_m2s_uart_cti   [i][j][k][t] ),
              .wb_uart_bte_o   (wb_m2s_uart_bte   [i][j][k][t] ),
              .wb_uart_dat_i   (wb_s2m_uart_dat   [i][j][k][t] ),
              .wb_uart_ack_i   (wb_s2m_uart_ack   [i][j][k][t] ),
              .wb_uart_err_i   (wb_s2m_uart_err   [i][j][k][t] ),
              .wb_uart_rty_i   (wb_s2m_uart_rty   [i][j][k][t] )
            );
          end
        end
      end
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // GENERIC JTAG TAP
  //
  ////////////////////////////////////////////////////////////////////////
  wire dbg_if_select       [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire dbg_if_tdo          [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire jtag_tap_tdo        [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire jtag_tap_shift_dr   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire jtag_tap_pause_dr   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire jtag_tap_update_dr  [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire jtag_tap_capture_dr [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];

  generate
    for (i=0; i<X; i=i+1) begin
      for (j=0; j<Y; j=j+1) begin
        for (k=0; k<Z; k=k+1) begin
          for (t=0; t<CORES_PER_TILE; t=t+1) begin
            tap_top jtag_tap0 (
              .tdo_pad_o   (tdo_pad_o [i][j][k][t] ),
              .tms_pad_i   (tms_pad_i [i][j][k][t] ),
              .tck_pad_i   (tck_pad_i [i][j][k][t] ),
              .trst_pad_i  (wb_rst),
              .tdi_pad_i   (tdi_pad_i [i][j][k][t] ),

              .tdo_padoe_o (),

              .tdo_o (jtag_tap_tdo [i][j][k][t] ),

              .shift_dr_o     (jtag_tap_shift_dr   [i][j][k][t] ),
              .pause_dr_o     (jtag_tap_pause_dr   [i][j][k][t] ),
              .update_dr_o    (jtag_tap_update_dr  [i][j][k][t] ),
              .capture_dr_o   (jtag_tap_capture_dr [i][j][k][t] ),

              .extest_select_o         (),
              .sample_preload_select_o (),
              .mbist_select_o          (),
              .debug_select_o          (dbg_if_select [i][j][k][t] ),


              .bs_chain_tdi_i   (1'b0),
              .mbist_tdi_i      (1'b0),
              .debug_tdi_i      (dbg_if_tdo [i][j][k][t] )
            );
          end
        end
      end
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // Debug Interface
  //
  ////////////////////////////////////////////////////////////////////////
  wire [31:0] or1k_dbg_dat_i [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] or1k_dbg_adr_i [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        or1k_dbg_we_i  [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        or1k_dbg_stb_i [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        or1k_dbg_ack_o [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [31:0] or1k_dbg_dat_o [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];

  wire        or1k_dbg_stall_i [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        or1k_dbg_ewt_i   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [ 3:0] or1k_dbg_lss_o   [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [ 1:0] or1k_dbg_is_o    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire [10:0] or1k_dbg_wp_o    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        or1k_dbg_bp_o    [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        or1k_dbg_rst;

  generate
    for (i=0; i<X; i=i+1) begin
      for (j=0; j<Y; j=j+1) begin
        for (k=0; k<Z; k=k+1) begin
          for (t=0; t<CORES_PER_TILE; t=t+1) begin
            adbg_top dbg_if0 (
              // OR1K interface
              .cpu0_clk_i   (wb_clk),
              .cpu0_rst_o   (or1k_dbg_rst),
              .cpu0_addr_o  (or1k_dbg_adr_i   [i][j][k][t] ),
              .cpu0_data_o  (or1k_dbg_dat_i   [i][j][k][t] ),
              .cpu0_stb_o   (or1k_dbg_stb_i   [i][j][k][t] ),
              .cpu0_we_o    (or1k_dbg_we_i    [i][j][k][t] ),
              .cpu0_data_i  (or1k_dbg_dat_o   [i][j][k][t] ),
              .cpu0_ack_i   (or1k_dbg_ack_o   [i][j][k][t] ),
              .cpu0_stall_o (or1k_dbg_stall_i [i][j][k][t] ),
              .cpu0_bp_i    (or1k_dbg_bp_o    [i][j][k][t] ),

              // TAP interface
              .tck_i          (tck_pad_i    [i][j][k][t] ),
              .tdi_i          (jtag_tap_tdo [i][j][k][t] ),
              .tdo_o          (dbg_if_tdo   [i][j][k][t] ),
              .rst_i          (wb_rst),
              .capture_dr_i   (jtag_tap_capture_dr [i][j][k][t] ),
              .shift_dr_i     (jtag_tap_shift_dr   [i][j][k][t] ),
              .pause_dr_i     (jtag_tap_pause_dr   [i][j][k][t] ),
              .update_dr_i    (jtag_tap_update_dr  [i][j][k][t] ),
              .debug_select_i (dbg_if_select       [i][j][k][t] ),

              // Wishbone debug master
              .wb_clk_i (wb_clk),
              .wb_dat_i (wb_s2m_dbg_dat [i][j][k][t] ),
              .wb_ack_i (wb_s2m_dbg_ack [i][j][k][t] ),
              .wb_err_i (wb_s2m_dbg_err [i][j][k][t] ),

              .wb_adr_o (wb_m2s_dbg_adr [i][j][k][t] ),
              .wb_dat_o (wb_m2s_dbg_dat [i][j][k][t] ),
              .wb_cyc_o (wb_m2s_dbg_cyc [i][j][k][t] ),
              .wb_stb_o (wb_m2s_dbg_stb [i][j][k][t] ),
              .wb_sel_o (wb_m2s_dbg_sel [i][j][k][t] ),
              .wb_we_o  (wb_m2s_dbg_we  [i][j][k][t] ),
              .wb_cti_o (wb_m2s_dbg_cti [i][j][k][t] ),
              .wb_bte_o (wb_m2s_dbg_bte [i][j][k][t] )
            );
          end
        end
      end
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // mor1kx cpu
  //
  ////////////////////////////////////////////////////////////////////////
  wire [31:0] or1k_irq [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  wire        or1k_clk;
  wire        or1k_rst;

  assign or1k_clk = wb_clk;
  assign or1k_rst = wb_rst | or1k_dbg_rst;

  generate
    for (i=0; i<X; i=i+1) begin : x_c
      for (j=0; j<Y; j=j+1) begin : y_c
        for (k=0; k<Z; k=k+1) begin : z_c
          for (t=0; t<CORES_PER_TILE; t=t+1) begin : t_c
            mor1kx #(
              .FEATURE_DEBUGUNIT ("ENABLED"),
              .FEATURE_CMOV ("ENABLED"),
              .FEATURE_INSTRUCTIONCACHE ("ENABLED"),
              .OPTION_ICACHE_BLOCK_WIDTH (5),
              .OPTION_ICACHE_SET_WIDTH (8),
              .OPTION_ICACHE_WAYS (2),
              .OPTION_ICACHE_LIMIT_WIDTH (32),
              .FEATURE_IMMU ("ENABLED"),
              .FEATURE_DATACACHE ("ENABLED"),
              .OPTION_DCACHE_BLOCK_WIDTH (5),
              .OPTION_DCACHE_SET_WIDTH (8),
              .OPTION_DCACHE_WAYS (2),
              .OPTION_DCACHE_LIMIT_WIDTH (31),
              .FEATURE_DMMU ("ENABLED"),
              .OPTION_RF_NUM_SHADOW_GPR (1),
              .IBUS_WB_TYPE ("B3_REGISTERED_FEEDBACK"),
              .DBUS_WB_TYPE ("B3_REGISTERED_FEEDBACK"),
              .OPTION_CPU0 ("CAPPUCCINO"),
              .OPTION_RESET_PC (32'h00000100)
            )
            mor1kx0 (
              .iwbm_adr_o   (wb_m2s_or1k_i_adr [i][j][k][t] ),
              .iwbm_stb_o   (wb_m2s_or1k_i_stb [i][j][k][t] ),
              .iwbm_cyc_o   (wb_m2s_or1k_i_cyc [i][j][k][t] ),
              .iwbm_sel_o   (wb_m2s_or1k_i_sel [i][j][k][t] ),
              .iwbm_we_o    (wb_m2s_or1k_i_we  [i][j][k][t] ),
              .iwbm_cti_o   (wb_m2s_or1k_i_cti [i][j][k][t] ),
              .iwbm_bte_o   (wb_m2s_or1k_i_bte [i][j][k][t] ),
              .iwbm_dat_o   (wb_m2s_or1k_i_dat [i][j][k][t] ),

              .dwbm_adr_o   (wb_m2s_or1k_d_adr [i][j][k][t] ),
              .dwbm_stb_o   (wb_m2s_or1k_d_stb [i][j][k][t] ),
              .dwbm_cyc_o   (wb_m2s_or1k_d_cyc [i][j][k][t] ),
              .dwbm_sel_o   (wb_m2s_or1k_d_sel [i][j][k][t] ),
              .dwbm_we_o    (wb_m2s_or1k_d_we  [i][j][k][t] ),
              .dwbm_cti_o   (wb_m2s_or1k_d_cti [i][j][k][t] ),
              .dwbm_bte_o   (wb_m2s_or1k_d_bte [i][j][k][t] ),
              .dwbm_dat_o   (wb_m2s_or1k_d_dat [i][j][k][t] ),

              .clk          (or1k_clk),
              .rst          (or1k_rst),

              .iwbm_err_i   (wb_s2m_or1k_i_err [i][j][k][t] ),
              .iwbm_ack_i   (wb_s2m_or1k_i_ack [i][j][k][t] ),
              .iwbm_dat_i   (wb_s2m_or1k_i_dat [i][j][k][t] ),
              .iwbm_rty_i   (wb_s2m_or1k_i_rty [i][j][k][t] ),

              .dwbm_err_i   (wb_s2m_or1k_d_err [i][j][k][t] ),
              .dwbm_ack_i   (wb_s2m_or1k_d_ack [i][j][k][t] ),
              .dwbm_dat_i   (wb_s2m_or1k_d_dat [i][j][k][t] ),
              .dwbm_rty_i   (wb_s2m_or1k_d_rty [i][j][k][t] ),

              .irq_i        (or1k_irq [i][j][k][t] ),

              .du_addr_i    (or1k_dbg_adr_i   [i][j][k][t][15:0] ),
              .du_stb_i     (or1k_dbg_stb_i   [i][j][k][t] ),
              .du_dat_i     (or1k_dbg_dat_i   [i][j][k][t] ),
              .du_we_i      (or1k_dbg_we_i    [i][j][k][t] ),
              .du_dat_o     (or1k_dbg_dat_o   [i][j][k][t] ),
              .du_ack_o     (or1k_dbg_ack_o   [i][j][k][t] ),
              .du_stall_i   (or1k_dbg_stall_i [i][j][k][t] ),
              .du_stall_o   (or1k_dbg_bp_o    [i][j][k][t] )
            );
          end
        end
      end
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // Generic main RAM
  //
  ////////////////////////////////////////////////////////////////////////
  generate
    for (i=0; i<X; i=i+1) begin : x_g
      for (j=0; j<Y; j=j+1) begin : y_g
        for (k=0; k<Z; k=k+1) begin : z_g
          for (t=0; t<CORES_PER_TILE; t=t+1) begin : t_g
            mpsoc_wb_spram #(
              .DEPTH (MEM_SIZE/4)
            )
            wb_bfm_memory0 (
              //Wishbone Master interface
              .wb_clk_i (wb_clk_i),
              .wb_rst_i (wb_rst_i),
              .wb_adr_i (wb_m2s_mem_adr [i][j][k][t][$clog2(MEM_SIZE)-3:0] ),
              .wb_dat_i (wb_m2s_mem_dat [i][j][k][t] ),
              .wb_sel_i (wb_m2s_mem_sel [i][j][k][t] ),
              .wb_we_i  (wb_m2s_mem_we  [i][j][k][t] ),
              .wb_cyc_i (wb_m2s_mem_cyc [i][j][k][t] ),
              .wb_stb_i (wb_m2s_mem_stb [i][j][k][t] ),
              .wb_cti_i (wb_m2s_mem_cti [i][j][k][t] ),
              .wb_bte_i (wb_m2s_mem_bte [i][j][k][t] ),
              .wb_dat_o (wb_s2m_mem_dat [i][j][k][t] ),
              .wb_ack_o (wb_s2m_mem_ack [i][j][k][t] ),
              .wb_err_o (wb_s2m_mem_err [i][j][k][t] )
            );

            assign wb_s2m_mem_rty [i][j][k][t] = 1'b0;
          end
        end
      end
    end
  endgenerate

  wire uart_irq [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];

  generate
    for (i=0; i<X; i=i+1) begin
      for (j=0; j<Y; j=j+1) begin
        for (k=0; k<Z; k=k+1) begin
          for (t=0; t<CORES_PER_TILE; t=t+1) begin
            mpsoc_wb_uart #(
              .DEBUG (0),
              .SIM   (1)
            ) uart16550 (
              //Wishbone Master interface
              .wb_clk_i  (wb_clk_i),
              .wb_rst_i  (wb_rst_i),
              .wb_adr_i  (wb_m2s_uart_adr [i][j][k][t][2:0] ),
              .wb_dat_i  (wb_m2s_uart_dat [i][j][k][t] ),
              .wb_sel_i  (4'h0),
              .wb_we_i   (wb_m2s_uart_we  [i][j][k][t] ),
              .wb_cyc_i  (wb_m2s_uart_cyc [i][j][k][t] ),
              .wb_stb_i  (wb_m2s_uart_stb [i][j][k][t] ),
              .wb_dat_o  (wb_s2m_uart_dat [i][j][k][t] ),
              .wb_ack_o  (wb_s2m_uart_ack [i][j][k][t] ),
              .int_o     (uart_irq        [i][j][k][t] ),
              .srx_pad_i (1'b0),
              .stx_pad_o (),
              .rts_pad_o (),
              .cts_pad_i (1'b0),
              .dtr_pad_o (),
              .dsr_pad_i (1'b0),
              .ri_pad_i  (1'b0),
              .dcd_pad_i (1'b0)
            );

            assign wb_s2m_uart_err [i][j][k][t] = 1'b0;
            assign wb_s2m_uart_rty [i][j][k][t] = 1'b0;
          end
        end
      end
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // CPU Interrupt assignments
  //
  ////////////////////////////////////////////////////////////////////////
  generate
    for (i=0; i<X; i=i+1) begin
      for (j=0; j<Y; j=j+1) begin
        for (k=0; k<Z; k=k+1) begin
          for (t=0; t<CORES_PER_TILE; t=t+1) begin
            assign or1k_irq[i][j][k][t][0] = 0;
            assign or1k_irq[i][j][k][t][1] = 0;
            assign or1k_irq[i][j][k][t][2] = uart_irq [i][j][k][t];
            assign or1k_irq[i][j][k][t][3] = 0;
            assign or1k_irq[i][j][k][t][4] = 0;
            assign or1k_irq[i][j][k][t][5] = 0;
            assign or1k_irq[i][j][k][t][6] = 0;
            assign or1k_irq[i][j][k][t][7] = 0;
            assign or1k_irq[i][j][k][t][8] = 0;
            assign or1k_irq[i][j][k][t][9] = 0;
            assign or1k_irq[i][j][k][t][10] = 0;
            assign or1k_irq[i][j][k][t][11] = 0;
            assign or1k_irq[i][j][k][t][12] = 0;
            assign or1k_irq[i][j][k][t][13] = 0;
            assign or1k_irq[i][j][k][t][14] = 0;
            assign or1k_irq[i][j][k][t][15] = 0;
            assign or1k_irq[i][j][k][t][16] = 0;
            assign or1k_irq[i][j][k][t][17] = 0;
            assign or1k_irq[i][j][k][t][18] = 0;
            assign or1k_irq[i][j][k][t][19] = 0;
            assign or1k_irq[i][j][k][t][20] = 0;
            assign or1k_irq[i][j][k][t][21] = 0;
            assign or1k_irq[i][j][k][t][22] = 0;
            assign or1k_irq[i][j][k][t][23] = 0;
            assign or1k_irq[i][j][k][t][24] = 0;
            assign or1k_irq[i][j][k][t][25] = 0;
            assign or1k_irq[i][j][k][t][26] = 0;
            assign or1k_irq[i][j][k][t][27] = 0;
            assign or1k_irq[i][j][k][t][28] = 0;
            assign or1k_irq[i][j][k][t][29] = 0;
            assign or1k_irq[i][j][k][t][30] = 0;
          end
        end
      end
    end
  endgenerate
endmodule
