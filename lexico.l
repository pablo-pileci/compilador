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

{DECVAR}        {  declarando=1; return DECVAR;}
{ENDDEC}        {  declarando=0; return ENDDEC;}
{REPEAT}       	{  return REPEAT;}
{UNTIL}    	    {  return UNTIL;}
{IF}          	{ return IF;}
{ENDIF}       	{  return ENDIF;}
{ELSE}			{  return ELSE;}
{AND}         	{  return AND;}
{OR}          	{  return OR;}
{NOT}         	{ return NOT;}
{ALIAS}    	    {  return ALIAS;}
{BETWEEN}	    {  return BETWEEN;}
{WRITE}       	{ return WRITE;}
{READ}        	{ return READ;}
{INTEGER}     	{ return INTEGER;}
{FLOAT}       	{ return FLOAT;}
{STRING}      	{ return STRING;}

{OP_ASIG}     { return OP_ASIG;}
{OP_CONCAT}   {  return OP_CONCAT;}
{OP_SUMA}     {  return OP_SUMA;}
{OP_RESTA}    {  return OP_RESTA;}
{OP_POR}      {  return OP_POR;}
{OP_DIV}      { return OP_DIV;}
{OP_MENIG}    { return OP_MENIG;}
{OP_MEN}      {  return OP_MEN;}
{OP_MAYIG}    { return OP_MAYIG;}
{OP_MAY}      {  return OP_MAY;}
{OP_IG}       { return OP_IG;}
{OP_NOIG}     { return OP_NOIG;}
{PAR_AB}      { return PAR_AB;}
{PAR_CERR}    { return PAR_CERR;}
{CORC_AB}     {  return CORC_AB;}
{CORC_CERR}   {  return CORC_CERR;}
{COMA}        {  return COMA;}
{PYCOMA}      {  return PYCOMA;}
{DOSPUNTOS}   {  return DOSPUNTOS;}
{PORCIENTO}    {return PORCIENTO;}

{ID} {
	validar(0);
	if (declarando == 1){
		agregarSimbolo(yytext,0);
	}
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
	strcpy(constantes,"_");
	strcat(constantes,yytext);
	yylval = buscarSimbolo(constantes);
	return CTE_INT;
}
{CTE_REAL}    {
	validar(2);
	agregarSimbolo(yytext,2);
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
	if (tipo != 0){
		pos = buscarEnTS(aux);
	}
	else{
		pos = buscarEnTS(nombre);
	}
	
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
	else if (tipo == 0){
		printf("Identificador %s ya declarado, linea %d\n", nombre,linea);
	    exit(-1);
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
			if (strcmp((*it).alias,nombre) == 0){
				(*it).busquedaAlias = 1;
			}
			else{
				(*it).busquedaAlias = 0;
			}
			
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

// eliminar todos los elementos de la lista
// opcion vaciar
elem* borrar_pila(elem* esto) {
	elem* temp; // auxiliar 
	// iterativa
	while (esto != NULL) {
		temp = esto->siguiente;
		free(esto); // liberar
		esto = temp; // avanza al siguinte
	}
	return NULL; // que ya no hay lista
}

// devuelve si o no se pudo eliminar
// (no se puede eliminar si no esta)
// valor cuyo elemento hay que eliminar
// (unicamente elimina el primer elemento
// cuyo valor coincide)
// elemento en el cual estamos buscando = aqui
int eliminar_elemento_pila(elem* aqui,
	elem** inicio) {
	if (aqui != NULL) { // si hay algo
		*inicio = aqui->siguiente;
		free(aqui); // borrame      return TRUE; // eliminacion exitosa
		return 1;
	}
	return -1;
}

// interface para llamadas mas bonitas
int pop(elem** inicio) {
	return eliminar_elemento_pila(*inicio, inicio);
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

// interface que agrega [ ... ] y el \n
void imprimir_pila(elem* lista) {
	printf("----> ");
	imprime_elemento(lista);
	printf("\n");
	return;
}

// agregar un elemento en la posicion que
// le corresponde (valores de menor a mayor)
elem* push(char *valor, char *tipo, elem* aqui) {
	elem* nuevo = NULL; // auxiliar
	// para crear el nuevo elemento

	if (aqui != NULL) {
		//imprimir_pila(aqui);
	}
	else {
		printf("No hay nada.\n");
	}

	if (aqui == NULL) { // no hay nadie
		nuevo = (elem*)malloc(sizeof(elem));
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




