#include "datetime.h"

Datetime::Datetime()
{
    m_time = time(nullptr) - rand() % 10 * 24 * 60 * 60; // for debug use only
}

Datetime::Datetime(int code) // for everyday use
{
    m_time = time(nullptr);
}

Datetime::~Datetime()
{
}


void Datetime::set_current()
{
    m_time = time(nullptr);
}

std::wstring Datetime::localstr() const
{
    tm* localtm = localtime(&m_time);

    char str[50];
    strcpy(str, asctime(localtm));
    std::string narrowStr(str);
    std::wstring result(narrowStr.begin(), narrowStr.end());
    if (result.back() == L'\n') result.pop_back();
    return result;
}


bool operator< (const Datetime& lhs, const Datetime& rhs) { return lhs.m_time < rhs.m_time; }
bool operator> (const Datetime& lhs, const Datetime& rhs) { return rhs < lhs; }
bool operator<=(const Datetime& lhs, const Datetime& rhs) { return !(lhs > rhs); }
bool operator>=(const Datetime& lhs, const Datetime& rhs) { return !(lhs < rhs); }
