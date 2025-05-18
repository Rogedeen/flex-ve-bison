#define _CRT_NONSTDC_NO_DEPRECATE
#define _CRT_SECURE_NO_WARNINGS

%{
#include "parser.h"
#include <stdio.h>
FILE* yyin;
%}

%%
"--".*                          ;
[0-9]+                          { yylval.intval = atoi(yytext); return INTEGER; }
[a-zA-Z_][a-zA-Z0-9_]*          { return IDENTIFIER; }
"<-"                            { return ASSIGN; }
"+"                             { return PLUS; }
[ \t\r\n]+                      ;  // boþluklarý yoksay
.                               { printf("Bilinmeyen karakter: %s\n", yytext); }
%%

int yywrap(void) { return 1; }
