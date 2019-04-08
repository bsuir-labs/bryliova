Public Function ValidateAll() As Boolean
	If Not IsNumeric(weightEdit) Then
		MsgBox ("Вес должен быть числом")
		weightEdit.SetFocus
		ValidateAll = False
		Exit Function
	End If

	If Not IsNumeric(lengthEdit) Then
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

	If temperatureCheckBox = True Then

		If Not IsNumeric(minTempEdit) Then
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

    myStart = CStr(startBox.Text)
    myDest = CStr(destinationBox.Text)
    myWeight = CDbl(weightEdit.Value)
    myVolume = CDbl(volumeEdit.Value)
    myLength = CDbl(lengthEdit.Value)
    myRef = temperatureCheckBox.Value
    If myRef Then
        myMinTemp = CInt(minTempEdit.Value)
        myMaxTemp = CInt(maxTempEdit.Value)
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
        
        start = CStr(Cells(i, "B").Value)
        dest = CStr(Cells(i, "C").Value)
        weight = CDbl(Cells(i, "F").Value)
        volume = CDbl(Cells(i, "D").Value)
        If IsNumeric(Cells(i, "E").Value) Then
            length = CDbl(Cells(i, "E").Value)
        Else
            length = 0
        End If
        
        If Not IsEmpty(Cells(i, "G").Value) And Not IsEmpty(Cells(i, "H").Value) And _
             IsNumeric(Cells(i, "G").Value) And IsNumeric(Cells(i, "H").Value) Then
            ref = True
            minTemp = CInt(Cells(i, "G").Value)
            maxTemp = CInt(Cells(i, "H").Value)
        End If
        
        accept = False
        
        Dim ok As Boolean
        ok = myWeight >= weight And myLength >= length And myVolume >= volume
        ok = ok And ((ref And myRef And myMinTemp <= maxTemp And myMaxTemp >= minTemp) Or Not ref)
        ok = ok And (myStart = "Any" Or myStart = start) And (myDest = "Any" Or myDest = dest)
        'Debug.Print (myStart + " " + start + " " + myDest + " " + dest + "\n")
        
        
        
        If ok Then
            'MsgBox (.Cells(i, "A").Value)
            pushRow (Rows(i))
        End If
    Next i

    Unload Me
End Sub