# Simple ebpf raw loader
This generates a simple bpf bytecode object (probe) which prints Hello world messages to */sys/kernel/debug/tracing/trace_pipe* by attaching to a specific kprobe. 
A raw loader based on ioctl() function is implemented to inject ebpf inside the kernel.
Consult [https://www.kernel.org/doc/html/latest/trace/kprobetrace.html](https://www.kernel.org/doc/html/latest/trace/kprobetrace.html) for reference on how to create kprobes.

### Config probe
Gain admin privileges:
```bash 
sudo su
```

Create kprobe:
```bash 
echo 'p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
```
Enable the probe:
```bash 
echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
```
Gather probe id:
```bash
cat /sys/kernel/debug/tracing/events/kprobes/myprobe/id 

1673
```
Start tracing:
```bash
echo 1 > tracing_on
```
Now watch at the flowing events:
```bash
tail /sys/kernel/debug/tracing/trace

<...>-62821   [001] .... 16816.457860: myprobe: (do_sys_open+0x0/0x290) dfd=0xffffffffabedaf80 filename=0x88000 flags=0x0 mode=0x81e33f48ffffffff
...
```
### Attach ebpf probe

Compile the project:
```bash
make all
```
Launch and attach the probe to the **previous id**:
```bash
cd build
sudo loader probe 1673
```

Now look at the tracing events, you shoud see Hello World ! printed out:
```bash
tail /sys/kernel/debug/tracing/trace

<...>-64133   [002] .... 17647.900652: 0: Hello World!
<...>-64133   [002] d... 17647.900660: myretprobe: (__x64_sys_openat+0x20/0x30 <- do_sys_open) arg1=0x3
...
```

**Hooray we just injected bpf bytecode in the kernel !**



