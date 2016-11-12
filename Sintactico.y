
%{
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
			generarAssembler();
		} |
		cuerpo {
			fprintf(reglas, "1 ");
			escribirTS();
			escribirPolaca();
			generarAssembler();
		}  |
		declaracion {
			fprintf(reglas, "2 ");
			escribirTS();
			generarAssembler();
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










