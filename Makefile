# Simple explicit makefile (follow clean Redis style)

# Naming configuration
LOADER_NAME=loader
LOADER_OBJ=loader.o
PROBE_NAME=probe
PROBE_OBJ=probe.o



all: $(LOADER_NAME) $(PROBE_NAME)
	@mkdir -p build
	@cp ./$(LOADER_NAME)/loader build
	@cp ./$(PROBE_NAME)/probe.o build
	@sh ./scripts/bpfstrip build/probe.o build/probe 

# loader
$(LOADER_NAME): $(LOADER_OBJ)
	$(info BUILT: $(LOADER_NAME))	

# probe
$(PROBE_NAME): $(PROBE_OBJ)
	$(info BUILT: $(PROBE_NAME))	

# loader-obj
$(LOADER_OBJ):
	$(MAKE) -C $(LOADER_NAME) 

# probe-obj
$(PROBE_OBJ):
	$(MAKE) -C $(PROBE_NAME) 


.PHONY: clean
clean: 
	$(MAKE) -C $(PROBE_NAME) $@ 
	$(MAKE) -C $(LOADER_NAME) $@ 
	@rm -rf build
