%{
	#define YYSTYPE t_simbolo *
    #include "lexico.h"

    FILE *f;
    //**Lista que contiene la tabla de simbolos**//
	list <t_simbolo> listSimbolos;
	char constantes[100];

    int declarando=0;
    int linea = 1;

%}

DIGITO  	[0-9]
LETRA   	[a-zA-Z]

DECVAR			DECVAR
ENDDEC	    	ENDDEC
REPEAT       	REPEAT
UNTIL    	    UNTIL
IF          	IF
ENDIF       	ENDIF
ELSE			ELSE
AND         	AND
OR          	OR
NOT         	NOT
WRITE       	WRITE
READ        	READ
ALIAS           ALIAS
BETWEEN         BETWEEN
INTEGER     	Integer
FLOAT       	Float
STRING      	String

OP_ASIG     :=
OP_CONCAT   (\+){2}
OP_SUMA     (\+){1}
OP_RESTA    \-
OP_POR      \*
OP_DIV      \/
OP_MEN      <
OP_MENIG    <=
OP_MAY      >
OP_MAYIG    >=
OP_IG       ==
OP_NOIG     !=
PAR_AB      \(
PAR_CERR    \)
CORC_AB     \[
CORC_CERR   \]
COMENT_AB   -\/
COMENT_CERR \/-
COMA        ,
COMILLA     \"
PYCOMA      ;
GUION	    _
DOSPUNTOS   :
BLANCOS     [ \t\r]+
LINEA       \n
PORCIENTO   %


