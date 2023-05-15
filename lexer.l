%option noyywrap

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
void lexer_error(const char *msg) {
    printf("Error: %s at line %d\n", msg, yylineno + 1);
}

%}

%%

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
.                       { lexer_error("Unrecognized token"); return T_ERROR; }
%%

int main(int argc, char **argv) {
    int token;
    while ((token = yylex()) != 0) {
        if (token == T_ERROR) {
            // Handle error token
            printf("Error: Unrecognized token at line %d\n", yylineno);
        } else {
            // Handle other tokens
            printf("Token: %d\n", token);
        }
    }
return 0;
}