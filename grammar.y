%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char* s){
  printf("Syntax error: %s\n",s);
}
%}

%token T_ROOT
%token T_CLOSE_ROOT
%token T_LINEAR_LAYOUT
%token T_CLOSE_LINEAR_LAYOUT
%token T_RELATIVE_LAYOUT
%token T_CLOSE_RELATIVE_LAYOUT
%token T_CLOSE_RADIO_GROUP
%token T_A_LAYOUT_HEIGHT
%token T_A_LAYOUT_WIDTH
%token T_A_ID
%token T_A_ORIENTATION
%token T_A_TEXT
%token T_A_TEXT_COLOUR
%token T_A_SRC
%token T_A_PADDING
%token T_A_CHECKED_BUTTON
%token T_A_PROGRESS
%token T_A_MAX
%token T_VALUE
%token T_INTEGER
%token T_ALPHANUMERIC
%token T_OPEN_ANGLE
%token T_CLOSE_ANGLE
%token T_SLASH_CLOSE_ANGLE
%token T_EQUALS
%token T_WHITESPACE
%token T_ERROR

%start root 


%%

root: LinearLayout
     |RelativeLayout
    ;

LinearLayout: T_OPEN_ANGLE T_LINEAR_LAYOUT LinearAttributes T_CLOSE_ANGLE Element T_CLOSE_LINEAR_LAYOUT
        ;

RelativeLayout: T_OPEN_ANGLE T_RELATIVE_LAYOUT RelativeAttributes T_CLOSE_ANGLE Element T_CLOSE_RELATIVE_LAYOUT
        ;

Element:  TextView
        | ImageView
        | Button
        | RadioGroup
        | ProgressBar
        | LinearLayout
        | RelativeLayout
        ;

LinearAttributes: PrimaryAttribute ID Orientation
;

RelativeAttributes: PrimaryAttribute ID
;

TextView: T_OPEN_ANGLE PrimaryAttribute Text ID TextColour T_SLASH_CLOSE_ANGLE
;

ImageView: T_OPEN_ANGLE PrimaryAttribute Src ID Padding T_SLASH_CLOSE_ANGLE
;

Button: T_OPEN_ANGLE PrimaryAttribute Text ID Padding T_SLASH_CLOSE_ANGLE
;

RadioGroup:T_OPEN_ANGLE PrimaryAttribute ID CheckedButton T_CLOSE_ANGLE RadioButton T_CLOSE_RADIO_GROUP
;

RadioButton: PrimaryAttribute Text ID T_SLASH_CLOSE_ANGLE
;

ProgressBar:PrimaryAttribute Progress Max ID T_SLASH_CLOSE_ANGLE
;

PrimaryAttribute: Height|Width
;
Height: T_A_LAYOUT_HEIGHT T_EQUALS T_WHITESPACE Value
;

Width: T_A_LAYOUT_WIDTH T_EQUALS T_WHITESPACE Value
;

ID: T_A_ID T_EQUALS T_WHITESPACE T_ALPHANUMERIC
;

Orientation: T_A_ORIENTATION T_EQUALS T_WHITESPACE T_ALPHANUMERIC
;

Text: T_A_TEXT T_EQUALS T_WHITESPACE T_ALPHANUMERIC
;

TextColour: T_A_TEXT_COLOUR T_EQUALS T_WHITESPACE T_ALPHANUMERIC
;

Src: T_A_SRC T_EQUALS T_WHITESPACE T_ALPHANUMERIC
;

Padding: T_A_PADDING T_EQUALS T_WHITESPACE T_INTEGER
;

CheckedButton: T_A_CHECKED_BUTTON T_EQUALS T_WHITESPACE T_ALPHANUMERIC
;

Progress: T_A_PROGRESS T_EQUALS T_WHITESPACE T_INTEGER
;

Max: T_A_MAX T_EQUALS T_WHITESPACE T_INTEGER
;

Value: T_VALUE T_EQUALS T_WHITESPACE T_INTEGER
      | T_VALUE T_EQUALS T_WHITESPACE T_ALPHANUMERIC
      ;

%%
