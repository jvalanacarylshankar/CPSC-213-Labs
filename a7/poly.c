#include <stdio.h>
#include <string.h>
#include <malloc.h>

struct Person_class {
    void* super;
    char* name;
    char* (*toString) (void *, char*, int);
};

struct Person{
    struct Person_class * class;
};

char* X_toString(void* thisv, char* buf, int bufSize){
    struct Person * obj = (struct Person*) thisv;
    char x[1000];
    snprintf(x, sizeof(x), "%s %s", buf, strdup(obj->class->name));
    return strdup(x);
}

struct Student_class{
    int sid;
    struct Person_class * p;
    char* (*toString) (void *, char*, int);
};

struct Student{
    struct Student_class * s;
};

char* S_toString(void* thisv, char* buf, int bufSize) {
    struct Student * obj = (struct Student*)thisv;
    char stid[100];
    snprintf(stid, sizeof(stid), "%d", (obj->s->sid));
    char * bufx = ", SID: ";
    return strdup(X_toString(strdup(X_toString((obj->s->p->toString), bufx, sizeof(bufx))), strdup(stid), sizeof(strdup(stid))));
}

struct Person_class Person_class_obj = {NULL, NULL, X_toString};
struct Student_class Student_class_obj = {0, &Person_class_obj, S_toString};

struct Person * new_Person(char * n){
    struct Person * obj = malloc(sizeof(struct Person));
    obj->class = &Person_class_obj;
    obj->class->name = strdup(n);
    return obj;
}

struct Student * new_Student(char * n, int id){
    struct Student * obj = malloc(sizeof(struct Student));
    obj->s = &Student_class_obj;
    obj->s->sid = id;
    struct Person * p = new_Person(n);
    obj->s->p = p->class;
    return obj;
}

void printx(struct Person * p){
    char * bufx = "Name: ";
    char* s = strdup(X_toString(p, bufx, sizeof(bufx)));
    printf("%s", s);
    printf("\n");
}

int main() {
    struct Student * s = new_Student("Alice", 300);
    struct Person * pr = new_Person("Alex");
    struct Person * p[2];
    p[1] = pr;
    p[2] = new_Person(s->s->p->name);
    for(int i = 0; i < 2; i++){
        printx(p[i]);
    }
    return 0;
}