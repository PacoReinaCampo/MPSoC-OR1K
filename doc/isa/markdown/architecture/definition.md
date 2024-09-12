# DEFINITION

This directory contains MetaData for the RISC-V Instruction Set Architecture

| File                           | Description                             |
|--------------------------------|:----------------------------------------|
| `enums`                        | `Enumerated Types`                      |
| `constraints`                  | `Constraint Definitions`                |
| `operands`                     | `Operand Bit Encodings`                 |
: Definition Directory

OpenRISC 1000 instructions belong to one of the following instruction subsets:

* ORBIS32:
   * 32-bit integer instructions
   * Basic DSP instructions
   * 32-bit load and store instructions
   * Program flow instructions
   * Special instructions

* ORBIS64:
   * 64-bit integer instructions
   * 64-bit load and store instructions

* ORFPX32:
   * Single-precision floating-point instructions

* ORFPX64:
   * Double-precision floating-point instructions
   * 64-bit load and store instructions

* ORFPX64A32:
   * Double-precision floating-point instructions
   * Uses 32-bit general purpose register pairs for operations

* ORVDX64:
   * Vector instructions
   * DSP instructions
