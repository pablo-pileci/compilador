/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



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




/* Copy the first part of user declarations.  */
#line 2 "./Sintactico.y"

	#define YYSTYPE t_simbolo *
	#include <string.h>
	#include "lexico.h"
	#include "ttipos.h"
	FILE *reglas=NULL;
	FILE *intermedia=NULL;
	char error[1000];
	#define CANTVAR 200
	#define _MAXLONGITUD 50


    #define TIPO_ENTERO 0
    #define TIPO_REAL 1
    #define TIPO_STRING 2
    #define ERROR_TIPO 3

	typedef struct  {
	        int pos;
	        char * cad;
	} tElementoPolaca;

	std::vector<tElementoPolaca> tiraPolaca;

	int posActualPolaca = -1,x,inAnd=0,inOr=0,isNot = 0;
	char auxPolaca[10],auxComparador[5];
	struct tpila * pilaPolaca;
	struct tdato dato;

    void insertar_en_polaca(char *);
    void insertar_en_polaca(char *,int,int);
    void escribirPolaca();
    void escribirPolacaPorLinea();
    int validarOperacion(const char*, const char*);
    int getTipo(const char*);

    //**Variables usadas para las declaraciones**//
	char dec_variables[CANTVAR][32];
	int i_variables=0;
	char tipoId[32];
	struct elemento_de_lista* pila;
	FILE *assemblerFile = NULL;
	char outputAssembler[] = "FINAL.ASM";       //archivo generado con el assembler
	char modoAppendText[] = "at";
	FILE *assemblerFilePolacaTemp = NULL;
	char polacaTemp[] = "codigoPolacaTMP";
	char inputTS[] = "ts_bin.dat";                      //tabla de simbolos generada en el Sintactico.y
	char modoLecturaBinario[] = "rb";
	int imprimir = 1;
	char tsTipoCte[] = "Cte";
	char tsTipoCteFloat[] = "CteFloat";
	char tsTipoCteString[] = "CteString";
	t_data tablaDeSimbolo[1000];
	int posicionPolaca = 0;
	char tsTipoInteger[] = "Integer";
	char tsTipoFloat[] = "Float";
	char tsTipoCteInteger[] = "CteInteger";
	char tsTipoString[] = "String";
	char declaracionesAuxFloat[10000];
	char declaracionesAuxString[10000];	
	char e1[250];
	char e2[250];
	int numeroSalto;

	//**Variables usadas para los errores de tipo**//
	int tipoDat;
	int facTipo;
	int termTipo;
	int expTipo;
	int condLiTipo;
	int condLdTipo;
	int compLiTipo;
	int compLdTipo;
	int condTipo;
	int getTipo(char*);



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 282 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  32
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   163

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  50
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  42
/* YYNRULES -- Number of rules.  */
#define YYNRULES  77
/* YYNRULES -- Number of states.  */
#define YYNSTATES  125

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   304

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     6,     8,    10,    12,    15,    17,    19,
      21,    23,    25,    29,    32,    34,    37,    41,    43,    45,
      47,    49,    51,    55,    59,    61,    65,    69,    73,    77,
      79,    81,    83,    87,    91,    95,    97,    99,   101,   103,
     105,   107,   109,   111,   113,   114,   120,   121,   122,   123,
     137,   139,   140,   145,   146,   151,   152,   156,   158,   160,
     162,   166,   168,   170,   172,   174,   176,   178,   180,   182,
     183,   191,   192,   200,   201,   211,   214,   217
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      51,     0,    -1,    54,    52,    -1,    52,    -1,    54,    -1,
      53,    -1,    52,    53,    -1,    60,    -1,    86,    -1,    88,
      -1,    91,    -1,    69,    -1,    46,    55,    47,    -1,    46,
      47,    -1,    56,    -1,    55,    56,    -1,    58,    39,    57,
      -1,    17,    -1,    18,    -1,    19,    -1,    59,    -1,    68,
      -1,    59,    36,    68,    -1,    68,    20,    61,    -1,    63,
      -1,    61,    22,    63,    -1,    61,    23,    63,    -1,    62,
      21,    68,    -1,    62,    21,    67,    -1,    68,    -1,    67,
      -1,    64,    -1,    63,    24,    64,    -1,    63,    25,    64,
      -1,    32,    61,    33,    -1,    68,    -1,    65,    -1,    66,
      -1,    67,    -1,     4,    -1,     5,    -1,     6,    -1,     3,
      -1,    70,    -1,    -1,    48,     3,    71,    45,     3,    -1,
      -1,    -1,    -1,    49,    32,    68,    73,    36,    34,    61,
      74,    38,    61,    75,    35,    33,    -1,    80,    -1,    -1,
      80,    12,    77,    81,    -1,    -1,    80,    13,    78,    81,
      -1,    -1,    14,    79,    80,    -1,    72,    -1,    82,    -1,
      82,    -1,    83,    85,    84,    -1,    61,    -1,    61,    -1,
      28,    -1,    29,    -1,    30,    -1,    31,    -1,    27,    -1,
      26,    -1,    -1,     7,    87,    52,     8,    32,    76,    33,
      -1,    -1,     9,    32,    76,    33,    52,    89,    10,    -1,
      -1,     9,    32,    76,    33,    52,    90,    11,    52,    10,
      -1,    16,    68,    -1,    15,    68,    -1,    15,    67,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   134,   134,   142,   148,   154,   158,   163,   167,   171,
     175,   179,   184,   187,   192,   202,   214,   220,   225,   230,
     236,   241,   245,   250,   259,   264,   276,   287,   294,   302,
     309,   316,   321,   332,   344,   349,   356,   362,   368,   376,
     383,   390,   397,   414,   421,   421,   442,   446,   460,   442,
     478,   479,   479,   482,   482,   495,   495,   500,   504,   508,
     511,   541,   546,   551,   560,   570,   580,   589,   599,   611,
     610,   637,   637,   653,   652,   677,   688,   694
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID", "CTE_INT", "CTE_REAL", "CTE_STR",
  "REPEAT", "UNTIL", "IF", "ENDIF", "ELSE", "AND", "OR", "NOT", "WRITE",
  "READ", "INTEGER", "FLOAT", "STRING", "OP_ASIG", "OP_CONCAT", "OP_SUMA",
  "OP_RESTA", "OP_POR", "OP_DIV", "OP_MEN", "OP_MENIG", "OP_MAY",
  "OP_MAYIG", "OP_IG", "OP_NOIG", "PAR_AB", "PAR_CERR", "CORC_AB",
  "CORC_CERR", "COMA", "COMILLA", "PYCOMA", "DOSPUNTOS", "GUION",
  "BLANCOS", "LINEA", "COMENT_AB", "COMENT_CERR", "PORCIENTO", "DECVAR",
  "ENDDEC", "ALIAS", "BETWEEN", "$accept", "programa", "cuerpo",
  "sentencia", "declaracion", "dec", "lineadeclara", "tipo", "listavar",
  "vars", "asignacion", "exp", "factor_str", "termino", "factor",
  "cte_int", "cte_real", "cte_str", "id", "funcion", "falias", "@1",
  "fbetween", "@2", "@3", "@4", "condiciones", "@5", "@6", "@7", "comp_Li",
  "comp_Ld", "condicion", "cond_Li", "cond_Ld", "comparador", "iteracion",
  "@8", "decision", "@9", "@10", "io", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    50,    51,    51,    51,    52,    52,    53,    53,    53,
      53,    53,    54,    54,    55,    55,    56,    57,    57,    57,
      58,    59,    59,    60,    61,    61,    61,    61,    61,    62,
      62,    63,    63,    63,    64,    64,    64,    64,    64,    65,
      66,    67,    68,    69,    71,    70,    73,    74,    75,    72,
      76,    77,    76,    78,    76,    79,    76,    76,    80,    81,
      82,    83,    84,    85,    85,    85,    85,    85,    85,    87,
      86,    89,    88,    90,    88,    91,    91,    91
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     2,     1,     1,     1,     2,     1,     1,     1,
       1,     1,     3,     2,     1,     2,     3,     1,     1,     1,
       1,     1,     3,     3,     1,     3,     3,     3,     3,     1,
       1,     1,     3,     3,     3,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     0,     5,     0,     0,     0,    13,
       1,     0,     4,     0,     4,     0,     3,     1,     1,     1,
       3,     1,     1,     1,     1,     1,     1,     1,     1,     0,
       7,     0,     7,     0,     9,     2,     2,     2
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    42,    69,     0,     0,     0,     0,     0,     0,     3,
       5,     4,     7,     0,    11,    43,     8,     9,    10,     0,
       0,    41,    77,    76,    75,    13,     0,    14,     0,    20,
      21,    44,     1,     6,     2,     0,     0,    39,    40,    55,
       0,     0,    61,     0,    24,    31,    36,    37,    38,    35,
      57,     0,    50,    58,     0,    12,    15,     0,     0,     0,
      23,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    51,    53,    68,    67,    63,    64,    65,    66,     0,
      17,    18,    19,    16,    22,     0,     0,    56,    34,    46,
      25,    38,    35,    26,    28,    27,    32,    33,    71,     0,
       0,    62,    60,    45,     0,     0,     0,     0,    52,    59,
      54,    70,     0,    72,     0,     0,     0,    47,    74,     0,
       0,    48,     0,     0,    49
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     8,     9,    10,    11,    26,    27,    83,    28,    29,
      12,    42,    43,    44,    45,    46,    47,    48,    13,    14,
      15,    59,    50,   105,   119,   122,    51,    99,   100,    62,
      52,   108,    53,    54,   102,    79,    16,    19,    17,   106,
     107,    18
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -31
static const yytype_int8 yypact[] =
{
      11,   -31,   -31,   -17,     1,    16,     3,    18,    32,   115,
     -31,   115,   -31,    23,   -31,   -31,   -31,   -31,   -31,   115,
      34,   -31,   -31,   -31,   -31,   -31,     8,   -31,    12,    31,
     -31,   -31,   -31,   -31,   115,    75,    26,   -31,   -31,   -31,
      75,    15,     2,    35,    28,   -31,   -31,   -31,    63,    70,
     -31,    61,    64,   -31,   106,   -31,   -31,    27,    16,    53,
       2,    68,    75,   -10,    16,    75,    75,     1,    75,    75,
     115,   -31,   -31,   -31,   -31,   -31,   -31,   -31,   -31,    75,
     -31,   -31,   -31,   -31,   -31,    99,    34,   -31,   -31,   -31,
      28,   -31,   -31,    28,   -31,   -31,   -31,   -31,    90,    75,
      75,     2,   -31,   -31,    71,    67,   104,   112,   -31,   -31,
     -31,   -31,    81,   -31,   115,    75,   110,     2,   -31,    83,
      75,     2,    92,    95,   -31
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -31,   -31,    -2,    -6,   -31,   -31,   103,   -31,   -31,   -31,
     -31,   -30,   -31,    21,    20,   -31,   -31,     4,    -4,   -31,
     -31,   -31,   -31,   -31,   -31,   -31,    54,   -31,   -31,   -31,
      77,    41,     9,   -31,   -31,   -31,   -31,   -31,   -31,   -31,
     -31,   -31
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -74
static const yytype_int8 yytable[] =
{
      23,    24,    30,    33,     1,    60,     1,    21,    22,    34,
      63,     1,    65,    66,     1,    20,    49,    36,     2,     1,
       3,    31,    30,    88,    65,    66,     4,     5,    33,     1,
      33,    49,    32,     2,    61,     3,    49,     1,    37,    38,
      21,     4,     5,    35,    80,    81,    82,    64,    39,   101,
      25,    57,    68,    69,    84,    55,    67,     6,    49,     7,
      89,    92,    92,    95,    92,    92,    40,    58,    98,    91,
      91,    94,    91,    91,     7,    49,    71,    72,     1,    37,
      38,    21,    49,    41,   -30,   117,    90,    93,    96,    97,
     121,   -29,    33,     1,    70,    49,    49,     2,    85,     3,
      86,   -73,   103,   112,   111,     4,     5,    40,   109,   109,
      33,    49,   116,     1,   113,   115,    49,     2,     1,     3,
     118,   120,     2,   114,     3,     4,     5,   123,   124,    56,
       4,     5,    73,    74,    75,    76,    77,    78,     7,    87,
     104,   110,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     7,     0,
       0,     0,     0,     7
};

static const yytype_int8 yycheck[] =
{
       4,     5,     6,     9,     3,    35,     3,     6,     4,    11,
      40,     3,    22,    23,     3,    32,    20,    19,     7,     3,
       9,     3,    26,    33,    22,    23,    15,    16,    34,     3,
      36,    35,     0,     7,     8,     9,    40,     3,     4,     5,
       6,    15,    16,    20,    17,    18,    19,    32,    14,    79,
      47,    39,    24,    25,    58,    47,    21,    46,    62,    48,
      64,    65,    66,    67,    68,    69,    32,    36,    70,    65,
      66,    67,    68,    69,    48,    79,    12,    13,     3,     4,
       5,     6,    86,    49,    21,   115,    65,    66,    68,    69,
     120,    21,    98,     3,    33,    99,   100,     7,    45,     9,
      32,    11,     3,    36,    33,    15,    16,    32,    99,   100,
     116,   115,   114,     3,    10,    34,   120,     7,     3,     9,
      10,    38,     7,    11,     9,    15,    16,    35,    33,    26,
      15,    16,    26,    27,    28,    29,    30,    31,    48,    62,
      86,   100,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    48,    -1,
      -1,    -1,    -1,    48
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     7,     9,    15,    16,    46,    48,    51,    52,
      53,    54,    60,    68,    69,    70,    86,    88,    91,    87,
      32,     6,    67,    68,    68,    47,    55,    56,    58,    59,
      68,     3,     0,    53,    52,    20,    52,     4,     5,    14,
      32,    49,    61,    62,    63,    64,    65,    66,    67,    68,
      72,    76,    80,    82,    83,    47,    56,    39,    36,    71,
      61,     8,    79,    61,    32,    22,    23,    21,    24,    25,
      33,    12,    13,    26,    27,    28,    29,    30,    31,    85,
      17,    18,    19,    57,    68,    45,    32,    80,    33,    68,
      63,    67,    68,    63,    67,    68,    64,    64,    52,    77,
      78,    61,    84,     3,    76,    73,    89,    90,    81,    82,
      81,    33,    36,    10,    11,    34,    52,    61,    10,    74,
      38,    61,    75,    35,    33
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 135 "./Sintactico.y"
    {

			fprintf(reglas, "0 ");
			escribirTS();
			escribirPolaca();
			generarAssembler();
		}
    break;

  case 3:
#line 142 "./Sintactico.y"
    {
			fprintf(reglas, "1 ");
			escribirTS();
			escribirPolaca();
			generarAssembler();
		}
    break;

  case 4:
#line 148 "./Sintactico.y"
    {
			fprintf(reglas, "2 ");
			escribirTS();
			generarAssembler();
		}
    break;

  case 5:
#line 154 "./Sintactico.y"
    {
			fprintf(reglas, "3 ");
		}
    break;

  case 6:
#line 159 "./Sintactico.y"
    {
			fprintf(reglas, "4 ");
		}
    break;

  case 7:
#line 164 "./Sintactico.y"
    {
			fprintf(reglas, "5 ");
		}
    break;

  case 8:
#line 168 "./Sintactico.y"
    {
			fprintf(reglas, "6 ");
		}
    break;

  case 9:
#line 172 "./Sintactico.y"
    {
			fprintf(reglas, "7 ");
		}
    break;

  case 10:
#line 176 "./Sintactico.y"
    {
			fprintf(reglas, "8 ");
		}
    break;

  case 11:
#line 180 "./Sintactico.y"
    {
			fprintf(reglas, "9 ");
		}
    break;

  case 12:
#line 185 "./Sintactico.y"
    {
			fprintf(reglas, "10 ");
		}
    break;

  case 13:
#line 188 "./Sintactico.y"
    {
			fprintf(reglas, "11 ");
		}
    break;

  case 14:
#line 193 "./Sintactico.y"
    {
        	fprintf(reglas, "12 ");
            int i=0;
			while(i_variables > i){
				agregarTipo(dec_variables[i],tipoId);
				i++;
			}
			i_variables = 0;
        }
    break;

  case 15:
#line 203 "./Sintactico.y"
    {
            	fprintf(reglas, "13 ");
                int i=0;
                while(i_variables > i){
                    agregarTipo(dec_variables[i],tipoId);
                    i++;
                }
                i_variables = 0;
            }
    break;

  case 16:
#line 215 "./Sintactico.y"
    {
			fprintf(reglas, "14 ");
		}
    break;

  case 17:
#line 221 "./Sintactico.y"
    {
			fprintf(reglas, "15 ");
			strcpy(tipoId,"Integer");
		}
    break;

  case 18:
#line 226 "./Sintactico.y"
    {
			fprintf(reglas, "16 ");
			strcpy(tipoId,"Float");
		}
    break;

  case 19:
#line 231 "./Sintactico.y"
    {
			fprintf(reglas, "17 ");
			strcpy(tipoId,"String");
		}
    break;

  case 20:
#line 237 "./Sintactico.y"
    {
			fprintf(reglas, "18 ");
		}
    break;

  case 21:
#line 242 "./Sintactico.y"
    {
			fprintf(reglas, "19 ");
		}
    break;

  case 22:
#line 246 "./Sintactico.y"
    {
			fprintf(reglas, "20	");
		}
    break;

  case 23:
#line 251 "./Sintactico.y"
    {
			fprintf(reglas, "21 ");
			insertar_en_polaca((yyvsp[(1) - (3)])->nombre);
			strcpy(auxPolaca,":=");
			insertar_en_polaca(auxPolaca);
			verificarTipo('A', getTipo((yyvsp[(1) - (3)])->tipo), expTipo,linea);
		}
    break;

  case 24:
#line 260 "./Sintactico.y"
    {
			fprintf(reglas, "22 ");
			expTipo=termTipo;
        }
    break;

  case 25:
#line 265 "./Sintactico.y"
    {
			fprintf(reglas, "23 ");
			strcpy(auxPolaca,"+");
			insertar_en_polaca(auxPolaca);
			if (expTipo == TIPO_STRING || termTipo == TIPO_STRING){
				sprintf(error,"Operación no válida para strings");
				yyerror(error);
			}
			expTipo=verificarTipo('+', expTipo, termTipo,linea);

		}
    break;

  case 26:
#line 277 "./Sintactico.y"
    {
			fprintf(reglas, "24 ");
			strcpy(auxPolaca,"-");
			insertar_en_polaca(auxPolaca);
			if (expTipo == TIPO_STRING || termTipo == TIPO_STRING){
				sprintf(error,"Operación no válida para strings");
				yyerror(error);
			}
			expTipo=verificarTipo('-', expTipo, termTipo,linea);
		}
    break;

  case 27:
#line 287 "./Sintactico.y"
    {
			fprintf(reglas, "25 ");
			insertar_en_polaca((yyvsp[(3) - (3)])->nombre);
			strcpy(auxPolaca,"++");
			insertar_en_polaca(auxPolaca);
			expTipo=verificarTipo('C', facTipo, getTipo((yyvsp[(3) - (3)])->tipo),linea);
		}
    break;

  case 28:
#line 294 "./Sintactico.y"
    {
			fprintf(reglas, "25b ");
			strcpy(auxPolaca,"++");
			insertar_en_polaca(auxPolaca);
			expTipo=verificarTipo('C', facTipo, TIPO_STRING,linea);
		}
    break;

  case 29:
#line 303 "./Sintactico.y"
    {
			fprintf(reglas, "30b ");
			insertar_en_polaca((yyvsp[(1) - (1)])->nombre);
			facTipo=tipoDat;

		}
    break;

  case 30:
#line 310 "./Sintactico.y"
    {
			fprintf(reglas, "33b ");
			insertar_en_polaca((yyvsp[(1) - (1)])->nombre);
            facTipo=TIPO_STRING;
		}
    break;

  case 31:
#line 317 "./Sintactico.y"
    {
			fprintf(reglas, "26 ");
			termTipo=facTipo;
		}
    break;

  case 32:
#line 322 "./Sintactico.y"
    {
			fprintf(reglas, "27 ");
			strcpy(auxPolaca,"*");
			insertar_en_polaca(auxPolaca);
			if (termTipo == TIPO_STRING || facTipo == TIPO_STRING){
				sprintf(error,"Operación no válida para strings");
				yyerror(error);
			}
			termTipo=verificarTipo('*', termTipo, facTipo,linea);
		}
    break;

  case 33:
#line 333 "./Sintactico.y"
    {
			fprintf(reglas, "28 ");
			strcpy(auxPolaca,"/");
			insertar_en_polaca(auxPolaca);
			if (termTipo == TIPO_STRING || facTipo == TIPO_STRING){
				sprintf(error,"Operación no válida para strings");
				yyerror(error);
			}
            termTipo=verificarTipo('/', termTipo, facTipo,linea);
		}
    break;

  case 34:
#line 345 "./Sintactico.y"
    {
			fprintf(reglas, "29 ");

		}
    break;

  case 35:
#line 350 "./Sintactico.y"
    {
			fprintf(reglas, "30 ");
			insertar_en_polaca((yyvsp[(1) - (1)])->nombre);
			facTipo=tipoDat;

		}
    break;

  case 36:
#line 357 "./Sintactico.y"
    {
			fprintf(reglas, "31 ");
			insertar_en_polaca((yyvsp[(1) - (1)])->nombre);
			facTipo=TIPO_ENTERO;
		}
    break;

  case 37:
#line 363 "./Sintactico.y"
    {
			fprintf(reglas, "32 ");
			insertar_en_polaca((yyvsp[(1) - (1)])->nombre);
			facTipo=TIPO_REAL;
		}
    break;

  case 38:
#line 369 "./Sintactico.y"
    {
			fprintf(reglas, "33 ");
			insertar_en_polaca((yyvsp[(1) - (1)])->nombre);
            facTipo=TIPO_STRING;
		}
    break;

  case 39:
#line 377 "./Sintactico.y"
    {
            char aux[32];
			sprintf(aux,"_%s",yytext);
            agregarTipo(aux,"CteInteger");
		}
    break;

  case 40:
#line 384 "./Sintactico.y"
    {
            char aux[32];
			sprintf(aux,"_%s",yytext);
            agregarTipo(aux,"CteFloat");
		}
    break;

  case 41:
#line 391 "./Sintactico.y"
    {
            char aux[32];
			sprintf(aux,"_%s",yytext);
            agregarTipo(aux,"CteString");
	    }
    break;

  case 42:
#line 398 "./Sintactico.y"
    {   t_simbolo *auxt;
            if(declarando){
				strcpy(dec_variables[i_variables++], yytext);
			}
			else{
				if (buscarEnTS((yyvsp[(1) - (1)])->nombre) == -1){
	                    sprintf(error,"Identificador \"%s\" no declarado",(yyvsp[(1) - (1)])->nombre);
	                    yyerror(error);
				}
				
			}
			expTipo=tipoDat;
			tipoDat= getTipo(((yyvsp[(1) - (1)]))->tipo);

		}
    break;

  case 43:
#line 415 "./Sintactico.y"
    {
			fprintf(reglas, "34 ");
		}
    break;

  case 44:
#line 421 "./Sintactico.y"
    {

	if ((yyvsp[(2) - (2)])->alias != NULL && strcmp((yyvsp[(2) - (2)])->alias," ") != 0 && (yyvsp[(2) - (2)])->busquedaAlias == 1 ){
					sprintf(error,"Alias \"%s\" ya definido",(yyvsp[(2) - (2)])->alias);
					yyerror(error);
			}

			if (buscarEnTS((yyvsp[(2) - (2)])->nombre) != -1 && (yyvsp[(2) - (2)])->busquedaAlias == 0){
					sprintf(error,"Identificador \"%s\" ya definido",(yyvsp[(2) - (2)])->nombre);
					yyerror(error);
			}

}
    break;

  case 45:
#line 434 "./Sintactico.y"
    {
			if (buscarEnTS((yyvsp[(5) - (5)])->nombre) == -1){
				sprintf(error,"Identificador \"%s\" no declarado",yytext);
				yyerror(error);
			}
			guardarAlias((yyvsp[(5) - (5)])->nombre,(yyvsp[(2) - (5)])->nombre);
		}
    break;

  case 46:
#line 442 "./Sintactico.y"
    {
	insertar_en_polaca((yyvsp[(3) - (3)])->nombre);
}
    break;

  case 47:
#line 446 "./Sintactico.y"
    {
				dato.clave = posActualPolaca+2;
				dato.inAnd = 0;
				apilar(pilaPolaca,dato);

				strcpy(auxPolaca,"CMP");
				insertar_en_polaca(auxPolaca);
				strcpy(auxPolaca,"");
				insertar_en_polaca(auxPolaca);
				strcpy(auxComparador,"JBE");
				insertar_en_polaca(auxComparador);
				insertar_en_polaca((yyvsp[(3) - (7)])->nombre);

}
    break;

  case 48:
#line 460 "./Sintactico.y"
    {
				dato.clave = posActualPolaca+2;
				dato.inAnd = 1;
				apilar(pilaPolaca,dato);
				strcpy(auxPolaca,"CMP");
				insertar_en_polaca(auxPolaca);
				strcpy(auxPolaca,"");
				insertar_en_polaca(auxPolaca);
				strcpy(auxComparador,"JAE");
				insertar_en_polaca(auxComparador);
	}
    break;

  case 49:
#line 473 "./Sintactico.y"
    {
			fprintf(reglas, "37 ");

		}
    break;

  case 51:
#line 479 "./Sintactico.y"
    {
		inAnd=1;
	}
    break;

  case 53:
#line 482 "./Sintactico.y"
    {
			inOr = 1;
			strcpy(auxPolaca,"");
			insertar_en_polaca(auxPolaca);
			strcpy(auxPolaca,"JMP");
			insertar_en_polaca(auxPolaca);
			dato = desapilar(pilaPolaca);
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);

			dato.clave = posActualPolaca-1;
			dato.inAnd = 0;
			apilar(pilaPolaca,dato);
	}
    break;

  case 55:
#line 495 "./Sintactico.y"
    {isNot = 1;}
    break;

  case 56:
#line 496 "./Sintactico.y"
    {
			verificarTipo('!', compLiTipo, compLiTipo,linea);

		}
    break;

  case 58:
#line 504 "./Sintactico.y"
    { compLiTipo=condTipo;

		}
    break;

  case 59:
#line 508 "./Sintactico.y"
    { compLdTipo=condTipo;

		}
    break;

  case 60:
#line 511 "./Sintactico.y"
    {
			if (inAnd == 1){
				dato.clave = posActualPolaca+2;
				dato.inAnd = 1;
				apilar(pilaPolaca,dato);
				inAnd = 0;
			}
			else if (inOr == 1){
				dato = desapilar(pilaPolaca);
				snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 4);
				inOr = 0;

				dato.clave = posActualPolaca+2;
				dato.inAnd = 0;
				apilar(pilaPolaca,dato);
			}
			else{
				dato.clave = posActualPolaca+2;
				dato.inAnd = 0;
				apilar(pilaPolaca,dato);
			}
			strcpy(auxPolaca,"CMP");
			insertar_en_polaca(auxPolaca);
			strcpy(auxPolaca,"");
			insertar_en_polaca(auxPolaca);
			insertar_en_polaca(auxComparador);
			verificarTipo('C', condLiTipo, condLdTipo,linea);
			condTipo=condLiTipo;
			}
    break;

  case 61:
