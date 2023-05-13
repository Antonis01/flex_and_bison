myprogram: lexer.c parser.c main.c
	gcc -o myprogram lexer.c parser.c main.c -lfl

lex.yy.c: lexer.l
	flex -o lexer.c lexer.l

parser.c: grammar.y
	bison -o parser.c grammar.y

clean:
	rm -f lexer.c parser.c myprogram
