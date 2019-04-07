#include <cstdio>
#include <string>
#include <cmath>

class Money
{
protected:
    int cent_factor = 100;
    long long m_value = 0;
public:
    Money();
    Money(double);
    Money(std::wstring);
    virtual ~Money();

    double toDouble() const;
    long long value() const;
    std::wstring str() const;

    Money& operator+=(const Money& rhs);
    Money& operator-=(const Money& rhs);
    friend Money operator+(Money lhs, const Money& rhs);
    friend Money operator-(Money lhs, const Money& rhs);

    friend bool operator< (const Money& lhs, const Money& rhs);// { return m_value < rhs.m_value; }
    friend bool operator> (const Money& lhs, const Money& rhs);// { return rhs < *this; }
    friend bool operator<=(const Money& lhs, const Money& rhs);// { return !(*this > rhs); }
    friend bool operator>=(const Money& lhs, const Money& rhs);// { return !(*this < rhs); }
};



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

class Cargo
{
private:
	double weight;
	double volume;
	double length;
	int  pallets; 
	enum pallets_type 
	{
		EURO,
		NONSTANDARD,
		INDUSTRIAL,
		FINNISH
	};
	Money cost;
public:

};

int main()
{

	return 0;
}