# Build probe with clang
# probe is built inside the kernel path so that it can link against the other headers
# other examples can be found at /KERNELDIR/samples/..

# build in kernel
always += probe.o

CLANG ?= clang
LLC ?= llc

KERNELDIR ?= /lib/modules/$(shell uname -r)/build

# DEBUG = -DBPF_DEBUG

# make inside kernel source directory and pass M=<external 
# module path (PWD)> to kernel Makefile (kbuild notation)
all:
	$(MAKE) -C $(KERNELDIR) M=$$PWD

clean:
	$(MAKE) -C $(KERNELDIR) M=$$PWD clean
	@rm -f *~

# required by the kernel make system to build my object
$(obj)/probe.o: $(src)/probe.c 
	$(CLANG) $(LINUXINCLUDE) \
		$(KBUILD_CPPFLAGS) \
		$(KBUILD_EXTRA_CPPFLAGS) \
		$(DEBUG) \
		-D__KERNEL__ \
		-D__BPF_TRACING__ \
		-Wno-gnu-variable-sized-type-not-at-end \
                -Wno-compare-distinct-pointer-types \
		-Wno-address-of-packed-member \
		-fno-stack-protector \
                -Wno-unknown-warning-option \
		-Wno-tautological-compare \
		-O2 -g -emit-llvm -c $< -o $(patsubst %.o,%.ll,$@)
	$(LLC) -march=bpf -filetype=obj -o $@ $(patsubst %.o,%.ll,$@)
#                          		-fno-jump-tables \
