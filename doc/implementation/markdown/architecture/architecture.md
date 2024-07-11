# ARCHITECTURE

| Pipeline          | Testing Support                              | Comments                                                               |
| ----------------- | -------------------------------------------- | ---------------------------------------------------------------------- |
| `CAPPUCCINO`      | `Linting` `or1k-tests` `formal-verification` | All supported tests passing                                            |
| `ESPRESSO`        | `linting` `or1k-tests`                       | Still many pipeline failures, see issue #71                            |
| `PRONTO_ESPRESSO` | `linting`                                    | No toolchain support for no-delayslot c code                           |
| `MAROCCHINO`      | `linting` `or1k-tests`                       | See [marocchino](https://github.com/openrisc/or1k_marocchino) project. |

## MAIN

| `Component`    |
| :------------- |
| `pu_or1k_core` |
| `pu_or1k_cpu`  |
: Implementation - Main

| `Component`               |
| :------------------------ |
| `pu_or1k_cfgrs`           |
| `pu_or1k_ctrl_cappuccino` |
| `pu_or1k_pcu`             |
| `pu_or1k_pic`             |
| `pu_or1k_ticktimer`       |
: Implementation - Control

### PU OR1K CORE
### PU OR1K CPU

## FETCH

| `Component`      |
| :--------------- |
| `pu_or1k_fetch`  |
| `pu_or1k_icache` |
| `pu_or1k_immu`   |
: Implementation - Fetch

### PU OR1K FETCH
### PU OR1K ICACHE
### PU OR1K IMMU

## DECODE

| `Component`       |
| :---------------- |
| `pu_or1k_decode`  |
: Implementation - Decode

### PU OR1K DECODE
### PU OR1K DECODE-EXECUTE

## EXECUTE

| `Component`            |
| :--------------------- |
| `pu_or1k_execute_alu`  |
| `pu_or1k_wb_mux`       |
| `pu_or1k_rf`           |
| `pu_or1k_execute_ctrl` |
: Implementation - Execute

### PU OR1K EXECUTE-ALU
### PU OR1K WB-MUX
### PU OR1K RF
### PU OR1K EXECUTE-CTRL

## MEMORY

| `Component`      |
| :--------------- |
| `pu_or1k_lsu`    |
| `pu_or1k_dcache` |
| `pu_or1k_dmmu`   |
: Implementation - Memory

### PU OR1K LSU
### PU OR1K DCACHE
### PU OR1K DMMU

## CONTROL

### PU OR1K CTRL
### PU OR1K BRANCH-PREDICTION

## PERIPHERAL

| `Component`      |
| :--------------- |
| `pu_or1k_pfpu32` |
: Implementation - PFPU32

### PU OR1K PFPU32

| `Parameter`            | `Description`                             | `Default`    | `Values`                                  | `Usage?`               |
| :--------------------- | :---------------------------------------- | :----------- | :---------------------------------------- | :--------------------- |
| `OPTION_OPERAND_WIDTH` | `Specify the CPU data and address widths` | `32`         | `32, 64, etc`                             |                        |
| `OPTION_CPU0`          | `Specify the CPU pipeline core`           | `CAPPUCCINO` | `CAPPUCCINO` `ESPRESSO` `PRONTO_ESPRESSO` | `CAPPUCCINO for Linux` |
| `OPTION_RESET_PC`      | `Specify the program counter upon reset`  | `0x100`      | `n`                                       |                        |
: Basic parameters

| `Parameter`                 | `Description`                                | `Default` | `Values`         | `Usage?`                                       |
| :-------------------------- | :------------------------------------------- | :-------- | :--------------- | :--------------------------------------------- |
| `FEATURE_DATACACHE`         | `Enable memory access data caching`          | `NONE`    | `ENABLED` `NONE` |                                                |
| `OPTION_DCACHE_BLOCK_WIDTH` | `Specify the address width of a cache block` | `5`       | `n`              |                                                |
| `OPTION_DCACHE_SET_WIDTH`   | `Specify the set address width`              | `9`       | `n`              |                                                |
| `OPTION_DCACHE_WAYS`        | `Specify the number of blocks per set`       | `2`       | `n`              |                                                |
| `OPTION_DCACHE_LIMIT_WIDTH` | `Specify the maximum address width`          | `32`      | `n`              | `31 for Linux to allow uncached device access` |
| `OPTION_DCACHE_SNOOP`       | `Enable bus snooping for cache coherency`    | `NONE`    | `ENABLED` `NONE` | `Linux SMP`                                    |
| `FEATURE_INSTRUCTIONCACHE`  | `Enable memory access instruction caching`   | `NONE`    | `ENABLED` `NONE` |                                                |
| `OPTION_ICACHE_BLOCK_WIDTH` | `Specify the address width of a cache block` | `5`       | `n`              |                                                |
| `OPTION_ICACHE_SET_WIDTH`   | `Specify the set address width`              | `9`       | `n`              |                                                |
| `OPTION_ICACHE_WAYS`        | `Specify the number of blocks per set`       | `2`       | `n`              |                                                |
| `OPTION_ICACHE_LIMIT_WIDTH` | `Specify the maximum address width`          | `32`      | `n`              |                                                |
: Caching parameters

| `Parameter`                  | `Description`                        | `Default` | `Values`         | `Usage?`                  |
| :--------------------------- | :----------------------------------- | :-------- | :--------------- | :------------------------ |
| `FEATURE_DMMU`               | `Enable the data bus MMU`            | `NONE`    | `ENABLED` `NONE` | `Linux expects` `ENABLED` |
| `FEATURE_DMMU_HW_TLB_RELOAD` | `Enable hardware TLB reload`         | `NONE`    | `ENABLED` `NONE` | `Linux expects` `NONE`    |
| `OPTION_DMMU_SET_WIDTH`      | `Specify the set address width`      | `6`       | `n`              |                           |
| `OPTION_DMMU_WAYS`           | `Specify the number of ways per set` | `1`       | `n`              |                           |
| `FEATURE_IMMU`               | `Enable the instruction bus MMU`     | `NONE`    | `ENABLED` `NONE` | `Linux expects` `ENABLED` |
| `FEATURE_IMMU_HW_TLB_RELOAD` | `Enable hardware TLB reload`         | `NONE`    | `ENABLED` `NONE` | `Linux expects` `NONE`    |
| `OPTION_IMMU_SET_WIDTH`      | `Specify the set address width`      | `6`       | `n`              |                           |
| `OPTION_IMMU_WAYS`           | `Specify the number of ways per set` | `1`       | `n`              |                           |
: Memory Management Unit (MMU) parameters

| `Parameter`                       | `Description`                                       | `Default`          | `Values`                                              | `Usage?`          |
| :-------------------------------- | :-------------------------------------------------- | :----------------- | :---------------------------------------------------- | :---------------- |
| `FEATURE_STORE_BUFFER`            | `Enable the load store unit store buffer`           | `ENABLED`          | `ENABLED` `NONE`                                      | `Large footprint` |
| `OPTION_STORE_BUFFER_DEPTH_WIDTH` | `Specify the load store unit store buffer depth`    | `8`                | `1-n`                                                 |                   |
| `BUS_IF_TYPE`                     | `Specify the bus interface type`                    | `WISHBONE32`       | `WISHBONE32`                                          |                   |
| `IBUS_WB_TYPE`                    | `Specify the Instruction bus interface type option` | `B3_READ_BURSTING` | `B3_READ_BURSTING` `B3_REGISTERED_FEEDBACK` `CLASSIC` |                   |
| `DBUS_WB_TYPE`                    | `Specify the Data bus interface type option`        | `CLASSIC`          | `B3_READ_BURSTING` `B3_REGISTERED_FEEDBACK` `CLASSIC` |                   |
: System bus parameters

| `Parameter`                | `Description        `                                                                                  | `Default` | `Values`                        | `Usage?`                |
| :------------------------- | :----------------------------------------------------------------------------------------------------- | :-------- | :------------------------------ | :---------------------- |
| `FEATURE_TRACEPORT_EXEC`   | `Enable the traceport hardware interface`                                                              | `NONE`    | `ENABLED` `NONE`                | `Verilator`             |
| `FEATURE_DEBUGUNIT`        | `Enable hardware breakpoints and advanced debug unit interface`                                        | `NONE`    | `ENABLED` `NONE`                | `OpenOCD`               |
| `FEATURE_PERFCOUNTERS`     | `Enable the performance counters unit`                                                                 | `NONE`    | `ENABLED` `NONE`                |                         |
| `OPTION_PERFCOUNTERS_NUM`  | `Specify the number of performance counters to generate`                                               | `0`       | `n`                             |                         |
| `FEATURE_TIMER`            | `Enable the internal OpenRISC timer`                                                                   | `ENABLED` | `ENABLED` `NONE`                |                         |
| `FEATURE_PIC`              | `Enable the internal OpenRISC PIC`                                                                     | `ENABLED` | `ENABLED` `NONE`                |                         |
| `OPTION_PIC_TRIGGER`       | `Specify the PIC trigger mode`                                                                         | `LEVEL`   | `LEVEL` `EDGE` `LATCHED_LEVEL`  |                         |
| `OPTION_PIC_NMI_WIDTH`     | `Specify non maskable interrupts width, starting at 0, these interrupts will not be reset or maskable` | `0`       | `0-32`                          |                         |
| `OPTION_RF_CLEAR_ON_INIT`  | `Enable clearing all registers on initialization`                                                      | `0`       | `0, 1`                          |                         |
| `OPTION_RF_NUM_SHADOW_GPR` | `Specify the number of shadow register files`                                                          | `0`       | `0-16`                          | `Set >=1 for Linux SMP` |
| `OPTION_RF_ADDR_WIDTH`     | `Specify the address width of the register file`                                                       | `5`       | `5`                             |                         |
| `OPTION_RF_WORDS`          | `Specify the number of registers in the register file`                                                 | `32`      | `32`                            |                         |
| `FEATURE_FASTCONTEXTS`     | `Enable fast context switching of register sets`                                                       | `NONE`    | `ENABLED` `NONE`                |                         |
| `FEATURE_MULTICORE`        | `Enable the 'coreid' and 'numcores' SPR registers`                                                     | `NONE`    | `ENABLED` `NONE`                | `Linux SMP`             |
| `FEATURE_FPU`              | `Enable the FPU, for cappuccino pipeline only`                                                         | `NONE`    | `ENABLED` `NONE`                |                         |
| `FEATURE_BRANCH_PREDICTOR` | `Select the branch predictor implementation`                                                           | `SIMPLE`  | `SIMPLE` `GSHARE` `SAT_COUNTER` |                         |
: Hardware unit configuration parameters

| `Parameter`        | `Description`                                                               | `Default` | `Values`         | `Usage?` |
| :----------------- | :-------------------------------------------------------------------------- | :-------- | :--------------- | :------- |
| `FEATURE_DSX`      | `Enable setting the 'SR[DSX]' flag when raising exceptions in a delay slot` | `ENABLED` | `ENABLED` `NONE` |          |
| `FEATURE_RANGE`    | `Enable checking and raising range exceptions`                              | `ENABLED` | `ENABLED` `NONE` |          |
| `FEATURE_OVERFLOW` | `Enable checking and raising overflow exceptions`                           | `ENABLED` | `ENABLED` `NONE` |          |
: Exception handling options

| `Parameter`          | `Description`                                | `Default`    | `Values`                                              | `Usage?` |
| :------------------- | :------------------------------------------- | :----------- | :---------------------------------------------------- | :------- |
| `FEATURE_MULTIPLIER` | `Specify the multiplier implementation`      | `THREESTAGE` | `THREESTAGE` `PIPELINED` `SERIAL` `SIMULATION` `NONE` |          |
| `FEATURE_DIVIDER`    | `Specify the divider implementation`         | `SERIAL`     | `SERIAL` `SIMULATION` `NONE`                          |          |
| `OPTION_SHIFTER`     | `Specify the shifter implementation`         | `BARREL`     | `BARREL` `SERIAL`                                     |          |
| `FEATURE_CARRY_FLAG` | `Enable checking and setting the carry flag` | `ENABLED`    | `ENABLED` `NONE`                                      |          |
: ALU configuration options

| `Parameter`       | `Description`                                                | `Default` | `Values`         | `Usage?`    |
| :---------------- | :----------------------------------------------------------- | :-------- | :--------------- | :---------- |
| `FEATURE_MAC`     | `Enable the 'l.mac*' multiply accumulate instructions`       | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_SYSCALL` | `Enable the 'l.sys OS syscall instruction`                   | `ENABLED` | `ENABLED` `NONE` |             |
| `FEATURE_TRAP`    | `Enable the 'l.trap' instruction`                            | `ENABLED` | `ENABLED` `NONE` | `GDB`       |
| `FEATURE_ADDC`    | `Enable the 'l.addc' add with 'carry' flag instruction`      | `ENABLED` | `ENABLED` `NONE` |             |
| `FEATURE_SRA`     | `Enable the 'l.sra' shirt right arithmetic instruction`      | `ENABLED` | `ENABLED` `NONE` |             |
| `FEATURE_ROR`     | `Enable the 'l.ror*' rotate right instructions`              | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_EXT`     | `Enable the 'l.ext*' sign extend instructions`               | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CMOV`    | `Enable the 'l.cmov' conditional move instruction`           | `ENABLED` | `ENABLED` `NONE` |             |
| `FEATURE_FFL1`    | `Enable the 'l.f[fl]1' find first/last set bit instructions` | `ENABLED` | `ENABLED` `NONE` | `Linux`     |
| `FEATURE_ATOMIC`  | `Enable the 'l.lwa' and 'l.swa' atomic instructions`         | `ENABLED` | `ENABLED` `NONE` | `Linux SMP` |
| `FEATURE_CUST1`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CUST2`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CUST3`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CUST4`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CUST5`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CUST6`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CUST7`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
| `FEATURE_CUST8`   | `Enable the 'l.cust*' custom instruction`                    | `NONE`    | `ENABLED` `NONE` |             |
: Instruction enabling options
