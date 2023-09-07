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
char *alphanumeric_checked_button = NULL, *alphanumeric_android_id = NULL;
int passed_radio_button = 0, android_max_integer, android_progress_integer, element_counter_radio_group = 0;


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


void android_max_value(int token) {
    int next_token = yylex();
    
    if (next_token == T_EQUALS) {
        int new_next_token = yylex();
        if (new_next_token == T_INTEGER) {
            // Convert the yytext string to an integer
            android_max_integer = atoi(yytext);
            printf("=%d", android_max_integer);
        }
    }
}

void android_progress_value(int token) {
    int next_token = yylex();
    
    if (next_token == T_EQUALS) {
        int new_next_token = yylex();
        if (new_next_token == T_INTEGER) {
            // Convert the yytext string to an integer
            android_progress_integer = atoi(yytext);
            printf("=%d", android_progress_integer);
            
            // Compare if the android:progress value is between 0 and android:max
            if (android_progress_integer < 0 || android_progress_integer > android_max_integer) {
                lexer_error("android:progress value is not between 0 and android:max. Value = ", yytext);
                printf("\n\n\n");
                exit(0);
            }
        }
    }
}




void save_checked_button(int token) {
    int next_token = yylex();
    
    if (next_token == T_EQUALS) {
        int new_next_token = yylex();
        if (new_next_token == T_ALPHANUMERIC) {
                
            // We find the position of the first > in the yytext string
            // then we calculate the length until the first '>'
            // and we create a new string with the extracted value
            // This is done because the yytext contains all the radio button 
            // attributes and we only need the alphanumeric value
                
            char* closing_angle_bracket = strchr(yytext, '>');
            size_t length_until_closing_bracket = closing_angle_bracket - yytext;
            alphanumeric_checked_button = strndup(yytext, length_until_closing_bracket);
                    
            printf("=%s", alphanumeric_checked_button);

            // we set the flag to 1 to indicate that we have passed the android:checkedButton attribute
            // so that we check the android:id attribute only after we have passed the android:checkedButton attribute
            passed_radio_button = 1;
                
        }
    }
}


void save_android_id(int token) {
    
    alphanumeric_android_id = yytext;
    
    // we check if the alphanumeric value of android:id and android:checkedButton match
    
    if(strcmp(alphanumeric_android_id, alphanumeric_checked_button) != 0) {
        lexer_error("android:id and android:checkedButton values do not match. Checked Button = ", alphanumeric_checked_button);
        lexer_error("android:id and android:checkedButton values do not match. Android ID = ", alphanumeric_android_id);
        printf("\n\n");
        exit(0);
    }
    // we reset the flag to 0 to indicate that we have passed the android:checkedButton attribute
    passed_radio_button = 0;
}


void counter_radio_group(int token){
    if (token == '\n'){
        element_counter_radio_group++;
        int next_token = yylex();
        if (next_token == T_COUNT_ELEMENTS){
            element_counter_radio_group = 0;
        }

    }
    else if (token == T_COUNT_ELEMENTS){
        exit(0);
        int next_token = yylex();
        if (next_token == T_EQUALS){
            int new_next_token = yylex();
            if (new_next_token == T_POSITIVE_INTEGER){
                int count_elements = atoi(yytext);
                if (count_elements != element_counter_radio_group){
                    lexer_error("The count:elements value is not equal to the number of elements. Value = ", yytext);
                    printf("\n\n");
                    exit(0);
                }
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

    if (token == T_A_ID) {
        unique_id(token);
    }
    
    if (token == T_A_PADDING){
        paddingT(token);
    }

    if (token == T_A_MAX){
        android_max_value(token);
    }

    if (token == T_A_PROGRESS){
        android_progress_value(token);
    }

    if (token == T_A_CHECKED_BUTTON){
        save_checked_button(token);
    }

    if (token == T_A_ID && passed_radio_button == 1){
        save_android_id(token);
    }

    if (token == T_RADIO_GROUP){
        counter_radio_group(token);
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
"count:elements"        {return T_COUNT_ELEMENTS;}
[0-9]+                  {return T_POSITIVE_INTEGER;}
[-]?[0-9]+              {return T_INTEGER;}
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
            printToken(token, yytext); // Pass additional parameters        
        }
       
    }

    printf("\n\n");
    fclose(file);
    return 0;
}


