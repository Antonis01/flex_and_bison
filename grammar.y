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



%token T_LINEAR_LAYOUT
%token T_CLOSE_LINEAR_LAYOUT
%token T_RELATIVE_LAYOUT
%token T_CLOSE_RELATIVE_LAYOUT
%token T_TEXT_VIEW
%token T_IMAGE_VIEW
%token T_BUTTON
%token T_RADIO_GROUP
%token T_CLOSE_RADIO_GROUP
%token T_RADIO_BUTTON
%token T_PROGRESS_BAR
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


%%

Root: LinearLayout
        | RelativeLayout
        ;

LinearLayout: T_LINEAR_LAYOUT LinearAttributes LinearElement T_CLOSE_ANGLE T_CLOSE_LINEAR_LAYOUT
        ;

RelativeLayout: T_RELATIVE_LAYOUT RelativeAttributes RelativeElement T_CLOSE_ANGLE T_CLOSE_RELATIVE_LAYOUT
        ;

LinearElement: TextView
                | ImageView
                | Button
                | RadioGroup
                | ProgressBar
                | LinearLayout
                ;

RelativeElement: 
               | TextView
               | ImageView
               | Button
               | RadioGroup
               | ProgressBar
               | RelativeLayout
               ;

LinearAttributes: PrimaryAttribute 
                | PrimaryAttribute ID 
                | PrimaryAttribute Orientation
                | PrimaryAttribute ID Orientation
                ;

RelativeAttributes: PrimaryAttribute ID
                ;

TextView: T_TEXT_VIEW PrimaryAttribute Text T_CLOSING_TAG
        | T_TEXT_VIEW PrimaryAttribute Text ID  T_CLOSING_TAG
        | T_TEXT_VIEW PrimaryAttribute Text TextColour T_CLOSING_TAG
        | T_TEXT_VIEW PrimaryAttribute Text TextColour ID T_CLOSING_TAG
        ;

ImageView: T_IMAGE_VIEW PrimaryAttribute Src T_CLOSING_TAG
        | T_IMAGE_VIEW PrimaryAttribute Src ID T_CLOSING_TAG     
        | T_IMAGE_VIEW PrimaryAttribute Src Padding T_CLOSING_TAG 
        | T_IMAGE_VIEW PrimaryAttribute Src ID Padding T_CLOSING_TAG 
        ;

Button: T_BUTTON PrimaryAttribute Text T_CLOSING_TAG
        | T_BUTTON PrimaryAttribute Text ID T_CLOSING_TAG
        | T_BUTTON PrimaryAttribute Text Padding T_CLOSING_TAG
        | T_BUTTON PrimaryAttribute Text ID Padding T_CLOSING_TAG
        ;

// 3.1
RadioGroup: T_RADIO_GROUP PrimaryAttribute RadioButton CountElements T_CLOSING_TAG T_CLOSE_RADIO_GROUP    
        | T_RADIO_GROUP PrimaryAttribute RadioButton CountElements ID T_CLOSING_TAG T_CLOSE_RADIO_GROUP
        | T_RADIO_GROUP PrimaryAttribute RadioButton CountElements CheckedButton T_CLOSING_TAG T_CLOSE_RADIO_GROUP
        | T_RADIO_GROUP PrimaryAttribute RadioButton CountElements ID CheckedButton T_CLOSING_TAG T_CLOSE_RADIO_GROUP
        ;


RadioButton: T_RADIO_BUTTON PrimaryAttribute Text T_CLOSING_TAG
        | T_RADIO_BUTTON PrimaryAttribute Text ID T_CLOSING_TAG
        ;

ProgressBar: T_PROGRESS_BAR PrimaryAttribute T_CLOSING_TAG Progress Max  
        | T_PROGRESS_BAR PrimaryAttribute ID T_CLOSING_TAG 
        | T_PROGRESS_BAR PrimaryAttribute Progress T_CLOSING_TAG
        | T_PROGRESS_BAR PrimaryAttribute Max T_CLOSING_TAG
        | T_PROGRESS_BAR PrimaryAttribute ID Progress T_CLOSING_TAG
        | T_PROGRESS_BAR PrimaryAttribute ID Max T_CLOSING_TAG
        | T_PROGRESS_BAR PrimaryAttribute Progress Max T_CLOSING_TAG
        | T_PROGRESS_BAR PrimaryAttribute ID Progress Max T_CLOSING_TAG
        ;

// 3.2
CountElements: T_A_COUNT_ELEMENTS T_EQUALS T_QUOTE T_POSITIVE_INTEGER T_QUOTE
;

PrimaryAttribute: Height Width
;

Height: T_A_LAYOUT_HEIGHT T_EQUALS Value
;

Width: T_A_LAYOUT_WIDTH T_EQUALS Value
;

ID: T_A_ID T_EQUALS T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Orientation: T_A_ORIENTATION T_EQUALS T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Text: T_A_TEXT T_EQUALS T_QUOTE T_ALPHANUMERIC T_QUOTE
;

TextColour: T_A_TEXT_COLOUR T_EQUALS T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Src: T_A_SRC T_EQUALS T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Padding: T_A_PADDING T_EQUALS T_QUOTE T_POSITIVE_INTEGER T_QUOTE
;

CheckedButton: T_A_CHECKED_BUTTON T_EQUALS T_QUOTE T_ALPHANUMERIC T_QUOTE
;

Progress: T_A_PROGRESS T_EQUALS T_QUOTE T_INTEGER T_QUOTE
;

Max: T_A_MAX T_EQUALS T_QUOTE T_INTEGER T_QUOTE
;

Value: T_QUOTE T_WRAP_CONTENT T_QUOTE
        | T_QUOTE  T_MATCH_PARENT T_QUOTE
        | T_QUOTE  T_POSITIVE_INTEGER T_QUOTE
        ;
%%