#line 541 "./Sintactico.y"
    { 
		condLiTipo=expTipo;
		   }
    break;

  case 62:
#line 546 "./Sintactico.y"
    { condLdTipo=expTipo;
		   }
    break;

  case 63:
#line 551 "./Sintactico.y"
    {
	if (isNot == 0){
		strcpy(auxComparador,"JBE");
	}
	else{
		strcpy(auxComparador,"JA");
	}
	isNot = 0;
}
    break;

  case 64:
#line 560 "./Sintactico.y"
    {
		if (isNot == 0){
			strcpy(auxComparador,"JB");
		}
		else{
			strcpy(auxComparador,"JAE");
		}
		isNot = 0;

	}
    break;

  case 65:
#line 570 "./Sintactico.y"
    {
		if (isNot == 0){
			strcpy(auxComparador,"JNE");
		}
		else{
			strcpy(auxComparador,"JE");
		}
		isNot = 0;

	}
    break;

  case 66:
#line 580 "./Sintactico.y"
    {
		if (isNot == 0){
			strcpy(auxComparador,"JE");
		}
		else{
			strcpy(auxComparador,"JNE");
		}
		isNot = 0;
	}
    break;

  case 67:
#line 589 "./Sintactico.y"
    {
		if (isNot == 0){
			strcpy(auxComparador,"JA");
		}
		else{
			strcpy(auxComparador,"JBE");
		}
		isNot = 0;

	}
    break;

  case 68:
