#include "Cargo.h"
#include <algorithm>

Cargo::Cargo()
{
    //ctor
}

Cargo::~Cargo()
{
    //dtor
}

void Cargo::set_weight(double w)
{
    m_weight = w;
}

void Cargo::set_volume(double v)
{
    m_volume = v;
}

void Cargo::set_length(double l)
{
    m_length = l;
}

void Cargo::set_pallets(int p)
{
    m_pallets = p;
}

void Cargo::set_cost(Money c)
{
    m_cost = c;
}

void Cargo::set_temperature_range(int minimal, int maximal)
{
    if (minimal > maximal)
        std::swap(minimal, maximal);
    m_temperature = true;
    m_temperature_range = std::make_pair(minimal, maximal);
}

void Cargo::set_time_range(Datetime minimal, Datetime maximal)
{
    if (minimal > maximal)
        std::swap(minimal, maximal);
    m_time_range = std::make_pair(minimal, maximal);
}

double Cargo::weight()
{
    return m_weight;
}

double Cargo::volume()
{
    return m_volume;
}

double Cargo::length()
{
    return m_length;
}

int Cargo::pallets()
{
    return m_pallets;
}

Money Cargo::cost()
{
    return m_cost;
}

bool Cargo::has_temperature_conditions()
{
    return m_temperature;
}

std::pair<int, int> Cargo::temperature_range()
{
    return m_temperature_range;
}

int Cargo::min_temperature()
{
    return m_temperature_range.first;
}

int Cargo::max_temperature()
{
    return m_temperature_range.second;
}

std::pair<Datetime, Datetime> Cargo::time_range()
{
    return m_time_range;
}

Datetime Cargo::min_time()
{
    return m_time_range.first;
}

Datetime Cargo::max_time()
{
    return m_time_range.second;
}
