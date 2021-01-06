# Kernel trace event ebpf probe
This is the internal port of the trace_event bpf sample under kernel sources /kerne-src/samples/bpf/trace_event*
To be properly loaded with bpftool requires a kernel cmpiled with BTF info baked in

### Structure 
This is composed of two parts as usual:
- kernelspace ebpf probe: taps kernel events
- userspace ebpf loader: makes use of libbpf

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

