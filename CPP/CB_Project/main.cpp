#include <iostream>
#include <cstdio>
#include "Cargo.h"

using namespace std;

void print_cargo(Cargo& x)
{
    printf("Weight:  %5.2F\n", x.weight());
    printf("Volume:  %5.2F\n", x.volume());
    printf("Length:  %5.2F\n", x.length());
    printf("Pallets: %5d\n", x.pallets());

}

Cargo generate_cargo()
{
    Cargo c;
    c.set_weight(23);
    c.set_volume(300);
    c.set_length(18);
    c.set_pallets(8);
    c.set_cost(Money(289000.54));
    c.set_temperature_range(-2, 6);
    c.set_time_range(Datetime(0), Datetime(0));
    return c;
}

int main()
{
    Cargo cargo = generate_cargo();
    print_cargo(cargo);
    return 0;
}
