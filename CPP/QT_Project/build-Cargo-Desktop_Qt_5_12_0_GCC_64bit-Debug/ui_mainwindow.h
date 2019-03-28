/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 5.12.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QCheckBox>
#include <QtWidgets/QDateTimeEdit>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSlider>
#include <QtWidgets/QTextBrowser>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralWidget;
    QLabel *weightLabel;
    QLineEdit *weightEdit;
    QLabel *volumeLabel;
    QLineEdit *volumeEdit;
    QLabel *lengthLabel;
    QLineEdit *lengthEdit;
    QLabel *palletsLabel;
    QLineEdit *palletsEdit;
    QCheckBox *temperatureCheckBox;
    QSlider *temperatureSlider;
    QDateTimeEdit *startDateTimeEdit;
    QDateTimeEdit *endDateTimeEdit;
    QTextBrowser *logBrowser;
    QPushButton *addButton;
    QLabel *label;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(508, 418);
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        weightLabel = new QLabel(centralWidget);
        weightLabel->setObjectName(QString::fromUtf8("weightLabel"));
        weightLabel->setGeometry(QRect(20, 40, 61, 15));
        weightEdit = new QLineEdit(centralWidget);
        weightEdit->setObjectName(QString::fromUtf8("weightEdit"));
        weightEdit->setGeometry(QRect(20, 60, 113, 23));
        volumeLabel = new QLabel(centralWidget);
        volumeLabel->setObjectName(QString::fromUtf8("volumeLabel"));
        volumeLabel->setGeometry(QRect(140, 40, 61, 15));
        volumeEdit = new QLineEdit(centralWidget);
        volumeEdit->setObjectName(QString::fromUtf8("volumeEdit"));
        volumeEdit->setGeometry(QRect(140, 60, 113, 23));
        lengthLabel = new QLabel(centralWidget);
        lengthLabel->setObjectName(QString::fromUtf8("lengthLabel"));
        lengthLabel->setGeometry(QRect(260, 40, 61, 15));
        lengthEdit = new QLineEdit(centralWidget);
        lengthEdit->setObjectName(QString::fromUtf8("lengthEdit"));
        lengthEdit->setGeometry(QRect(260, 60, 113, 23));
        palletsLabel = new QLabel(centralWidget);
        palletsLabel->setObjectName(QString::fromUtf8("palletsLabel"));
        palletsLabel->setGeometry(QRect(380, 40, 61, 15));
        palletsEdit = new QLineEdit(centralWidget);
        palletsEdit->setObjectName(QString::fromUtf8("palletsEdit"));
        palletsEdit->setGeometry(QRect(380, 60, 113, 23));
        temperatureCheckBox = new QCheckBox(centralWidget);
        temperatureCheckBox->setObjectName(QString::fromUtf8("temperatureCheckBox"));
        temperatureCheckBox->setGeometry(QRect(20, 100, 181, 21));
        temperatureSlider = new QSlider(centralWidget);
        temperatureSlider->setObjectName(QString::fromUtf8("temperatureSlider"));
        temperatureSlider->setEnabled(false);
        temperatureSlider->setGeometry(QRect(20, 130, 471, 16));
        temperatureSlider->setMinimum(-25);
        temperatureSlider->setMaximum(25);
        temperatureSlider->setOrientation(Qt::Horizontal);
        startDateTimeEdit = new QDateTimeEdit(centralWidget);
        startDateTimeEdit->setObjectName(QString::fromUtf8("startDateTimeEdit"));
        startDateTimeEdit->setGeometry(QRect(20, 150, 194, 24));
        endDateTimeEdit = new QDateTimeEdit(centralWidget);
        endDateTimeEdit->setObjectName(QString::fromUtf8("endDateTimeEdit"));
        endDateTimeEdit->setGeometry(QRect(250, 150, 194, 24));
        logBrowser = new QTextBrowser(centralWidget);
        logBrowser->setObjectName(QString::fromUtf8("logBrowser"));
        logBrowser->setGeometry(QRect(20, 220, 471, 192));
        addButton = new QPushButton(centralWidget);
        addButton->setObjectName(QString::fromUtf8("addButton"));
        addButton->setGeometry(QRect(20, 190, 471, 23));
        label = new QLabel(centralWidget);
        label->setObjectName(QString::fromUtf8("label"));
        label->setGeometry(QRect(20, 0, 471, 31));
        QFont font;
        font.setFamily(QString::fromUtf8("DejaVu Serif"));
        font.setPointSize(16);
        font.setBold(true);
        font.setItalic(true);
        font.setWeight(75);
        label->setFont(font);
        label->setAlignment(Qt::AlignCenter);
        MainWindow->setCentralWidget(centralWidget);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "MainWindow", nullptr));
        weightLabel->setText(QApplication::translate("MainWindow", "Weight:", nullptr));
        volumeLabel->setText(QApplication::translate("MainWindow", "Volume:", nullptr));
        lengthLabel->setText(QApplication::translate("MainWindow", "Length:", nullptr));
        palletsLabel->setText(QApplication::translate("MainWindow", "Pallets:", nullptr));
        temperatureCheckBox->setText(QApplication::translate("MainWindow", "Temperature conditions", nullptr));
        addButton->setText(QApplication::translate("MainWindow", "Add cargo", nullptr));
        label->setText(QApplication::translate("MainWindow", "Cargo adder ultimate 2019 XXL", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
