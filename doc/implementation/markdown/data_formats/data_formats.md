# DATA FORMATS

## MAIN

### PU OR1K CORE
### PU OR1K CPU

## FETCH

### PU OR1K FETCH
### PU OR1K ICACHE
### PU OR1K IMMU

## DECODE

### PU OR1K DECODE
### PU OR1K DECODE-EXECUTE

## EXECUTE

### PU OR1K EXECUTE-ALU
### PU OR1K WB-MUX
### PU OR1K RF
### PU OR1K EXECUTE-CTRL

| `Name`              | `Value` |
| :------------------ | :------ |
| `OR1K_FPUOP_WIDTH`  | `8`     |
| `OR1K_FPUOP_SELECT` | `7:0`   |

:MSbit indicates FPU operation valid

| `Name`                          | `Value` |
| :------------------------------ | :------ |
| `OR1K_FPUOP_GENERIC_CMP_WIDTH`  | `3`     |
| `OR1K_FPUOP_GENERIC_CMP_SELECT` | `2:0`   |

:Select bits for Ordered/Unordered comparison

| `Name`                         | `Value` |
| :----------------------------- | :------ |
| `OR1K_FPUOP_UNORDERED_CMP_BIT` | `5`     |

:Unordered comparison bit

FP instruction is double precision if bit 4 is set. We're a 32-bit

| `Name`                  | `Value` |
| :---------------------- | :------ |
| `OR1K_FPUOP_DOUBLE_BIT` | `4`     |

:implementation thus do not support double precision FP

| `Name`                | `Value`        |
| :-------------------- | :------------- |
| `OR1K_FPUOP_ADD`      | `8'b0000_0000` |
| `OR1K_FPUOP_SUB`      | `8'b0000_0001` |
| `OR1K_FPUOP_MUL`      | `8'b0000_0010` |
| `OR1K_FPUOP_DIV`      | `8'b0000_0011` |
| `OR1K_FPUOP_ITOF`     | `8'b0000_0100` |
| `OR1K_FPUOP_FTOI`     | `8'b0000_0101` |
| `OR1K_FPUOP_REM`      | `8'b0000_0110` |
| `OR1K_FPUOP_RESERVED` | `8'b0000_0111` |

:FP Arithmetic OPCs

| `Name`            | `Value`        |
| :---------------- | :------------- |
| `OR1K_FPCOP_SFEQ` | `8'b0000_1000` |
| `OR1K_FPCOP_SFNE` | `8'b0000_1001` |
| `OR1K_FPCOP_SFGT` | `8'b0000_1010` |
| `OR1K_FPCOP_SFGE` | `8'b0000_1011` |
| `OR1K_FPCOP_SFLT` | `8'b0000_1100` |
| `OR1K_FPCOP_SFLE` | `8'b0000_1101` |

:FP Ordered Comparison OPCs

| `Name`             | `Value`        |
| :----------------- | :------------- |
| `OR1K_FPCOP_SFUEQ` | `8'b0010_1000` |
| `OR1K_FPCOP_SFUNE` | `8'b0010_1001` |
| `OR1K_FPCOP_SFUGT` | `8'b0010_1010` |
| `OR1K_FPCOP_SFUGE` | `8'b0010_1011` |
| `OR1K_FPCOP_SFULT` | `8'b0010_1100` |
| `OR1K_FPCOP_SFULE` | `8'b0010_1101` |
| `OR1K_FPCOP_SFUN`  | `8'b0010_1110` |

:FP Unordered Comparison OPCs

## MEMORY

### PU OR1K LSU
### PU OR1K DCACHE
### PU OR1K DMMU

## CONTROL

### PU OR1K CTRL
### PU OR1K BRANCH-PREDICTION

## PERIPHERAL

### PU OR1K PFPU32

| `Name`              | `Value` |
| :------------------ | :------ |
| `OR1K_FPUOP_WIDTH`  | `8`     |
| `OR1K_FPUOP_SELECT` | `7:0`   |

:MSbit indicates FPU operation valid

| `Name`                          | `Value` |
| :------------------------------ | :------ |
| `OR1K_FPUOP_GENERIC_CMP_WIDTH`  | `3`     |
| `OR1K_FPUOP_GENERIC_CMP_SELECT` | `2:0`   |

:Select bits for Ordered/Unordered comparison

| `Name`                         | `Value` |
| :----------------------------- | :------ |
| `OR1K_FPUOP_UNORDERED_CMP_BIT` | `5`     |

:Unordered comparison bit

FP instruction is double precision if bit 4 is set. We're a 32-bit

| `Name`                  | `Value` |
| :---------------------- | :------ |
| `OR1K_FPUOP_DOUBLE_BIT` | `4`     |

:implementation thus do not support double precision FP

| `Name`                | `Value`        |
| :-------------------- | :------------- |
| `OR1K_FPUOP_ADD`      | `8'b0000_0000` |
| `OR1K_FPUOP_SUB`      | `8'b0000_0001` |
| `OR1K_FPUOP_MUL`      | `8'b0000_0010` |
| `OR1K_FPUOP_DIV`      | `8'b0000_0011` |
| `OR1K_FPUOP_ITOF`     | `8'b0000_0100` |
| `OR1K_FPUOP_FTOI`     | `8'b0000_0101` |
| `OR1K_FPUOP_REM`      | `8'b0000_0110` |
| `OR1K_FPUOP_RESERVED` | `8'b0000_0111` |

:FP Arithmetic OPCs

| `Name`            | `Value`        |
| :---------------- | :------------- |
| `OR1K_FPCOP_SFEQ` | `8'b0000_1000` |
| `OR1K_FPCOP_SFNE` | `8'b0000_1001` |
| `OR1K_FPCOP_SFGT` | `8'b0000_1010` |
| `OR1K_FPCOP_SFGE` | `8'b0000_1011` |
| `OR1K_FPCOP_SFLT` | `8'b0000_1100` |
| `OR1K_FPCOP_SFLE` | `8'b0000_1101` |

:FP Ordered Comparison OPCs

| `Name`             | `Value`        |
| :----------------- | :------------- |
| `OR1K_FPCOP_SFUEQ` | `8'b0010_1000` |
| `OR1K_FPCOP_SFUNE` | `8'b0010_1001` |
| `OR1K_FPCOP_SFUGT` | `8'b0010_1010` |
| `OR1K_FPCOP_SFUGE` | `8'b0010_1011` |
| `OR1K_FPCOP_SFULT` | `8'b0010_1100` |
| `OR1K_FPCOP_SFULE` | `8'b0010_1101` |
| `OR1K_FPCOP_SFUN`  | `8'b0010_1110` |

:FP Unordered Comparison OPCs
