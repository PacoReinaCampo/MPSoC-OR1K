TARGET               := soc-or1k
VPI_MODULES          := elf-loader.vpi jtag_vpi.vpi
TOPLEVEL             := or1k_testbench
IVERILOG_OPTIONS     := -DSIM
ALIGNILLEGALINSN     ?= +elf_load=../software/tests/build/or1k/or1k-alignillegalinsn
BACKTOBACK_JMP       ?= +elf_load=../software/tests/build/or1k/or1k-backtoback_jmp
BASIC                ?= +elf_load=../software/tests/build/or1k/or1k-basic
CMOV                 ?= +elf_load=../software/tests/build/or1k/or1k-cmov
CY                   ?= +elf_load=../software/tests/build/or1k/or1k-cy
DSX                  ?= +elf_load=../software/tests/build/or1k/or1k-dsx
DSXINSN              ?= +elf_load=../software/tests/build/or1k/or1k-dsxinsn
EXT                  ?= +elf_load=../software/tests/build/or1k/or1k-ext
FFL1                 ?= +elf_load=../software/tests/build/or1k/or1k-ffl1
ICACHE               ?= +elf_load=../software/tests/build/or1k/or1k-icache
ILLEGALINSN          ?= +elf_load=../software/tests/build/or1k/or1k-illegalinsn
ILLEGALINSNDELAYSLOT ?= +elf_load=../software/tests/build/or1k/or1k-illegalinsndelayslot
INSNFETCHALIGN       ?= +elf_load=../software/tests/build/or1k/or1k-insnfetchalign
INSNFETCHERROR       ?= +elf_load=../software/tests/build/or1k/or1k-insnfetcherror
INTLOOP              ?= +elf_load=../software/tests/build/or1k/or1k-intloop
INTMULTICYCLE        ?= +elf_load=../software/tests/build/or1k/or1k-intmulticycle
INTSYSCALL           ?= +elf_load=../software/tests/build/or1k/or1k-intsyscall
INTTICKLOOP          ?= +elf_load=../software/tests/build/or1k/or1k-inttickloop
JMP                  ?= +elf_load=../software/tests/build/or1k/or1k-jmp
JR                   ?= +elf_load=../software/tests/build/or1k/or1k-jr
LSU                  ?= +elf_load=../software/tests/build/or1k/or1k-lsu
LSUALIGN             ?= +elf_load=../software/tests/build/or1k/or1k-lsualign
LSUALIGNDELAYSLOT    ?= +elf_load=../software/tests/build/or1k/or1k-lsualigndelayslot
LSUERROR             ?= +elf_load=../software/tests/build/or1k/or1k-lsuerror
LSUERRORDELAYSLOT    ?= +elf_load=../software/tests/build/or1k/or1k-lsuerrordelayslot
LWJR                 ?= +elf_load=../software/tests/build/or1k/or1k-lwjr
MSYNC                ?= +elf_load=../software/tests/build/or1k/or1k-msync
MUL-BASIC            ?= +elf_load=../software/tests/build/or1k/or1k-mul-basic
OV                   ?= +elf_load=../software/tests/build/or1k/or1k-ov
REGJMP               ?= +elf_load=../software/tests/build/or1k/or1k-regjmp
RFE                  ?= +elf_load=../software/tests/build/or1k/or1k-rfe
SF                   ?= +elf_load=../software/tests/build/or1k/or1k-sf
SFBF                 ?= +elf_load=../software/tests/build/or1k/or1k-sfbf
SHIFTOPTS            ?= +elf_load=../software/tests/build/or1k/or1k-shiftopts
SHORTBRANCH          ?= +elf_load=../software/tests/build/or1k/or1k-shortbranch
SHORTJUMP            ?= +elf_load=../software/tests/build/or1k/or1k-shortjump
SYSTEMCALL           ?= +elf_load=../software/tests/build/or1k/or1k-systemcall
TICKLOOP             ?= +elf_load=../software/tests/build/or1k/or1k-tickloop
TICKRFFORWARD        ?= +elf_load=../software/tests/build/or1k/or1k-tickrfforward
TICKSYSCALL          ?= +elf_load=../software/tests/build/or1k/or1k-ticksyscall
TIMER                ?= +elf_load=../software/tests/build/or1k/or1k-timer
TRAP                 ?= +elf_load=../software/tests/build/or1k/or1k-trap
TRAPDELAYSLOT        ?= +elf_load=../software/tests/build/or1k/or1k-trapdelayslot