#line 599 "./Sintactico.y"
    {
		if (isNot == 0){
			strcpy(auxComparador,"JAE");
		}
		else{
			strcpy(auxComparador,"JB");
		}
		isNot = 0;
	}
    break;

  case 69:
#line 611 "./Sintactico.y"
    {
			dato.clave = posActualPolaca+1;
			dato.inAnd = 0;
			apilar(pilaPolaca,dato);
}
    break;

  case 70:
#line 617 "./Sintactico.y"
    {

        	dato = desapilar(pilaPolaca);
        	snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 3);

			if (dato.inAnd == 1){
				dato = desapilar(pilaPolaca);
				snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 3);
			}

        	dato = desapilar(pilaPolaca);
			snprintf(auxPolaca, 10, "%d", dato.clave);
        	insertar_en_polaca(auxPolaca);

			strcpy(auxPolaca,"JMP");
			insertar_en_polaca(auxPolaca);

			fprintf(reglas, "44 ");
        }
    break;

  case 71:
#line 637 "./Sintactico.y"
    {

			dato = desapilar(pilaPolaca);
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);
			if (dato.inAnd == 1){
				dato = desapilar(pilaPolaca);
				snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);
			}



}
    break;

  case 72:
#line 649 "./Sintactico.y"
    {
			fprintf(reglas, "45 ");
		}
    break;

  case 73:
