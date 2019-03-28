#include "Money.h"

Money::Money()
{
}

Money::Money(double x)
{
    m_value = int(round(x * 100));
}

Money::Money(std::wstring s)
{
    double res = 0;
    try {
        res = std::stod(s);
    }
    catch (...) {}
    *this = res;
}

Money::~Money()
{
}

double Money::toDouble() const
{
    return 1.0 * m_value / cent_factor;
}

long long Money::value() const
{
    return m_value;
}

std::wstring Money::str() const
{
    long long integer  = m_value / cent_factor;
    long long fraction = m_value % cent_factor;
    return std::to_wstring(integer) + L"." + std::to_wstring(fraction);
}

Money& Money::operator+=(const Money& rhs)
{
    m_value += rhs.m_value;
    return *this;
}

Money& Money::operator-=(const Money& rhs)
{
    m_value -= rhs.m_value;
    return *this;
}

Money operator+(Money lhs, const Money& rhs)
{
    lhs += rhs;
    return lhs;
}

Money operator-(Money lhs, const Money& rhs)
{
    lhs -= rhs;
    return lhs;
}

bool operator< (const Money& lhs, const Money& rhs) { return lhs.m_value < rhs.m_value; }
bool operator> (const Money& lhs, const Money& rhs) { return rhs < lhs; }
bool operator<=(const Money& lhs, const Money& rhs) { return !(lhs > rhs); }
bool operator>=(const Money& lhs, const Money& rhs) { return !(lhs < rhs); }
