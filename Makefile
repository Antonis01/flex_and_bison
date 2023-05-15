myParser: lex.yy.c grammar.tab.c
	gcc -o myParser grammar.tab.c lex.yy.c -lfl

grammar.tab.c grammar.tab.h: grammar.y
	bison -d grammar.y

lex.yy.c: lexer.l grammar.tab.h
	flex lexer.l

clean:
	rm myParser grammar.tab.c lex.yy.c grammar.tab.h grammar.output
