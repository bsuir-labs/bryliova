Private Sub updateSheet()                               ' Подготовим лист с результатами
    Dim mainSheet, resultSheet As Worksheet             ' Объявим переменные для удобства
    Set mainSheet = Worksheets("MainTable")             ' Главный лист с основной таблицей
    Set resultSheet = Worksheets("Results")             ' А тут результаты

    resultSheet.UsedRange.ClearContents                 ' Очистим лист с результатами от мусора
    
    Dim i As Integer
    For i = Asc("A") To Asc("I")                        ' Перенесём шапку из главной таблицы
        resultSheet.Cells(1, Chr(i)) = Cells(3, Chr(i))
    Next i
End Sub

Private Sub submitButton_Click()                        ' Итак, начинаем работу
    updateSheet                                         ' Вызовем функцию для подготовки листа с рез-тами (см выше)

    Dim myStart, myDest As String                       ' Объявим все переменные для работы
    Dim myWeight, myVolume, myLength As Double
    Dim myRef As Boolean
    Dim myMinTemp, myMaxTemp As Integer

    myStart = startBox                                  ' Положим сюда значение поля "откуда"
    myDest = destinationBox                             ' CStr - "Convert to String"
    myWeight = Val(weightEdit)                         ' CDbl - "Convert to Double"
    myVolume = Val(volumeEdit)
    myLength = Val(lengthEdit)
    myRef = temperatureCheckBox
    If myRef Then
        myMinTemp = Val(minTempEdit)                   ' CInt - "Convert to Integer"
        myMaxTemp = Val(maxTempEdit)
    End If

    Worksheets("MainTable").Activate

    Dim i, resultsLastRow As Integer                    ' Объявим ещё переменных для удобства
    Dim lastRow As Long
    Dim rw As Range
    Dim c As Integer
    
    Dim weight, volume, length As Double
    Dim minTemp, maxTemp As Integer
    Dim start, dest As String
    Dim ref, accept As Boolean

    Dim resultsSheet As Worksheet
    Set resultsSheet = Worksheets("Results")
    
    lastRow = Cells(Rows.Count, "A").End(xlUp).Row      ' Поиск номера последней строки в таблице
    resultsLastRow = 2                                  ' Я не знаю, как это сделать проще

    For i = 4 To lastRow                                ' Идём по строкам таблицы и сравниваем значения
        ref = False
        
        start = Cells(i, "B")                           ' Откуда
        dest = Cells(i, "C")                            ' Куда, и т.д.
        weight = Val(Cells(i, "F"))
        volume = Val(Cells(i, "D"))
        If IsNumeric(Cells(i, "E")) Then
            length = Val(Cells(i, "E"))
        Else
            length = 0
        End If
        
        If Not IsEmpty(Cells(i, "G")) And Not IsEmpty(Cells(i, "H")) And _
             IsNumeric(Cells(i, "G")) And IsNumeric(Cells(i, "H")) Then                 ' Разбирательства с температурой
            ref = True
            minTemp = Val(Cells(i, "G"))
            maxTemp = Val(Cells(i, "H"))
        End If
        
        Dim ok As Boolean                                                                               ' Чтоб проверить, подходит ли груз, создадим для удобства переменную
        ok = myWeight >= weight And myLength >= length And myVolume >= volume                           ' Сравним вес, длину, объём
        ok = ok And ((ref And myRef And myMinTemp <= maxTemp And myMaxTemp >= minTemp) Or Not ref)      ' Если требуется - сравним температуры
        ok = ok And (myStart = "Any" Or myStart = start) And (myDest = "Any" Or myDest = dest)          ' И конечно, сравним пункт назначения и отправления
        
        If ok Then                          ' Если всё ещё тут True,
                                            ' значит, груз нам подходит
            For c = Asc("A") To Asc("I")
                resultsSheet.Cells(resultsLastRow, Chr(c)) = Cells(i, Chr(c))   ' Переносим его в таблицу результатов
            Next c
            resultsLastRow = resultsLastRow + 1     ' Увеличим счётчик последней строки в результатах (сюда положим следующий подходящий груз)
        End If
    Next i

    For c = Asc("A") To Asc("I")
        resultsSheet.Range(Chr(c) & "1").EntireColumn.AutoFit  ' Подгоним размеры столбцов
    Next c

    Unload Me           ' Закрываем форму, когда всё выполнилось
End Sub

Private Sub temperatureCheckBox_Click()             ' Если изменили состояние чекбокса
    If temperatureCheckBox.Value = True Then        ' Если галочку поставили
        minTempEdit.Locked = False                  ' Активируем поля для температуры
        maxTempEdit.Locked = False
    Else                                            ' А если убрали -
        minTempEdit.Locked = True                   ' Блокируем
        maxTempEdit.Locked = True
        minTempEdit = ""
        maxTempEdit = ""
    End If
End Sub

