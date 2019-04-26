#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct Element {
  char   name[200];
  struct Element *next;
};

struct Element *top = NULL;

void push (char* aName) {
  struct Element* e = malloc (sizeof (*e));    
// Not the bug: sizeof (*e) == sizeof(struct Element)
  strncpy (e->name, aName, sizeof (e->name));  
// Not the bug: sizeof (e->name) == 200
  e->next  = top;
  top = e;
}


char* pop() {
  struct Element* e = top;
  char* a = e->name;
  top = top->next;
  free(e);
  return a;
}

int main (int argc, char** argv) {
  push ("A");
  push ("B");
  char w[200];
  strncpy(w, pop(), sizeof (w));  
  push ("C");
  push ("D");
  char x[200];
  strncpy(x, pop(), sizeof (x)); 
  char y[200]; 
  strncpy(y, pop(), sizeof (y));
  char z[200];
  strncpy(z, pop(), sizeof (z)); 
  printf ("%s %s %s %s\n", w, x, y, z);
}
