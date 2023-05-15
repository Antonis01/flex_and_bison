%option noyywrap
%option noinput
%option nounput

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include "parser.h"
#define YY_DECL int yylex()
#include "grammar.tab.h"
//helper function that prints the token
void printToken(const char *token){
       printf("Token: %s\n",token);
    }

//helper function that handles the errors
void lexer_error(const char* msg) {
    printf("Error: %s at line %d\n", msg, yylineno + 1);

    // Print the line content
    fseek(yyin, 0, SEEK_SET); // Move file pointer to the beginning
    int line_number = 1;
    char line[256];

    while (fgets(line, sizeof(line), yyin) != NULL) {
        if (line_number == yylineno + 1) {
            printf("Line %d: %s", line_number, line);
            break;
        }
        line_number++;
    }
}


%}

%%
"<root>"                {return T_ROOT;}
"</root>"               {return T_CLOSE_ROOT;}
"<LinearLayout>"        {return T_LINEAR_LAYOUT;}
"</LinearLayout>"       {return T_CLOSE_LINEAR_LAYOUT;}
"<RelativeLayout>"      {return T_RELATIVE_LAYOUT;}
"</RelativeLayout>"     {return T_CLOSE_RELATIVE_LAYOUT;}
"</RadioGroup>"         {return T_CLOSE_RADIO_GROUP;}
"android:layout_height" {return T_A_LAYOUT_HEIGHT;}
"android:layout_width"  {return T_A_LAYOUT_WIDTH;}
"android:id"            {return T_A_ID;}
"android:orientation"   {return T_A_ORIENTATION;}
"android:text"          {return T_A_TEXT;}
"android:textColour"    {return T_A_TEXT_COLOUR;}
"adnroid:src"           {return T_A_SRC;}
"android:padding"       {return T_A_PADDING;}
"android:checkedButton" {return T_A_CHECKED_BUTTON;}
"android:progress"      {return T_A_PROGRESS;}
"android:max"           {return T_A_MAX;}
"value"                 {return T_VALUE;}
[0-9]+                  {return T_INTEGER;}
[a-zA-Z0-9]+            {return T_ALPHANUMERIC;}
"<"                     {return T_OPEN_ANGLE;}
">"                     {return T_CLOSE_ANGLE;}
"/>"                    {return T_SLASH_CLOSE_ANGLE;}
"="                     {return T_EQUALS;}
"\n"                    {/*ignore new lines*/}
[ \t\r]                 {/*ignore whitespaces*/}
.                       {return T_ERROR; }
%%

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    
    FILE* file = fopen(argv[1], "r");
    if (!file) {
        printf("Error: Could not open file %s\n", argv[1]);
        return 1;
    }
    
    yyin = file;

    int token;
    while ((token = yylex()) != 0) {
        if (token == T_ERROR) {
            // Handle error token
            lexer_error("Invalid token");   
        } else {
            // Handle other tokens
           // printf("Token: %d\n", token);
        }
    }
    
    fclose(file);
    return 0;
}


