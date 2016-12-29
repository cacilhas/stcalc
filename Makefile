OS := $(shell uname)

LEX= flex
YACC= bison -dy
RM= rm -f

ifeq ($(OS),Darwin)
	CC= clang
else
	CC= gcc
endif

YSRC= $(wildcard *.y)
LSRC= $(wildcard *.l)
YCSRC= $(YSRC:%.y=%.tab.c)
LCSRC= $(LSRC:%.l=%.lex.c)
YHDR= $(YCSRC:%.c=%.h)
TARGET= $(YSRC:%.y=%)


#-------------------------------------------------------------------------------
.PHONY: clean mrproper test


all: $(TARGET)


clean:
	$(RM) $(LCSRC) $(YCSRC) $(YHDR)


test: $(TARGET) hello.txt
	./$?


mrproper: clean
	$(RM) $(TARGET)


$(TARGET): $(YCSRC) $(LCSRC)
	$(CC) -o $@ $?


%.lex.c: %.l
	$(LEX) -o $@ $<

%.tab.c: %.y
	$(YACC) -o $@ $<
