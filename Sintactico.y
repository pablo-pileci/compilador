
%{
	#define YYSTYPE t_simbolo *
	#include "lexico.h"
	#include "ttipos.h"
	FILE *reglas=NULL;
	FILE *intermedia=NULL;
	char error[1000];
	#define CANTVAR 200

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

			fprintf(reglas, "0 ");
			escribirTS();
			escribirPolaca();
			
		} |
		cuerpo {
			fprintf(reglas, "1 ");
			escribirTS();
			escribirPolaca();
		}  |
		declaracion {
			fprintf(reglas, "2 ");
			escribirTS();
		};

cuerpo: sentencia {
			fprintf(reglas, "3 ");
		}

	| cuerpo sentencia
		{
			fprintf(reglas, "4 ");
		};

sentencia: asignacion
		{
			fprintf(reglas, "5 ");
		}
	| iteracion
		{
			fprintf(reglas, "6 ");
		}
	| decision
		{
			fprintf(reglas, "7 ");
		}
	| io
		{
			fprintf(reglas, "8 ");
		}
	|funcion
		{
			fprintf(reglas, "9 ");
		};

declaracion: DECVAR  dec ENDDEC
		{
			fprintf(reglas, "10 ");
		} | DECVAR ENDDEC
		{
			fprintf(reglas, "11 ");
		};

dec : lineadeclara
        {
        	fprintf(reglas, "12 ");
            int i=0;
			while(i_variables > i){
				agregarTipo(dec_variables[i],tipoId);
				i++;
			}
			i_variables = 0;
        }
        |dec lineadeclara
            {
            	fprintf(reglas, "13 ");
                int i=0;
                while(i_variables > i){
                    agregarTipo(dec_variables[i],tipoId);
                    i++;
                }
                i_variables = 0;
            };


lineadeclara: listavar DOSPUNTOS tipo
		{
			fprintf(reglas, "14 ");
		};


tipo: INTEGER
		{
			fprintf(reglas, "15 ");
			strcpy(tipoId,"Integer");
		}
	| FLOAT
		{
			fprintf(reglas, "16 ");
			strcpy(tipoId,"Float");
		}
	| STRING
		{
			fprintf(reglas, "17 ");
			strcpy(tipoId,"String");
		};

listavar: vars
		{
			fprintf(reglas, "18 ");
		};

vars: id
		{
			fprintf(reglas, "19 ");
		}
	| vars COMA id
		{
			fprintf(reglas, "20	");
		}  ;

asignacion: id OP_ASIG exp
		{
			fprintf(reglas, "21 ");
			insertar_en_polaca($1->nombre);
			strcpy(auxPolaca,":=");
			insertar_en_polaca(auxPolaca);
			verificarTipo('A', getTipo($1->tipo), expTipo,linea);
		};

exp: termino
		{
			fprintf(reglas, "22 ");
			expTipo=termTipo;
        }
	| exp OP_SUMA termino
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
	| exp OP_RESTA termino
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
	| factor_str OP_CONCAT id {
			fprintf(reglas, "25 ");
			insertar_en_polaca($3->nombre);
			strcpy(auxPolaca,"++");
			insertar_en_polaca(auxPolaca);
			expTipo=verificarTipo('C', facTipo, getTipo($3->tipo),linea);
		}
    | factor_str OP_CONCAT cte_str {
			fprintf(reglas, "25b ");
			strcpy(auxPolaca,"++");
			insertar_en_polaca(auxPolaca);
			expTipo=verificarTipo('C', facTipo, TIPO_STRING,linea);
		};

factor_str:
        id
		{
			fprintf(reglas, "30b ");
			insertar_en_polaca($1->nombre);
			facTipo=tipoDat;

		}
		| cte_str
		{
			fprintf(reglas, "33b ");
			insertar_en_polaca($1->nombre);
            facTipo=TIPO_STRING;
		};

termino: factor
		{
			fprintf(reglas, "26 ");
			termTipo=facTipo;
		}
	| termino OP_POR factor
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
	| termino OP_DIV factor
		{
			fprintf(reglas, "28 ");
			strcpy(auxPolaca,"/");
			insertar_en_polaca(auxPolaca);
			if (termTipo == TIPO_STRING || facTipo == TIPO_STRING){
				sprintf(error,"Operación no válida para strings");
				yyerror(error);
			}
            termTipo=verificarTipo('/', termTipo, facTipo,linea);
		}  ;

factor: PAR_AB exp PAR_CERR
		{
			fprintf(reglas, "29 ");

		}
	| id
		{
			fprintf(reglas, "30 ");
			insertar_en_polaca($1->nombre);
			facTipo=tipoDat;

		}
	| cte_int
		{
			fprintf(reglas, "31 ");
			insertar_en_polaca($1->nombre);
			facTipo=TIPO_ENTERO;
		}
	| cte_real
		{
			fprintf(reglas, "32 ");
			insertar_en_polaca($1->nombre);
			facTipo=TIPO_REAL;
		}
	| cte_str
		{
			fprintf(reglas, "33 ");
			insertar_en_polaca($1->nombre);
            facTipo=TIPO_STRING;
		};


cte_int: CTE_INT
		{
            char aux[32];
			sprintf(aux,"_%s",yytext);
            agregarTipo(aux,"CteInteger");
		}	;

