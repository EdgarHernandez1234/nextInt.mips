public static int glyph2int(char glyph, int radix){
   
   init: ;

         int conversion;
   
         conversion = 0;

            if (glyph <= 57) {

   consone: ;

               conversion = glyph - '0';
      
               if (conversion < radix){
   checkone: ;

                  return conversion;
               }
            }

            else if (glyph > 57){

   constwo: ;

               conversion = glyph - 'A';
               conversion = conversion + 10;
         
                if (conversion < radix){
   checktwo: ;

                  return conversion;

               }
            }

   return -1;
}

static char [] buffer = new char[256]; 

public static int nextInt(int radix){
  
  init: ;

         int i;
         int x;
         int v;
         int buffer_length;
   
         i = 0;
         v = 0;

         mips.read_s(buffer, 256); 
         buffer_length = mips.retval();

  loop:  while (i < buffer_length){

  body: ;

            x = glyph2int(buffer[i],radix);   
            
            if (x == -1){
  ifone: ;
               i++;
            }
         
            else {  
  elseone: ;  

               v = v * radix;
               v = v + x;
               i++;

            }
       }

  finish: ;

   return v;
}

// Task 1 complete: Fri Nov 10 20:48:40 PST 2023

