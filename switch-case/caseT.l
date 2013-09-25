%{
    #include"y.tab.h"	
    #include<string.h>
    extern int Dbool=0;
    extern int Bbool=0;
    extern int Cbool=0;
    extern int count=0;
    extern int First=1;
%}
alpha [a-zA-Z]
digit [0-9]
op [+-/*^&|]
%%

[ \t\n]				            {printf("%s",yytext);}

switch                          {   
                                    printf("var_exp%d=",count++); 
                                    Dbool=0;
                                    Bbool=0;
                                    Cbool=0;
                                    First=1;
                                    return S;
                                }

case                            {   
                                    Cbool=1;
                                    if(Bbool==0 && Dbool==0)
                                    {
                                        if(First==0){
                                            printf("//}");
                                        }
                                        printf("if(var_exp%d==",count-1); 
                                        if(First!=0)
                                            First=0;
                                    }else if (Bbool==1 && Dbool==0){
                                        printf("}else if(var_exp%d==",count-1);
                                    }
                                    Bbool=0;
                                    Dbool=0;
                                    return C;
                                }

break                           {   
                                    Bbool=1; 
                                    Cbool=0;
                                    return B;
                                }

default                         {   
                                    Dbool=1; 
                                    printf("}else{");
                                    if(count!=0){
                                        count--;
                                        Bbool=-1;
                                        Cbool=-1;
                                    }
                                    return D;
                                }
                                
main				            {printf("%s(){",yytext);return M;}
#.*\n                           {printf("%s",yytext);return I;}
'\.'                            {printf("%s",yytext);return DOT;}
{digit}+                        {printf("%s",yytext);return NUM;}
{alpha}+({digit}|{alpha}|"_")*  {printf("%s",yytext);return ID;}
\'.\'                           {printf("%s",yytext);return CHAR;}
[+-/*^&|]                       {printf("%s",yytext);return OPER;}
:                               {   
                                    if(Dbool==0 && Cbool==1 && Bbool!=1 )
                                    {
                                        printf("){");
                                    } else if(Dbool==1 && Bbool==1 )
                                    {
                                        printf("}else{");
                                  
                                    }
                                    return L;
                                }
=                               {printf("%s",yytext);return EQ;}
.                               {return yytext[0];}
        

%%

int yywrap(){
    return 1;
}

char * newelem(char * s)
{
  return s++;
}
