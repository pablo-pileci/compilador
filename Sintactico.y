
%{
	#include "lexico.h"
	FILE *reglas=NULL;

	#define CANTVAR 200

    #include "ttipos.h"

    #define TIPO_ENTERO 0
    #define TIPO_REAL 1
    #define TIPO_STRING 2
    #define ERROR_TIPO 3

%}


%token  ID
		CTE_INT
		CTE_REAL
		CTE_STR
		WHILE
		ENDWHILE
		IF
		ENDIF
		ELSE
		AND
		OR
		NOT
		WRITE
		READ
		INTEGER
		FLOAT
		STRING
		OP_ASIG
		OP_CONCAT
		OP_SUMA
		OP_RESTA
		OP_POR
		OP_DIV
		OP_MEN
		OP_MENIG
		OP_MAY
		OP_MAYIG
		OP_IG
		OP_NOIG
		PAR_AB
		PAR_CERR
		CORC_AB
		CORC_CERR
		COMA
		COMILLA
		PYCOMA
		DOSPUNTOS
        GUION
        BLANCOS
        LINEA
        COMENT_AB
        COMENT_CERR
        PORCIENTO
        DECVAR
        ENDDEC
        ALIAS
        BETWEEN


%left   OP_SUMA OP_RESTA OP_POR OP_DIV PAR_CERR CORC_CERR
%right  OP_ASIG PAR_AB CORC_AB
%start  programa


%%
programa: declaracion cuerpo
		{ printf("0  - (START) PROGRAMA: DECLARACION CUERPO\n\n***** COMPILACION EXITOSA *****\n");fprintf(reglas, "0 ");
		escribirTS();
		}  ;

cuerpo: sentencia
		{ printf("1  - CUERPO: SENTENCIA\n");fprintf(reglas, "1 ");	}

	| cuerpo sentencia
		{ printf("2  - CUERPO: CUERPO SENTENCIA\n");fprintf(reglas, "2 ");}
			;


sentencia: asignacion
		{ printf("3  - SENTENCIA: ASIGNACION\n");fprintf(reglas, "3 ");	}
	| iteracion
		{ printf("4  - SENTENCIA: ITERACION\n");fprintf(reglas, "4 "); }
	| decision
		{ printf("5  - SENTENCIA: DECISION\n");fprintf(reglas, "5 "); }
	| io
		{ printf("6  - SENTENCIA: IO\n");fprintf(reglas, "6 "); }
	|funcion
		{ printf("7  - SENTENCIA: FUNCION\n");fprintf(reglas, "7 "); };

declaracion: DECVAR  lineadeclara ENDDEC
		{	printf("8  - DECVAR  lineadeclara ENDDEC\n"); fprintf(reglas, "8 ");};


lineadeclara: listavar DOSPUNTOS tipo
		{	printf("9  - lineadeclara: listavar DOSPUNTOS tipo\n"); fprintf(reglas, "9 ");};

tipo: INTEGER
		{ printf("10 - TIPO: INTEGER\n");fprintf(reglas, "14 ");}
	| FLOAT
		{ printf("11 - TIPO: FLOAT\n");fprintf(reglas, "15 ");}
	| STRING
		{ printf("12 - TIPO: STRING\n");fprintf(reglas, "16 ");}  ;

listavar: vars
		{ printf("13 - LISTAVAR: VARS\n");fprintf(reglas, "17 "); }  ;

vars: id
		{
			printf("14 - VARS: ID\n");fprintf(reglas, "18 ");
		}
	| vars COMA id
		{
			printf("15 - VARS: VARS COMA ID\n");fprintf(reglas, "19	");
		}  ;

asignacion: id OP_ASIG exp
		{
			printf("16 - ASIGNACION: ID OP_ASIG EXP\n");fprintf(reglas, "20 ");
			if($1 != $3){
				yyerror("asignacion entre datos de tipos diferentes");
			}

		   };

exp: termino
		{
			printf("17 - EXP: TERMINO\n");fprintf(reglas, "17 ");

        }
	| exp OP_SUMA termino
		{
			printf("18 - EXP: EXP OP_SUMA TERMINO\n");fprintf(reglas, "18 ");
			if($1 != $3){
				yyerror("operacion entre datos de tipos diferentes");
			}
			if($1 == STRING_DEF){
				yyerror("operacion no permitida para el tipo string");
			}

		}
	| exp OP_RESTA termino
		{
			printf("9 - EXP: ESP OP_RESTA TERMINO\n");fprintf(reglas, "19 ");
			if($1 != $3){
				yyerror("operacion entre datos de tipos diferentes");
			}
			if($1 == STRING_DEF){
				yyerror("operacion no permitida para el tipo string");
			}


		}  ;


