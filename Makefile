# SOURCES
SOURCES = ${shell find . -name '*.c'}
ADD_MAIN = ./src/add.c
MUL_MAIN = ./src/mul.c

# INCLUDES
INCLUDES = ${wildcard include/*.h}

# LIBS
LIB_SOURCES = ${filter-out $(ADD_MAIN) $(MUL_MAIN), $(SOURCES)}
LIB = lib/libteste.a

# BIN
ADD = bin/add
MUL = bin/mul

# FLAG
CFLAGS = -Llib -lteste -Iinclude
all: $(ADD) $(MUL)
	@echo $(SOURCES)
	@echo $(LIB_SOURCES)

$(LIB): $(LIB_SOURCES) $(INCLUDES)
	@gcc -o obj/a.o -c src/a.c -Iinclude
	@gcc -o obj/b.o -c src/b.c -Iinclude
	@ar rcs lib/libteste.a obj/*.o
	@echo "Building.."
	@echo $@  #Nome do alvo, no caso: libteste.a
	@echo $?  #Nome das dependências
	@echo $<  #Nome da primeira dependência

$(ADD): $(ADD_MAIN) $(INCLUDES) $(LIB)
	gcc -o $@ $< $(CFLAGS)

$(MUL): $(MUL_MAIN) $(INCLUDES) $(LIB)
	gcc -o $@ $< $(CFLAGS)

clean:
	@rm -f lib/* bin/*
	@find . -name "*.o" -exec rm -f {} \;

install: $(ADD) $(MUL)
	sudo cp $? /usr/local/bin

uninstall:
	@sudo rm -f /usr/local/bin/add
	@sudo rm -f /usr/local/bin/mul
