%{
#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include "parser.h"

%option noyywrap

typedef enum {
TOKEN_LINEAR_LAYOUT,
TOKEN_RELATIVE_LAYOUT,
TOKEN_TEXT_VIEW,
TOKEN_TEXT_COLOUR,
TOKEN_IMAGE_VIEW,
TOKEN_BUTTON,
TOKEN_RADIO_GROUP,
TOKEN_RADIO_BUTTON,
TOKEN_PROGRESS_BAR,
TOKEN_ANGLE_OPEN,
TOKEN_ANGLE_CLOSE,
TOKEN_SLASH,
TOKEN_ANDROID_ID,
TOKEN_ANDROID_TEXT,
TOKEN_ANDROID_TEXT_COLOUR,
TOKEN_ANDROID_SRC,
TOKEN_ANDROID_PADDING,
TOKEN_ANDROID_CHECKED_BUTTON,
TOKEN_ANDROID_PROGRESS,
TOKEN_ANDROID_MAX,
TOKEN_ANDROID_LAYOUT_WIDTH,
TOKEN_ANDROID_LAYOUT_HEIGHT,
TOKEN_ANDROID_WIDTH,
TOKEN_ANDROID_HEIGHT,
TOKEN_ANDROID_ORIENTATION,
TOKEN_INT,
TOKEN_VALUE,
TOKEN_ERROR
} TokenType;

typedef struct {
    int intVal;
    char* stringVal;
} TokenData;

TokenData token_data;

//helper function that prints the token
void printToken(const char *token){
       printf("Token: %s\n",token);
    }

//helper function that handles the errors
void yyerror(const char *msg) {
    printf("Error: %s at line %d\n", msg, yylineno + 1);
}

%}

%x ANDROID_ID ANDROID_TEXT ANDROID_TEXT_COLOUR ANDROID_SRC ANDROID_PADDING ANDROID_CHECKED_BUTTON ANDROID_PROGRESS ANDROID_MAX ANDROID_LAYOUT_WIDTH ANDROID_LAYOUT_HEIGHT


%%
"<LinearLayout>"  {return TOKEN_LINEAR_LAYOUT;}
"<RelativeLayout>" {return TOKEN_RELATIVE_LAYOUT;}
"TextView" {return TOKEN_TEXT_VIEW;}
"TextColor" {return TOKEN_TEXT_COLOUR;}
"ImageView" {return TOKEN_IMAGE_VIEW;}
"Button" {return TOKEN_BUTTON;}
"RadioGroup" {return TOKEN_RADIO_GROUP;}
"RadioButton" {return TOKEN_RADIO_BUTTON;}
"ProgressBar" {return TOKEN_PROGRESS_BAR;}

"<" {return TOKEN_ANGLE_OPEN;}
">" {return TOKEN_ANGLE_CLOSE;}
"/" {return TOKEN_SLASH;}

"android:id" { BEGIN(TOKEN_ANDROID_ID);}
"android:text" { BEGIN(TOKEN_ANDROID_TEXT);}
"android:textColor" { BEGIN(TOKEN_ANDROID_TEXT_COLOUR);}
"android:src" { BEGIN(TOKEN_ANDROID_SRC);}
"android:padding" { BEGIN(TOKEN_ANDROID_PADDING);}
"android:checkedButton" { BEGIN(TOKEN_ANDROID_CHECKED_BUTTON);}
"android:progress" { BEGIN(TOKEN_ANDROID_PROGRESS);}
"android:max" { BEGIN(TOKEN_ANDROID_MAX);}
"android:layout_width" { BEGIN(TOKEN_ANDROID_LAYOUT_WIDTH);}
"android:layout_height" { BEGIN(TOKEN_ANDROID_LAYOUT_HEIGHT);}

"<AndroidHeight>" {return TOKEN_ANDROID_HEIGHT;} 
"<AndroidWidth>" {return TOKEN_ANDROID_WIDTH;}
"<AndroidID>" {return TOKEN_ANDROID_ID;}
"<AndroidOrientation>" {return TOKEN_ANDROID_ORIENTATION;}
"<AndroidText>" {return TOKEN_ANDROID_TEXT;}
"<AndroidTextColour>" {return TOKEN_ANDROID_TEXT_COLOR;}
"<AndroidSRC>" {return TOKEN_ANDROID_SRC;}
"<AndroidPadding>" {return TOKEN_ANDROID_PADDING;}
"<AndroidCheckedButton>" {return ATOKEN_NDROID_CHECKED_BUTTON;}
"<AndroidProgress>" {return TOKEN_ANDROID_PROGRESS;}
"<AndroidMax>" {return TOKEN_ANDROID_MAX;}
"<AndroidLayoutWidth>" { BEGIN(TOKEN_ANDROID_LAYOUT_WIDTH);}
"<AndroidLayoutHeight>" { BEGIN(TOKEN_ANDROID_LAYOUT_HEIGHT);}

<ANDROID_ID>        { token_data.stringVal = strdup(yytext); return TOKEN_ANDROID_ID; }
<ANDROID_TEXT>      { token_data.stringVal = strdup(yytext); return TOKEN_ANDROID_TEXT; }
<ANDROID_TEXT_COLOUR> { token_data.stringVal = strdup(yytext); return TOKEN_ANDROID_TEXT_COLOUR; }
<ANDROID_SRC>       { token_data.stringVal = strdup(yytext); return TOKEN_ANDROID_SRC; }
<ANDROID_PADDING>   { token_data.intVal = atoi(yytext); return TOKEN_ANDROID_PADDING; }
<ANDROID_CHECKED_BUTTON> { token_data.stringVal = strdup(yytext); return TOKEN_ANDROID_CHECKED_BUTTON; }
<ANDROID_PROGRESS>  { token_data.intVal = atoi(yytext); return TOKEN_ANDROID_PROGRESS; }
<ANDROID_MAX>       { token_data.intVal = atoi(yytext); return TOKEN_ANDROID_MAX; }
<ANDROID_LAYOUT_WIDTH>    { token_data.stringVal = strdup(yytext); return TOKEN_ANDROID_LAYOUT_WIDTH; }
<ANDROID_LAYOUT_HEIGHT>   { token_data.stringVal = strdup(yytext); return TOKEN_ANDROID_LAYOUT_HEIGHT; }


[a-zA-Z_][a-zA-Z0-9_]* { token_data.stringVal = strdup(yytext); return TOKEN_VALUE; }

[0-9]+              { token_data.intVal = atoi(yytext); return TOKEN_INT; }

\"[^\"]*\"          { token_data.stringVal = strdup(yytext); return TOKEN_VALUE; }

[ \t\n]             { /* ignore whitespace */ }
.                   { yyerror("Unrecognized token"); return TOKEN_ERROR; }
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