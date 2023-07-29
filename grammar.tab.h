/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_GRAMMAR_TAB_H_INCLUDED
# define YY_YY_GRAMMAR_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    T_ROOT = 258,                  /* T_ROOT  */
    T_CLOSE_ROOT = 259,            /* T_CLOSE_ROOT  */
    T_LINEAR_LAYOUT = 260,         /* T_LINEAR_LAYOUT  */
    T_CLOSE_LINEAR_LAYOUT = 261,   /* T_CLOSE_LINEAR_LAYOUT  */
    T_RELATIVE_LAYOUT = 262,       /* T_RELATIVE_LAYOUT  */
    T_CLOSE_RELATIVE_LAYOUT = 263, /* T_CLOSE_RELATIVE_LAYOUT  */
    T_ELEMENT = 264,               /* T_ELEMENT  */
    T_CLOSE_ELEMENT = 265,         /* T_CLOSE_ELEMENT  */
    T_TEXT_VIEW = 266,             /* T_TEXT_VIEW  */
    T_CLOSE_TEXT_VIEW = 267,       /* T_CLOSE_TEXT_VIEW  */
    T_IMAGE_VIEW = 268,            /* T_IMAGE_VIEW  */
    T_CLOSE_IMAGE_VIEW = 269,      /* T_CLOSE_IMAGE_VIEW  */
    T_BUTTON = 270,                /* T_BUTTON  */
    T_CLOSE_BUTTON = 271,          /* T_CLOSE_BUTTON  */
    T_RADIO_GROUP = 272,           /* T_RADIO_GROUP  */
    T_CLOSE_RADIO_GROUP = 273,     /* T_CLOSE_RADIO_GROUP  */
    T_PROGRESS_BAR = 274,          /* T_PROGRESS_BAR  */
    T_CLOSE_PROGRESS_BAR = 275,    /* T_CLOSE_PROGRESS_BAR  */
    T_LINEAR_ATTRIBUTES = 276,     /* T_LINEAR_ATTRIBUTES  */
    T_CLOSE_LINEAR_ATTRIBUTES = 277, /* T_CLOSE_LINEAR_ATTRIBUTES  */
    T_RELATIVE_ATTRIBUTES = 278,   /* T_RELATIVE_ATTRIBUTES  */
    T_CLOSE_RELATIVE_ATTRIBUTES = 279, /* T_CLOSE_RELATIVE_ATTRIBUTES  */
    T_PRIMARY_ATTRIBUTES = 280,    /* T_PRIMARY_ATTRIBUTES  */
    T_CLOSE_PRIMARY_ATTRIBUTES = 281, /* T_CLOSE_PRIMARY_ATTRIBUTES  */
    T_A_LAYOUT_HEIGHT = 282,       /* T_A_LAYOUT_HEIGHT  */
    T_A_LAYOUT_WIDTH = 283,        /* T_A_LAYOUT_WIDTH  */
    T_A_ID = 284,                  /* T_A_ID  */
    T_A_ORIENTATION = 285,         /* T_A_ORIENTATION  */
    T_A_TEXT = 286,                /* T_A_TEXT  */
    T_A_TEXT_COLOUR = 287,         /* T_A_TEXT_COLOUR  */
    T_A_SRC = 288,                 /* T_A_SRC  */
    T_A_PADDING = 289,             /* T_A_PADDING  */
    T_A_CHECKED_BUTTON = 290,      /* T_A_CHECKED_BUTTON  */
    T_A_PROGRESS = 291,            /* T_A_PROGRESS  */
    T_A_MAX = 292,                 /* T_A_MAX  */
    T_VALUE = 293,                 /* T_VALUE  */
    T_INTEGER = 294,               /* T_INTEGER  */
    T_ALPHANUMERIC = 295,          /* T_ALPHANUMERIC  */
    T_OPEN_ANGLE = 296,            /* T_OPEN_ANGLE  */
    T_CLOSE_ANGLE = 297,           /* T_CLOSE_ANGLE  */
    T_CLOSING_TAG = 298,           /* T_CLOSING_TAG  */
    T_EQUALS = 299,                /* T_EQUALS  */
    T_WHITESPACE = 300,            /* T_WHITESPACE  */
    T_ERROR = 301,                 /* T_ERROR  */
    T_NEWLINE = 302                /* T_NEWLINE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_GRAMMAR_TAB_H_INCLUDED  */
