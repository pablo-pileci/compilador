
%{
	#define YYSTYPE t_simbolo *
	#include "lexico.h"
	FILE *reglas=NULL;
	FILE *intermedia=NULL;
	char error[1000];
	#define CANTVAR 200

    #include "ttipos.h"
	#include <vector>
	
    #define TIPO_ENTERO 0
    #define TIPO_REAL 1
    #define TIPO_STRING 2
    #define ERROR_TIPO 3

    typedef struct  {
    	int pos;
    	char * cad;
    } tElementoPolaca;
	std::vector<tElementoPolaca> tiraPolaca;
	int posActualPolaca = -1,x,inAnd=0,inOr=0;
	char auxPolaca[10],auxComparador[5];
	struct tpila * pilaPolaca;
	struct tdato dato;

    void insertar_en_polaca(char *);
    void insertar_en_polaca(char *,int,int);
    void escribirPolaca();
    void escribirPolacaPorLinea();
%}

%token  ID
		CTE_INT
	    CTE_REAL
	    CTE_STR
		REPEAT
		UNTIL
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
		{
			printf("0  - (START) PROGRAMA: DECLARACION CUERPO\n\n***** COMPILACION EXITOSA *****\n");
			fprintf(reglas, "0 ");
			escribirTS();
			escribirPolacaPorLinea();	
		} |
		cuerpo {
			printf("1  - (START) PROGRAMA: CUERPO\n\n***** COMPILACION EXITOSA *****\n");
			fprintf(reglas, "1 ");
			escribirTS();
			escribirPolacaPorLinea();
		}  |
		declaracion {
			printf("2  - (START) PROGRAMA: DECLARACION\n\n***** COMPILACION EXITOSA *****\n");
			fprintf(reglas, "2 ");
			escribirTS();
			
		};

cuerpo: sentencia {
			printf("3  - CUERPO: SENTENCIA\n");
			fprintf(reglas, "3 ");
		}

	| cuerpo sentencia
		{
			printf("4  - CUERPO: CUERPO SENTENCIA\n");
			fprintf(reglas, "4 ");
		};

sentencia: asignacion
		{
			printf("5  - SENTENCIA: ASIGNACION\n");
			fprintf(reglas, "5 ");
		}
	| iteracion
		{
			printf("6  - SENTENCIA: ITERACION\n");
			fprintf(reglas, "6 ");
		}
	| decision
		{
			printf("7  - SENTENCIA: DECISION\n");
			fprintf(reglas, "7 ");
		}
	| io
		{
			printf("8  - SENTENCIA: IO\n");
			fprintf(reglas, "8 ");
		}
	|funcion
		{
			printf("9  - SENTENCIA: FUNCION\n");
			fprintf(reglas, "9 ");
		};

declaracion: DECVAR  dec ENDDEC
		{
			printf("10  - DECVAR  dec\n");
			fprintf(reglas, "10 ");
		} | DECVAR ENDDEC
		{
			printf("11  - DECVAR  dec\n");
			fprintf(reglas, "11 ");
		};

dec : lineadeclara
        {
        	printf("12  - lineadeclara ENDDEC  dec\n");
        	fprintf(reglas, "12 ");
        }
        |dec lineadeclara
            {
            	printf("13  - dec lineadeclara ENNDEC  dec\n");
            	fprintf(reglas, "13 ");
            };


lineadeclara: listavar DOSPUNTOS tipo
		{
			printf("14  - lineadeclara: listavar DOSPUNTOS tipo\n");
			fprintf(reglas, "14 ");
		};


tipo: INTEGER
		{
			printf("15 - TIPO: INTEGER\n");
			fprintf(reglas, "15 ");
		}
	| FLOAT
		{
			printf("16 - TIPO: FLOAT\n");
			fprintf(reglas, "16 ");
		}
	| STRING
		{
			printf("17 - TIPO: STRING\n");
			fprintf(reglas, "17 ");
		};

listavar: vars
		{
			printf("18 - LISTAVAR: VARS\n");
			fprintf(reglas, "18 ");
		};

