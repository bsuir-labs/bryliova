Public Function ValidateAll() As Boolean    '   Проверка всех полей на корректность
    If Not IsNumeric(weightEdit) Then '         Если поле содержит нечисловое значение
        MsgBox ("Вес должен быть числом") '     То мы останавливаемся
        weightEdit.SetFocus
        ValidateAll = False                 '   И выходим из функции, возвращая False
        Exit Function
    End If

    If Not IsNumeric(lengthEdit) Then      '    Аналогично поступаем для всех полей
        MsgBox ("Длина должна быть числом")
        lengthEdit.SetFocus
        ValidateAll = False
        Exit Function
    End If

    If Not IsNumeric(volumeEdit) Then
        MsgBox ("Объём должен быть числом")
        volumeEdit.SetFocus
        ValidateAll = False
        Exit Function
    End If

    If temperatureCheckBox = True Then      '   Для полей с температурой проверка
                                            '   имеет смысл, только если в чекбоксе
        If Not IsNumeric(minTempEdit) Then  '   стоит галочка
            MsgBox ("Температура должна быть числом")
            minTempEdit.SetFocus
            ValidateAll = False
            Exit Function
        End If

        If Not IsNumeric(maxTempEdit) Then
            MsgBox ("Температура должны быть числом")
            maxTempEdit.SetFocus
            ValidateAll = False
            Exit Function
        End If

        If CInt(minTempEdit) > CInt(maxTempEdit) Then  ' Проверяем, что минимальная температура
            Dim temp As String                         ' меньше максимальной
            temp = minTempEdit                         ' И если такое вдруг случилось - не беда
            minTempEdit = maxTempEdit                  ' Просто поменяем их местами
            maxTempEdit = temp
        End If

    End If
    ValidateAll = True  ' Если прошли все проверки - вернём True
End Function

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
    If Not ValidateAll Then                             ' Проверим все поля на корректность (см выше)
        Exit Sub                                        ' Если что-то не так - останавливаемся
    End If

    updateSheet                                         ' Вызовем функцию для подготовки листа с рез-тами (см выше)

    Dim myStart, myDest As String                       ' Объявим все переменные для работы
    Dim myWeight, myVolume, myLength As Double
    Dim myRef As Boolean
    Dim myMinTemp, myMaxTemp As Integer

    myStart = CStr(startBox)                            ' Положим сюда значение поля "откуда"
    myDest = CStr(destinationBox)                       ' CStr - "Convert to String"
    myWeight = CDbl(weightEdit)                         ' CDbl - "Convert to Double"
    myVolume = CDbl(volumeEdit)
    myLength = CDbl(lengthEdit)
    myRef = temperatureCheckBox
    If myRef Then
        myMinTemp = CInt(minTempEdit)                   ' CInt - "Convert to Integer"
        myMaxTemp = CInt(maxTempEdit)
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
    MsgBox (Rows.Count)
    resultsLastRow = 2                                  ' Я не знаю, как это сделать проще

    For i = 4 To lastRow                                ' Идём по строкам таблицы и сравниваем значения
        ref = False
        
        start = CStr(Cells(i, "B"))                     ' Откуда
        dest = CStr(Cells(i, "C"))                      ' Куда, и т.д.
        weight = CDbl(Cells(i, "F"))
        volume = CDbl(Cells(i, "D"))
        If IsNumeric(Cells(i, "E")) Then
            length = CDbl(Cells(i, "E"))
        Else
            length = 0
        End If
        
        If Not IsEmpty(Cells(i, "G")) And Not IsEmpty(Cells(i, "H")) And _
             IsNumeric(Cells(i, "G")) And IsNumeric(Cells(i, "H")) Then                 ' Разбирательства с температурой
            ref = True
            minTemp = CInt(Cells(i, "G"))
            maxTemp = CInt(Cells(i, "H"))
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

