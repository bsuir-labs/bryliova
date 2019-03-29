#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->weightEdit->setValidator(new QDoubleValidator(0, 100, 4, this));
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

void MainWindow::updateCargoListWidget(std::vector<Cargo>::iterator element)
{
    QString rowstr;
    rowstr = element->name() + " (" +
             QString::number(element->weight()) + ")";
    ui->cargoListWidget->addItem(rowstr);
}

QWidget* MainWindow::check_fields()
{
    QWidget* failed = nullptr;
    if (ui->nameEdit->text() == "") failed = ui->nameEdit;
    if (ui->weightEdit->text() == "") failed = ui->weightEdit;
    if (ui->volumeEdit->text() == "") failed = ui->volumeEdit;
    return failed;
}

void MainWindow::on_addButton_clicked()
{
    {
        QWidget* failed = check_fields();
        if (failed != nullptr)
        {
            failed->setFocus(Qt::OtherFocusReason);
            return;
        }
    }

    Cargo c;
    c.set_weight(ui->weightEdit->text().toDouble());
    c.set_length(ui->lengthEdit->text().toDouble());
    c.set_volume(ui->volumeEdit->text().toDouble());
    c.set_pallets(ui->palletsEdit->text().toInt());
    c.set_name(ui->nameEdit->text());

    cargos.push_back(c);
    updateLog();

    // updating cargoWidget
    updateCargoListWidget(--cargos.end());
}

void MainWindow::on_temperatureCheckBox_stateChanged(int arg1)
{
    ui->temperatureSlider->setEnabled(arg1);
}
