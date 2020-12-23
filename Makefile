# Simple explicit makefile (follow clean Redis style)

# Naming configuration
LOADER_NAME=loader
LOADER_OBJ=loader.o
PROBE_NAME=probe
PROBE_OBJ=probe.o



all: $(LOADER_NAME) $(PROBE_NAME)

# loader
$(LOADER_NAME): $(LOADER_OBJ)
	$(info BUILT: $(LOADER_NAME))	

# probe
$(PROBE_NAME): $(PROBE_OBJ)
	$(info BUILT: $(PROBE_NAME))	

# loader-obj
$(LOADER_OBJ):
	cd $(LOADER_NAME) && $(MAKE)

# probe-obj
$(PROBE_OBJ):
	cd $(PROBE_NAME) && $(MAKE)


.PHONY: clean
clean: 
	$(MAKE) -C $(PROBE_NAME) $@ 
	$(MAKE) -C $(LOADER_NAME) $@ 