cte_real: CTE_REAL
		{
            char aux[32];
			sprintf(aux,"_%s",yytext);
            agregarTipo(aux,"CteFloat");
		}  ;

cte_str:  CTE_STR
		{
            char aux[32];
			sprintf(aux,"_%s",yytext);
            agregarTipo(aux,"CteString");
	    };

id: ID
		{   t_simbolo *auxt;
            if(declarando){
				strcpy(dec_variables[i_variables++], yytext);
			}
			else{
				if (buscarEnTS($1->nombre) == -1){
	                    sprintf(error,"Identificador \"%s\" no declarado",$1->nombre);
	                    yyerror(error);
				}
				
			}
			expTipo=tipoDat;
			tipoDat= getTipo(($1)->tipo);

		};

funcion: falias
		{
			fprintf(reglas, "34 ");
		};



falias: ALIAS ID {

	if ($2->alias != NULL && strcmp($2->alias," ") != 0 && $2->busquedaAlias == 1 ){
					sprintf(error,"Alias \"%s\" ya definido",$2->alias);
					yyerror(error);
			}

			if (buscarEnTS($2->nombre) != -1 && $2->busquedaAlias == 0){
					sprintf(error,"Identificador \"%s\" ya definido",$2->nombre);
					yyerror(error);
			}

} PORCIENTO ID
		{
			if (buscarEnTS($5->nombre) == -1){
				sprintf(error,"Identificador \"%s\" no declarado",yytext);
				yyerror(error);
			}
			guardarAlias($5->nombre,$2->nombre);
		} ;

fbetween: BETWEEN PAR_AB id {
	insertar_en_polaca($3->nombre);
}

 COMA CORC_AB exp {
				dato.clave = posActualPolaca+2;
				dato.inAnd = 0;
				apilar(pilaPolaca,dato);

				strcpy(auxPolaca,"CMP");
				insertar_en_polaca(auxPolaca);
				strcpy(auxPolaca,"");
				insertar_en_polaca(auxPolaca);
				strcpy(auxComparador,"JBE");
				insertar_en_polaca(auxComparador);
				insertar_en_polaca($3->nombre);

} PYCOMA exp
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

 CORC_CERR PAR_CERR
        {
			fprintf(reglas, "37 ");

		}   ;

condiciones: comp_Li
	| comp_Li AND {
		inAnd=1;
	}comp_Ld
	| comp_Li OR {
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
	} comp_Ld
	| NOT {isNot = 1;} comp_Li
		{
			verificarTipo('!', compLiTipo, compLiTipo,linea);

		}
	| fbetween
;


comp_Li: condicion { compLiTipo=condTipo;

		};

comp_Ld: condicion { compLdTipo=condTipo;

		};
condicion: cond_Li comparador cond_Ld {
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
			};

cond_Li: exp { 
		condLiTipo=expTipo;
		   }
       ;

cond_Ld: exp { condLdTipo=expTipo;
		   }
       ;


comparador: OP_MAY 	{
	if (isNot == 0){
		strcpy(auxComparador,"JBE");
	}
	else{
		strcpy(auxComparador,"JA");
	}
	isNot = 0;
}
	|	OP_MAYIG	{
		if (isNot == 0){
			strcpy(auxComparador,"JB");
		}
		else{
			strcpy(auxComparador,"JAE");
		}
		isNot = 0;

	}
	|	OP_IG 		{
		if (isNot == 0){
			strcpy(auxComparador,"JNE");
		}
		else{
			strcpy(auxComparador,"JE");
		}
		isNot = 0;

	}
	|	OP_NOIG 	{
		if (isNot == 0){
			strcpy(auxComparador,"JE");
		}
		else{
			strcpy(auxComparador,"JNE");
		}
		isNot = 0;
	}
	|	OP_MENIG 	{
		if (isNot == 0){
			strcpy(auxComparador,"JA");
		}
		else{
			strcpy(auxComparador,"JBE");
		}
		isNot = 0;

	}
	|	OP_MEN 		{
		if (isNot == 0){
			strcpy(auxComparador,"JAE");
		}
		else{
			strcpy(auxComparador,"JB");
		}
		isNot = 0;
	};


iteracion: REPEAT
{
			dato.clave = posActualPolaca+1;
			dato.inAnd = 0;
			apilar(pilaPolaca,dato);
}
cuerpo UNTIL PAR_AB condiciones PAR_CERR
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
			fprintf(reglas, "45 ");
		}
		|IF PAR_AB condiciones PAR_CERR cuerpo
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
		ELSE cuerpo  ENDIF
		{
			dato = desapilar(pilaPolaca);
			snprintf(tiraPolaca.at(dato.clave).cad, 10, "%d", posActualPolaca + 1);
		};

io: READ id
		{
			fprintf(reglas, "47 ");
			insertar_en_polaca($2->nombre);
			strcpy(auxPolaca,"READ");
			insertar_en_polaca(auxPolaca);
			if (getTipo($2->tipo) != TIPO_STRING){
				sprintf(error,"Identificador \"%s\" en READ debe ser string",$2->nombre);
	            yyerror(error);
			}
		}
	| WRITE id
		{
			insertar_en_polaca($2->nombre);
			strcpy(auxPolaca,"WRITE");
			insertar_en_polaca(auxPolaca);
		}
	| WRITE cte_str
		{
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

