#include <cstdio>  
extern "C" int yyparse();
extern "C" FILE* yyin;

int main() {
    FILE* file = fopen("test.txt", "r");
    if (!file) {
        perror("test.txt açýlamadý");
        return 1;
    }

    extern FILE* yyin;
    yyin = file;

    yyparse();

    fclose(file);
    return 0;
}

