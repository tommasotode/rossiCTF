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
        cout << "non ci siamo, però se rispondi a queste domande forse ti regalo la flag ;)" << endl;
        string ans;

        cout << "come si chiama la città preferita di Pier Luigi Costa?" << endl;
        cin >> ans;
        if (Utils::str_tolower(ans) == "pinnacoli pendenti")
            cout << "bravo! prossima domanda" << endl;
        else
        {
            cout << "no, mi dispiace" << endl;
            exit(0);
        }

        cout << "" << endl;
        cin >> ans;
        if (Utils::str_tolower(ans) == "si")
            cout << "quante " << endl;
        else
        {
            cout << "no" << endl;
            exit(0);
        }

        cout << "Complimenti! Purtroppo non mi ricordo la flag, devi indovinarla mi sa" << endl;
    }
};

int main()
{
    string hexb[] = {
        "72", "6f", "73", "73", "69", "43", "54", "46",
        "7b", "68", "33", "58", "5f", "31", "73", "5f",
        "72", "33", "76", "45", "72", "73", "34", "62",
        "4c", "33", "5f", "3f", "21", "3f", "3f", "21",
        "21", "7d"};
    string hex;
    for (const auto &b : hexb)
        hex += b;

    cout << "Ciao!" << endl;
    cout << "Indovina la flag se ne sei capace: " << endl;

    string flag;
    cin >> flag;
    if (Utils::str_to_hex(flag) == hex)
        cout << "bravo!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
    else
        Utils::game();

    return 0;
}