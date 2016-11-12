#ifndef g_lexico_h
#define g_lexico_h


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>
#include <float.h>
#include <errno.h>
#include <list>
#include <cctype>
#include <stdbool.h>
#include <vector>

//estructura de simbolos de la tabla
typedef struct{
    char *nombre;
    char *tipo;
    char *valor;
    int longitud;
    char *alias;
    int busquedaAlias;
}t_simbolo;

typedef struct{
    char nombre[32];
    char tipo[32];
    char valor[32];
    int longitud;
    char alias[32];
}t_data;

struct elemento_de_lista {
    char dato[1000]; // donde la info va
    char tipo[50];
    // doblemente enlazada
    struct elemento_de_lista *siguiente; // puntero
    struct elemento_de_lista *anterior; // puntero
}; // <= ojo con el punto y coma

typedef struct elemento_de_lista elem;

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
int buscarAlias(const char*);
t_simbolo* buscarSimbolo(const char* );
int obtenerTipo(int);
void escribirTS();
int agregarTipo(const char*, const char*);
void tsEscribirBinario();
void generarAssembler();
void cargarTablaSimboloYModificarNombres();
void LeerYGuardarIntemedia();
void escribirAssembler();
void agregarCabecera();
void agregarDeclaracion();
void agregarFunciones();
FILE* openFilePolaca(char *, char *);
void insertarAssemblerPolacaEnAssemblerFinal();
void agregarFin();

void renameSimbolo(char *simbolo);
void procesar(char *);
int pop(elem** );
elem* push(char* , char* , elem* );
t_data BuscarEnTSxNombre(char *);
int esOperadorBinario(char *);
char* obtenerComando(char *);
int esNumero(char *);
int esSalto(char *);
void imprimir_pila(elem* );
int eliminar_elemento_pila(elem* ,elem** );
void imprime_elemento(elem* ); 
#endif
