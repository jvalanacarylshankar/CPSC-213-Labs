#include<stdio.h>

int q2(int x, int y, int z)
{
   int i = 0;
   if(x >= 10 && x <= 18)
   {
          i = x - 10;
          switch(i)
          {
              case 0: i = y + z;
                      break;
              case 2: i = y - z;
                      break;
              case 4: if(y - z > 0)
                        i = 1;
                      else
                        i = 0;
                      break;
              case 6: if(z - y > 0)
                        i = 1;
                      else 
                        i = 0;
                      break;
              case 8: if(y - z == 0)
                        i = 1;
                      else 
                        i = 0;
                      break;
              default: i = 0;
           }
   }
   return i;
}

int main()
{
   int a[4] = {18, 3, 3, 4};
   a[3] = q2(a[0], a[1], a[2]);
   
   for(int i = 0; i < 4; i++)
      printf("%d\n", a[i]);

   return 0;
}