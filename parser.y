#define _CRT_NONSTDC_NO_DEPRECATE
#define _CRT_SECURE_NO_WARNINGS


%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex(void);
%}

%union {
    int intval;
    char* id;
}

%token <intval> INTEGER
%token <id> IDENTIFIER
%token ASSIGN PLUS
%type <intval> expr

%start program

%%

program:
    statements { printf("[Baþarýlý] Kod gramer kurallarýna uygundur.\n"); }
;

statements:
    statements statement
    | statement
;

statement:
    IDENTIFIER ASSIGN expr
;

expr:
    INTEGER
    | expr PLUS expr
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Hata: %s\n", s);
}
