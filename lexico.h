#ifndef g_lexico_h
#define g_lexico_h

//estructura de simbolos de la tabla
typedef struct{
    char *nombre;
    int tipo;
    char *valor;
    int longitud;
    char *alias;
}t_simbolo;

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <float.h>
#include <errno.h>
#include <list>
#include <string.h>
#include <cctype>
#include "y.tab.h"

using namespace std;

#define MAX_ENTERO 65535
#define MAX_REAL 4294967296.
#define INT_DEF 1000
#define FLOAT_DEF 1001
#define STRING_DEF 1002
#define MAX_VARIABLES 1024      //cantidad maxima de variables que puede tener el programa


//variables que se usan en el lexico y el sintactico
extern FILE *yyin;
extern char* yytext;
extern int linea;
extern int iniSentencia;
extern int iniWhile;
extern int declarando;


//funciones lexico
void validar(int);
void agregar_nop_lista_tokens(const char *);
void agregar_op_lista_tokens(const char *);

//funciones sintactico
int yylex(void);
int yyerror(const char *);
int agregarSimbolo(const char*, int);
void guardarAlias(const char*, const char*);
int buscarEnTS(const char*);
t_simbolo* buscarSimbolo(const char* nombre);
int obtenerTipo(int);
void escribirTS();
int hexaAdec(const char *);
int binaAdec(const char *);

typedef struct{
    char nombre[32];
    char tipo[32];
    char valor[32];
    int longitud;
    char alias[32];
}data;

#endif
