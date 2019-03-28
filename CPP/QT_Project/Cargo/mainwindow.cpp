#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::updateLog()
{
    QString result;
    for (size_t i = 0; i < cargos.size(); ++i)
    {
        result += "Cargo " + QString::number(int(i)) + "\n";
        result += "Weight: " + QString::number(cargos[i].weight()) + "\n";

        result += "*****\n";
    }

    ui->logBrowser->setText(result);
}

void MainWindow::on_addButton_clicked()
{
    Cargo c;
    c.set_weight(ui->weightEdit->text().toDouble());
    c.set_length(ui->lengthEdit->text().toDouble());
    c.set_volume(ui->volumeEdit->text().toDouble());
    c.set_pallets(ui->palletsEdit->text().toInt());

    cargos.push_back(c);
    updateLog();
}

void MainWindow::on_temperatureCheckBox_stateChanged(int arg1)
{
    ui->temperatureSlider->setEnabled(arg1);
}
