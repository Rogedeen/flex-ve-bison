%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

extern int line_number;
int hata_var = 0;

#define _CRT_NONSTDC_NO_DEPRECATE
#define _CRT_SECURE_NO_WARNINGS

typedef struct ExprList {
    int value;
    struct ExprList* next;
} ExprList;

ExprList* create_expr_list(int val, ExprList* next) {
    ExprList* list = (ExprList*)malloc(sizeof(ExprList));
    list->value = val;
    list->next = next;
    return list;
}

void print_expr_list(ExprList* list) {
    while (list) {
        printf("%d", list->value);
        if (list->next) printf(", ");
        list = list->next;
    }
}
%}

%union {
    int intval;
    char* id;
    struct ExprList* exprlist; 
}

%type <exprlist> expr_list

%token <intval> INTEGER
%token <id> IDENTIFIER

%token ASSIGN PLUS MINUS TIMES DIVIDE MOD POWER
%token EQ NEQ LT LE GT GE
%token AND OR NOT

%token IF THEN ELSE ELSE_CONT
%token WHILE WHILE_COND END_BLOCK

%token FUNCTION END_FUNCTION RETURN

%token DRAW_CIRCLE
%token KEY_PRESSED
%token TUS_UP TUS_DOWN TUS_LEFT TUS_RIGHT

%type <intval> expr

%start program

%%

program:
    statements {
        if (!hata_var)
            printf("[Basarili] Kod gramer kurallarina uygundur.\n");
    }
  | /* boþ program */ {
        if (!hata_var)
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
    | function_call
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

function_call:
    IDENTIFIER expr_list {
       
        
    }
;

expr_list:
      expr {
          $$ = create_expr_list($1, NULL);
      }
    | expr ',' expr_list {
          $$ = create_expr_list($1, $3);
      }
;


logic_expr:
      comparison_expr
    | logic_expr AND logic_expr
    | logic_expr OR logic_expr
    | NOT logic_expr
;

%%

void yyerror(const char *s) {
    hata_var = 1;
    fprintf(stderr, "Hata (satir %d): %s\n", line_number, s);
}