#line 653 "./Sintactico.y"
    {
			fprintf(reglas, "46 ");

			dato = desapilar(pilaPolaca);
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 3);
			if (dato.inAnd == 1){
				dato = desapilar(pilaPolaca);
				snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 3);
			}
			dato.clave = posActualPolaca+1;
			dato.inAnd = 0;
			apilar(pilaPolaca,dato);
			strcpy(auxPolaca,"");
			insertar_en_polaca(auxPolaca);
			strcpy(auxPolaca,"JMP");
			insertar_en_polaca(auxPolaca);

		}
    break;

  case 74:
#line 672 "./Sintactico.y"
    {
			dato = desapilar(pilaPolaca);
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);
		}
    break;

  case 75:
#line 678 "./Sintactico.y"
    {
			fprintf(reglas, "47 ");
			insertar_en_polaca((yyvsp[(2) - (2)])->nombre);
			strcpy(auxPolaca,"READ");
			insertar_en_polaca(auxPolaca);
			if (getTipo((yyvsp[(2) - (2)])->tipo) != TIPO_STRING){
				sprintf(error,"Identificador \"%s\" en READ debe ser string",(yyvsp[(2) - (2)])->nombre);
	            yyerror(error);
			}
		}
    break;

  case 76:
#line 689 "./Sintactico.y"
    {
			insertar_en_polaca((yyvsp[(2) - (2)])->nombre);
			strcpy(auxPolaca,"WRITE");
			insertar_en_polaca(auxPolaca);
		}
    break;

  case 77:
#line 695 "./Sintactico.y"
    {
			fprintf(reglas, "49 ");
			insertar_en_polaca((yyvsp[(2) - (2)])->nombre);
			strcpy(auxPolaca,"WRITE");
			insertar_en_polaca(auxPolaca);
		}
    break;


/* Line 1267 of yacc.c.  */
#line 2372 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 701 "./Sintactico.y"



//=========================================================

int main(int argc,char *argv[])
{

	if ((yyin = fopen(argv[1], "rt")) == NULL)
	{
		printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
	}
	else
	{

		if ((reglas  = fopen("reglas.txt",  "w")) == NULL)
		{
			printf("\nNo se puede crear el archivo reglas.txt\n");
		}
		else
		{
			crearPila(&pilaPolaca);
			cargarTablaSintesis();
			while(!feof(yyin))
			{
				yyparse();
            }

			fclose(yyin);
			fclose(reglas);

		}
	}

}

//sino se define yyerror tira error bison
int yyerror(const char * msj) {
	printf("ERROR: %s; linea nro: %d\n", msj, linea);
	exit(-1);
}

void insertar_en_polaca(char * cadena) {
	if (declarando == 0){
		tElementoPolaca * elementoAInsertar = (tElementoPolaca *) malloc (sizeof (tElementoPolaca));
		elementoAInsertar->cad = (char *) malloc ((30+1) * sizeof(char));
		strcpy(elementoAInsertar->cad,cadena);
		elementoAInsertar->pos = ++posActualPolaca;
		tiraPolaca.push_back(*elementoAInsertar);
	}
}

void escribirPolaca() {
	if ((intermedia  = fopen("intermedia.txt",  "w")) == NULL){
			printf("\nNo se puede crear el archivo intermedia.txt\n");
	}
	else {
		for (std::vector<tElementoPolaca>::iterator it = tiraPolaca.begin() ; it != tiraPolaca.end(); ++it){
			fprintf(intermedia, "%s||",it->cad);
		}
    	fclose(intermedia);
	}
}

void escribirPolacaPorLinea() {
	if ((intermedia  = fopen("intermedia.txt",  "w")) == NULL){
			printf("\nNo se puede crear el archivo intermedia.txt\n");
	}
	else {
		int i = 0;
		for (std::vector<tElementoPolaca>::iterator it = tiraPolaca.begin() ; it != tiraPolaca.end(); ++it){
			fprintf(intermedia, "%d - %s \n",i,it->cad);
			i++;

		}
    	fclose(intermedia);
	}
}

int getTipo(char*t)
{
	int tipo = 3;
    if(strcmp(t,"Integer")==0)
        tipo = TIPO_ENTERO;
    if(strcmp(t,"Float")==0)
        tipo = TIPO_REAL;
    if(strcmp(t,"String")==0)
        tipo = TIPO_STRING;
	return tipo;
}

void generarAssembler()
{
	/***** PARA SACAR ESTOS 2 METODOS A CONTINUACION DESDE LA GCI TENDRIA QUE VENIR LA TS Y LA TIRA POLACA CON EL _ADELANTE **********/
	// Leo la TS y modifico los nombres de las variables.
	cargarTablaSimboloYModificarNombres();
	//Leo la polaca y modifico los nombres de las variables
	//modificarNombresIntermedia();
	/**********************************************************************************************************************************/

	pila = NULL;

	//remove(outputAssembler);
	//remove(assemblerFilePolacaTemp);

	//genero assembler en variable temporal
	escribirAssembler();

	//Armado de archivo final
	assemblerFile = openFilePolaca(outputAssembler, modoAppendText);

	agregarCabecera();
	agregarDeclaracion();
	agregarFunciones();
	insertarAssemblerPolacaEnAssemblerFinal();
	agregarFin();

	fclose(assemblerFile);
	fclose(assemblerFilePolacaTemp);
	remove(polacaTemp);

	printf("FIN\n");
	imprimir_pila(pila);
	getchar();
}

void cargarTablaSimboloYModificarNombres()
{
	t_data tsData;
	FILE *tsReadFile = openFilePolaca(inputTS, modoLecturaBinario); //entrada ts_bin.dat 
	int i = 0;
	if (imprimir == 1) { printf("TABLA DE SIMBOLOS: \n"); printf(" Nombre || Tipo \t|| Longitud  \t|| Valor \t\n"); }

	fread(&tsData, sizeof(t_data), 1, tsReadFile);
	while (feof(tsReadFile) == 0)
	{
		//por cada uno agregar cambiar "." y " " por _
		if (strcmp(tsData.tipo, tsTipoCteString) == 0 || strcmp(tsData.tipo, tsTipoCteFloat) == 0)
		{
			renameSimbolo(tsData.nombre);
		}

		tablaDeSimbolo[i] = tsData; //guardo la TS

		if (imprimir == 1){ printf(" %s \t|| %s \t|| %d  \t|| %s \t\n", tsData.nombre, tsData.tipo, tsData.longitud, tsData.valor); }

		fread(&tsData, sizeof(t_data), 1, tsReadFile);
		i++;
	}
	fclose(tsReadFile);
}

