#ifndef CARGO_H
#define CARGO_H

#include "money.h"
#include "datetime.h"
#include <QString>

class Cargo
{
    public:
        Cargo();
        virtual ~Cargo();

        void set_name(const QString& name);

        void set_weight(double w);
        void set_volume(double v);
        void set_length(double l);
        void set_pallets(int p);

        void set_cost(Money c);

        void set_temperature_range(int minimal, int maximal);
        void set_time_range(Datetime minimal, Datetime maximal);

        QString name();

        double weight();
        double volume();
        double length();
        int pallets();

        Money cost();
        bool has_temperature_conditions();
        std::pair<int, int> temperature_range();
        int min_temperature();
        int max_temperature();

        std::pair<Datetime, Datetime> time_range();
        Datetime min_time();
        Datetime max_time();

    protected:
        QString m_name;

        // sizes
        double m_weight;
        double m_volume;
        double m_length;
        int    m_pallets;

        Money  m_cost;
        // enum currency

        bool   m_temperature;
        std::pair<int, int> m_temperature_range;

        std::pair<Datetime, Datetime> m_time_range;
};

#endif // CARGO_H