vars: id
		{
			printf("19 - VARS: ID\n");
			fprintf(reglas, "19 ");
		}
	| vars COMA id
		{
			printf("20 - VARS: VARS COMA ID\n");
			fprintf(reglas, "20	");
		}  ;

asignacion: id OP_ASIG exp
		{
			printf("21 - ASIGNACION: ID OP_ASIG EXP\n");
			fprintf(reglas, "21 ");
			insertar_en_polaca($1->nombre);
			strcpy(auxPolaca,":=");
			insertar_en_polaca(auxPolaca);
			
		};

exp: termino
		{
			printf("22 - EXP: TERMINO\n");
			fprintf(reglas, "22 ");
        }
	| exp OP_SUMA termino
		{
			printf("23 - EXP: EXP OP_SUMA TERMINO\n");
			fprintf(reglas, "23 ");
			strcpy(auxPolaca,"+");
			insertar_en_polaca(auxPolaca);

		}
	| exp OP_RESTA termino
		{
			printf("24 - EXP: ESP OP_RESTA TERMINO\n");
			fprintf(reglas, "24 ");
			strcpy(auxPolaca,"-");
			insertar_en_polaca(auxPolaca);
		}
	| factor OP_CONCAT factor {
			printf("25 - EXP: FACT OP_CONCAT FACTOR\n");
			fprintf(reglas, "25 ");
			strcpy(auxPolaca,"++");
			insertar_en_polaca(auxPolaca);
		} ;


termino: factor
		{
			printf("26 - TERMINO: FACTOR\n");
			fprintf(reglas, "26 ");

		}
	| termino OP_POR factor
		{
			printf("27 - TERMINO: TERMINO OP_POR FACTOR\n");
			fprintf(reglas, "27 ");
			strcpy(auxPolaca,"*");
			insertar_en_polaca(auxPolaca);
		}
	| termino OP_DIV factor
		{
			printf("28 - TERMINO: TERMINO OP_DIV FACTOR\n");
			fprintf(reglas, "28 ");
			strcpy(auxPolaca,"/");
			insertar_en_polaca(auxPolaca);
			
		}  ;

factor: PAR_AB exp PAR_CERR
		{
			printf("29 - FACTOR: PAR_AB EXP PAR_CERR\n");
			fprintf(reglas, "29 ");

		}
	| id
		{
			printf("30 - FACTOR: ID\n");
			fprintf(reglas, "30 ");
			insertar_en_polaca($1->nombre);
			
		}
	| cte_int
		{
			printf("31 - FACTOR: CTE_INT\n");
			fprintf(reglas, "31 ");
			insertar_en_polaca($1->nombre);
		}
	| cte_real
		{
			printf("32 - FACTOR: CTE_REAL\n");
			fprintf(reglas, "32 ");
			insertar_en_polaca($1->nombre);
		}
	| cte_str
		{
			printf("33 - FACTOR: CTE_STR\n");
			fprintf(reglas, "33 ");
			insertar_en_polaca($1->nombre);
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
		};

funcion: falias
		{
			printf("34 - FUNCION: ALIAS\n");
			fprintf(reglas, "34 ");
		}
		| fbetween
		{
             printf("35 - FUNCION: BETWEEN\n");
             fprintf(reglas, "35 ");
		};



falias: ALIAS id PORCIENTO id
		{
			printf("36 - FALIAS: ALIAS ID PORCIENTO ID\n");
			fprintf(reglas, "36 ");
			if (buscarEnTS($2->nombre) != -1){
				sprintf(error,"Identificador en alias \"%s\" ya declarado",$2->nombre);
				yyerror(error);
			}

			if (buscarEnTS($4->nombre) == -1){
				sprintf(error,"Identificador \"%s\" no declarado",yytext);
				yyerror(error);
			}
			guardarAlias($4->nombre,$2->nombre);
		} ;

fbetween: BETWEEN PAR_AB id COMA CORC_AB exp PYCOMA exp CORC_CERR PAR_CERR
        {
			printf("37 - FBETWEEN:BETWEEN PAR_AB ID COMA CORC_AB exp PYCOMA exp CORC_CERR PAR_CERR\n");
			fprintf(reglas, "37 ");

		}   ;

