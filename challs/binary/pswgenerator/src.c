#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

char token[33];
char psw[65];
char nome[64];
time_t seed;

void init()
{
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
}

void printflag()
{
    FILE *f = fopen("flag", "r");
    if (!f)
    {
        perror("errore (chiama admin)");
        return;
    }
    char flag[128];
    if (fgets(flag, sizeof(flag), f) != NULL)
        printf("bravo\n%s", flag);
    else
        fprintf(stderr, "errore (chiama admin)\n");

    fclose(f);
}

int main()
{
    init();
    seed = time(0);

    printf("Benvenuto al generatore di password più sicuro di sempre!\n");
    printf("Come ti chiami?\n");

    scanf("%s", nome);

    printf("Ciao %s!\n", nome);
    printf("Inserisci il token! (se non ce l'hai puoi comprarlo qua: https://www.fortnite.com/)\n");
    scanf("%32s", token);
    if (strcmp(token, "supersafeunguessabletoken") != 0)
    {
        printf("Token non valido! Vai a comprare la licenza!\n");
        return 0;
    }

    srand(seed);
    for (int i = 0; i < 64; i++)
        psw[i] = (char)((rand() % (126 - 47 + 1)) + 47);
    psw[64] = 0;

    char buf[65];
    printf("Bene bene, ho pensato ad una password adatta a te\n", nome);
    printf("Mi fido così tanto della sua sicurezza che se la indovini ti regalo la flag!\n");
    scanf("%64s", buf);

    if (!strncmp(buf, psw, 64))
        printflag();
    else
        printf("non ci siamo, riprova");

    return 0;
}