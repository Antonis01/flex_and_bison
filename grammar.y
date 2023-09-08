%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char* s){
  syslog(LOG_ERR, "Syntax error: %s\n", s);
}
%}


%token T_ROOT
%token T_CLOSE_ROOT
%token T_LINEAR_LAYOUT
%token T_CLOSE_LINEAR_LAYOUT
%token T_RELATIVE_LAYOUT
%token T_CLOSE_RELATIVE_LAYOUT
%token T_ELEMENT
%token T_CLOSE_ELEMENT
%token T_TEXT_VIEW
%token T_CLOSE_TEXT_VIEW
%token T_IMAGE_VIEW
%token T_CLOSE_IMAGE_VIEW
%token T_BUTTON
%token T_CLOSE_BUTTON
%token T_RADIO_GROUP
%token T_CLOSE_RADIO_GROUP
%token T_RADIO_BUTTON
%token T_CLOSE_RADIO_BUTTON
%token T_PROGRESS_BAR
%token T_CLOSE_PROGRESS_BAR
%token T_LINEAR_ATTRIBUTES
%token T_CLOSE_LINEAR_ATTRIBUTES
%token T_RELATIVE_ATTRIBUTES
%token T_CLOSE_RELATIVE_ATTRIBUTES
%token T_PRIMARY_ATTRIBUTES
%token T_CLOSE_PRIMARY_ATTRIBUTES
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
%token T_CLOSING_TAG
%token T_EQUALS
%token T_WHITESPACE
%token T_WRAP_CONTENT
%token T_MATCH_PARENT
%token T_POSITIVE_INTEGER
%token T_ERROR
%token T_NEWLINE
%token T_COMMENT_OPENING_TAG
%token T_COMMENT_CLOSING_TAG
%token T_A_COUNT_ELEMENTS
%token T_QUOTE
%start root 



%%

root: LinearLayout
     |RelativeLayout
    ;

LinearLayout: T_OPEN_ANGLE T_LINEAR_LAYOUT LinearAttributes  Element T_CLOSE_LINEAR_LAYOUT
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

TextView: T_OPEN_ANGLE PrimaryAttribute Text ID TextColour T_CLOSING_TAG
;

ImageView: T_OPEN_ANGLE PrimaryAttribute Src ID Padding T_CLOSING_TAG
;

Button: T_OPEN_ANGLE PrimaryAttribute Text ID Padding T_CLOSING_TAG
;

RadioGroup:T_OPEN_ANGLE PrimaryAttribute ID CheckedButton RadioButton CountElements T_CLOSING_TAG
;

CountElements: T_A_COUNT_ELEMENTS T_EQUALS T_QUOTE T_POSITIVE_INTEGER T_QUOTE
;

RadioButton: T_OPEN_ANGLE PrimaryAttribute Text ID T_CLOSING_TAG
;

ProgressBar:PrimaryAttribute Progress Max ID
;

PrimaryAttribute: Height|Width
;
Height: T_A_LAYOUT_HEIGHT T_EQUALS T_WHITESPACE Value
;

Width: T_A_LAYOUT_WIDTH T_EQUALS T_WHITESPACE  Value
;

ID: T_A_ID T_EQUALS T_WHITESPACE T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Orientation: T_A_ORIENTATION T_EQUALS T_WHITESPACE T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Text: T_A_TEXT T_EQUALS T_WHITESPACE T_QUOTE T_ALPHANUMERIC T_QUOTE
;

TextColour: T_A_TEXT_COLOUR T_EQUALS T_WHITESPACE T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Src: T_A_SRC T_EQUALS T_WHITESPACE T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Padding: T_A_PADDING T_EQUALS T_WHITESPACE T_QUOTE T_INTEGER T_QUOTE
;

CheckedButton: T_A_CHECKED_BUTTON T_EQUALS T_WHITESPACE T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Progress: T_A_PROGRESS T_EQUALS T_WHITESPACE T_QUOTE T_INTEGER T_QUOTE
;

Max: T_A_MAX T_EQUALS T_WHITESPACE T_QUOTE T_INTEGER T_QUOTE
;

Value:  T_VALUE T_EQUALS T_WHITESPACE T_QUOTE T_WRAP_CONTENT T_QUOTE
        | T_VALUE T_EQUALS T_WHITESPACE T_QUOTE T_MATCH_PARENT T_QUOTE
        | T_VALUE T_EQUALS T_WHITESPACE T_QUOTE T_POSITIVE_INTEGER T_QUOTE
        ;
%%