void escribirAssembler()
{
	assemblerFilePolacaTemp = openFilePolaca(polacaTemp, "w");
	posicionPolaca = 0;
	for (std::vector<tElementoPolaca>::iterator it = tiraPolaca.begin() ; it != tiraPolaca.end(); ++it){
			procesar(it->cad);
			posicionPolaca++;
	}
	fclose(assemblerFilePolacaTemp);
}

void agregarCabecera()
{
	fprintf(assemblerFile, ".MODEL LARGE ;\n");
	fprintf(assemblerFile, ".386 ;\n");
	fprintf(assemblerFile, ".STACK 200h ;\n\n");
}

void agregarDeclaracion()
{
	t_data auxData;

	//variable usada para guardar los tipos de datos assembler
	char tipo[3] = "";

	fprintf(assemblerFile, "\n");
	fprintf(assemblerFile, ".DATA\n");
	fprintf(assemblerFile, "\tMAXTEXTSIZE EQU 50\n");
	fprintf(assemblerFile, "\tmsgPRESIONE DB 0DH,0AH, \"presione una tecla para continuar...\" ,'$'\n");
	fprintf(assemblerFile, "\tNEWLINE    DB 0Dh,0Ah,'$'\n");
	fprintf(assemblerFile, "\tPUNTO       DB \".$\"\n");
	fprintf(assemblerFile, "\tGUION       DB \"-\" ,'$'\n");
	//se declara una cte para el incremento y decremento
	fprintf(assemblerFile, "\t&1    dd   1\n");
	//se declara una cte para la inicializacion
	fprintf(assemblerFile, "\t&0    dd   0\n");	//se declaran auxiliares para resultado de condiciones
	fprintf(assemblerFile, "\t_&leftCond     dd    0 \n");
	fprintf(assemblerFile, "\t_&rightCond    dd    0 \n");
	//se declaran auxiliares para el display
	fprintf(assemblerFile, "\t&cad1 db 30 dup (?),'$'\n");
	fprintf(assemblerFile, "\t&cad2 db 30 dup (?),'$'\n");
	fprintf(assemblerFile, "\t&inc_aux dd ? \n");
	fprintf(assemblerFile, "\t&aux_f dd 1000 \n");
	fprintf(assemblerFile, "\t&aux_prec dd 100000 \n");
	fprintf(assemblerFile, "\t&auxN dd 0 \n");
	fprintf(assemblerFile, "\taux_trunc dd 0 \n");
	fprintf(assemblerFile, "\ttruncn dw 0 \n");
	fprintf(assemblerFile, "\ttruncv dw 0 \n");

	int i = 0;
	while (i < 1000 && strcmp(tablaDeSimbolo[i].nombre, "") != 0)
	{
		if (strcmp(tablaDeSimbolo[i].tipo, tsTipoInteger) == 0 || strcmp(tablaDeSimbolo[i].tipo, tsTipoFloat) == 0)
		{
			strcpy(tipo, "DD");
			fprintf(assemblerFile, "\t%s \t %s \t ? \n", tablaDeSimbolo[i].nombre, tipo);
		}
		else if (strcmp(tablaDeSimbolo[i].tipo, tsTipoCteInteger) == 0 || strcmp(tablaDeSimbolo[i].tipo, tsTipoCteFloat) == 0)
		{
			strcpy(tipo, "DD");
			fprintf(assemblerFile, "\t%s \t %s \t %s  \n", tablaDeSimbolo[i].nombre, tipo, tablaDeSimbolo[i].valor);
		}
		//strings
		else if ((strcmp(tablaDeSimbolo[i].tipo, tsTipoCteString) == 0) || (strcmp(tablaDeSimbolo[i].tipo, tsTipoString) == 0))
		{
			strcpy(tipo, "DB");
			if (strncmp(tablaDeSimbolo[i].tipo, tsTipoCte, 3) == 0)
			{
				fprintf(assemblerFile, "\t%s \t %s \t \"%s\" , %d dup('$') \n", tablaDeSimbolo[i].nombre, tipo, tablaDeSimbolo[i].valor, _MAXLONGITUD);
			}
			else
			{
				fprintf(assemblerFile, "\t%s \t %s \t %d dup('$') \n", tablaDeSimbolo[i].nombre, tipo, _MAXLONGITUD);
			}
		}

		i++;
	}

	char *aux;
	aux = strtok(declaracionesAuxFloat, ",");
	while (aux != NULL)
	{
		fprintf(assemblerFile, "\t%s \t DD \t 0.0 \n", aux);
		aux = strtok(NULL, ",");
	}

	aux = strtok(declaracionesAuxString, ",");
	while (aux != NULL)
	{
		fprintf(assemblerFile, "\t%s \t DB \t %d dup('$') \n", aux, _MAXLONGITUD);
		aux = strtok(NULL, ",");
	}
}

