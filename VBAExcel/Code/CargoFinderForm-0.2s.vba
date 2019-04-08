Public Function ValidateAll() As Boolean    ' 	Проверка всех полей на корректность
	If Not IsNumeric(weightEdit) Then ' 		Если поле содержит нечисловое значение
		MsgBox ("Вес должен быть числом") ' 	То мы останавливаемся
		weightEdit.SetFocus
		ValidateAll = False					' 	И выходим из функции, возвращая False
		Exit Function
	End If

	If Not IsNumeric(lengthEdit) Then      '	Аналогично поступаем для всех полей
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

	If temperatureCheckBox = True Then 		'	Для полей с температурой проверка 
											'	имеет смысл, только если в чекбоксе
		If Not IsNumeric(minTempEdit) Then	'	стоит галочка
			MsgBox ("Температура должны быть числом")
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

		If CInt(minTempEdit) > CInt(maxTempEdit) Then
			Dim temp As String
			temp = minTempEdit
			minTempEdit = maxTempEdit
			maxTempEdit = temp 
		End If

	End If
	ValidateAll = True
End Function

Private Sub updateSheet()     
	Worksheets("Results").UsedRange.ClearContents
	Dim sheet As Worksheet
	Set sheet = ActiveSheet
	sheet.Rows(3).EntireRow.Copy Worksheets("Results").Rows(1)
End Sub

Private Sub submitButton_Click()
	If Not ValidateAll Then
		Exit Sub
	End If

	updateSheet

	Dim myStart, myDest As String
    Dim myWeight, myVolume, myLength As Double
    Dim myRef As Boolean
    Dim myMinTemp, myMaxTemp As Integer

    myStart = CStr(startBox)
    myDest = CStr(destinationBox)
    myWeight = CDbl(weightEdit)
    myVolume = CDbl(volumeEdit)
    myLength = CDbl(lengthEdit)
    myRef = temperatureCheckBox
    If myRef Then
        myMinTemp = CInt(minTempEdit)
        myMaxTemp = CInt(maxTempEdit)
    End If

    Worksheets("MainTable").Activate

    Dim i As Integer
    Dim lastRow As Long
    Dim rw As Range
    
    Dim weight, volume, length As Double
    Dim minTemp, maxTemp As Integer
    Dim start, dest As String
    Dim ref, accept As Boolean
    
    lastRow = Cells(Rows.Count, "A").End(xlUp).Row

    For i = 4 To lastRow Step 1
        ref = False
        
        start = CStr(Cells(i, "B"))
        dest = CStr(Cells(i, "C"))
        weight = CDbl(Cells(i, "F"))
        volume = CDbl(Cells(i, "D"))
        If IsNumeric(Cells(i, "E")) Then
            length = CDbl(Cells(i, "E"))
        Else
            length = 0
        End If
        
        If Not IsEmpty(Cells(i, "G")) And Not IsEmpty(Cells(i, "H")) And _
             IsNumeric(Cells(i, "G")) And IsNumeric(Cells(i, "H")) Then
            ref = True
            minTemp = CInt(Cells(i, "G"))
            maxTemp = CInt(Cells(i, "H"))
        End If
        
        Dim ok As Boolean
        ok = myWeight >= weight And myLength >= length And myVolume >= volume
        ok = ok And ((ref And myRef And myMinTemp <= maxTemp And myMaxTemp >= minTemp) Or Not ref)
        ok = ok And (myStart = "Any" Or myStart = start) And (myDest = "Any" Or myDest = dest)
        
        If ok Then
            pushRow (Rows(i))
        End If
    Next i

    Unload Me
End Sub

Private Sub pushRow(ByRef rw As Range)
	Dim lastRow As Integer
	lastRow = Worksheets("Results").Cells(Rows.Count, "A").End(xlUp).Row + 1
	rw.EntireRow.Copy (Worksheets("Results").Rows(lastRow))
End Sub

Private Sub temperatureCheckBox_Click()
	If temperatureCheckBox.Value = True Then
		minTempEdit.Locked = False
		maxTempEdit.Locked = False
	Else
		minTempEdit.Locked = True
		maxTempEdit.Locked = True
		minTempEdit = ""
		maxTempEdit = ""
	End If
End Sub