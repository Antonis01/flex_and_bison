%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.h"

typedef enum {
TOKEN_ERROR,
} Token;

//helper function that prints the token
void printToken(const char *token){
       printf("Token: %s\n",token);
    }

//helper function that handles the errors
void lexer_error(const char *msg) {
    printf("Error: %s at line %d\n", msg, yylineno + 1);
}

%}

%option noyywrap

%%
"<LinearLayout>"        {return "<LinearLayout>";}
"</LinearLayout>"       {return "</LinearLayout>";}
"<RelativeLayout>"      {return "<RelativeLayout>";}
"</RelativeLayout>"     {return "</RelativeLayout>";}
"<TextView/>"           {return "<TextView/>";}
"<ImageView/>"          {return "<ImageView/>";}
"<Button/>"             {return "<Button/>";}
"<RadioGroup>"          {return "<RadioGroup>";}
"</RadioGroup>"         {return "</RadioGroup>";}
"<RadioButton/>"        {return "<RadioButton/>";}
"<ProgressBar/>"        {return "<ProgressBar/>";}
"android:layout_height" {return "android:layout_height";}
"android:layout_width"  {return "android:layout_width";}
"android:id"            {return "android:id";}
"android:orientation"   {return "android:orientation";}
"android:text"          {return "android:text";}
"android:textColour"    {return "android:textColour";}
"adnroid:src"           {return "adnroid:src";}
"android:padding"       {return "android:padding";}
"android:checkedButton" {return "android:checkedButton";}
"android:progress"      {return "android:progress";}
"android:max"           {return "android:max";}
[0-9]+                  {return "integer";}
[a-zA-Z0-9]+            {return "alphanumeric";}
"<"                     {return "<";}
">"                     {return ">";}
"/>"                    {return "/>";}
"="                     {return "=";}
"\n"                    {/*ignore new lines*/}
[ \t\r]                 {/*ignore whitespaces*/}
.                       { lexer_error("Unrecognized token"); return TOKEN_ERROR; }
%%

int main(int argc, char **argv) {
    int token;
    while ((token = yylex()) != 0) {
        if (token == TOKEN_ERROR) {
            // Handle error token
            printf("Error: Unrecognized token at line %d\n", yylineno);
        } else {
            // Handle other tokens
            printf("Token: %d\n", token);
        }
    }
return 0;
}