%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);

#define _CRT_NONSTDC_NO_DEPRECATE
#define _CRT_SECURE_NO_WARNINGS
%}

%union {
    int intval;
    char* id;
}

%token <intval> INTEGER
%token <id> IDENTIFIER
%token ASSIGN PLUS MINUS TIMES DIVIDE MOD POWER
%type <intval> expr

%start program

%%

program:
    statements { printf("[Basarili] Kod gramer kurallarina uygundur.\n"); }
;

statement:
    IDENTIFIER ASSIGN expr
;

statements:
    statements statement
    | statement
;

expr:
      INTEGER
    | IDENTIFIER
    | expr PLUS expr
    | expr MINUS expr
    | expr TIMES expr
    | expr DIVIDE expr
    | expr MOD expr
    | expr POWER expr
;


%%

void yyerror(const char *s) {
    fprintf(stderr, "Hata: %s\n", s);
}
