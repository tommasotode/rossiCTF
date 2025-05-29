#include <iostream>
#include <sstream>
#include <iomanip>
#include <string>

using namespace std;

class Utils
{
public:
    static string str_to_hex(const string &input)
    {
        ostringstream s;
        s << hex << setfill('0');
        for (unsigned char c : input)
            s << setw(2) << static_cast<int>(c);
        return s.str();
    }

    static string str_tolower(const string &input)
    {
        string res = input;
        for (char &c : res)
            c = tolower(static_cast<unsigned char>(c));
        return res;
    }

    static void game()
    {
        cout << "\nnon ci siamo, ma se rispondi a queste domande forse ti regalo la flag ;)" << endl;
        string ans;

        cout << "come si chiama la cittadina preferita di Pier Luigi Costa? ";
        getline(cin, ans);
        if (Utils::str_tolower(ans) == "pinnacoli pendenti")
            cout << "bravo! prossima domanda" << endl;
        else
        {
            cout << "no, mi dispiace" << endl;
            exit(0);
        }

        cout << "quanti kg di massa magra pesa jok3r? ";
        getline(cin, ans);
        if (Utils::str_tolower(ans) != "122")
        {
            cout << "no" << endl;
            exit(0);
        }

        cout << "Complimenti! Purtroppo non mi ricordo la flag, dovrai indovinarla mi sa..." << endl;
    }
};

int main()
{
    string hexb[] = {"72", "6f", "73", "73", "69", "43", "54", "46", "7b", "57", "34", "69", "54", "5f", "68", "33", "58", "5f", "31", "73", "5f", "72", "33", "76", "45", "72", "73", "34", "62", "4c", "33", "5f", "3f", "21", "3f", "3f", "21", "21", "5f", "36", "66", "65", "63", "66", "31", "7d"};
    string hex;
    for (const auto &b : hexb)
        hex += b;

    cout << "Ciao!" << endl;
    cout << "Indovina la flag se ne sei capace: " << endl;

    string flag;
    cin >> flag;
    cin.ignore();
    if (Utils::str_to_hex(flag) == hex)
        cout << "bravo!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
    else
        Utils::game();

    return 0;
}