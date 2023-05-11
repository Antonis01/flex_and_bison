%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Forward declarations */
struct element;
struct linear_attributes;
struct relative_attributes;
struct text_view;
struct image_view;
struct button;
struct radio_group;
struct radio_button;
struct progress_bar;

/* External variables */
extern char* yytext;
extern int yyleng;
extern int yylex();

/* Function prototypes */
void yyerror(const char* msg);
int yyparse();

/* Struct definitions */
struct element {
  text_view | image_view | button | radio_group | radio_button | progress_bar
};

struct linear_attributes {
  
};

struct relative_attributes {
  /* TODO */
};

struct text_view {
  /* TODO */
};

struct image_view {
  /* TODO */
};

struct button {
  /* TODO */
};

struct radio_group {
  /* TODO */
};

struct radio_button {
  /* TODO */
};

struct progress_bar {
  /* TODO */
};

/* Global variables */
struct element* root_element;

%}

%%

root : LinearLayout
        | RelativeLayout
        ;

LinearLayout : linear_attributes '{' elements '}'
        ;

RelativeLayout : relative_attributes '{' elements '}'
        ;

elements : text_view
        | image_view
        | button
        | radio_group
        | progress_bar
        ;

linear_attributes : PrimaryAttributes AndroidID AndroidOrientation
        ;

relative_attributes : PrimaryAttributes AndroidID 
        ;

text_view : PrimaryAttributes AndroidText AndroidID AndroidTextColour
        ;

image_view : PrimaryAttributes AndroidSRC AndroidID AndroidPadding
        ;

button : PrimaryAttributes AndroidText AndroidID AndroidPadding
        ;

radio_group : radio_button AndroidID AndroidCheckButton
        ;

radio_button : PrimaryAttributes AndroidID AndroidText AndroidID
        ;

progress_bar : PrimaryAttributes AndroidID AndroidProgress AndroidMax
        ;

PrimaryAttributes : AndroidHeight AndroidWidth
        ;

AndroidHeight : 'Height :' value
        ;

AndroidWidth : 'Width :' value
        ;

AndroidID : 'ID :' alphanumeric
        ;

AndroidOrientation : 'Orientation :' alphanumeric
        ;

AndroidText : 'Text :' alphanumeric
        ;

AndroidTextColour : 'TextColour :' alphanumeric
        ;

AndroidSRC : 'SRC :' alphanumeric 
        ;

AndroidPadding : 'Padding :' PositiveInteger
        ;

AndroidCheckButton : 'CheckButton :' alphanumeric
        ;

AndroidProgress : 'Progress :' PositiveInteger
        ;

AndroidMax : 'Max :' PositiveInteger
        ;

value : alphanumeric
        | PositiveInteger
        ;

alphanumeric : [a-zA-Z0-9]+
        ;

PositiveInteger : [0-9]+
        ;

%%


