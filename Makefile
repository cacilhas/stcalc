LEX= flex
YACC= bison -dy
CC= clang
RM= rm -f

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


$(LCSRC): $(LSRC) $(YCSRC)
	$(LEX) -o $@ $<

$(YCSRC): $(YSRC)
	$(YACC) -o $@ $<
