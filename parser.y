%{
#include <stdio.h>
#include <stdlib.h>

// yyerror ve yylex bildirimleri
void yyerror(const char *s);
int yylex(void);

// Lex'te tanýmlanan satýr sayacýný burada kullanmak için extern
extern int line_number;

#define _CRT_NONSTDC_NO_DEPRECATE
#define _CRT_SECURE_NO_WARNINGS
%}

%union {
    int intval;
    char* id;
}

%token <intval> INTEGER
%token <id> IDENTIFIER

// Operatörler
%token ASSIGN PLUS MINUS TIMES DIVIDE MOD POWER
%token EQ NEQ LT LE GT GE
%token AND OR NOT

// Kontrol ifadeleri
%token IF THEN ELSE ELSE_CONT
%token WHILE WHILE_COND END_BLOCK

// Fonksiyonlar
%token FUNCTION END_FUNCTION RETURN

// Çizim ve giriþ
%token DRAW_CIRCLE
%token KEY_PRESSED
%token TUS_UP TUS_DOWN TUS_LEFT TUS_RIGHT

%type <intval> expr

%start program

%%

program:
    statements {
        printf("[Basarili] Kod gramer kurallarina uygundur.\n");
    }
    | /* boþ program */ {
        printf("[Bos program] Kod gramer kurallarina uygundur.\n");
    }
;


statements:
    statements statement
    | statement
;

statement:
      IDENTIFIER ASSIGN expr
    | if_stmt
    | while_stmt
    | function_def
    | draw_stmt
    | input_stmt
;

if_stmt:
    IF logic_expr THEN statement ELSE ELSE_CONT statement
;

while_stmt:
    WHILE logic_expr WHILE_COND statements END_BLOCK
;

function_def:
    FUNCTION IDENTIFIER parameters ':' statements END_FUNCTION
;

parameters:
      IDENTIFIER
    | IDENTIFIER ',' parameters
;

draw_stmt:
    DRAW_CIRCLE expr expr expr
;

input_stmt:
      IF KEY_PRESSED TUS_UP THEN IDENTIFIER ASSIGN IDENTIFIER PLUS expr
    | IF KEY_PRESSED TUS_DOWN THEN IDENTIFIER ASSIGN IDENTIFIER MINUS expr
    | IF KEY_PRESSED TUS_LEFT THEN IDENTIFIER ASSIGN IDENTIFIER MINUS expr
    | IF KEY_PRESSED TUS_RIGHT THEN IDENTIFIER ASSIGN IDENTIFIER PLUS expr
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
    | '(' expr ')'
;

comparison_expr:
      expr EQ expr
    | expr NEQ expr
    | expr LT expr
    | expr LE expr
    | expr GT expr
    | expr GE expr
;

logic_expr:
      comparison_expr
    | logic_expr AND logic_expr
    | logic_expr OR logic_expr
    | NOT logic_expr
;

%%

// yylineno yerine line_number kullanýldý
void yyerror(const char *s) {
    fprintf(stderr, "Hata (satýr %d): %s\n", line_number, s);
}
