#include "StringHelper.h"

#include <sstream>

using namespace std;

vector<string> StringHelper::split(const char *s, char delim)
{
    stringstream ss(s);
    string item;

    vector<string> tokens;
    while (getline(ss, item, delim))
    {
        tokens.push_back(item);
    }

    return tokens;
}

pair<string,string> StringHelper::split2(string &s, char delim)
{
    size_t sep = s.find(delim);
    if (sep == string::npos)
    {
        return pair<string,string>(s, string());
    }
    string left = string(s, 0, sep);
    string right = string(s, sep + 1, string::npos);
    return pair<string,string>(left, right);
}
