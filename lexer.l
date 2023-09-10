%option noyywrap
%option noinput
%option nounput

%{
#include <stdio.h>
#include <string.h>
#include "grammar.tab.h"

#define YY_DECL int yylex()

extern int yylex();

// Global variables for the lexer
// Variables for PrintToken function
int current_line = 1, check_line = 0;

// 2.a) Define a maximum number for the alphanumeric values
#define MAX_ALPHANUMERIC_VALUES 1000

// 2.a) array to store the unique alphanumeric values that we encountered
char unique_alphanumeric_values[MAX_ALPHANUMERIC_VALUES][64];
int num_alphanumeric_values = 0;

// 2.d
char *alphanumeric_checked_button = NULL, *alphanumeric_android_id = NULL;

// 2.d passed_radio_button, 2.e android_max_integer, android_progress_integer
int passed_radio_button = 0, android_max_integer, android_progress_integer;

// 3.d
int element_start_line=0, element_end_line=0, counter_radio_button_passed_check=0;
char *elementCount;
int elementIntCount = 0, elements = 0, checked_counter_radio_group = 0;


// Function that prints the error message and the token text
void lexer_error(const char *message, const char *tokenText) {
    printf("\nError at line %d: %s '%s'", current_line, message, tokenText);
}


// 2.a
// Function to check if the alphanumeric value is already present
int is_unique_alphanumeric(char *alphanumeric) {
    
    // Parse through the array to check if the alphanumeric value is already present
    for (int i = 0; i < num_alphanumeric_values; i++) {
    
        // If strcmp returns 0, then the alphanumeric value is not unique
        if (strcmp(alphanumeric, unique_alphanumeric_values[i]) == 0) {
            printf("=\"%s\"", alphanumeric);
            lexer_error("Duplicate alphanumeric value found", alphanumeric);
            printf("\n\n");
            exit(0);
        }
    }
    
    return 1; // Unique
}


// 2.a
// Function that checks if android:id uses unique values
void unique_id(int token) {
    
    int token1 = yylex();
        
    // Check if the next token is '='
    if (token1 == T_EQUALS) {
        int token2 = yylex();
        
        // Check if the next token is '"'
        if(token2 == T_QUOTE){
            int token3 = yylex();
        
            // Check if the next token is alphanumeric
            if (token3 == T_ALPHANUMERIC) {
                char *alphanumeric = yytext;
        
                // Check if the alphanumeric value is unique
                if (is_unique_alphanumeric(alphanumeric)) {
                    // Add the new unique alphanumeric value to the array
                    strcpy(unique_alphanumeric_values[num_alphanumeric_values], alphanumeric);
                    num_alphanumeric_values++;
                    printf("=\"%s", alphanumeric);
                }
            }
        }       
    }
}


// 2.b
// Function that checks if android:layout_width and android:layout_height 
// use wrap_content or match_parent or positive integer values
void width_height(int token){
    int token1 = yylex();
    
    if (token1 == T_EQUALS){
        int token2 = yylex();

        if (token2 == T_QUOTE){
            int token3 = yylex();
            
            if (token3 == T_WRAP_CONTENT || token3 == T_MATCH_PARENT){
                printf("=\"%s", yytext);
            }
            
            else if (token3 == T_POSITIVE_INTEGER){
                printf("=\"%s", yytext);
            }
            
            else{
                printf("=\"%s\"", yytext);
                if (token == T_A_LAYOUT_WIDTH){
                    lexer_error("\nError: android:layout_width value is not wrap_content or match_parent or positive integer. Value=", yytext);
                }
                else if (token == T_A_LAYOUT_HEIGHT){
                    lexer_error("\nError: android:layout_height value is not wrap_content or match_parent or positive integer. Value=", yytext);
                }
                printf("\n\n");
                exit(0);
            }        
        }
    }
}

// 2.c
// Function that checks if android:padding uses positive integer values
void paddingT(int token){
    int token1 = yylex();
    
    if (token1 == T_EQUALS){
        int token2 = yylex();

        if (token2 == T_QUOTE){
            int token3 = yylex();
            char *integerpadding = yytext;
            
            // We change the yytext string to an integer
            // and we check if the integer is positive
            if (atoi(integerpadding) > 0){
                printf("=\"%s", integerpadding);
            }
            
            else{
                printf("=\"%s\"", integerpadding);
                lexer_error("\nError: android:padding value is not a positive integer. Value=", integerpadding);
                printf("\n\n");
                exit(0);
            }        
        }
    }
}


// 2.d
void save_checked_button(int token) {
    int token1 = yylex();
    
    if (token1 == T_EQUALS) {
        int token2 = yylex();

        if (token2 == T_QUOTE){
            int token3 = yylex();
            
            if (token3 == T_ALPHANUMERIC) {
                    
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
}


// 2.d
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


// 2.e
void android_max_value(int token) {
    int token1 = yylex();
    
    if (token1 == T_EQUALS) {
        int token2 = yylex();

        if(token2 == T_QUOTE){
            int token3 = yylex();
            // Convert the yytext string to an integer
            android_max_integer = atoi(yytext);
            printf("=\"%d", android_max_integer);
            
        }
    }
}

// 2.e
void android_progress_value(int token) {
    int token1 = yylex();
    
    if (token1 == T_EQUALS) {
        int token2 = yylex();
        
        if (token2 == T_QUOTE) {
            int token3 = yylex();
            // Convert the yytext string to an integer
            android_progress_integer = atoi(yytext);

            // Compare if the android:progress value is between 0 and android:max
            if (android_progress_integer < 0 || android_progress_integer > android_max_integer) {
                printf("=\"%d\"", android_progress_integer);  
                lexer_error("android:progress value is not between 0 and android:max. Value = ", yytext);
                printf("\n\n\n");
                exit(0);
            }
            else{
                printf("=\"%d", android_progress_integer);            
            }      
        }
    }
}


// 3.d
void counter_radio_group(int token){
    
    if (token == T_RADIO_BUTTON){
        element_start_line = current_line;
        counter_radio_button_passed_check = 1;
    }

    if (token == T_CLOSING_TAG && counter_radio_button_passed_check == 1){
        element_end_line = current_line;
        counter_radio_button_passed_check = 0;
        // we find the number of elements in RadioButton
        elements = element_end_line - element_start_line;
        checked_counter_radio_group = 1;
        
        // we check if the value of android:count_elements is equal to the number of (elements_end_line-elements_start_line)
        // and if the value of android:count_elements is not equal to 0
        // we added the second condition because the android:count_elements can be before the RadioButton
        // so we need to check if the value of android:count_elements is not equal to 0
        // and that means that the android:count_elements is before the RadioButton
        // so the condition is only executed if the android:count_elements is before the RadioButton
        if (elementIntCount != elements && elementIntCount != 0){
            lexer_error("The value of count:elements is not equal to the number of elements in RadioButton. Value = ", elementCount);
            printf("\n%d != %d", elementIntCount, elements);
            printf("\n\n");
            exit(0);
        }
                
    }
}

// 3.d
void counter_radio_group_elements(int token){

    if (token == T_A_COUNT_ELEMENTS){
        int next_token = yylex();
        
        if (next_token == T_EQUALS){
            int new_next_token = yylex();
            
            if (new_next_token == T_QUOTE){
                int n_next_token = yylex();

                // the value of android:count_elements is stored in the elementCount variable
                // and it can be used in both counter_radio_group and counter_radio_group_elements functions
                elementCount = yytext;
                elementIntCount = atoi(yytext);
                printf("=\"%d", elementIntCount);
                
                // we check if the value of android:count_elements is equal to the number of (elements_end_line-elements_start_line)
                // and if the value of checked_counter_radio_group is equal to 1
                // we added the second condition because the android:count_elements can be after the RadioButton
                // so we need to check if the value of checked_counter_radio_group is equal to 1
                // and that means that the android:count_elements is after the RadioButton
                // so the condition is only executed if the android:count_elements is after the RadioButton
                if (elementIntCount != elements && checked_counter_radio_group == 1){
                    lexer_error("The value of count:elements is not equal to the number of elements in RadioButton. Value = ", elementCount);
                    printf("\n%d != %d", elementIntCount, elements);
                    printf("\n\n");
                    exit(0);


                }
            }        
        }
 
    }
}

void quotation_mark(int token){
    if (token == T_EQUALS){
        int next_token = yylex();
        
        if (next_token != T_QUOTE){
            lexer_error("\nQuotation mark is missing after equals sign.", "\"");
            printf("\n\n");
            exit(0);
        }
        else{
            printf("\"");
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

        if (current_line == check_line){
           
            printf("%s", tokenText);

        }
        else{
            printf("\nToken at line %d: %s", current_line, tokenText);
            check_line = current_line;
            
        }
    }

    quotation_mark(token);

    // 2.a
    if (token == T_A_ID) {
        unique_id(token);
    }
    
    // 2.b
    if (token == T_A_LAYOUT_HEIGHT || token == T_A_LAYOUT_WIDTH) {
        width_height(token);
    }

    // 2.c
    if (token == T_A_PADDING){
        paddingT(token);
    }

    // 2.d
    if (token == T_A_CHECKED_BUTTON){
        save_checked_button(token);
    }

    if (token == T_A_ID && passed_radio_button == 1){
        save_android_id(token);
    }

    // 2.e
    if (token == T_A_MAX){
        android_max_value(token);
    }

    if (token == T_A_PROGRESS){
        android_progress_value(token);
    }

    // 3.c
    counter_radio_group_elements(token);
    counter_radio_group(token);
}

%}

%%
"<LinearLayout"          {return T_LINEAR_LAYOUT;}
"</LinearLayout>"        {return T_CLOSE_LINEAR_LAYOUT;}
"<RelativeLayout"        {return T_RELATIVE_LAYOUT;}
"</RelativeLayout>"      {return T_CLOSE_RELATIVE_LAYOUT;}
"<TextView"              {return T_TEXT_VIEW;}
"<ImageView"             {return T_IMAGE_VIEW;}
"<Button"                {return T_BUTTON;}
"<RadioGroup"            {return T_RADIO_GROUP;}
"</RadioGroup>"          {return T_CLOSE_RADIO_GROUP;}
"<RadioButton"           {return T_RADIO_BUTTON;}
"<ProgressBar"           {return T_PROGRESS_BAR;}
"android:layout_height"  {return T_A_LAYOUT_HEIGHT;}
"android:layout_width"   {return T_A_LAYOUT_WIDTH;}
"android:id"             {return T_A_ID;}
"android:orientation"    {return T_A_ORIENTATION;}
"android:text"           {return T_A_TEXT;}
"android:textColour"     {return T_A_TEXT_COLOUR;}
"android:src"            {return T_A_SRC;}
"android:padding"        {return T_A_PADDING;}
"android:checkedButton"  {return T_A_CHECKED_BUTTON;}
"android:progress"       {return T_A_PROGRESS;}
"android:max"            {return T_A_MAX;}
"wrap_content"           {return T_WRAP_CONTENT;}
"match_parent"           {return T_MATCH_PARENT;}
"android:count_elements" {return T_A_COUNT_ELEMENTS;}
[0-9]+                   {return T_POSITIVE_INTEGER;}
[a-zA-Z0-9]+             {return T_ALPHANUMERIC;}
"<"                      {return T_OPEN_ANGLE;}
">"                      {return T_CLOSE_ANGLE;}
"/>"                     {return T_CLOSING_TAG;}
"="                      {return T_EQUALS;}
"\""                     {return T_QUOTE;}
"="*                     {printf("=");}   // Replace multiple '=' with a single '='
"<!--"                   {return T_COMMENT_OPENING_TAG;}
"-->"                    {return T_COMMENT_CLOSING_TAG;}
"--"                     { printToken(T_ERROR, yytext); }
\n                       { current_line++; return T_NEWLINE;}
[ \t\r]                  {/*ignore whitespaces*/}
.                        { printToken(T_ERROR, yytext); }
%%

int main(int argc, char **argv) {


    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* file;
    // We check if the file exists in read mode
    if ((file = fopen(argv[1], "r")) == NULL) {
        printf("Error: Could not open file %s\n", argv[1]);
        return 1;
    }

    yyin = file;

    int token;
    // We parse the file until we reach the end of the file
    // We read the tokens one by one
    while ((token = yylex()) != 0) {
        
        if (token != T_NEWLINE) {
            printToken(token, yytext);      
        }
    
    }

    printf("\n\n");
    fclose(file);
    return 0;
}