termino: factor
		{
			printf("20 - TERMINO: FACTOR\n");fprintf(reglas, "20 ");
		}
	| termino OP_POR factor
		{
			printf("21 - TERMINO: TERMINO OP_POR FACTOR\n");fprintf(reglas, "21 ");
			if($1 != $3){
				yyerror("operacion entre datos de tipos diferentes");
			}
			if($1 == STRING_DEF){
				yyerror("operacion no permitida para el tipo string");
			}
		}
	| termino OP_DIV factor
		{
			printf("22 - TERMINO: TERMINO OP_DIV FACTOR\n");fprintf(reglas, "22 ");
			if($1 != $3){
				yyerror("operacion entre datos de tipos diferentes");
			}
			if($1 == STRING_DEF){
				yyerror("operacion no permitida para el tipo string");
			}

		}  ;

factor: PAR_AB exp PAR_CERR
		{
			printf("23 - FACTOR: PAR_AB EXP PAR_CERR\n");	fprintf(reglas, "23 ");

		}
	| id
		{
			printf("24 - FACTOR: ID\n");	fprintf(reglas, "24 ");

		}
	| cte_int
		{
			printf("25 - FACTOR: CTE_INT\n");	fprintf(reglas, "25 ");

		}
	| cte_real
		{
			printf("26 - FACTOR: CTE_REAL\n");	fprintf(reglas, "26 ");

		}
	| cte_str
		{
			printf("27 - FACTOR: CTE_STR\n");	fprintf(reglas, "27 ");

		}
	| funcion
		{
			printf("28 - FACTOR: FUNCION\n");	fprintf(reglas, "28 ");

		};


cte_int: CTE_INT
		{
		}	;

cte_real: CTE_REAL
		{
		}  ;

cte_str:  CTE_STR
		{
        };

id: ID
		{
		}	;



funcion: falias
		{ printf("29 - FUNCION: ALIAS\n");fprintf(reglas, "29 ");

		}
		| fbetween
		{
             printf("30 - FUNCION: BETWEEN\n");fprintf(reglas, "30 ");
		};



falias: ALIAS ID PORCIENTO ID
		{
			printf("31 - FALIAS: ALIAS ID % ID\n");fprintf(reglas, "31 ");

		}   ;

fbetween: BETWEEN PAR_AB ID COMA CORC_AB exp PYCOMA exp CORC_CERR PAR_CERR
        {
			printf("32 - FBETWEEN:BETWEEN PAR_AB ID COMA CORC_AB exp PYCOMA exp CORC_CERR PAR_CERR\n");fprintf(reglas, "32 ");

		}   ;

condiciones: comp_Li
		{
			printf("33 - CONDICIONES: CONDICION\n");fprintf(reglas, "33 ");
		}
	| comp_Li AND comp_Ld
		{
			printf("34 - CONDICIONES: CONDICION AND CONDICION\n");fprintf(reglas, "34 ");
		}
	| comp_Li OR comp_Ld
		{
			printf("35 - CONDICIONES: CONDICION OR CONDICION\n");fprintf(reglas, "35 ");
		}
	| NOT comp_Li
		{
			printf("36 - CONDICIONES: NOT CONDICION\n");fprintf(reglas, "36 ");
		}  ;

comp_Li: condicion {
		   }
       ;

comp_Ld: condicion {
		   }
       ;
condicion: cond_Li comparador cond_Ld {
				printf("37 - CONDICION: EXP COMPARADOR EXP\n");fprintf(reglas, "37 ");
				    }	 ;

cond_Li: exp {
		   }
       ;

cond_Ld: exp {
		   }
       ;


comparador: OP_MAY 	{	$$ = OP_MAY; strcpy(opcomp,"JBE"); }
	|	OP_MAYIG	{	$$ = OP_MAYIG; strcpy(opcomp,"JB"); }
	|	OP_IG 		{	$$ = OP_IG; strcpy(opcomp,"JNE"); }
	|	OP_NOIG 	{	$$ = OP_NOIG; strcpy(opcomp,"JE"); }
	|	OP_MENIG 	{	$$ = OP_MENIG; strcpy(opcomp,"JNB"); }
	|	OP_MEN 		{	$$ = OP_MEN; strcpy(opcomp,"JNBE"); }	;


iteracion: WHILE PAR_AB condiciones PAR_CERR{} cuerpo ENDWHILE
		{
			printf("38 - ITERACION: WHILE ( CONDICIONES ) CUERPO ENDWHILE\n");fprintf(reglas, "38 ");
		}  ;

decision: IF PAR_AB condiciones PAR_CERR cuerpo ENDIF
		{
			printf("39 - DECISION: IF ( CONDICIONES ) CUERPO ENDIF\n");fprintf(reglas, "39 ");
		}
		|IF PAR_AB condiciones PAR_CERR cuerpo
		{
		printf("40 - DECISION: IF ( CONDICIONES ) CUERPO ELSE CUERPO ENDIF\n");fprintf(reglas, "40 ");
		}
		ELSE cuerpo  ENDIF
		{		}

		;

io: READ id
		{
			printf("41 - IO: READ ID\n");fprintf(reglas, "41 ");

		}
	| WRITE id
		{
			printf("42 - IO: WRITE ID\n");fprintf(reglas, "42 ");
		}
	| WRITE cte_str
		{
			printf("43 - IO: WRITE CTE_STR\n");fprintf(reglas, "43 ");
		}  ;
%%


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

