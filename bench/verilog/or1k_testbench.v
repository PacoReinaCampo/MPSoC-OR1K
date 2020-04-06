module or1k_testbench;

  localparam X = 2;
  localparam Y = 2;
  localparam Z = 2;

  localparam CORES_PER_TILE = 8;
  localparam MEM_SIZE       = 32'h02000000; //Set default memory size to 32MB

  genvar t;

  vlog_tb_utils vlog_tb_utils0();

  ////////////////////////////////////////////////////////////////////////
  //
  // JTAG VPI interface
  //
  ////////////////////////////////////////////////////////////////////////

  wire [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tms;
  wire [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tck;
  wire [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tdi;
  wire [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0] tdo;

  reg enable_jtag_vpi;
  initial enable_jtag_vpi = $test$plusargs("enable_jtag_vpi");

  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      jtag_vpi jtag_vpi0 (
        .tms       (tms [i][j][k][t] ),
        .tck       (tck [i][j][k][t] ),
        .tdi       (tdi [i][j][k][t] ),
        .tdo       (tdo [i][j][k][t] ),
        .enable    (enable_jtag_vpi),
        .init_done (or1k_testbench.dut.wb_rst)
      );
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // ELF program loading
  //
  ////////////////////////////////////////////////////////////////////////
  integer mem_words [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  integer i;

  reg [  31:0] mem_word [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];
  reg [1023:0] elf_file [X-1:0][Y-1:0][Z-1:0][CORES_PER_TILE-1:0];

  generate
    for (t=0; t<CORES_PER_TILE; t=t+1) begin
      initial begin
        if ($test$plusargs("clear_ram")) begin
          $display("Clearing RAM");
          for(i=0; i < MEM_SIZE/4; i = i+1) begin
            or1k_testbench[i][j][k][t].dut.wb_bfm_memory0.ram0.mem[i] = 32'h00000000;
          end
        end
        if($value$plusargs("elf_load=%s", elf_file[i][j][k][t])) begin
          $elf_load_file(elf_file[i][j][k][t]);

          mem_words[i][j][k][t] = $elf_get_size/4;
          $display("Loading %d words", mem_words[i][j][k][t]);
          for(i=0; i < mem_words[i][j][k][t]; i = i+1) begin
            or1k_testbench.dut[i][j][k][t].wb_bfm_memory0.ram0.mem[i] = $elf_read_32(i*4);
          end
        end else
          $display("No ELF file specified");
      end
    end
  endgenerate

  ////////////////////////////////////////////////////////////////////////
  //
  // Clock and reset generation
  //
  ////////////////////////////////////////////////////////////////////////
  reg syst_clk = 1;
  reg syst_rst = 1;

  always #5 syst_clk <= ~syst_clk;
  initial #100 syst_rst <= 0;

  ////////////////////////////////////////////////////////////////////////
  //
  // mor1kx monitor
  //
  ////////////////////////////////////////////////////////////////////////
  mor1kx_monitor #(.LOG_DIR(".")) i_monitor();

  ////////////////////////////////////////////////////////////////////////
  //
  // DUT
  //
  ////////////////////////////////////////////////////////////////////////
  or1k_mpsoc #(
    .X (X),
    .Y (Y),
    .Z (Z),

    .CORES_PER_TILE (CORES_PER_TILE),
    .MEM_SIZE       (MEM_SIZE)
  )
  dut (
    .wb_clk_i  (syst_clk),
    .wb_rst_i  (syst_rst),
    .tms_pad_i (tms),
    .tck_pad_i (tck),
    .tdi_pad_i (tdi),
    .tdo_pad_o (tdo)
  );
endmodule
