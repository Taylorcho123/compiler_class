%{
#include <stdio.h>
#include <stdlib.h>

int num_line = 1;    
%}

%option yylineno

%%
"void"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "VOID", yytext);		    // keywords
"int"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "INT", yytext);
"if"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "IF", yytext); 
"else"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "ELSE", yytext); 
"while"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "WHILE", yytext); 
"return"	printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "RETURN", yytext); 
"input"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "INPUT", yytext);
"output"	printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "OUTPUT", yytext);

"+"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "PLUS", yytext); 		    // special symbols
"-"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "MINUS", yytext); 
"*"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "MULTIPLY", yytext);
"/"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "DIVIDE", yytext);
"<"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "LT", yytext); 
"<="		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "LE", yytext);
">"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "GT", yytext);
">="		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "GE", yytext);
"=="		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "EQ", yytext);
"!="		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "NE", yytext); 
"="		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "ASSIGN", yytext); 
","		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "COMMA", yytext);
";"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "SEMICOLON", yytext); 
"("		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "LPAR", yytext); 
")"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "RPAR", yytext);
"{"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "LBRACE", yytext);
"}"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "RBRACE", yytext);
"["		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "LBRACKET", yytext);
"]"		printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "RBRACKET", yytext); 

[a-zA-Z_][a-zA-Z0-9_]*	    printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "ID", yytext);	    // identifier

[0-9]*			    printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "NUM", yytext);	    // numbers

[ \t\r\n]+			    	;   // whitespace

"//".*					;   // comments
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]	;

.			    printf("line=%d, token=%s, lexeme=\"%s\"\n", yylineno, "UNDEFINED", yytext); 	    //error
%%

extern int yylex();
int yywrap(void) {
    return 1;
}

int main(int argc, char* argv[])
{
    int token;

    if(argc == 2) {
	if(!(yyin = fopen(argv[1], "r"))) {
	    perror("Error ");
	    return -1;
	}
	yyset_in(yyin);
	token = yylex();
	fclose(yyin);
    }
    else { 
	printf("Usage: scanner [filename]\n");
    }

    return 0;
}
