#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include <vector>
#include "cargo.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_addButton_clicked();

    void on_temperatureCheckBox_stateChanged(int arg1);

private:
    Ui::MainWindow *ui;
    std::vector<Cargo> cargos;

    void updateLog();
    void updateCargoListWidget(std::vector<Cargo>::iterator element);
    QWidget* check_fields();
};

#endif // MAINWINDOW_H
