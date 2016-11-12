/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     CTE_INT = 259,
     CTE_REAL = 260,
     CTE_STR = 261,
     REPEAT = 262,
     UNTIL = 263,
     IF = 264,
     ENDIF = 265,
     ELSE = 266,
     AND = 267,
     OR = 268,
     NOT = 269,
     WRITE = 270,
     READ = 271,
     INTEGER = 272,
     FLOAT = 273,
     STRING = 274,
     OP_ASIG = 275,
     OP_CONCAT = 276,
     OP_SUMA = 277,
     OP_RESTA = 278,
     OP_POR = 279,
     OP_DIV = 280,
     OP_MEN = 281,
     OP_MENIG = 282,
     OP_MAY = 283,
     OP_MAYIG = 284,
     OP_IG = 285,
     OP_NOIG = 286,
     PAR_AB = 287,
     PAR_CERR = 288,
     CORC_AB = 289,
     CORC_CERR = 290,
     COMA = 291,
     COMILLA = 292,
     PYCOMA = 293,
     DOSPUNTOS = 294,
     GUION = 295,
     BLANCOS = 296,
     LINEA = 297,
     COMENT_AB = 298,
     COMENT_CERR = 299,
     PORCIENTO = 300,
     DECVAR = 301,
     ENDDEC = 302,
     ALIAS = 303,
     BETWEEN = 304
   };
#endif
/* Tokens.  */
#define ID 258
#define CTE_INT 259
#define CTE_REAL 260
#define CTE_STR 261
#define REPEAT 262
#define UNTIL 263
#define IF 264
#define ENDIF 265
#define ELSE 266
#define AND 267
#define OR 268
#define NOT 269
#define WRITE 270
#define READ 271
#define INTEGER 272
#define FLOAT 273
#define STRING 274
#define OP_ASIG 275
#define OP_CONCAT 276
#define OP_SUMA 277
#define OP_RESTA 278
#define OP_POR 279
#define OP_DIV 280
#define OP_MEN 281
#define OP_MENIG 282
#define OP_MAY 283
#define OP_MAYIG 284
#define OP_IG 285
#define OP_NOIG 286
#define PAR_AB 287
#define PAR_CERR 288
#define CORC_AB 289
#define CORC_CERR 290
#define COMA 291
#define COMILLA 292
#define PYCOMA 293
#define DOSPUNTOS 294
#define GUION 295
#define BLANCOS 296
#define LINEA 297
#define COMENT_AB 298
#define COMENT_CERR 299
#define PORCIENTO 300
#define DECVAR 301
#define ENDDEC 302
#define ALIAS 303
#define BETWEEN 304




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

