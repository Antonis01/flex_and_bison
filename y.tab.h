/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_LINEAR_LAYOUT = 258,
    T_CLOSE_LINEAR_LAYOUT = 259,
    T_RELATIVE_LAYOUT = 260,
    T_CLOSE_RELATIVE_LAYOUT = 261,
    T_ELEMENT = 262,
    T_LINEAR_ATTRIBUTES = 263,
    T_RELATIVE_ATTRIBUTES = 264,
    T_TEXT_VIEW = 265,
    T_IMAGE_VIEW = 266,
    T_BUTTON = 267,
    T_RADIO_GROUP = 268,
    T_CLOSE_RADIO_GROUP = 269,
    T_RADIO_BUTTON = 270,
    T_PROGRESS_BAR = 271,
    T_PRIMARY_ATTRIBUTE = 272,
    T_A_LAYOUT_HEIGHT = 273,
    T_A_LAYOUT_WIDTH = 274,
    T_A_ID = 275,
    T_A_ORIENTATION = 276,
    T_A_TEXT = 277,
    T_A_TEXT_COLOUR = 278,
    T_A_SRC = 279,
    T_A_PADDING = 280,
    T_A_CHECKED_BUTTON = 281,
    T_A_PROGRESS = 282,
    T_A_MAX = 283,
    T_VALUE = 284,
    T_INTEGER = 285,
    T_ALPHANUMERIC = 286,
    T_OPEN_ANGLE = 287,
    T_CLOSE_ANGLE = 288,
    T_SLASH_CLOSE_ANGLE = 289,
    T_EQUALS = 290,
    T_NEWLINE = 291,
    T_WHITESPACE = 292,
    T_ERROR = 293
  };
#endif
/* Tokens.  */
#define T_LINEAR_LAYOUT 258
#define T_CLOSE_LINEAR_LAYOUT 259
#define T_RELATIVE_LAYOUT 260
#define T_CLOSE_RELATIVE_LAYOUT 261
#define T_ELEMENT 262
#define T_LINEAR_ATTRIBUTES 263
#define T_RELATIVE_ATTRIBUTES 264
#define T_TEXT_VIEW 265
#define T_IMAGE_VIEW 266
#define T_BUTTON 267
#define T_RADIO_GROUP 268
#define T_CLOSE_RADIO_GROUP 269
#define T_RADIO_BUTTON 270
#define T_PROGRESS_BAR 271
#define T_PRIMARY_ATTRIBUTE 272
#define T_A_LAYOUT_HEIGHT 273
#define T_A_LAYOUT_WIDTH 274
#define T_A_ID 275
#define T_A_ORIENTATION 276
#define T_A_TEXT 277
#define T_A_TEXT_COLOUR 278
#define T_A_SRC 279
#define T_A_PADDING 280
#define T_A_CHECKED_BUTTON 281
#define T_A_PROGRESS 282
#define T_A_MAX 283
#define T_VALUE 284
#define T_INTEGER 285
#define T_ALPHANUMERIC 286
#define T_OPEN_ANGLE 287
#define T_CLOSE_ANGLE 288
#define T_SLASH_CLOSE_ANGLE 289
#define T_EQUALS 290
#define T_NEWLINE 291
#define T_WHITESPACE 292
#define T_ERROR 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
