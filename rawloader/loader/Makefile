CC=gcc
CFLAGS=-I.
DEPS = 
OBJ = loader.o


all: loader

# Rule 1
# all object files depend from the corresponding c files
# % placeholder for exactly same name
# $@ expands to target name (loader.o)
# $< expands to the FIRST prerequisite (loader.c)
# Here i just compile, but not link
%.o: %.c $(DEPS)
	$(CC) -c -g -o $@ $< $(CFLAGS)


# Rule 2
# loader target depends on objects listed in $(OBJ) 
# $^ expands to ALL prerequisites (loader.o ..)
# expands targets one by one inside <Rule 1> by compiling
# each of them, then compiles/links everything altogether to solve the final targets
# here i should link
loader: $(OBJ) 
	$(CC) -g -o $@ $^ $(CFLAGS)


# Declare PHONY as it has no target
# *~ removes old vim backup files
.PHONY: clean
clean:
	@rm -f *.o *~ loader
