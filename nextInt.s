         .data
buffer: .space 256                                         #static char [] buffer = new char[256];          
 
           .text
   .globl nextInt                                      #public static int glyph2int(char glyph, int radix){
           .include "macros/syscalls.s"
           .include "macros/subroutine.s"
           .include "macros/stack.s"
           .include "macros/bit_manipulation.s"
   
   glyph2int: nop
                     #a0 : glyph 
                     #a1 : radix
                     #t0 : i
                     #t1 : x
                     #t2 : v
                     #t3 : bufferlength
                     #t4 : radix
                     #t5 : buffer[t0]
                     #t6 : pointer
                     #t7 : -1
                     #t8 : glyph
                     #t9 : conversion

  start: nop                                                   #int conversion;
            li $t7, 0
            subi $t7, $zero, 1
            move $t4, $a0
            move $t8, $a1
            li $t9, 0                                          #conversion = 0;

   oneif: bgt $t8, '9' twoif                                   #if (glyph <= 57) {

   consone: nop

   subi $t9, $t8, '0'                                          #conversion = glyph - '0';
      
   checkone: blt $t8, $t4, fail                                #if (conversion < radix){
     
      b end
                                                               #return conversion;
                                                               #}
                                                               #}

                                                                                                                  
 twoif: blt $t8, '9' fail                                      #else if (glyph > 57){ 

    subi $t9, $t8, 'A'                                         #conversion = glyph - 'A';
    addi $t9, $t9, 10                                          #conversion = conversion + 10;
         
                                                               #if (conversion < radix){
   checktwo: bgt $t8, $t1, fail  
   b end
                                                                #return conversion;

                                                               #}
   fail: nop
      move $t9, $t7
                                                               #}
   end: nop

   move $v0, $t9                                             #return -1;
     jr $ra

                                                               #}


#a0 : glyph 
                     #a1 : radix
                     #t0 : i
                     #t1 : x
                     #t2 : v
                     #t3 : bufferlength
                     #t4 : radix
                     #t5 : buffer[t0]
                     #t6 : pointer
                     #t7 : -1
                     #t8 : glyph
                     #t9 : conversion

                               
 nextInt: nop                                              #public static int nextInt(int radix){
 
 init: nop
           move $t4, $a0                                             #radix  : t4    
           li $t0, 0                                                 #int i = 0; t0
           li $t1, 0                                                 #int x = 0; t1
           li $t2, 0                                                 #int v = 0; t2
           li $t3, 0                                                 #int buffer_length;
           li $t7, 0
           subi $t7, $zero, 1                                         # -1
           la $t5, buffer                                                     # $l = buffer[i]
           add $t5, $t5, $t0                                   
           lbu $t6, 0($t5)                                                    #i = 0;                                                                   #v = 0;

           read_si($t5, 255)                                         #mips.read_s(buffer, 256); 
           move $t3, $v0
                                                                    #buffer_length = mips.retval();

 loop: bne $t0, $t3 finish                                          #while (i < buffer_length){
        
           
 body: nop

         call glyph2int $t4, $t6
         move $t1, $v0                                                #x = glyph2int(buffer[i],radix);   
           
                                                                      
 ifone: bne $t1, $t7 elseone                                          #if (x == -1){
 
         addi $t0, $t0, 1 
            b loop                                                    #}
        
                                                                  
 elseone: nop                                                         #else {  
            la $t5, buffer    
            add $t5, $t5, $t0 
            lbu $t6, 0($t5)
            mul $t2, $t2, $t4                                         #v = v * radix;
            add $t2, $t2, $t1                                         #v = v + x;
            b loop                                                    #i++;
                                                                     #}
                                                                     #}

 finish: nop
            
            move $v0, $t2
            jr $ra                                             #return v;
                                                               #}

#// Task 1 complete: Fri Nov 10 20:48:40 PST 2023

#// Task 2 complete: Fri Nov 10 21:54:04 PST 2023