%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char *s);
    extern char* yytext;
    
%}

%token S C NUM B ID D CHAR Q L
%left OPER
%right EQ

%%
Program         :   StatementBlock                              {printf("\nprogram");exit(0);}
                ;

StatementBlock  :   Statement StatementBlock                    
                |
                ;

Statement       :   SwitchStatement                             
                |   Expression ';'                 {printf(";");}             
                |   MExpression ';'                {printf(";");}                                  
                ;

SwitchStatement :   S '(' MExpression ')' '{' CaseBlock '}'   {printf("}");}  
                ;

CaseBlock       :   CaseStatementBlock DefaultStatement 
                |   CaseStatementBlock        
                ;

DefaultStatement   :   D L StatementBlock

CaseStatementBlock : CaseStatement CaseStatementBlock
                   |
                   ;
CaseStatement  :   C NUM L StatementBlock       
               |   C CHAR L StatementBlock      
               |   C NUM L StatementBlock B ';' 
               |   C CHAR L StatementBlock B ';'
               ;

Expression      :   ID EQ MExpression                                                        
                ;

MExpression     :   MExpression OPER MExpression               
                |   ID                                          
                |   NUM                                         
                ;
%%

void yyerror(char *s){
    printf("\nError: %s",s);
}
int main(){
    yyparse();
    return 0;
}
