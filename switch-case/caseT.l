%{
    #include<stdlib.h>
    #include"y.tab.h"
    
%}
alpha [a-zA-Z]
digit [0-9]
op [+-/*^&|]
%%

[ \t\n]
switch                          {printf("var_expr="); return S;}
case                            {printf(" if(var_expr==");return C;}
break                           {printf(" else"); return B;}
default                         {printf(" else{");return D;}
{digit}+                        {printf("%s",yytext);return NUM;}
{alpha}+({digit}|{alpha}|"_")*  {printf("%s",yytext);return ID;}
\'.\'                           {printf("%s",yytext);return CHAR;}
[+-/*^&|]                       {printf("%s",yytext);return OPER;}
:                               {printf("{");return L;}
=                               {printf("%s",yytext);return EQ;}
.                               return yytext[0];
        

%%

int yywrap(){
    return 1;
}
