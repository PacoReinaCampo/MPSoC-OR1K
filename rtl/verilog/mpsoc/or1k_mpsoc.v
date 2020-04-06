module or1k_soc #(
  parameter CORES_PER_TILE = 8,
  parameter MEM_SIZE       = 32'h02000000
)
  (
    input  wb_clk_i,
    input  wb_rst_i,
    output [CORES_PER_TILE-1:0] tdo_pad_o,
    input  [CORES_PER_TILE-1:0] tms_pad_i,
    input  [CORES_PER_TILE-1:0] tck_pad_i,
    input  [CORES_PER_TILE-1:0] tdi_pad_i
  );

  localparam wb_aw = 32;
  localparam wb_dw = 32;

  genvar t;

  ////////////////////////////////////////////////////////////////////////
  //
  // Wishbone interconnect
  //
  ////////////////////////////////////////////////////////////////////////
  wire wb_clk = wb_clk_i;
  wire wb_rst = wb_rst_i;

  wire [31:0] wb_m2s_or1k_d_adr [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_or1k_d_dat [CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_or1k_d_sel [CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_d_we  [CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_d_cyc [CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_d_stb [CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_or1k_d_cti [CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_or1k_d_bte [CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_or1k_d_dat [CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_d_ack [CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_d_err [CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_d_rty [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_or1k_i_adr [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_or1k_i_dat [CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_or1k_i_sel [CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_i_we  [CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_i_cyc [CORES_PER_TILE-1:0];
  wire        wb_m2s_or1k_i_stb [CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_or1k_i_cti [CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_or1k_i_bte [CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_or1k_i_dat [CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_i_ack [CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_i_err [CORES_PER_TILE-1:0];
  wire        wb_s2m_or1k_i_rty [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_dbg_adr    [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_dbg_dat    [CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_dbg_sel    [CORES_PER_TILE-1:0];
  wire        wb_m2s_dbg_we     [CORES_PER_TILE-1:0];
  wire        wb_m2s_dbg_cyc    [CORES_PER_TILE-1:0];
  wire        wb_m2s_dbg_stb    [CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_dbg_cti    [CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_dbg_bte    [CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_dbg_dat    [CORES_PER_TILE-1:0];
  wire        wb_s2m_dbg_ack    [CORES_PER_TILE-1:0];
  wire        wb_s2m_dbg_err    [CORES_PER_TILE-1:0];
  wire        wb_s2m_dbg_rty    [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_mem_adr    [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_mem_dat    [CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_mem_sel    [CORES_PER_TILE-1:0];
  wire        wb_m2s_mem_we     [CORES_PER_TILE-1:0];
  wire        wb_m2s_mem_cyc    [CORES_PER_TILE-1:0];
  wire        wb_m2s_mem_stb    [CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_mem_cti    [CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_mem_bte    [CORES_PER_TILE-1:0];
  wire [31:0] wb_s2m_mem_dat    [CORES_PER_TILE-1:0];
  wire        wb_s2m_mem_ack    [CORES_PER_TILE-1:0];
  wire        wb_s2m_mem_err    [CORES_PER_TILE-1:0];
  wire        wb_s2m_mem_rty    [CORES_PER_TILE-1:0];
  wire [31:0] wb_m2s_uart_adr   [CORES_PER_TILE-1:0];
  wire  [7:0] wb_m2s_uart_dat   [CORES_PER_TILE-1:0];
  wire  [3:0] wb_m2s_uart_sel   [CORES_PER_TILE-1:0];
  wire        wb_m2s_uart_we    [CORES_PER_TILE-1:0];
  wire        wb_m2s_uart_cyc   [CORES_PER_TILE-1:0];
  wire        wb_m2s_uart_stb   [CORES_PER_TILE-1:0];
  wire  [2:0] wb_m2s_uart_cti   [CORES_PER_TILE-1:0];
  wire  [1:0] wb_m2s_uart_bte   [CORES_PER_TILE-1:0];
  wire  [7:0] wb_s2m_uart_dat   [CORES_PER_TILE-1:0];
  wire        wb_s2m_uart_ack   [CORES_PER_TILE-1:0];
  wire        wb_s2m_uart_err   [CORES_PER_TILE-1:0];
  wire        wb_s2m_uart_rty   [CORES_PER_TILE-1:0];

  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      mpsoc_msi_wb_interface wb_interface0 (
        .wb_clk_i        (wb_clk),
        .wb_rst_i        (wb_rst),
        .wb_or1k_d_adr_i (wb_m2s_or1k_d_adr [t] ),
        .wb_or1k_d_dat_i (wb_m2s_or1k_d_dat [t] ),
        .wb_or1k_d_sel_i (wb_m2s_or1k_d_sel [t] ),
        .wb_or1k_d_we_i  (wb_m2s_or1k_d_we  [t] ),
        .wb_or1k_d_cyc_i (wb_m2s_or1k_d_cyc [t] ),
        .wb_or1k_d_stb_i (wb_m2s_or1k_d_stb [t] ),
        .wb_or1k_d_cti_i (wb_m2s_or1k_d_cti [t] ),
        .wb_or1k_d_bte_i (wb_m2s_or1k_d_bte [t] ),
        .wb_or1k_d_dat_o (wb_s2m_or1k_d_dat [t] ),
        .wb_or1k_d_ack_o (wb_s2m_or1k_d_ack [t] ),
        .wb_or1k_d_err_o (wb_s2m_or1k_d_err [t] ),
        .wb_or1k_d_rty_o (wb_s2m_or1k_d_rty [t] ),
        .wb_or1k_i_adr_i (wb_m2s_or1k_i_adr [t] ),
        .wb_or1k_i_dat_i (wb_m2s_or1k_i_dat [t] ),
        .wb_or1k_i_sel_i (wb_m2s_or1k_i_sel [t] ),
        .wb_or1k_i_we_i  (wb_m2s_or1k_i_we  [t] ),
        .wb_or1k_i_cyc_i (wb_m2s_or1k_i_cyc [t] ),
        .wb_or1k_i_stb_i (wb_m2s_or1k_i_stb [t] ),
        .wb_or1k_i_cti_i (wb_m2s_or1k_i_cti [t] ),
        .wb_or1k_i_bte_i (wb_m2s_or1k_i_bte [t] ),
        .wb_or1k_i_dat_o (wb_s2m_or1k_i_dat [t] ),
        .wb_or1k_i_ack_o (wb_s2m_or1k_i_ack [t] ),
        .wb_or1k_i_err_o (wb_s2m_or1k_i_err [t] ),
        .wb_or1k_i_rty_o (wb_s2m_or1k_i_rty [t] ),
        .wb_dbg_adr_i    (wb_m2s_dbg_adr    [t] ),
        .wb_dbg_dat_i    (wb_m2s_dbg_dat    [t] ),
        .wb_dbg_sel_i    (wb_m2s_dbg_sel    [t] ),
        .wb_dbg_we_i     (wb_m2s_dbg_we     [t] ),
        .wb_dbg_cyc_i    (wb_m2s_dbg_cyc    [t] ),
        .wb_dbg_stb_i    (wb_m2s_dbg_stb    [t] ),
        .wb_dbg_cti_i    (wb_m2s_dbg_cti    [t] ),
        .wb_dbg_bte_i    (wb_m2s_dbg_bte    [t] ),
        .wb_dbg_dat_o    (wb_s2m_dbg_dat    [t] ),
        .wb_dbg_ack_o    (wb_s2m_dbg_ack    [t] ),
        .wb_dbg_err_o    (wb_s2m_dbg_err    [t] ),
        .wb_dbg_rty_o    (wb_s2m_dbg_rty    [t] ),
        .wb_mem_adr_o    (wb_m2s_mem_adr    [t] ),
        .wb_mem_dat_o    (wb_m2s_mem_dat    [t] ),
        .wb_mem_sel_o    (wb_m2s_mem_sel    [t] ),
        .wb_mem_we_o     (wb_m2s_mem_we     [t] ),
        .wb_mem_cyc_o    (wb_m2s_mem_cyc    [t] ),
        .wb_mem_stb_o    (wb_m2s_mem_stb    [t] ),
        .wb_mem_cti_o    (wb_m2s_mem_cti    [t] ),
        .wb_mem_bte_o    (wb_m2s_mem_bte    [t] ),
        .wb_mem_dat_i    (wb_s2m_mem_dat    [t] ),
        .wb_mem_ack_i    (wb_s2m_mem_ack    [t] ),
        .wb_mem_err_i    (wb_s2m_mem_err    [t] ),
        .wb_mem_rty_i    (wb_s2m_mem_rty    [t] ),
        .wb_uart_adr_o   (wb_m2s_uart_adr   [t] ),
        .wb_uart_dat_o   (wb_m2s_uart_dat   [t] ),
        .wb_uart_sel_o   (wb_m2s_uart_sel   [t] ),
        .wb_uart_we_o    (wb_m2s_uart_we    [t] ),
        .wb_uart_cyc_o   (wb_m2s_uart_cyc   [t] ),
        .wb_uart_stb_o   (wb_m2s_uart_stb   [t] ),
        .wb_uart_cti_o   (wb_m2s_uart_cti   [t] ),
        .wb_uart_bte_o   (wb_m2s_uart_bte   [t] ),
        .wb_uart_dat_i   (wb_s2m_uart_dat   [t] ),
        .wb_uart_ack_i   (wb_s2m_uart_ack   [t] ),
        .wb_uart_err_i   (wb_s2m_uart_err   [t] ),
        .wb_uart_rty_i   (wb_s2m_uart_rty   [t] )
      );
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // GENERIC JTAG TAP
  //
  ////////////////////////////////////////////////////////////////////////
  wire dbg_if_select       [CORES_PER_TILE-1:0];
  wire dbg_if_tdo          [CORES_PER_TILE-1:0];
  wire jtag_tap_tdo        [CORES_PER_TILE-1:0];
  wire jtag_tap_shift_dr   [CORES_PER_TILE-1:0];
  wire jtag_tap_pause_dr   [CORES_PER_TILE-1:0];
  wire jtag_tap_update_dr  [CORES_PER_TILE-1:0];
  wire jtag_tap_capture_dr [CORES_PER_TILE-1:0];

  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      tap_top jtag_tap0 (
        .tdo_pad_o   (tdo_pad_o [t] ),
        .tms_pad_i   (tms_pad_i [t] ),
        .tck_pad_i   (tck_pad_i [t] ),
        .trst_pad_i  (wb_rst),
        .tdi_pad_i   (tdi_pad_i [t] ),

        .tdo_padoe_o (),

        .tdo_o (jtag_tap_tdo [t] ),

        .shift_dr_o     (jtag_tap_shift_dr   [t] ),
        .pause_dr_o     (jtag_tap_pause_dr   [t] ),
        .update_dr_o    (jtag_tap_update_dr  [t] ),
        .capture_dr_o   (jtag_tap_capture_dr [t] ),

        .extest_select_o         (),
        .sample_preload_select_o (),
        .mbist_select_o          (),
        .debug_select_o          (dbg_if_select [t] ),


        .bs_chain_tdi_i   (1'b0),
        .mbist_tdi_i      (1'b0),
        .debug_tdi_i      (dbg_if_tdo [t] )
      );
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // Debug Interface
  //
  ////////////////////////////////////////////////////////////////////////
  wire [31:0] or1k_dbg_dat_i [CORES_PER_TILE-1:0];
  wire [31:0] or1k_dbg_adr_i [CORES_PER_TILE-1:0];
  wire        or1k_dbg_we_i  [CORES_PER_TILE-1:0];
  wire        or1k_dbg_stb_i [CORES_PER_TILE-1:0];
  wire        or1k_dbg_ack_o [CORES_PER_TILE-1:0];
  wire [31:0] or1k_dbg_dat_o [CORES_PER_TILE-1:0];

  wire        or1k_dbg_stall_i [CORES_PER_TILE-1:0];
  wire        or1k_dbg_ewt_i   [CORES_PER_TILE-1:0];
  wire [ 3:0] or1k_dbg_lss_o   [CORES_PER_TILE-1:0];
  wire [ 1:0] or1k_dbg_is_o    [CORES_PER_TILE-1:0];
  wire [10:0] or1k_dbg_wp_o    [CORES_PER_TILE-1:0];
  wire        or1k_dbg_bp_o    [CORES_PER_TILE-1:0];
  wire        or1k_dbg_rst;

  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      adbg_top dbg_if0 (
        // OR1K interface
        .cpu0_clk_i   (wb_clk),
        .cpu0_rst_o   (or1k_dbg_rst),
        .cpu0_addr_o  (or1k_dbg_adr_i   [t] ),
        .cpu0_data_o  (or1k_dbg_dat_i   [t] ),
        .cpu0_stb_o   (or1k_dbg_stb_i   [t] ),
        .cpu0_we_o    (or1k_dbg_we_i    [t] ),
        .cpu0_data_i  (or1k_dbg_dat_o   [t] ),
        .cpu0_ack_i   (or1k_dbg_ack_o   [t] ),
        .cpu0_stall_o (or1k_dbg_stall_i [t] ),
        .cpu0_bp_i    (or1k_dbg_bp_o    [t] ),

        // TAP interface
        .tck_i          (tck_pad_i    [t] ),
        .tdi_i          (jtag_tap_tdo [t] ),
        .tdo_o          (dbg_if_tdo   [t] ),
        .rst_i          (wb_rst),
        .capture_dr_i   (jtag_tap_capture_dr [t] ),
        .shift_dr_i     (jtag_tap_shift_dr   [t] ),
        .pause_dr_i     (jtag_tap_pause_dr   [t] ),
        .update_dr_i    (jtag_tap_update_dr  [t] ),
        .debug_select_i (dbg_if_select       [t] ),

        // Wishbone debug master
        .wb_clk_i (wb_clk),
        .wb_dat_i (wb_s2m_dbg_dat [t] ),
        .wb_ack_i (wb_s2m_dbg_ack [t] ),
        .wb_err_i (wb_s2m_dbg_err [t] ),

        .wb_adr_o (wb_m2s_dbg_adr [t] ),
        .wb_dat_o (wb_m2s_dbg_dat [t] ),
        .wb_cyc_o (wb_m2s_dbg_cyc [t] ),
        .wb_stb_o (wb_m2s_dbg_stb [t] ),
        .wb_sel_o (wb_m2s_dbg_sel [t] ),
        .wb_we_o  (wb_m2s_dbg_we  [t] ),
        .wb_cti_o (wb_m2s_dbg_cti [t] ),
        .wb_bte_o (wb_m2s_dbg_bte [t] )
      );
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // mor1kx cpu
  //
  ////////////////////////////////////////////////////////////////////////
  wire [31:0] or1k_irq [CORES_PER_TILE-1:0];
  wire        or1k_clk;
  wire        or1k_rst;

  assign or1k_clk = wb_clk;
  assign or1k_rst = wb_rst | or1k_dbg_rst;

  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
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
        .iwbm_adr_o   (wb_m2s_or1k_i_adr [t] ),
        .iwbm_stb_o   (wb_m2s_or1k_i_stb [t] ),
        .iwbm_cyc_o   (wb_m2s_or1k_i_cyc [t] ),
        .iwbm_sel_o   (wb_m2s_or1k_i_sel [t] ),
        .iwbm_we_o    (wb_m2s_or1k_i_we  [t] ),
        .iwbm_cti_o   (wb_m2s_or1k_i_cti [t] ),
        .iwbm_bte_o   (wb_m2s_or1k_i_bte [t] ),
        .iwbm_dat_o   (wb_m2s_or1k_i_dat [t] ),

        .dwbm_adr_o   (wb_m2s_or1k_d_adr [t] ),
        .dwbm_stb_o   (wb_m2s_or1k_d_stb [t] ),
        .dwbm_cyc_o   (wb_m2s_or1k_d_cyc [t] ),
        .dwbm_sel_o   (wb_m2s_or1k_d_sel [t] ),
        .dwbm_we_o    (wb_m2s_or1k_d_we  [t] ),
        .dwbm_cti_o   (wb_m2s_or1k_d_cti [t] ),
        .dwbm_bte_o   (wb_m2s_or1k_d_bte [t] ),
        .dwbm_dat_o   (wb_m2s_or1k_d_dat [t] ),

        .clk          (or1k_clk),
        .rst          (or1k_rst),

        .iwbm_err_i   (wb_s2m_or1k_i_err [t] ),
        .iwbm_ack_i   (wb_s2m_or1k_i_ack [t] ),
        .iwbm_dat_i   (wb_s2m_or1k_i_dat [t] ),
        .iwbm_rty_i   (wb_s2m_or1k_i_rty [t] ),

        .dwbm_err_i   (wb_s2m_or1k_d_err [t] ),
        .dwbm_ack_i   (wb_s2m_or1k_d_ack [t] ),
        .dwbm_dat_i   (wb_s2m_or1k_d_dat [t] ),
        .dwbm_rty_i   (wb_s2m_or1k_d_rty [t] ),

        .irq_i        (or1k_irq [t] ),

        .du_addr_i    (or1k_dbg_adr_i   [t][15:0] ),
        .du_stb_i     (or1k_dbg_stb_i   [t] ),
        .du_dat_i     (or1k_dbg_dat_i   [t] ),
        .du_we_i      (or1k_dbg_we_i    [t] ),
        .du_dat_o     (or1k_dbg_dat_o   [t] ),
        .du_ack_o     (or1k_dbg_ack_o   [t] ),
        .du_stall_i   (or1k_dbg_stall_i [t] ),
        .du_stall_o   (or1k_dbg_bp_o    [t] )
      );
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // Generic main RAM
  //
  ////////////////////////////////////////////////////////////////////////
  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      mpsoc_wb_spram #(
        .DEPTH (MEM_SIZE/4)
      )
      wb_bfm_memory0 (
        //Wishbone Master interface
        .wb_clk_i (wb_clk_i),
        .wb_rst_i (wb_rst_i),
        .wb_adr_i (wb_m2s_mem_adr [t][$clog2(MEM_SIZE)-3:0] ),
        .wb_dat_i (wb_m2s_mem_dat [t] ),
        .wb_sel_i (wb_m2s_mem_sel [t] ),
        .wb_we_i  (wb_m2s_mem_we  [t] ),
        .wb_cyc_i (wb_m2s_mem_cyc [t] ),
        .wb_stb_i (wb_m2s_mem_stb [t] ),
        .wb_cti_i (wb_m2s_mem_cti [t] ),
        .wb_bte_i (wb_m2s_mem_bte [t] ),
        .wb_dat_o (wb_s2m_mem_dat [t] ),
        .wb_ack_o (wb_s2m_mem_ack [t] ),
        .wb_err_o (wb_s2m_mem_err [t] )
      );

      assign wb_s2m_mem_rty [t] = 1'b0;
    end
  endgenerate

  wire uart_irq [CORES_PER_TILE-1:0];

  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      mpsoc_wb_uart #(
        .DEBUG (0),
        .SIM   (1)
      ) uart16550 (
        //Wishbone Master interface
        .wb_clk_i  (wb_clk_i),
        .wb_rst_i  (wb_rst_i),
        .wb_adr_i  (wb_m2s_uart_adr [t][2:0] ),
        .wb_dat_i  (wb_m2s_uart_dat [t] ),
        .wb_sel_i  (4'h0),
        .wb_we_i   (wb_m2s_uart_we  [t] ),
        .wb_cyc_i  (wb_m2s_uart_cyc [t] ),
        .wb_stb_i  (wb_m2s_uart_stb [t] ),
        .wb_dat_o  (wb_s2m_uart_dat [t] ),
        .wb_ack_o  (wb_s2m_uart_ack [t] ),
        .int_o     (uart_irq        [t] ),
        .srx_pad_i (1'b0),
        .stx_pad_o (),
        .rts_pad_o (),
        .cts_pad_i (1'b0),
        .dtr_pad_o (),
        .dsr_pad_i (1'b0),
        .ri_pad_i  (1'b0),
        .dcd_pad_i (1'b0)
      );

      assign wb_s2m_uart_err [t] = 1'b0;
      assign wb_s2m_uart_rty [t] = 1'b0;
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // CPU Interrupt assignments
  //
  ////////////////////////////////////////////////////////////////////////
  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      assign or1k_irq[t][0] = 0;
      assign or1k_irq[t][1] = 0;
      assign or1k_irq[t][2] = uart_irq [t];
      assign or1k_irq[t][3] = 0;
      assign or1k_irq[t][4] = 0;
      assign or1k_irq[t][5] = 0;
      assign or1k_irq[t][6] = 0;
      assign or1k_irq[t][7] = 0;
      assign or1k_irq[t][8] = 0;
      assign or1k_irq[t][9] = 0;
      assign or1k_irq[t][10] = 0;
      assign or1k_irq[t][11] = 0;
      assign or1k_irq[t][12] = 0;
      assign or1k_irq[t][13] = 0;
      assign or1k_irq[t][14] = 0;
      assign or1k_irq[t][15] = 0;
      assign or1k_irq[t][16] = 0;
      assign or1k_irq[t][17] = 0;
      assign or1k_irq[t][18] = 0;
      assign or1k_irq[t][19] = 0;
      assign or1k_irq[t][20] = 0;
      assign or1k_irq[t][21] = 0;
      assign or1k_irq[t][22] = 0;
      assign or1k_irq[t][23] = 0;
      assign or1k_irq[t][24] = 0;
      assign or1k_irq[t][25] = 0;
      assign or1k_irq[t][26] = 0;
      assign or1k_irq[t][27] = 0;
      assign or1k_irq[t][28] = 0;
      assign or1k_irq[t][29] = 0;
      assign or1k_irq[t][30] = 0;
    end
  endgenerate
endmodule