void agregarFunciones()
{
	//zona de codigo
	fprintf(assemblerFile, "\n\n .CODE ; Zona de codigo\n\n");

	fprintf(assemblerFile, "\t ;***STRLEN***\n");
	fprintf(assemblerFile, "\t STRLEN PROC\n");
	fprintf(assemblerFile, "\t\t mov bx,0\n");
	fprintf(assemblerFile, "\t\t STRL:\n");
	fprintf(assemblerFile, "\t\t\t cmp BYTE PTR [SI+BX],\"$\"\n");
	fprintf(assemblerFile, "\t\t\t je STREND\n");
	fprintf(assemblerFile, "\t\t\t inc BX\n");
	fprintf(assemblerFile, "\t\t\t jmp STRL\n");
	fprintf(assemblerFile, "\t\t STREND:\n");
	fprintf(assemblerFile, "\t\t\t ret\n");
	fprintf(assemblerFile, "\t STRLEN ENDP \n\n");

	fprintf(assemblerFile, "\t ;***COPIAR***\n");
	fprintf(assemblerFile, "\t COPIAR PROC\n");
	fprintf(assemblerFile, "\t	call STRLEN  ;***STRLEN***\n");
	fprintf(assemblerFile, "\t\t\t cmp bx,MAXTEXTSIZE\n");
	fprintf(assemblerFile, "\t\t\t jle COPIARSIZEOK\n");
	fprintf(assemblerFile, "\t\t\t mov bx,MAXTEXTSIZE\n");
	fprintf(assemblerFile, "\t\t COPIARSIZEOK:\n");
	fprintf(assemblerFile, "\t\t\t mov cx,bx ; la copia se hace de ’CX’ caracteres\n");
	fprintf(assemblerFile, "\t\t\t cld ; cld es para que la copia se realice hacia adelante\n");
	fprintf(assemblerFile, "\t\t\t rep movsb ; copia la cadea\n");
	fprintf(assemblerFile, "\t\t\t mov al,\"$\" ; carácter terminador\n");
	fprintf(assemblerFile, "\t\t\t mov BYTE PTR [DI],al\n");
	fprintf(assemblerFile, "\t\t\t ret\n");
	fprintf(assemblerFile, "\t COPIAR ENDP\n\n");

	fprintf(assemblerFile, "\t ;***CONCAT***\n");
	fprintf(assemblerFile, "\t CONCAT PROC\n");
	fprintf(assemblerFile, "\t\ push ds\n");
	fprintf(assemblerFile, "\t\t push si\n");
	fprintf(assemblerFile, "\t\t call STRLEN  ;***STRLEN***\n");
	fprintf(assemblerFile, "\t\t mov dx,bx ; guardo en DX la cantidad de caracteres en el origen.\n");
	fprintf(assemblerFile, "\t\t mov si,di\n");
	fprintf(assemblerFile, "\t\t push es\n");
	fprintf(assemblerFile, "\t\t pop ds\n");
	fprintf(assemblerFile, "\t\t call STRLEN  ;***STRLEN***\n");
	fprintf(assemblerFile, "\t\t add di,bx ; DI ya queda apuntando al final delprimer string\n");
	fprintf(assemblerFile, "\t\t add bx,dx ; tamaño total\n");
	fprintf(assemblerFile, "\t\t cmp bx,MAXTEXTSIZE ; excede el tamaño maximo\n");
	fprintf(assemblerFile, "\t\t jg CONCATSIZEMAL\n");
	fprintf(assemblerFile, "\t\t CONCATSIZEOK: ; La suma no excede el maximo, copio todos\n");
	fprintf(assemblerFile, "\t\t\t mov cx,dx ; los caracteres del segundo string.\n");
	fprintf(assemblerFile, "\t\t\t jmp CONCATSIGO\n");
	fprintf(assemblerFile, "\t\t CONCATSIZEMAL: ; La suma de caracteres de los 2 strings exceden el maximo\n");
	fprintf(assemblerFile, "\t\t\t sub bx,MAXTEXTSIZE\n");
	fprintf(assemblerFile, "\t\t\t sub dx,bx\n");
	fprintf(assemblerFile, "\t\t\t mov cx,dx ; copio lo maximo permitido el resto se pierde.\n");
	fprintf(assemblerFile, "\t\t CONCATSIGO:\n");
	fprintf(assemblerFile, "\t\t\t push ds\n");
	fprintf(assemblerFile, "\t\t\t pop es\n");
	fprintf(assemblerFile, "\t\t\t pop si\n");
	fprintf(assemblerFile, "\t\t\t pop ds\n");
	fprintf(assemblerFile, "\t\t\t cld ; cld es para que la copia se realice hacia adelante\n");
	fprintf(assemblerFile, "\t\t\t rep movsb ; copia la cadea\n");
	fprintf(assemblerFile, "\t\t\t mov al,\"$\" ; carácter terminador\n");
	fprintf(assemblerFile, "\t\t\t mov BYTE PTR [DI],al ; el regis>\n");
	fprintf(assemblerFile, "\t\t\t	ret\n");
	fprintf(assemblerFile, "\tCONCAT ENDP\n\n");

	//Muestra los datos que contienen las variables por el momento solo enteros
	fprintf(assemblerFile, "\t;***DisplayINT***\n");
	fprintf(assemblerFile, "\tDisplayINT PROC\n");
	fprintf(assemblerFile, "\t\t xor edx,edx\n");
	fprintf(assemblerFile, "\t\t div ecx\n");
	fprintf(assemblerFile, "\t\t add DL,30H\n");
	fprintf(assemblerFile, "\t\t mov [di],dl ;lo pasa a cadena\n");
	fprintf(assemblerFile, "\t\t inc di ;inc 1 a cadena\n");
	fprintf(assemblerFile, "\t\t add &inc_aux,1\n");
	fprintf(assemblerFile, "\t\t ret\n");
	fprintf(assemblerFile, "\tDisplayINT ENDP \n\n");

	fprintf(assemblerFile, "\tE_display PROC \n");
	fprintf(assemblerFile, "\t\t call DisplayINT \n");
	fprintf(assemblerFile, "\t\t cmp eax,0\n");
	fprintf(assemblerFile, "\t\t jne E_display\n");
	fprintf(assemblerFile, "\t\t lea di,&cad2 ;cadena fuente\n");
	fprintf(assemblerFile, "\t\t mov ebx,&inc_aux\n");
	fprintf(assemblerFile, "\t\t mov cx,di\n");
	fprintf(assemblerFile, "\t\t add ecx,ebx\n");
	fprintf(assemblerFile, "\t\t mov di, cx\n");
	fprintf(assemblerFile, "\t\t mov al,'$'\n");
	fprintf(assemblerFile, "\t\t mov byte ptr [di],al\n");
	fprintf(assemblerFile, "\t\t dec di\n");
	fprintf(assemblerFile, "\t\t mov ecx,&inc_aux\n");
	fprintf(assemblerFile, "\t\t lea si,&cad1 ;cadena fuente\n");
	fprintf(assemblerFile, "\t\t repite:\n");
	fprintf(assemblerFile, "\t\t\t lodsb ;pone en al un caracter\n");
	fprintf(assemblerFile, "\t\t\t mov [di],al ;lo pasa a cad2\n");
	fprintf(assemblerFile, "\t\t\t dec di ;resto 1 a cad2\n");
	fprintf(assemblerFile, "\t\t loop repite\n");
	fprintf(assemblerFile, "\t\t MOV AX, SEG &cad2 \n");
	fprintf(assemblerFile, "\t\t MOV DS, AX \n");
	fprintf(assemblerFile, "\t\t MOV DX, OFFSET &cad2\n");
	fprintf(assemblerFile, "\t\t MOV AH, 9 \n");
	fprintf(assemblerFile, "\t\t INT 21h ; Imprime\n");
	fprintf(assemblerFile, "\t\t ret\n");
	fprintf(assemblerFile, "\tE_display ENDP\n\n");


	fprintf(assemblerFile, "\tFLOAT_INT PROC \n");
	fprintf(assemblerFile, "\t\t rcl  eax,1;   //left shift acc to remove the sign\n");
	fprintf(assemblerFile, "\t\t mov  ebx,eax; //save the acc\n");
	fprintf(assemblerFile, "\t\t mov  edx,4278190080; //clear reg edx;4278190080\n");
	fprintf(assemblerFile, "\t\t and  eax,edx; //and acc to retrieve the exponent\n");
	fprintf(assemblerFile, "\t\t shr  eax,24;\n");
	fprintf(assemblerFile, "\t\t sub  eax,7fh; //subtract 7fh(127) to get the actual power\n");
	fprintf(assemblerFile, "\t\t mov  edx,eax; //save acc val power\n");
	fprintf(assemblerFile, "\t\t mov  eax,ebx; //retrieve from ebx\n");
	fprintf(assemblerFile, "\t\t rcl  eax,8;     //trim the left 8 bits that contain the power\n");
	fprintf(assemblerFile, "\t\t mov  ebx,eax; //store\n");
	fprintf(assemblerFile, "\t\t mov  ecx, 1fh; //subtract 17 h\n");
	fprintf(assemblerFile, "\t\t sub  ecx,edx;\n");
	fprintf(assemblerFile, "\t\t mov  edx,00000000h;\n");
	fprintf(assemblerFile, "\t\t cmp  ecx,0;\n");
	fprintf(assemblerFile, "\t\t je   loop2;\n");
	fprintf(assemblerFile, "\t\t shr  eax,1;\n");
	fprintf(assemblerFile, "\t\t or   eax,80000000h;\n");
	fprintf(assemblerFile, "\t\t loop1:   \n");
	fprintf(assemblerFile, "\t\t\t shr  eax,1; //shift (total bits - power bits);\n");
	fprintf(assemblerFile, "\t\t\t sub  ecx,1;\n");
	fprintf(assemblerFile, "\t\t\t add  edx,1;\n");
	fprintf(assemblerFile, "\t\t\t cmp  ecx,0;\n");
	fprintf(assemblerFile, "\t\t\t ja   loop1;\n");
	fprintf(assemblerFile, "\t\t loop2:  \n");
	fprintf(assemblerFile, "\t\t\t ret\n");
	fprintf(assemblerFile, "\tFLOAT_INT ENDP \n\n");


	fprintf(assemblerFile, "\tNEGATIVO PROC \n");
	fprintf(assemblerFile, "\t\t MOV DX, OFFSET GUION ; Agrega guiom\n");
	fprintf(assemblerFile, "\t\t MOV AH,09\n");
	fprintf(assemblerFile, "\t\t INT 21h\n");
	fprintf(assemblerFile, "\t\t mov eax, &auxN\n");
	fprintf(assemblerFile, "\t\t NEG eax \n");
	fprintf(assemblerFile, "\t\t ret\n");
	fprintf(assemblerFile, "\tNEGATIVO ENDP \n\n");

	fprintf(assemblerFile, "\tLIMPIA PROC \n");
	fprintf(assemblerFile, "\t\t FFREE ST(0)\n");
	fprintf(assemblerFile, "\t\t FFREE ST(1)\n");
	fprintf(assemblerFile, "\t\t FFREE ST(2)\n");
	fprintf(assemblerFile, "\t\t FFREE ST(3)\n");
	fprintf(assemblerFile, "\t\t FFREE ST(4)\n");
	fprintf(assemblerFile, "\t\t FFREE ST(5)\n");
	fprintf(assemblerFile, "\t\t FFREE ST(6)\n");
	fprintf(assemblerFile, "\t\t FFREE ST(7)\n");
	fprintf(assemblerFile, "\t\t ret\n");
	fprintf(assemblerFile, "\tLIMPIA ENDP \n\n");

	fprintf(assemblerFile, "\tROUND PROC \n");
	fprintf(assemblerFile, "\t\t frndint ;(Redondea y el resultado queda en el tope)\n");
	fprintf(assemblerFile, "\t\t ret\n");
	fprintf(assemblerFile, "\tROUND ENDP \n\n");

	fprintf(assemblerFile, "\tTRUNC PROC \n");
	fprintf(assemblerFile, "\t\t fstp aux_trunc   \n");
	fprintf(assemblerFile, "\t\t xor eax,eax \n");
	fprintf(assemblerFile, "\t\t fstcw truncv \n");
	fprintf(assemblerFile, "\t\t fwait \n");
	fprintf(assemblerFile, "\t\t mov ax,truncv \n");
	fprintf(assemblerFile, "\t\t or ax,0c00h \n");
	fprintf(assemblerFile, "\t\t mov truncn,ax \n");
	fprintf(assemblerFile, "\t\t fldcw truncn \n");
	fprintf(assemblerFile, "\t\t fld aux_trunc \n");
	fprintf(assemblerFile, "\t\t frndint       \n");
	//fprintf(assemblerFile, "\t  \n");
	fprintf(assemblerFile, "\t\t ret\n");
	fprintf(assemblerFile, "\tTRUNC ENDP \n\n");

	//MAIN DEL ASM
	fprintf(assemblerFile, "\n\nMAIN:\n");
	fprintf(assemblerFile, "\t\t mov ax,@data ; zona de codigo\n");
	fprintf(assemblerFile, "\t\t mov ds,ax; zona de codigo\n\n");
	fprintf(assemblerFile, "\t\t mov es,ax\n");
	fprintf(assemblerFile, "\n\t\t FINIT ;Inicializacion Copo\n");

}

/*funcion de apertura de archivos*/
FILE *openFilePolaca(char *fileName, char *mode)
{
	FILE* file = fopen(fileName, mode);
	if (file == NULL)
	{
		printf("No se puede abrir el archivo %s.\n", fileName);
	}

	return file;
}

void insertarAssemblerPolacaEnAssemblerFinal()
{
	assemblerFilePolacaTemp = openFilePolaca(polacaTemp, "rb");
	char byte;
	char buf[BUFSIZ];
	size_t n;
	while ((n = fread(buf, 1, sizeof buf, assemblerFilePolacaTemp)) > 0)
	{
		fwrite(buf, 1, n, assemblerFile);
	}
	fclose(assemblerFilePolacaTemp);
}