CTE_INT     {DIGITO}+
CTE_REAL    {CTE_INT}\.{CTE_INT}|\.{CTE_INT}|{CTE_INT}\.
CTE_STR     {COMILLA}[^\"]*{COMILLA}

ID          {LETRA}({DIGITO}|{LETRA})*
COMENTARIO  {COMENT_AB}([^\/]|(\/[^-]))*{COMENT_CERR}


%%
{COMENTARIO}  {int i; for(i=0; i<strlen(yytext); i++)   {if(yytext[i]=='\n')    linea++;}}
{LINEA}       {linea++;}
{BLANCOS}     {}

{DECVAR}        { agregar_nop_lista_tokens("PR"); declarando=1; return DECVAR;}
{ENDDEC}        { agregar_nop_lista_tokens("PR"); declarando=0; return ENDDEC;}
{REPEAT}       	{ agregar_nop_lista_tokens("PR"); return REPEAT;}
{UNTIL}    	    { agregar_nop_lista_tokens("PR"); return UNTIL;}
{IF}          	{ agregar_nop_lista_tokens("PR"); return IF;}
{ENDIF}       	{ agregar_nop_lista_tokens("PR"); return ENDIF;}
{ELSE}			{ agregar_nop_lista_tokens("PR"); return ELSE;}
{AND}         	{ agregar_nop_lista_tokens("PR"); return AND;}
{OR}          	{ agregar_nop_lista_tokens("PR"); return OR;}
{NOT}         	{ agregar_nop_lista_tokens("PR"); return NOT;}
{ALIAS}    	    { agregar_nop_lista_tokens("PR"); return ALIAS;}
{BETWEEN}	    { agregar_nop_lista_tokens("PR"); return BETWEEN;}
{WRITE}       	{ agregar_nop_lista_tokens("PR"); return WRITE;}
{READ}        	{ agregar_nop_lista_tokens("PR"); return READ;}
{INTEGER}     	{ agregar_nop_lista_tokens("PR"); return INTEGER;}
{FLOAT}       	{ agregar_nop_lista_tokens("PR"); return FLOAT;}
{STRING}      	{ agregar_nop_lista_tokens("PR"); return STRING;}

{OP_ASIG}     { agregar_op_lista_tokens("OP_ASIG"); return OP_ASIG;}
{OP_CONCAT}   { agregar_op_lista_tokens("OP_CONCAT"); return OP_CONCAT;}
{OP_SUMA}     { agregar_op_lista_tokens("OP_SUMA"); return OP_SUMA;}
{OP_RESTA}    { agregar_op_lista_tokens("OP_RESTA"); return OP_RESTA;}
{OP_POR}      { agregar_op_lista_tokens("OP_POR"); return OP_POR;}
{OP_DIV}      { agregar_op_lista_tokens("OP_DIV"); return OP_DIV;}
{OP_MENIG}    { agregar_op_lista_tokens("OP_MENIG"); return OP_MENIG;}
{OP_MEN}      { agregar_op_lista_tokens("OP_MEN"); return OP_MEN;}
{OP_MAYIG}    { agregar_op_lista_tokens("OP_MAYIG"); return OP_MAYIG;}
{OP_MAY}      { agregar_op_lista_tokens("OP_MAY"); return OP_MAY;}
{OP_IG}       { agregar_op_lista_tokens("OP_IG"); return OP_IG;}
{OP_NOIG}     { agregar_op_lista_tokens("OP_NOIG"); return OP_NOIG;}
{PAR_AB}      { agregar_op_lista_tokens("PAR_AB"); return PAR_AB;}
{PAR_CERR}    { agregar_op_lista_tokens("PAR_CERR"); return PAR_CERR;}
{CORC_AB}     { agregar_op_lista_tokens("CORC_AB"); return CORC_AB;}
{CORC_CERR}   { agregar_op_lista_tokens("CORC_CERR"); return CORC_CERR;}
{COMA}        { agregar_op_lista_tokens("COMA"); return COMA;}
{PYCOMA}      { agregar_op_lista_tokens("PYCOMA"); return PYCOMA;}
{DOSPUNTOS}   { agregar_op_lista_tokens("DOSPUNTOS"); return DOSPUNTOS;}
{PORCIENTO}    { agregar_op_lista_tokens("PORCIENTO"); return PORCIENTO;}

{ID} {
	validar(0);
	if (declarando == 1){
		agregarSimbolo(yytext,0);
	}
	agregar_nop_lista_tokens("ID");
	yylval = buscarSimbolo(yytext);
	if (yylval == NULL){
		yylval = ( t_simbolo* )malloc( sizeof(t_simbolo) );
		if ( !yylval ){
			return -1;
		}
		yylval->nombre = ( char* )malloc( sizeof(char)*31 );
		strcpy(yylval->nombre,yytext);
	}
	return ID;
}
{CTE_INT}     {
	validar(1);
	agregarSimbolo(yytext,1);
	agregar_nop_lista_tokens("CTE_INT");
	strcpy(constantes,"_");
	strcat(constantes,yytext);
	yylval = buscarSimbolo(constantes);
	return CTE_INT;
}
{CTE_REAL}    {
	validar(2);
	agregarSimbolo(yytext,2);
	agregar_nop_lista_tokens("CTE_REAL");
	strcpy(constantes,"_");
	strcat(constantes,yytext);
	yylval = buscarSimbolo(constantes);
	return CTE_REAL;
}
{CTE_STR}     {
	validar(3);
	yytext[strlen(yytext)-1] = '\0';
    yytext++;
	agregarSimbolo(yytext,3);
	agregar_nop_lista_tokens("CTE_STR");
	strcpy(constantes,"_");
	strcat(constantes,yytext);
	yylval = buscarSimbolo(constantes);
	return CTE_STR;
}

.	{ printf("Error lexico en %s \n", yytext); exit(-1); }

%%

void validar(int tipo)
{
    //verificar cantidad de caracteres
    int len = strlen(yytext);

    switch(tipo)
	{
        	case 0:
            {
		        if(len > 30)
				{
		           		printf("Error en %s, las id y constantes no pueden superar los 30 caracteres\n", yytext);
	                    exit(-1);
                }
 		    }
			case 1:
	        {
	                if(len > 30)
					{
                    	printf("Error en %s, las id y constantes no pueden superar los 30 caracteres\n", yytext);
	                    exit(-1);
	                }
	                long aux = atol(yytext);
					if(aux > MAX_ENTERO)
                	{
                    	printf("Error lexico: %s entero fuera de rango\n", yytext);
	                    exit(-1);
                	}
			};break;
	        case 2:
	           {
                if(len > 30)
				{
					printf("Error en %s, las id y constantes no pueden superar los 30 caracteres\n", yytext);
					exit(-1);
                }
	                double aux = atof(yytext);
	                if(aux > MAX_REAL)
	                {
						printf("Error lexico: %s real fuera de rango\n", yytext);
                        exit(-1);
	                }
	           };break;
	        case 3:
	            {
	                if(len > 32)
	                {
	                    printf("Error en %s, las id y constantes no pueden superar los 30 caracteres\n", yytext);
	                    exit(-1);
	                }
	            };break;
    }
}

void agregar_nop_lista_tokens(const char *token)
{
  //sprintf(stringtoken, "%s<%s:%s>",stringtoken, token, yytext);
}


void agregar_op_lista_tokens(const char *token)
{
    //sprintf(stringtoken, "%s<%s>",stringtoken, token);
}

/////FUNCINES PARA TS

/* Descrip: Funcion para agregar elementos a la tabla de simbolos
Retorno: Entero con la posicion del elemento insertado en la tabla de simbolos (yylval)
*/
int agregarSimbolo(const char* nombre, int tipo){
	int pos=1;			//Posicion del simbolo en la tabla
	t_simbolo* info;
    char aux[32];
    strcpy(aux,"_");
    strcat(aux,nombre);
	pos = buscarEnTS(aux);
	// Si el elemento no se encuentra en la lista, lo cargamos haciendo uso de la variable info

	if ( pos == -1 ){
		info = ( t_simbolo* )malloc( sizeof(t_simbolo) );
		if ( !info ){
			return -1;
		}

		info->nombre = ( char* )malloc( sizeof(char)*31 );
		info->tipo = ( char* )malloc( sizeof(char)*31 );
		info->valor = ( char* )malloc( sizeof(char)*31 );
		info->alias = ( char* )malloc( sizeof(char)*31 );

        strcpy( info->alias, " ");
        strcpy( info->valor, " ");
        strcpy( info->tipo, " ");
        info->longitud = 0;
		if(tipo==0){
			strcpy( info->nombre, nombre);
		}
        else{

            strcpy( info->valor, nombre);
            sprintf(aux,"_%s",yytext);
            strcpy( info->nombre, aux);
        }

		if (tipo==3){
            info->longitud = strlen(yytext);
		}
		listSimbolos.push_back( *info );
		pos = listSimbolos.size();
		free(info);
	}

	return pos;
}

void guardarAlias(const char* identificador, const char* alias){
	list<t_simbolo>::iterator it;
	if(!listSimbolos.empty()){
		// Obtenemos un iterador al comienzo de la lista
		it = listSimbolos.begin();
		// Buscamos el elemento
		while( it != listSimbolos.end() && strcmp((*it).nombre,identificador)!=0){
			it++;
		}
		// Si no se encontro el elemento
		if ( it != listSimbolos.end()){
			strcpy (it->alias,alias);
		}
    }
}

//busca en tabla, si encuentra devuelve la posicion y pone el tipo del identificador
int buscarEnTS(const char* nombre){
	int pos = -1;
	list<t_simbolo>::iterator it;
	if(!listSimbolos.empty()){
		pos = 1;
		// Obtenemos un iterador al comienzo de la lista
		it = listSimbolos.begin();
		// Buscamos el elemento
		while( it != listSimbolos.end() && strcmp((*it).nombre,nombre)!=0){
			it++;
			pos++;
		}
		// Si no se encontro el elemento
		if ( it == listSimbolos.end()){
			pos=-1;
		}
    }
    return pos;
}

t_simbolo* buscarSimbolo(const char* nombre){
	list<t_simbolo>::iterator it;
	t_simbolo * pSimbolo = NULL;
	if(!listSimbolos.empty()){
		// Obtenemos un iterador al comienzo de la lista
		it = listSimbolos.begin();
		// Buscamos el elemento
		while( it != listSimbolos.end() && strcmp((*it).nombre,nombre)!=0 && strcmp((*it).alias,nombre)){
			it++;
		}
		// Si no se encontro el elemento
		if ( it != listSimbolos.end()){
			pSimbolo = &(*it);
		}
    }
    return pSimbolo;
}


void escribirTS() {

	FILE *ptrTs;
	if ((ptrTs = fopen("ts.txt", "wt")) == NULL)
	{
		printf("\nNo se puede abrir el archivo: ts.txt\n");
		exit(-1);
	}

	fprintf(ptrTs,"%-33s%-15s%-15s%-31s%-5s\n", "Nombre","Alias","Tipo", "Valor", "Longitud");
	fprintf(ptrTs,"----------------------------------------------------------------------------------------------------------\n");
	// Recorro la lista de simbolos y voy mostrando todos sus atributos
	for( list<t_simbolo>::iterator it = listSimbolos.begin(); it != listSimbolos.end(); ++it){
		fprintf(ptrTs,"%-33s", (*it).nombre);
		fprintf(ptrTs,"%-15s", (*it).alias);
		fprintf(ptrTs,"%-15s", (*it).tipo);
		fprintf(ptrTs,"%-31s", (*it).valor);
		fprintf(ptrTs,"%-5d\n",(*it).longitud);
	}
	fclose(ptrTs);

	tsEscribirBinario();
}

int agregarTipo(const char* nombre, const char* tipo){
	int pos = -1;
	list<t_simbolo>::iterator it;
	if(!listSimbolos.empty()){
		pos = 1;
		it = listSimbolos.begin();
		while( it != listSimbolos.end() && strcmp((*it).nombre,nombre)!=0){
			it++;
			pos++;
		}
		strcpy((*it).tipo, tipo);
    }
    return pos;
}

void tsEscribirBinario(){
	t_data simbolo;
	FILE *ptrTsBin;
	if ((ptrTsBin = fopen("ts_bin.dat","wb")) == NULL)
	{
		printf("\nNo se puede abrir el archivo: ts_bin.dat\n");
		exit(-1);
	}

	for( list<t_simbolo>::iterator it = listSimbolos.begin(); it != listSimbolos.end(); ++it){
		simbolo.longitud = (*it).longitud;
		strcpy(simbolo.nombre,(*it).nombre);
		strcpy(simbolo.tipo,(*it).tipo);
		strcpy(simbolo.valor,(*it).valor);
		strcpy(simbolo.alias,(*it).alias);
		fwrite(&simbolo,sizeof(t_data),1,ptrTsBin);
	}
	fclose(ptrTsBin);
}