condiciones: comp_Li
		{
			printf("38 - CONDICIONES: CONDICION\n");fprintf(reglas, "38 ");
		}
	| comp_Li AND {
		inAnd=1;
	}comp_Ld
		{
			printf("39 - CONDICIONES: CONDICION AND CONDICION\n");fprintf(reglas, "39 ");
		}
	| comp_Li OR {
			inOr = 1;
			strcpy(auxPolaca,"");
			insertar_en_polaca(auxPolaca);	
			strcpy(auxPolaca,"BI");
			insertar_en_polaca(auxPolaca);	
			dato = desapilar(pilaPolaca);	
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);

			dato.clave = posActualPolaca-1;
			dato.inAnd = 0;
			apilar(pilaPolaca,dato);
	} comp_Ld
		{  	
			
			printf("40 - CONDICIONES: CONDICION OR CONDICION\n");fprintf(reglas, "40 ");
		}
	| NOT comp_Li
		{
			printf("41 - CONDICIONES: NOT CONDICION\n");fprintf(reglas, "41 ");
		}
	| fbetween
		{
			printf("42 - CONDICIONES: FBETWEEN\n");fprintf(reglas, "42 ");
		}
		;


comp_Li: condicion {

		};

comp_Ld: condicion {

		};
condicion: cond_Li comparador cond_Ld {
			printf("43 - CONDICION: EXP COMPARADOR EXP\n");fprintf(reglas, "43 ");
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
			};

cond_Li: exp {
		   }
       ;

cond_Ld: exp {
		   }
       ;


comparador: OP_MAY 	{	strcpy(auxComparador,"BLE");  }
	|	OP_MAYIG	{	strcpy(auxComparador,"BLT");  }
	|	OP_IG 		{	strcpy(auxComparador,"BNE");  }
	|	OP_NOIG 	{	strcpy(auxComparador,"BEQ");  }
	|	OP_MENIG 	{	strcpy(auxComparador,"BGT");  }
	|	OP_MEN 		{	strcpy(auxComparador,"BGE");  }	;


iteracion: REPEAT cuerpo UNTIL PAR_AB condiciones PAR_CERR
        {
            printf("44 - ITERACION: REPEAT CUERPO UNTIL (CONDICIONES)\n");
			fprintf(reglas, "44 ");
        };

decision: IF PAR_AB condiciones PAR_CERR cuerpo {
			
			dato = desapilar(pilaPolaca);
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);
			if (dato.inAnd == 1){
				dato = desapilar(pilaPolaca);
				snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);
			}

			

} ENDIF
		{
			printf("45 - DECISION: IF ( CONDICIONES ) CUERPO ENDIF\n");
			fprintf(reglas, "45 ");
		}
		|IF PAR_AB condiciones PAR_CERR cuerpo
		{
			printf("46 - DECISION: IF ( CONDICIONES ) CUERPO ELSE CUERPO ENDIF\n");
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
			strcpy(auxPolaca,"BI");
			insertar_en_polaca(auxPolaca);	
			
		}
		ELSE cuerpo  ENDIF
		{	
			dato = desapilar(pilaPolaca);
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);
		};

io: READ id
		{
			printf("47 - IO: READ ID\n");
			fprintf(reglas, "47 ");
			insertar_en_polaca($2->nombre);
			strcpy(auxPolaca,"READ");
			insertar_en_polaca(auxPolaca);

		}
	| WRITE id
		{
			printf("48 - IO: WRITE ID\n");fprintf(reglas, "48 ");
			insertar_en_polaca($2->nombre);
			strcpy(auxPolaca,"WRITE");
			insertar_en_polaca(auxPolaca);
		}
	| WRITE cte_str
		{
			printf("49 - IO: WRITE CTE_STR\n");
			fprintf(reglas, "49 ");
			insertar_en_polaca($2->nombre);
			strcpy(auxPolaca,"WRITE");
			insertar_en_polaca(auxPolaca);
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
			crearPila(&pilaPolaca);
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
			fprintf(intermedia, "%s \n",it->cad);
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