void agregarFin()
{
	char etiquetaActual[30];
	sprintf(etiquetaActual, "@et%d:", posicionPolaca);

	//grabacion del final del archivo ASM
	fprintf(assemblerFile, "\n\n\t%s\t MOV DX, OFFSET NEWLINE\n", etiquetaActual);
	fprintf(assemblerFile, "\t\t MOV ah, 09\n");
	fprintf(assemblerFile, "\t\t int 21h\n");
	fprintf(assemblerFile, "\n");
	//muestra el mensaje por pantalla
	fprintf(assemblerFile, "\t\t MOV dx,OFFSET msgPRESIONE\n");
	fprintf(assemblerFile, "\t\t MOV ah,09\n");
	fprintf(assemblerFile, "\t\t INT 21h\n");
	//espera que se presione una tecla
	fprintf(assemblerFile, "\t\t MOV ah, 01\n");
	fprintf(assemblerFile, "\t\t INT 21h\n");
	fprintf(assemblerFile, "\t\t MOV ax, 4C00h\n");
	fprintf(assemblerFile, "\t\t INT 21h\n");
	//fin del main del ASM
	fprintf(assemblerFile, "END MAIN\n");
}

void renameSimbolo(char *simbolo)
{
	//por cada uno agregar _ al inicio, cambiar "." y " " por _
	char reNombre[50] = "";
	//Se sacan los . del nombre de la constante porque da error un nombre de va con .
	int cantCaracteres = strlen(simbolo);
	int i;
	for (i = 0; i < cantCaracteres; i++)
	{
		if ((simbolo[i] >= 32 && simbolo[i] <= 47) || (simbolo[i] >= 58 && simbolo[i] <= 64) || (simbolo[i] >= 91 && simbolo[i] <= 96) || (simbolo[i] >= 123))
		{
			reNombre[i] = '_';
		}
		else
		{
			reNombre[i] = simbolo[i];
		}
	}
	strcpy(simbolo, reNombre);
}

void procesar(char *aux)
{
	imprimir_pila(pila);
	char etiquetaActual[10];
	char auxResultado[10];
	t_data auxData;

	if (aux[0] != '\0')
	{
		if (strcmp(aux, "WRITE") == 0)
		{
			strcpy(e1, pila->dato);
			pop(&pila);
			sprintf(etiquetaActual, "@et%d:", posicionPolaca - 1);

			auxData = BuscarEnTSxNombre(e1);

			if (strcmp(auxData.tipo, tsTipoCteInteger) == 0 || strcmp(auxData.tipo, tsTipoInteger) == 0)
			{
				fprintf(assemblerFilePolacaTemp, "\t%s\t mov cl,10 \n", etiquetaActual);
				fprintf(assemblerFilePolacaTemp, "\t\t mov eax, %s \n", e1);
				fprintf(assemblerFilePolacaTemp, "\t\t mov &auxN, eax \n");
				fprintf(assemblerFilePolacaTemp, "\t\t NEG eax            ; lo niego. si el numero es negativo la bandera de NEGATIVE estara desactivada\n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov eax,  %s \n", e1);
				fprintf(assemblerFilePolacaTemp, "\t\t ;JNLE NEGATIVO	        ; salta cuando sea igual o mayor que cero\n");

				fprintf(assemblerFilePolacaTemp, "\t\t lea si,&cad1  \n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov di, si\n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov &inc_aux,0 \n");
				fprintf(assemblerFilePolacaTemp, "\t\t call E_display \n");
				fprintf(assemblerFilePolacaTemp, "\t\t MOV DX, OFFSET NEWLINE ; Agrega newline\n");
				fprintf(assemblerFilePolacaTemp, "\t\t MOV AH,09\n");
				fprintf(assemblerFilePolacaTemp, "\t\t INT 21h\n\n");
			}
			else if (strcmp(auxData.tipo, tsTipoCteFloat) == 0 || strcmp(auxData.tipo, tsTipoFloat) == 0)
			{
				fprintf(assemblerFilePolacaTemp, "\t%s\t mov  eax,%s \n", etiquetaActual, e1);
				fprintf(assemblerFilePolacaTemp, "\t\t CALL FLOAT_INT \n");

				fprintf(assemblerFilePolacaTemp, "\t\t mov cl,10 \n");

				fprintf(assemblerFilePolacaTemp, "\t\t lea si,&cad1  \n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov di, si\n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov &inc_aux,0 \n");

				fprintf(assemblerFilePolacaTemp, "\t\t call E_display \n");

				fprintf(assemblerFilePolacaTemp, "\t\t MOV DX, OFFSET PUNTO \n");
				fprintf(assemblerFilePolacaTemp, "\t\t MOV AH,09\n");
				fprintf(assemblerFilePolacaTemp, "\t\t INT 21h\n\n");

				fprintf(assemblerFilePolacaTemp, "\t\t mov eax, %s \n", e1);
				fprintf(assemblerFilePolacaTemp, "\t\t CALL FLOAT_INT \n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov &aux_f,eax \n");
				fprintf(assemblerFilePolacaTemp, "\t\t FLD  %s \n", e1);
				fprintf(assemblerFilePolacaTemp, "\t\t FILD  &aux_f \n");
				fprintf(assemblerFilePolacaTemp, "\t\t FSUB  \n");
				fprintf(assemblerFilePolacaTemp, "\t\t FILD &aux_prec \n");
				fprintf(assemblerFilePolacaTemp, "\t\t FMUL \n");
				fprintf(assemblerFilePolacaTemp, "\t\t FSTP &aux_f \n");
				fprintf(assemblerFilePolacaTemp, "\t\t FWAIT \n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov eax,&aux_f \n");

				fprintf(assemblerFilePolacaTemp, "\t\t FFREE \n");
				fprintf(assemblerFilePolacaTemp, "\t\t CALL FLOAT_INT \n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov cl,10 \n");
				fprintf(assemblerFilePolacaTemp, "\t\t lea si,&cad1  \n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov di, si\n");
				fprintf(assemblerFilePolacaTemp, "\t\t mov &inc_aux,0 \n");

				fprintf(assemblerFilePolacaTemp, "\t\t call E_display \n");

				fprintf(assemblerFilePolacaTemp, "\t\t MOV DX, OFFSET NEWLINE ; Agrega newline\n");
				fprintf(assemblerFilePolacaTemp, "\t\t MOV AH,09\n");
				fprintf(assemblerFilePolacaTemp, "\t\t INT 21h\n\n");
			}
			else if (strcmp(auxData.tipo, tsTipoCteString) == 0 || strcmp(auxData.tipo, tsTipoString) == 0)
			{
				fprintf(assemblerFilePolacaTemp, "\t%s\t MOV AX, SEG %s \n", etiquetaActual, e1);
				fprintf(assemblerFilePolacaTemp, "\t\t\t MOV DS, AX \n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t MOV DX, OFFSET %s \n", e1);
				fprintf(assemblerFilePolacaTemp, "\t\t\t MOV AH, 9 \n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t INT 21h ; Imprime \n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t MOV DX, OFFSET NEWLINE ; Agrega newline\n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t MOV AH,09\n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t INT 21h\n\n");
			}
		}
		else if (strcmp(aux, "READ") == 0)
		{
			char etiquetaInicio[15];
			strcpy(e1, pila->dato);
			pop(&pila);
			sprintf(etiquetaActual, "@et%d:", posicionPolaca - 1);
			sprintf(etiquetaInicio, "@Inicio%d", posicionPolaca - 1);


			auxData = BuscarEnTSxNombre(e1);

			fprintf(assemblerFilePolacaTemp, "\t%s\t  MOV SI, 0000 \n", etiquetaActual);
			fprintf(assemblerFilePolacaTemp, "\t%s:\t  MOV AX, 0000 \n", etiquetaInicio);
			fprintf(assemblerFilePolacaTemp, "\t\t\t  MOV AH, 01h \n");
			fprintf(assemblerFilePolacaTemp, "\t\t\t  INT 21h \n");
			fprintf(assemblerFilePolacaTemp, "\t\t\t  MOV %s[si], al \n", e1);
			fprintf(assemblerFilePolacaTemp, "\t\t\t  INC SI \n");
			fprintf(assemblerFilePolacaTemp, "\t\t\t  CMP AL, 0dh \n");
			fprintf(assemblerFilePolacaTemp, "\t\t\t  JNE %s \n", etiquetaInicio);
			fprintf(assemblerFilePolacaTemp, "\t\t\t  MOV AH, 02h \n");
			fprintf(assemblerFilePolacaTemp, "\t\t\t  MOV DL, al \n");
			fprintf(assemblerFilePolacaTemp, "\t\t\t  INT 21h \n");
		}
		else if (strncmp(aux, "_", 1) == 0) // cte
		{
			renameSimbolo(aux);
			pila = push(aux, "", pila);
		}
		else if (strcmp(aux, "++") == 0)  // CONCATENADOR DE STRINGS
		{
			strcpy(e1, pila->dato);
			pop(&pila);
			strcpy(e2, pila->dato);
			pop(&pila);

			sprintf(auxResultado, "@aux%d", posicionPolaca);
			sprintf(etiquetaActual, "@et%d:", posicionPolaca - 2);

			fprintf(assemblerFilePolacaTemp, "\t%s\t MOV SI, OFFSET %s \n", etiquetaActual, e2);
			fprintf(assemblerFilePolacaTemp, "\t\t\t MOV DI, OFFSET %s \n", auxResultado);
			fprintf(assemblerFilePolacaTemp, "\t\t\t CALL COPIAR\n\n");
			fprintf(assemblerFilePolacaTemp, "\t\t\t MOV SI, OFFSET %s \n", e1);
			fprintf(assemblerFilePolacaTemp, "\t\t\t MOV DI, OFFSET %s \n", auxResultado);
			fprintf(assemblerFilePolacaTemp, "\t\t\t CALL CONCAT\n\n");

			pila = push(auxResultado, "", pila);
			strcat(declaracionesAuxString, (strcat(auxResultado, ",")));
		}
		else if (esOperadorBinario(aux) == 0)  // + * - / 
		{
			strcpy(e1, pila->dato);
			pop(&pila);
			strcpy(e2, pila->dato);
			pop(&pila);

			sprintf(auxResultado, "@aux%d", posicionPolaca);
			sprintf(etiquetaActual, "@et%d:", posicionPolaca - 2);

			auxData = BuscarEnTSxNombre(e1);

			fprintf(assemblerFilePolacaTemp, "\t\t%s\t FLD %s\n", etiquetaActual, e2);
			fprintf(assemblerFilePolacaTemp, "\t\t\t\t FLD %s\n", e1);
			fprintf(assemblerFilePolacaTemp, "\t\t\t\t %s\n", obtenerComando(aux));
			fprintf(assemblerFilePolacaTemp, "\t\t\t\t FSTP %s\n\n", auxResultado);

			pila = push(auxResultado, "", pila);
			strcat(declaracionesAuxFloat, (strcat(auxResultado, ",")));

		}
		else if (strcmp(aux, ":=") == 0) // :=
		{
			strcpy(e1, pila->dato);
			pop(&pila);
			strcpy(e2, pila->dato);
			pop(&pila);
			sprintf(etiquetaActual, "@et%d:", posicionPolaca - 2);

			auxData = BuscarEnTSxNombre(e1);
			if (strcmp(auxData.tipo, tsTipoCteFloat) == 0 || strcmp(auxData.tipo, tsTipoFloat) == 0 || strcmp(auxData.tipo, tsTipoCteInteger) == 0 || strcmp(auxData.tipo, tsTipoInteger) == 0)
			{
				fprintf(assemblerFilePolacaTemp, "\t\t%s\t FLD %s\n", etiquetaActual, e2);
				fprintf(assemblerFilePolacaTemp, "\t\t\t\t FSTP %s\n\n", e1);
			}
			else if (strcmp(auxData.tipo, tsTipoCteString) == 0 || strcmp(auxData.tipo, tsTipoString) == 0)
			{
				fprintf(assemblerFilePolacaTemp, "\t%s\t MOV SI, OFFSET %s \n", etiquetaActual, e2);
				fprintf(assemblerFilePolacaTemp, "\t\t\t MOV DI, OFFSET %s \n", e1);
				fprintf(assemblerFilePolacaTemp, "\t\t\t CALL COPIAR\n\n");
			}
			else
			{
				fprintf(assemblerFilePolacaTemp, "\t\t%s\t (????) **** %s := %s \n", etiquetaActual, e1, e2);
			}
		}
		else if (strcmp(aux, "CMP") == 0)
		{
			strcpy(e1, pila->dato);
			pop(&pila);
			strcpy(e2, pila->dato);
			pop(&pila);
			sprintf(etiquetaActual, "@et%d:", posicionPolaca - 2);

			auxData = BuscarEnTSxNombre(e1);

			if (strcmp(auxData.tipo, tsTipoCteFloat) == 0 || strcmp(auxData.tipo, tsTipoFloat) == 0 || strcmp(auxData.tipo, tsTipoCteInteger) == 0 || strcmp(auxData.tipo, tsTipoInteger) == 0)
			{

				fprintf(assemblerFilePolacaTemp, "\t\t%s\t FLD %s\n", etiquetaActual, e2);
				fprintf(assemblerFilePolacaTemp, "\t\t\t\t FLD %s\n", e1);
				fprintf(assemblerFilePolacaTemp, "\t\t\t\t FSUB \n");

				fprintf(assemblerFilePolacaTemp, "\t\t\t\t FCOMP \n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t\t FSTSW AX \n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t\t FWAIT \n");
				fprintf(assemblerFilePolacaTemp, "\t\t\t\t SAHF \n");

				//fprintf(assemblerFilePolacaTemp, "\t\t%s\t (FLOAT) **** %s CMP %s \n", etiquetaActual, e1, e2);
			}
			else if (strcmp(auxData.tipo, tsTipoCteString) == 0 || strcmp(auxData.tipo, tsTipoString) == 0)
			{
				fprintf(assemblerFilePolacaTemp, "\t\t%s\t (STRING) **** %s CMP %s \n", etiquetaActual, e1, e2);
			}
			else
			{
				fprintf(assemblerFilePolacaTemp, "\t\t%s\t (?????) **** %s CMP %s \n", etiquetaActual, e1, e2);
			}
		}
		else if (esNumero(aux) == 0)
		{
			numeroSalto = atoi(aux);
		}
		else if (esSalto(aux) == 0)
		{
			sprintf(etiquetaActual, "@et%d:", posicionPolaca - 1);
			fprintf(assemblerFilePolacaTemp, "\t\t%s\t  %s @et%d \n", etiquetaActual, aux, numeroSalto);
			numeroSalto = -1;
		}
		else //es ID
		{
			pila = push(aux, "", pila);
		}
	}
	imprimir_pila(pila);
}

