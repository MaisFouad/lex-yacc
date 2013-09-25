%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char *s);
    extern char* yytext;

    
%}

%token S C NUM B ID D CHAR Q L M I DEF AB DOT
%left OPER
%right EQ

%%
Program             :   StatementBlock                              {printf("program");exit(0);}
                    ;

StatementBlock      :   Statement StatementBlock                   
                    |								                
                    ;

Statement           :   SwitchStatement                             
                    |   Expression ';'                              {printf(";");}             
                    |   MExpression ';'                             {printf(";");}                                     
		            |   ID M '(' ')' '{' Statement '}'              {printf("}");}
		            |   I
		            ;



SwitchStatement     :   S '(' MExpression ')'                       {printf(";");}
                    |   SwitchStatement '{' CaseBlock '}'           {printf("}"); }
                    ;

CaseBlock           :   CaseStatementBlock DefaultStatement 
                    |   CaseStatementBlock                          {printf("}");}
                    ;

DefaultStatement    :   D L StatementBlock   
				    ;

CaseStatementBlock  :   CaseStatement CaseStatementBlock 
                    |
                    ;

CaseStatement       :   C NUM L StatementBlock       
                    |   C CHAR L StatementBlock      
                    |   C NUM L StatementBlock B ';' 
                    |   C CHAR L StatementBlock B ';'
                    ;

Expression          :   ID EQ MExpression
                    |   ID EQ FunctionStatement
                    ;

MExpression         :   MExpression OPER MExpression              
                    |   ID                                         
                    |   NUM                                       
                    ;
%%

void yyerror(char *s){
    printf("\nError: %s",s);
}
int main(){
    yyparse();
 //   printf("var_exp%d=%s",count++,exp); 
    return 0;
}
