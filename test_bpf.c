#define _GNU_SOURCE
#include "asm_goto_workaround.h"
#include "linux/bpf.h"
#include "bpf_helpers.h"

int bpf_prog(void *ctx) {
  char buf[] = "Hello World!\n";
  bpf_trace_printk(buf, sizeof(buf));
  return 0;
}
