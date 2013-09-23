%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char *s);
    
%}

%token S C NUM B ID D 
%left OPER
%right EQ

%%
Program         :   StatementBlock                              {printf("\nprogram");exit(0);}
                ;

StatementBlock  :   StatementBlock Statement                    {printf("\nStmtBlock");}
                |
                ;

Statement       :   SwitchStatement                             
                |   Expression ';'                              {printf("\nExp");}
                |   MExpression ';'                             {printf("\nMathExp");}
                ;

SwitchStatement :   S '(' MExpression ')' '{' CaseBlock '}'     {printf("\nswitchStatement");}
                ;

CaseBlock       :   CaseBlock CaseStatement 
                |   
                ;
CaseStatement   :   C NUM ':' StatementBlock                    {printf("\ncaseBlock");}
                |   C NUM ':' StatementBlock B ';'              {printf("\nbreakCaseBlock");}
                |   D ':' StatementBlock                        {printf("\nDefaultCase");}
                ;

Expression      :   ID EQ MExpression                           {printf("\nEQ Expression");}
                ;

MExpression     :   MExpression OPER MExpression                {printf("\nMath Expression");}
                |   ID                                          {printf("ID:%s", $$);}
                |   NUM                                         {printf("NUM:%s",$$);}
                ;
%%

void yyerror(char *s){
    printf("\nError: %s",s);
}
int main(){
    yyparse();
    return 0;
}
