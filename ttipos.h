#include <stdio.h>
#include <stdlib.h>

#define TIPO_ENTERO 0
#define TIPO_REAL 1
#define TIPO_STRING 2
#define ERROR_TIPO 3

int ts_Operacion[3][3];

int verificarTipo(char, int, int);


void cargarTablaSintesis()
{
     ts_Operacion[TIPO_ENTERO][TIPO_ENTERO] =  TIPO_ENTERO;
     ts_Operacion[TIPO_ENTERO][TIPO_REAL] =  ERROR_TIPO;
     ts_Operacion[TIPO_ENTERO][TIPO_STRING] = ERROR_TIPO;
     ts_Operacion[TIPO_REAL][TIPO_ENTERO] =  ERROR_TIPO;
     ts_Operacion[TIPO_REAL][TIPO_REAL] =  TIPO_REAL;
     ts_Operacion[TIPO_REAL][TIPO_STRING] =  ERROR_TIPO;
     ts_Operacion[TIPO_STRING][TIPO_ENTERO] =  ERROR_TIPO;
     ts_Operacion[TIPO_STRING][TIPO_REAL] =  ERROR_TIPO;
     ts_Operacion[TIPO_STRING][TIPO_STRING] =  TIPO_STRING;

}


//Verifica tipos de operaciones de *, - y /
int verificarTipo(char oper, int indLeft, int indRight)
{
 	 switch(ts_Operacion[indLeft][indRight])
	 {
	    case ERROR_TIPO:
			 printf("\n\t ERROR: de incompatibilidad de tipos\n");
			 system("PAUSE");
			 exit(1);
			 break;
	    default :
			 if (oper == '+' || oper == 'A')
          {
                return ts_Operacion[indLeft][indRight];
             }

             else

            if (oper == '@')
            	{
                  return ts_Operacion[indLeft][indRight];
                }

             else

             if (indLeft == TIPO_STRING || indRight == TIPO_STRING) {
                printf("\n\t ERROR: operacion no valida\n");

			    system("PAUSE");
			    exit(1);
             } else {
                return ts_Operacion[indLeft][indRight];
             }
    }
    return 0;
}

//////////PILA///////////

/* declaracion */
struct tpila{
  int clave;
  struct tpila *sig;
};

/* prototipos e implementacion */
int crearPila(struct tpila **pila);
int vacia(struct tpila *pila);
void apilar(struct tpila *pila, int elem);
int desapilar(struct tpila *pila);

void mostrarPila(struct tpila *pila);


int crearPila(struct tpila **pila)
{
   if ((*pila = (struct tpila *) malloc(sizeof(struct tpila))) == NULL )
   {
      return -1;
   }
   (*pila)->sig = NULL;
   return 0;
}

int vacia(struct tpila *pila)
{
  return (pila->sig == NULL);
}

void apilar(struct tpila *pila, int elem)
{
  struct tpila *nuevo;

  nuevo = (struct tpila *) malloc(sizeof(struct tpila));
  nuevo->clave = elem;
  nuevo->sig = pila->sig;
  pila->sig = nuevo;

}

void mostrarPila(struct tpila *pila)
{


  struct tpila *aux = pila;
  int valor;

   printf("\n----------PILA-----------");

  while (aux != NULL){
        valor = aux->clave;
        printf("\n Elemento: %d", valor);
        aux = aux->sig;
        }
    printf("\n--------FIN DE PILA---------\n\n");
}

int desapilar(struct tpila *pila)
{
  struct tpila *aux;
  int valor;

  aux = pila->sig;
  valor = aux->clave;
  pila->sig = aux->sig;
  free(aux);
  return valor;

}

