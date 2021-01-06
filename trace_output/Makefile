# Build probe with clang
# probe is built inside the kernel path so that it can link against the other headers
# other examples can be found at /KERNELDIR/samples/..

# build in kernel
always += trc_out_kern.o

CLANG = clang-10
LLC = llc-10

KERNELDIR ?= /lib/modules/$(shell uname -r)/build

# DEBUG = -DBPF_DEBUG

# make inside kernel source directory and pass M=<external 
# module path (PWD)> to kernel Makefile (kbuild notation)
all:
	$(MAKE) -C $(KERNELDIR) M=$$PWD

clean:
	$(MAKE) -C $(KERNELDIR) M=$$PWD clean
	@rm -f *~


$(obj)/trc_out_kern.o: $(src)/trc_out_kern.c \
		$(src)/bpf_helpers.h 
	$(CLANG) $(LINUXINCLUDE) \
		$(KBUILD_CPPFLAGS) \
		$(KBUILD_EXTRA_CPPFLAGS) \
		$(DEBUG) \
		-D__KERNEL__ \
		-D__BPF_TRACING__ \
		-Wno-gnu-variable-sized-type-not-at-end \
		-Wno-address-of-packed-member \
		-fno-jump-tables \
		-fno-stack-protector \
		-Wno-tautological-compare \
		-O2 -g -emit-llvm -S $< -o $(patsubst %.o,%.ll,$@)
	$(LLC) -march=bpf -filetype=obj -o $@ $(patsubst %.o,%.ll,$@)


#$(obj)/trc_out_kern.o: $(src)/trc_out_kern.c 
#	$(src)/bpf_helpers.h \
#	$(CLANG) $(LINUXINCLUDE) \
#		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
#		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
#		-Wno-gnu-variable-sized-type-not-at-end \
#		-Wno-address-of-packed-member -Wno-tautological-compare \
#		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
#		-O2 -g -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
#                          		-fno-jump-tables \
#
#		-I/home/crash/Documents/local/sysdig-repo/flash/workspace/kernel/tools/testing/selftests/bpf/ \
#		-include asm_goto_workaround.h \
#
#		-I/home/crash/Documents/local/sysdig-repo/flash/workspace/kernel/tools/testing/selftests/bpf/ \
#$(obj)/%.o: $(src)/%.c
#	@echo "  CLANG-bpf " $@
#	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
#		-I$(srctree)/tools/testing/selftests/bpf/ \
#		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
#		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
#		-Wno-gnu-variable-sized-type-not-at-end \
#		-Wno-address-of-packed-member -Wno-tautological-compare \
#		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
#		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
#		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
#
