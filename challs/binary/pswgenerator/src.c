#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

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

    printf("Ciao, come ti chiami?\n");
    scanf("%s", nome);

    srand(seed);
    for (int i = 0; i < 64; i++)
        psw[i] = (char)((rand() % (126 - 47 + 1)) + 47);
    psw[64] = 0;

    char buf[65];
    printf("Bene bene %s, ho pensato ad una password adatta a te\n", nome);
    printf("Se la indovini ti regalo la flag!\n");
    scanf("%64s", buf);

    if (!strncmp(buf, psw, 64))
        printflag();
    else
        printf("non ci siamo, riprova");

    return 0;
}