HELLO                ?= +elf_load=../software/hello/hello.elf

all: $(VPI_MODULES) $(TARGET)

$(TARGET):
	iverilog -s$(TOPLEVEL) -c $(TARGET).scr -o $@ $(IVERILOG_OPTIONS)

run-alignillegalinsn: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-alignillegalinsn.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(ALIGNILLEGALINSN)

run-backtoback_jmp: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-backtoback_jmp.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(BACKTOBACK_JMP)

run-basic: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-basic.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(BASIC)

run-cmov: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-cmov.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(CMOV)

run-cy: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-cy.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(CY)

run-dsx: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-dsx.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(DSX)

run-dsxinsn: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-dsxinsn.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(DSXINSN)

run-ext: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-ext.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(EXT)

run-ffl1: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-ffl1.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(FFL1)

run-icache: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-icache.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(ICACHE)

run-illegalinsn: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-illegalinsn.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(ILLEGALINSN)

run-illegalinsndelayslot: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-illegalinsndelayslot.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(ILLEGALINSNDELAYSLOT)

run-insnfetchalign: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-insnfetchalign.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(INSNFETCHALIGN)

run-insnfetcherror: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-insnfetcherror.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(INSNFETCHERROR)

run-intloop: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-intloop.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(INTLOOP)

run-intmulticycle: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-intmulticycle.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(INTMULTICYCLE)

run-intsyscall: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-intsyscall.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(INTSYSCALL)

run-inttickloop: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-inttickloop.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(INTTICKLOOP)

run-jmp: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-jmp.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(JMP)

run-jr: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-jr.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(JR)

run-lsu: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-lsu.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(LSU)

run-lsualign: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-lsualign.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(LSUALIGN)

run-lsualigndelayslot: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-lsualigndelayslot.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(LSUALIGNDELAYSLOT)

run-lsuerror: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-lsuerror.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(LSUERROR)

run-lsuerrordelayslot: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-lsuerrordelayslot.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(LSUERRORDELAYSLOT)

run-lwjr: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-lwjr.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(LWJR)

run-msync: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-msync.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(MSYNC)

run-mul-basic: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-mul-basic.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(MUL-BASIC)

run-ov: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-ov.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(OV)

run-regjmp: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-regjmp.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(REGJMP)

run-rfe: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-rfe.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(RFE)

run-sf: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-sf.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(SF)

run-sfbf: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-sfbf.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(SFBF)

run-shiftopts: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-shiftopts.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(SHIFTOPTS)

run-shortbranch: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-shortbranch.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(SHORTBRANCH)

run-shortjump: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-shortjump.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(SHORTJUMP)

run-systemcall: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-systemcall.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(SYSTEMCALL)

run-tickloop: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-tickloop.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(TICKLOOP)

run-tickrfforward: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-tickrfforward.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(TICKRFFORWARD)

run-ticksyscall: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-ticksyscall.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(TICKSYSCALL)

run-timer: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-timer.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(TIMER)

run-trap: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-trap.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(TRAP)

run-trapdelayslot: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-trapdelayslot.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(TRAPDELAYSLOT)


run-hello: $(VPI_MODULES) $(TARGET)
	vvp -n -M. -l or1k-hello.log $(patsubst %.vpi,-m%,$(VPI_MODULES)) $(TARGET) $(HELLO)


clean:
	$(RM) $(VPI_MODULES) $(TARGET)

elf-loader_LIBS := -lelf
elf-loader_INCS := -I../software/elf-loader/
elf-loader_SRCS := ../software/elf-loader/elf-loader.c ../software/elf-loader/vpi_wrapper.c

elf-loader.vpi: $(elf-loader_SRCS)
	iverilog-vpi --name=elf-loader $(elf-loader_LIBS) $(elf-loader_INCS) $?

clean_elf-loader:
	$(RM) elf-loader.vpi

jtag_vpi_LIBS := 
jtag_vpi_INCS := -I../pu/dbg/software/or1k/
jtag_vpi_SRCS := ../pu/dbg/software/or1k/jtag_common.c ../pu/dbg/software/or1k/jtag_vpi.c ../pu/dbg/bench/verilog/or1k/jtag_vpi/jtag_vpi.v

jtag_vpi.vpi: $(jtag_vpi_SRCS)
	iverilog-vpi --name=jtag_vpi $(jtag_vpi_LIBS) $(jtag_vpi_INCS) $?

clean_jtag_vpi:
	$(RM) jtag_vpi.vpi
