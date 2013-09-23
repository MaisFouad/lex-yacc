%{
    #include<stdlib.h>
    #include"y.tab.h"
    
%}
alpha [a-zA-Z]
digit [0-9]
op [+-/*^&|]
%%

[ \t\n]
switch                          return S;
case                            return C;
break                           return B;
default                         return D;
{digit}+                        return NUM;
{alpha}+({digit}|{alpha}|"_")*  return ID;
[+-/*]                          return OPER;
=                               return EQ;
.   return yytext[0];

%%

int yywrap(){
    return 1;
}