int pop(elem** inicio) {
	return eliminar_elemento_pila(*inicio, inicio);
}

// agregar un elemento en la posicion que
// le corresponde (valores de menor a mayor)
elem* push(char *valor, char *tipo, elem* aqui) {
	struct elemento_de_lista* nuevo = NULL; // auxiliar
	// para crear el nuevo elemento

	if (aqui != NULL) {
		//imprimir_pila(aqui);
	}
	else {
		printf("No hay nada.\n");
	}

	if (aqui == NULL) { // no hay nadie
		nuevo = (struct elemento_de_lista*)malloc(sizeof(elem));
		strcpy(nuevo->dato, valor); // asignar dato
		strcpy(nuevo->tipo, tipo);
		nuevo->siguiente = NULL; // el unico
		nuevo->anterior = NULL; // el unico
		return nuevo;
	}
	else {
		nuevo = (elem*)malloc(sizeof(elem));
		strcpy(nuevo->dato, valor); // asignar dato
		strcpy(nuevo->tipo, tipo);
		nuevo->siguiente = aqui;
		aqui->anterior = nuevo;
		nuevo->anterior = NULL;
	}
	return nuevo;
}

t_data BuscarEnTSxNombre(char *nombre)
{
	int i = 0;
	t_data t = { "", "", "", 0, "" };
	while (i < 1000 && strcmp(tablaDeSimbolo[i].nombre, "") != 0 && strcmp(t.nombre, "") == 0)
	{
		if ((strcmp(tablaDeSimbolo[i].nombre, nombre) == 0))
		{
			t = tablaDeSimbolo[i];
		}
		i++;
	}
	return t;
}

int esOperadorBinario(char *aux)
{
	if (strcmp(aux, "+") == 0 || strcmp(aux, "-") == 0 || strcmp(aux, "*") == 0 || strcmp(aux, "/") == 0)
	{
		return 0;
	}
	return -1;
}

char* obtenerComando(char *aux)
{
	if (strcmp(aux, "+") == 0)
	{
		return "FADD";
	}
	else if (strcmp(aux, "-") == 0)
	{
		return "FSUB";
	}
	else if (strcmp(aux, "*") == 0)
	{
		return "FMUL";
	}
	else if (strcmp(aux, "/") == 0)
	{
		return "FDIV";
	}

}

int esNumero(char *aux)
{
	int length, i;
	length = strlen(aux);
	for (i = 0; i < length; i++)
	{
		if (!isdigit(aux[i]))
		{
			return -1;
		}
	}
	return 0;
}

int esSalto(char *aux)
{
	if (strcmp(aux, "JB") == 0 || strcmp(aux, "JBE") == 0 || strcmp(aux, "JA") == 0 || strcmp(aux, "JAE") == 0 || strcmp(aux, "JE") == 0 || strcmp(aux, "JNE") == 0 || strcmp(aux, "JMP") == 0)
	{
		return 0;
	}
	return -1;
}

void imprimir_pila(elem* lista) {
	printf("----> ");
	imprime_elemento(lista);
	printf("\n");
	return;
}

void imprime_elemento(elem* esto) {
	// iterativa
	while (esto != NULL) {
		printf("%s - ", esto->dato);
		//printf("tipo: %s \n", esto->tipo);
		esto = esto->siguiente;
	}
	return;
}

int eliminar_elemento_pila(elem* aqui,
	elem** inicio) {
	if (aqui != NULL) { // si hay algo
		*inicio = aqui->siguiente;
		free(aqui); // borrame      return TRUE; // eliminacion exitosa
		return 1;
	}
	return -1;
}











