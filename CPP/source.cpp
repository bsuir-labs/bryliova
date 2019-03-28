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