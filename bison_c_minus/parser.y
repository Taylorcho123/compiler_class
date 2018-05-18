/* ====================================================================== */
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

/* ====================================================================== */

extern int source_line_no;
extern int yylex();
extern FILE *yyin;
extern char *yytext;

/* ====================================================================== */

int yyerror(char *message);

%}

/* ====================================================================== */

%token VOID
%token INT
%token IF
%token ELSE
%token WHILE
%token RETURN
%token INPUT
%token OUTPUT

%token LT
%token LE
%token GT
%token GE
%token EQ
%token NE

%token ID
%token NUM

%%

/* ====================================================================== */
program
        : var_declaration_list fun_declaration_list
;

var_declaration_list
        : var_declaration_list var_declaration
        | empty
;

fun_declaration_list
        : fun_declaration_list fun_declaration 
        | fun_declaration
;

var_declaration
        : type_specifier var ';'
        | type_specifier var '[' num ']' ';'
;

type_specifier
        : INT 
        | VOID
;

var
        : ID
;

num 
        : NUM
;

fun_declaration 
        : type_specifier var '(' params ')' '{' local_declarations statement_list '}'
;
params 
        : param_list 
        | VOID
;

param_list 
        : param_list ',' param 
        | param
;

param 
        : type_specifier var 
        | type_specifier var '[' ']'
;

local_declarations 
        : local_declarations var_declaration 
        | empty
;

statement_list 
        : statement_list statement 
        | empty
;

statement 
        : compound_stmt 
        | expression_stmt 
        | selection_stmt
        | iteration_stmt 
        | funcall_stmt 
        | return_stmt 
        | input_stmt
        | output_stmt
;

compound_stmt 
        : '{' statement_list '}'
;

expression_stmt 
        : expression ';'
        | ';'
;

expression 
        : var '=' expression
        | var '[' expression ']' '=' expression
        | simple_expression
;

simple_expression 
        : additive_expression relop additive_expression
        | additive_expression
;

relop : LT | LE | GT | GE | EQ | NE 
;

additive_expression 
        : additive_expression addop term 
        | term
;

addop 
        : '+'
        | '-'
;

term 
        : term mulop factor 
        | factor
;

mulop 
        : '*' 
        | '/'
;

factor 
        : '(' expression ')' 
        | var | var '[' expression ']'
        | num | '+' num | '-' num
;

selection_stmt 
        : IF '(' expression ')' statement ELSE statement
;

iteration_stmt 
        : WHILE '(' expression ')' statement
;

funcall_stmt 
        : var '='call
        | var '[' expression ']' '=' call
        | call
;

call 
        : var '(' args ')'
;

args 
        : arg_list
;

arg_list 
        : arg_list ',' expression 
        | expression
;
return_stmt 
        : RETURN ';' 
        | RETURN expression ';'
;

input_stmt 
        : INPUT var ';'
        | INPUT var '[' expression ']' ';'
;

output_stmt 
        : OUTPUT expression ';'
;

empty 
        :
;


%%

/* ====================================================================== */

int yyerror(char *message)
{
  fprintf(stderr, "line %d: %s at \"%s\"\n", source_line_no, message, yytext);
}

/* ====================================================================== */

int main(int argc, char *argv[])
{
  if(argc != 2) {
    fprintf(stderr, "usage: parser file\n");
    exit(1);
  }
  yyin = fopen(argv[1], "r");
  if(yyin == NULL) {
    fprintf(stderr, "%s: %s\n", argv[1], strerror(errno));
    exit(1);
  }
  yyparse();

  return 0;
}

/* ====================================================================== */

