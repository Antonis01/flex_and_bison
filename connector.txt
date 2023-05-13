#ifndef PARSER_H
#define PARSER_H

void yyerror(const char* message);
int yylex(void);

extern int yylineno;  

#endif // PARSER_H
