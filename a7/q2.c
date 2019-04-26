#include <stdio.h>

int x[8] = {1,2,3,0xffffffff,0xfffffffe,0,184,340057058};
int y[8];

int main() {
    int r4 = 8;
    int r2;
    int r0;
    int r3;
    int r1;
    while(r4 > 0) {
        r4--;
        r2 = -2147483648;
        //r0 = x[r4];
        r1 = x[r4];
        r0 = 0;
        while (r1 != 0) {
            r3 = r1;
            r3 = r3 & r2;
            if (r3 != 0)
                r0++;
            r1 = r1*2;
        }
        y[r4] = r0;
    }
    for(int i=0;i<8;i++){
        printf("%d",x[i]);
        printf("\n");
    }
    for(int i=0;i<8;i++){
        printf("%d",y[i]);
        printf("\n");
    }
}