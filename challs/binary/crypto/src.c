#include <stdio.h>
#include <string.h>
#include <ctype.h>

void rot13(char *str);
void leetspeak(char *str);
void atbash(char *str);

void banner()
{
    printf("o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o\n");
    printf("Benvenuto ad una normalissima challenge di crittografia!\n");
    printf("o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o\n");
}

int main()
{
    int choice;
    char buf[256];

    banner();
    for (int i = 0; i < 5; i++)
    {
        printf("\nCome vuoi cifrare il tuo messaggio?\n");
        printf("1. ROT13\n");
        printf("2. Leetspeak\n");
        printf("3. Atbash\n");
        printf("4. Esci\n");

        scanf("%d", &choice);
        getchar();

        if (choice != 1 && choice != 2 && choice != 3)
        {
            printf("ciao!\n");
            return 0;
        }

        printf("Inserisci il messaggio: ");
        fgets(buf, sizeof(buf), stdin);
        buf[strcspn(buf, "\n")] = '\0';

        switch (choice)
        {
        case 1:
            rot13(buf);
            printf("Messaggio cifrato: %s\n", buf);
            break;
        case 2:
            leetspeak(buf);
            printf("Messaggio cifrato: %s\n", buf);
            break;
        case 3:
            atbash(buf);
            printf("Messaggio cifrato: %s\n", buf);
            break;
        default:
            printf("ciao!");
            return 0;
        }
    }

    printf("ciao!");
    return 0;
}

void rot13(char *str)
{
    for (int i = 0; str[i]; i++)
    {
        if (isalpha(str[i]))
        {
            char base = isupper(str[i]) ? 'A' : 'a';
            str[i] = (str[i] - base + 13) % 26 + base;
        }
    }
}

void leetspeak(char *str)
{
    const char *leet_chars = "48cd3f9h1jklmn0pqr57uvwxyz";
    for (int i = 0; str[i]; i++)
    {
        if (isalpha(str[i]))
        {
            char c = tolower(str[i]);
            if (c >= 'a' && c <= 'z')
            {
                char leet_char = leet_chars[c - 'a'];
                if (isupper(str[i]))
                    str[i] = toupper(leet_char);
                else
                    str[i] = leet_char;
            }
        }
    }
}

void atbash(char *str)
{
    for (int i = 0; str[i]; i++)
    {
        if (isupper(str[i]))
            str[i] = 'Z' - (str[i] - 'A');
        else if (islower(str[i]))
            str[i] = 'z' - (str[i] - 'a');
    }
}