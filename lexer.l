%{
#include<stdio.h>
#include<string.h>
#include <stdlib.h>
void printToken(const char *token);

typedef enum {
    TOKEN_LINEAR_LAYOUT,
    TOKEN_RELATIVE_LAYOUT,
    TOKEN_TEXT_VIEW,
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
    TOKEN_ID,
    TOKEN_INT,
    TOKEN_VALUE
} Token;

Token yylval;

//helper function that prints the token
void printToken(const char *token){
       printf("Token: %s\n",token);
    }

%}


%%
//regular expressions
alphanumeric ([a-zA-Z0-9])+
positive_integer ([0-9])+



"<AndroidHeight>" {return ANDROID_HEIGHT;} 
"<AndroidWidth>" {return ANDROID_WIDTH;}
"<AndroidID>" {return ANDROID_ID;}
"<AndroidOrientation>" {return ANDROID_ORIENTATION;}
"<AndroidText>" {return ANDROID_TEXT;}
"<AndroidTextColour>" {return ANDROID_TEXT_COLOR;}
"<AndroidSRC>" {return ANDROID_SRC;}
"<AndroidPadding>" {return ANDROID_PADDING;}
"<AndroidCheckedButton>" {return ANDROID_CHECKED_BUTTON;}
"<AndroidProgress>" {return ANDROID_PROGRESS;}
"<AndroidMax>" {return ANDROID_MAX;}
%%

