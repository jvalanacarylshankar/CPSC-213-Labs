//
// Created by anmol on 2017-03-16.
//
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "list.h"

void print (element_t ev) {
    char* e = (char*) ev;
    printf ("%s\n", e);
}

void printx (intptr_t ev) {
    intptr_t e = (intptr_t) ev;
    printf ("%ld\n", e);
}


void truncate (element_t* rv, element_t av, element_t bv){
    int i = 0;
    char * x = (char*) *rv;
    char* y = (char*) av;
    while((char)y[i] != '\0'){
        if(i == (intptr_t) bv)
            break;
        x[i] = y[i];
        i++;
    }
    *rv = x;
}

void is_Int(element_t * s, element_t a){
    intptr_t x = strtol(a, NULL, 0);
    intptr_t b = -1;
    intptr_t c = x;
    if(x == 0) {
        *s = (element_t) b;
    }
    else{
        *s = (element_t)c;
    }
}

void nuller(element_t * x, element_t a, element_t b){
    if((intptr_t)b == -1){
        *x = a;
    }
    else{
        *x = "\0";
    }
}

int remove_negatives(element_t a){
    if((intptr_t)a == -1)
        return 0;
    return 1;
}

int remove_nulls(element_t a){
    if(a == "\0")
        return 0;
    return 1;
}

void max(element_t* a, element_t b, element_t c){
    intptr_t * x = (intptr_t *) a;
    *x = (intptr_t) b;
    if(*x < (intptr_t)c){
        *x = (intptr_t)c;
    }
}

int main(int argc, const char * argv[]){
    int i, num_count = 0, wrd_count = 0;
    struct list* l0 = list_create();
    for(i = 1;i < argc; i++){
        char * x = (char*)argv[i];
        element_t v = x;
        list_append(l0, v);
    }
    struct list* l1 = list_create();
    list_map1(is_Int, l1, l0);
    struct list* l2 = list_create();
    list_map2(nuller, l2, l0, l1);
    struct list * l3 = list_create();
    list_filter(remove_negatives, l3, l1);
    struct list * l4 = list_create();
    list_filter(remove_nulls, l4, l2);
    struct list * l5 = list_create();
    list_map2(truncate, l5, l4, l3);
    list_foreach(print, l5);
    intptr_t maxl = 0;
    list_foldl(max, (element_t*) &maxl, l3);
    printf("%ld\n", maxl);
    list_destroy(l0);
    list_destroy(l1);
    list_destroy(l2);
    list_destroy(l3);
    list_destroy(l4);
    list_destroy(l5);
}