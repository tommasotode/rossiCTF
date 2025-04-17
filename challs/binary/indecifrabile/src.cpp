#include <iostream>
#include <sstream>
#include <iomanip>
#include <string>

using namespace std;

string str_to_hex(const string &input)
{
    ostringstream s;
    s << hex << setfill('0');
    
    for (unsigned char c : input)
        s << setw(2) << static_cast<int>(c);
    
    return s.str();
}

int main()
{
    string hex = "726f7373694354467b6833585f31735f72337645727334624c335f3f213f3f21217d";

    cout << "Indovina la flag se ne sei capace: " << endl;
    
    string flag;
    cin >> flag;
    
    if (str_to_hex(flag) == hex)
        cout << "bravo!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
    else
        cout << "non ci siamo" << endl;

    return 0;
}