%{
#define YY_NO_UNISTD_H
#define _CRT_NONSTDC_NO_DEPRECATE
#define _CRT_SECURE_NO_WARNINGS

#include "parser.h"
#include <stdio.h>
FILE* yyin;
%}

%option noyywrap nodefault


%%
"--".*                          ;
[0-9]+                          { yylval.intval = atoi(yytext); return INTEGER; }
[a-zA-Z_][a-zA-Z0-9_]*          { return IDENTIFIER; }
"<-"                            { return ASSIGN; }
"+"                             { return PLUS; }
"-"                             { return MINUS; }
"*"                             { return TIMES; }
"/"                             { return DIVIDE; }
"%"                             { return MOD; }
"^"                             { return POWER; }
[ \t\r\n]+                      ;  // boþluk
.                               { printf("Bilinmeyen karakter: %s\n", yytext); }

%%

