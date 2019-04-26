#include <stdio.h>

int arr[10] = {0,0,0,0,0,0,0,0,0,0};

void func(int x, int y){
    arr[y] = arr[y] + x;
}

void main() {
    int local_variable_1 = 1;
    int local_variable_2 = 2;
    int argument_1 = 3;
    int argument_2 = 4;
    func(argument_1, argument_2);
    func(local_variable_1, local_variable_2);
    for(int i =0; i < 10; i++){
        printf("%d", arr[i]);
        printf("\n");
    }
}

