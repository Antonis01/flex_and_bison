myParser: grammar.y lexer.l grammar.tab.h lex.yy.c
		gcc -g -Wall -o myParser lex.yy.c grammar.tab.c -lfl

lex.yy.c: lexer.l grammar.tab.h
		flex lexer.l

grammar.tab.h: grammar.y
		bison -vd grammar.y

clean:
		rm -f myParser myParser.lex.h myParser.tab.* lex.yy.c myParser.output
