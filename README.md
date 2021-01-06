# EBPFun
Some fun loading the simplest ebpf modules possible in a variety of ways

### Examples
***raw loader:***
This includes a simple example of raw loading without any helper library
***trac_event***
Here libbpf library will be used

### Launch
Compile with:
```bash
make -j8
```
Test probe loading with bpftool of a ***btf enabled machine (compiled with CONFIG_DEBUG_INFO_BTF)***:
This will pin the module under /sys/fs/bpf/prog
```bash
bpftool prog load ./trace_event_kern.o /sys/fs/bpf/prog -d
```
To unload the probe simply remove the file:
```bash
rm /sys/fs/bpf/prog
```
### Requirements
This was tested with:
- llvm,clang,llc version: 10
- kernel version: 5.4.0-58-generic 
- kernel-headers: /usr/src/linux-headers-5.4.0-58 
- testing environment: (https://github.com/lumontec/flashbuild)[https://github.com/lumontec/flashbuild] with BTF enabled kernel 
