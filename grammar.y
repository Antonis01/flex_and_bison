%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.h"

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

 
struct LinearLayout {
        struct element* element;
        struct linear_attributes* attributes;
};

struct RelativeLayout {
        struct element* element;
        struct relative_attributes* attributes;
};

struct element {
        char* tag_name;
        struct element* parent;
        struct element* children;
        int num_children;
        struct text_view* text_view;
        struct image_view* image_view;
        struct button* button;
        struct radio_group* radio_group;
        struct progress_bar* progress_bar;
        struct LinearLayout* linear_layout;
        struct RelativeLayout* relative_layout;
};

struct linear_attributes {
        PrimaryAttributes* primary_attributes;
        AndroidID* android_id;
        AndroidOrientation* android_orientation;
};

struct relative_attributes {
        PrimaryAttributes* primary_attributes;
        AndroidID* android_id;
};

struct text_view {
        PrimaryAttributes* primary_attributes;
        AndroidText* android_text;
        AndroidID* android_id;
        AndroidTextColour* android_text_colour;
};

struct image_view {
        PrimaryAttributes* primary_attributes;
        AndroidSRC* android_src;
        AndroidID* android_id;
        AndroidPadding* android_padding;
};

struct button {
        PrimaryAttributes* primary_attributes;
        AndroidText* android_text;
        AndroidID* android_id;
        AndroidPadding* android_padding;
};

struct radio_group {
        struct radio_button* radio_button;
        AndroidID* android_id;
        AndroidCheckButton* android_check_button;
};

struct radio_button {
        PrimaryAttributes* primary_attributes;
        AndroidID* android_id;
        AndroidText* android_text;
        AndroidID* android_id;
};

struct progress_bar {
        PrimaryAttributes* primary_attributes;
        AndroidID* android_id;
        AndroidProgress* android_progress;
        AndroidMax* android_max;
};

/*struct PrimaryAttributes {
        AndroidHeight* android_height;
        AndroidWidth* android_width;
        }; */

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

radio_button : PrimaryAttributes AndroidID AndroidText
        ;

progress_bar : PrimaryAttributes AndroidID AndroidProgress AndroidMax
        ;

PrimaryAttributes : AndroidHeight AndroidWidth
        ;

AndroidHeight: 'Height :' value
        ;

AndroidWidth: 'Width :' value
        ;

AndroidID: 'ID :' alphanumeric
        ;

AndroidOrientation: 'Orientation :' alphanumeric
        ;

AndroidText: 'Text :' alphanumeric
        ;

AndroidTextColour: 'TextColour :' alphanumeric
        ;

AndroidSRC: 'SRC :' alphanumeric 
        ;

AndroidPadding: 'Padding :' PositiveInteger
        ;

AndroidCheckButton: 'CheckButton :' alphanumeric
        ;

AndroidProgress: 'Progress :' PositiveInteger
        ;

AndroidMax: 'Max :' PositiveInteger
        ;

value:    alphanumeric
        | PositiveInteger
        ;

alphanumeric: [a-zA-Z0-9]+
        ;

PositiveInteger: [0-9]+
        ;

%%


