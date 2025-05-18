%{
#define YY_NO_UNISTD_H
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line_number = 1;

%}

%option noyywrap

%%

"--".*$                             ;  /* Satir sonuna kadar yorum */

\n                                  { line_number++; }
[ \t\r]+                            ;

[0-9]+                              { yylval.intval = atoi(yytext); return INTEGER; }

"eger"                              { return IF; }
"ise"                               { return THEN; }
"aksi"                              { return ELSE; }
"halde"                             { return ELSE_CONT; }

"dongu"                             { return WHILE; }
"iken"                              { return WHILE_COND; }
"neki"                              { return END_BLOCK; }

"fonk"                              { return FUNCTION; }
"knof"                              { return END_FUNCTION; }
"dondur"                            { return RETURN; }

"daire_ciz"                         { return DRAW_CIRCLE; }

"tus_basildi"                       { return KEY_PRESSED; }

"TUS_YUKARI"                        { return TUS_UP; }
"TUS_ASAGI"                         { return TUS_DOWN; }
"TUS_SOLA"                          { return TUS_LEFT; }
"TUS_SAGA"                          { return TUS_RIGHT; }

"ve"                                { return AND; }
"veya"                              { return OR; }
"degil"                             { return NOT; }

","                                 { return ','; }
":"                                 { return ':'; }

"=="                                { return EQ; }
"<>"                                { return NEQ; }
"<="                                { return LE; }
">="                                { return GE; }
"<"                                 { return LT; }
">"                                 { return GT; }

"<-"                                { return ASSIGN; }
"+"                                 { return PLUS; }
"-"                                 { return MINUS; }
"*"                                 { return TIMES; }
"/"                                 { return DIVIDE; }
"%"                                 { return MOD; }
"^"                                 { return POWER; }

[a-zA-Z_][a-zA-Z0-9_]*              { yylval.id = strdup(yytext); return IDENTIFIER; }

.                                   { printf("Bilinmeyen karakter: %s (satýr %d)\n", yytext, line_number); }

%%
