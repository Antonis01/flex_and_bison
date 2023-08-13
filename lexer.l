%option noyywrap
%option noinput
%option nounput

%{
#include <stdio.h>
#include <string.h>
#include "grammar.tab.h"

#define YY_DECL int yylex()

extern int yylex();


int current_line = 1, check_line = 0, check = 0;

void lexer_error(const char *message, const char *tokenText) {
    printf("\nError at line %d: %s '%s'", current_line, message, tokenText);
}

// Define a maximum number for the alphanumeric values
#define MAX_ALPHANUMERIC_VALUES 1000

// array to store the unique alphanumeric values that we encountered
char unique_alphanumeric_values[MAX_ALPHANUMERIC_VALUES][64];
int num_alphanumeric_values = 0;

// Function to check if the alphanumeric value is already present
int is_unique_alphanumeric(const char *alphanumeric) {
    // Parse through the array to check if the alphanumeric value is already present
    for (int i = 0; i < num_alphanumeric_values; i++) {
        if (strcmp(alphanumeric, unique_alphanumeric_values[i]) == 0) {
            lexer_error("Duplicate alphanumeric value found", alphanumeric);
            printf("\n\n");
            exit(0);
        }
    }
    return 1; // Unique
}

int progressT_check(const char *integermax, const char *integerprogress){
    if (integerprogress < 0 && integerprogress > integermax){
        return 0;
    }
    else{
        return 1;
    }
}

// Function that checks if android:id uses unique values
void unique_id(int token) {
    // Check if the token is android:id
    if (token == T_A_ID) {
        int next_token = yylex();
        // Check if the next token is '='
        if (next_token == T_EQUALS) {
            int new_next_token = yylex();
            // Check if the next token is alphanumeric
            if (new_next_token == T_ALPHANUMERIC) {
                const char *alphanumeric = yytext;
                // Check if the alphanumeric value is unique
                if (is_unique_alphanumeric(alphanumeric)) {
                    // Add the new unique alphanumeric value to the array
                    strcpy(unique_alphanumeric_values[num_alphanumeric_values], alphanumeric);
                    num_alphanumeric_values++;
                    printf("=%s", alphanumeric);
                }
            }
        }
    }
}
void paddingT(int token){
    if (token == T_A_PADDING){
    int next_token = yylex();
        if (next_token == T_EQUALS){
            int new_next_token = yylex();
                if (new_next_token == T_INTEGER){
                const char *integerpadding = yytext;
                if (integerpadding > 0){
                    printf("=%s", integerpadding);
                }
                else{
                    lexer_error("\nExiting program because of Invalid token", integerpadding);
                    printf("\n\n");
                    exit(0);
                }
                }
        }
    }
}

void progressT(int token){
    if (token == T_A_MAX) {
    int next_token = yylex();

        if (next_token == T_EQUALS) {
            int new_next_token = yylex();

                if (new_next_token == T_INTEGER) {
                const char *integermax = yytext;
                    printf("=%s", integermax);
                    int next_new_next_token = yylex();

                        if (next_new_next_token == T_A_PROGRESS){
                            int new_next_new_next_token = yylex();

                                if (new_next_new_next_token == T_EQUALS){
                                    int next_new_next_new_next_new_next_token = yylex();

                                        if (next_new_next_new_next_new_next_token == T_INTEGER){
                                            const char *integerprogress = yytext;

                                            if (progressT_check(integermax, integerprogress) == 1){
                                                printf("=%s", integerprogress);
                                            } else{
                                                lexer_error("\nExiting program because of Invalid token", integerprogress);
                                                printf("\n\n");
                                                exit(0);
                                            }
                                        }
                                }
                        }
                }
        }
    }
}
    
void radio_button_id(int token){
    if(token == T_A_ID){
        int next_token = yylex();
        if (next_token == T_EQUALS){
            int new_next_token = yylex();
            if (new_next_token == T_ALPHANUMERIC){
                const char *alphanumeric_radio_button_id = yytext;
                printf("=%s", alphanumeric_radio_button_id);
                printf("\n\n\n");
            }
        }
    }
}

void checked_button(int token){

    if(token == T_A_CHECKED_BUTTON){
        int next_token = yylex();
        if (next_token == T_EQUALS){
            int new_next_token = yylex();
            if (new_next_token == T_ALPHANUMERIC){
                const char *alphanumeric_checked_button = yytext;
                printf("=%s", alphanumeric_checked_button);
                printf("\n\n\n");

            }
        }
    }
}


// Helper function that prints the token and the line number
void printToken(int token, const char *tokenText) {
    if (token == T_ERROR) {
        lexer_error("\nExiting program because of Invalid token", tokenText);
        printf("\n");
        exit(0);
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
    unique_id(token);
    paddingT(token);
    progressT(token);
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
"<RadioButton>"         {return T_RADIO_BUTTON;}
"</RadioButton>"        {return T_CLOSE_RADIO_BUTTON;}
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
"wrap_content"          {return T_WRAP_CONTENT;}
"match_parent"          {return T_MATCH_PARENT;}
"PositiveInteger"       {return T_POSITIVE_INTEGER;}
[0-9]+                  {return T_INTEGER;}
[a-zA-Z0-9]+            {return T_ALPHANUMERIC;}
"<"                     {return T_OPEN_ANGLE;}
">"                     {return T_CLOSE_ANGLE;}
"</"                    {return T_CLOSING_TAG;}
"="                     {return T_EQUALS;}
"="*                    {printf("=");}   // Replace multiple '=' with a single '='
"<!--"                  {return T_COMMENT_OPENING_TAG;}
"-->"                   {return T_COMMENT_CLOSING_TAG;}
"--"                    { printToken(T_ERROR, yytext); }
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


