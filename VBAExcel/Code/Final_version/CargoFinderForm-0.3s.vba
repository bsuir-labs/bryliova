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
    Dim mainSheet, resultSheet As Worksheet
    Set mainSheet = Worksheets("MainTable")
    Set resultSheet = Worksheets("Results")

    resultSheet.UsedRange.ClearContents
    
    Dim i As Integer
    For i = Asc("A") To Asc("I")
        resultSheet.Cells(1, Chr(i)) = Cells(3, Chr(i))
    Next i
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

    Dim i, resultsLastRow As Integer
    Dim lastRow As Long
    Dim rw As Range
    Dim c As Integer
    
    Dim weight, volume, length As Double
    Dim minTemp, maxTemp As Integer
    Dim start, dest As String
    Dim ref, accept As Boolean

    Dim resultsSheet As Worksheet
    Set resultsSheet = Worksheets("Results")
    
    lastRow = Cells(Rows.Count, "A").End(xlUp).Row
    MsgBox (Rows.Count)
    resultsLastRow = 2

    For i = 4 To lastRow
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
                                            
            For c = Asc("A") To Asc("I")
                resultsSheet.Cells(resultsLastRow, Chr(c)) = Cells(i, Chr(c))
            Next c
            resultsLastRow = resultsLastRow + 1
        End If
    Next i

    For c = Asc("A") To Asc("I")
        resultsSheet.Range(Chr(c) & "1").EntireColumn.AutoFit
    Next c

    Unload Me
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

