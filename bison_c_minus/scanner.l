/* ====================================================================== */

%{

#include "parser.h"
#include <string.h>

/* ====================================================================== */


/* ====================================================================== */

char *lex;                      /* current lexeme of ID or NUM */
int source_line_no = 1;

/* ====================================================================== */

%}

%%

"void"   {return VOID;}
"int"    {return INT;}
"if"     {return IF;}
"else"   {return ELSE;}
"while"  {return WHILE;}
"return" {return RETURN;}
"input"  {return INPUT;}
"output" {return OUTPUT;}

"+"  {return '+';}
"-"  {return '-';}
"*"  {return '*';}
"/"  {return '/';}

"<"  {return LT;}
"<=" {return LE;}
"==" {return EQ;}
"!=" {return NE;}
">"  {return GT;}
">=" {return GE;}

":" {return ':';}
";" {return ';';}
"," {return ',';}
"=" {return '=';}
"{" {return '{';}
"}" {return '}';}
"[" {return '[';}
"]" {return ']';}
"(" {return '(';}
")" {return ')';}

[A-Za-z_][A-Za-z0-9_]* {return ID;}
[0-9][0-9]*  {return NUM;}
"//".*  ;
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]     ;
[ \t]   {;}
. {}
[\n] {source_line_no++; }

%%

/* ====================================================================== */
