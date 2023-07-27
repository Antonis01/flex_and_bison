%option noyywrap
%option noinput
%option nounput

%{
#include <stdio.h>
#include <string.h>
#include "grammar.tab.h"

#define YY_DECL int yylex()
#define MAX_LINE_LENGTH 256

int current_line = 1, check_line = 0, check = 0;

void lexer_error(const char *message, const char *tokenText) {
    printf("Error at line %d: %s '%s'", current_line, message, tokenText);
}

// Helper function that prints the token and the line number
void printToken(int token, const char *tokenText) {
    if (token == T_ERROR) {
        lexer_error("Invalid token", tokenText);
    } else {
        //printf("Token at line %d: %s\n", current_line, tokenText);
        if (current_line == check_line){
            if (check == 1){
                printf("\nToken at line %d: %s", current_line, tokenText);
                check=0;
            }
            else{
                printf("%s", tokenText);
                check=0;
            }
        }
        else{
            printf("\nToken at line %d: %s", current_line, tokenText);
            check_line = current_line;
            check=0;
        }
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
"<element>"             {return T_ELEMENT;}
"</element>"            {return T_CLOSE_ELEMENT;}
"<TextView>"            {return T_TEXT_VIEW;}
"</TextView>"           {return T_CLOSE_TEXT_VIEW;}
"<ImageView>"           {return T_IMAGE_VIEW;}
"</ImageView>"          {return T_CLOSE_IMAGE_VIEW;}
"<Button>"              {return T_BUTTON;}
"</Button>"             {return T_CLOSE_BUTTON;}
"RadioGroup>"           {return T_RADIO_GROUP;}
"</RadioGroup>"         {return T_CLOSE_RADIO_GROUP;}
"<ProgressBar>"         {return T_PROGRESS_BAR;}
"</ProgressBar>"        {return T_CLOSE_PROGRESS_BAR;}
"<LinearAttributes>"    {return T_LINEAR_ATTRIBUTES;}
"</LinearAttributes>"   {return T_CLOSE_LINEAR_ATTRIBUTES;}
"<RelativeAttributes>"  {return T_RELATIVE_ATTRIBUTES;}
"</RelativeAttributes>" {return T_CLOSE_RELATIVE_ATTRIBUTES;}
"PrimaryAttributes>"    {return T_PRIMARY_ATTRIBUTES;}
"</PrimaryAttributes>"  {return T_CLOSE_PRIMARY_ATTRIBUTES;}
"android:layout_height" {return T_A_LAYOUT_HEIGHT;}
"android:layout_width"  {return T_A_LAYOUT_WIDTH;}
"android:id"            {return T_A_ID;}
"android:orientation"   {return T_A_ORIENTATION;}
"android:text"          {return T_A_TEXT;}
"android:textColour"    {return T_A_TEXT_COLOUR;}
"android:src"           {return T_A_SRC;}
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
\n                      { current_line++; return T_NEWLINE;}
[ \t\r]                 {/*ignore whitespaces*/}
.                       { printToken(T_ERROR, yytext); }
%%

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* file;
    if ((file = fopen(argv[1], "r")) == NULL) {
        printf("Error: Could not open file %s\n", argv[1]);
        return 1;
    }

    yyin = file;

    int token;
    while ((token = yylex()) != 0) {
        if (token != T_NEWLINE) {
            printToken(token, yytext); // Pass both the token and yytext
        }
    }

    printf("\n\n");
    fclose(file);
    return 0;
}


