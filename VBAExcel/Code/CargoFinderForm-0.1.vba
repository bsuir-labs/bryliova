Public Function ValidateAll() As Boolean                ' функция проверки на правильность всех полей
    With CargoFinderForm
        If Not IsNumeric(.weightEdit.Value) Then
            MsgBox ("Weight should be numeric")
            .weightEdit.SetFocus
            ValidateAll = False
            Exit Function
        End If
        
        If Not IsNumeric(.lengthEdit.Value) Then
            MsgBox ("Length should be numeric")
            .lengthEdit.SetFocus
            ValidateAll = False
            Exit Function
        End If
        
        If Not IsNumeric(.volumeEdit.Value) Then
            MsgBox ("Volume should be numeric")
            .volumeEdit.SetFocus
            ValidateAll = False
            Exit Function
        End If
        
        If .temperatureCheckBox.Object.Value = True Then
        
            If Not IsNumeric(.minTempEdit.Value) Then
                MsgBox ("Temperature should be numeric")
                .minTempEdit.SetFocus
                ValidateAll = False
                Exit Function
            End If
            
            If Not IsNumeric(.maxTempEdit.Value) Then
                MsgBox ("Temperature should be numeric")
                .maxTempEdit.SetFocus
                ValidateAll = False
                Exit Function
            End If
            
            If CInt(.minTempEdit.Value) > CInt(.maxTempEdit.Value) Then
                Dim temp As String
                temp = .minTempEdit.Value
                .minTempEdit.Value = .maxTempEdit.Value
                .maxTempEdit.Value = temp
            End If
        End If
        
    End With

    ValidateAll = True
End Function

Private Sub updateSheet()
    If Not CreateSheetIf("Results") Then
        ThisWorkbook.Sheets("Results").UsedRange.ClearContents
    End If
    Dim sheet As Worksheet
    Set sheet = ActiveSheet
    sheet.Rows(3).EntireRow.Copy ThisWorkbook.Sheets("Results").Rows(1)
End Sub

Private Sub submitButton_Click()
    If Not ValidateAll Then
        Exit Sub
    End If
    
    ' The program
    updateSheet
    
    Dim myStart, myDest As String
    Dim myWeight, myVolume, myLength As Double
    Dim myRef As Boolean
    Dim myMinTemp, myMaxTemp As Integer
    
    With CargoFinderForm
        myStart = CStr(.startBox.Text)
        myDest = CStr(.destinationBox.Text)
        myWeight = CDbl(.weightEdit.Value)
        myVolume = CDbl(.volumeEdit.Value)
        myLength = CDbl(.lengthEdit.Value)
        myRef = .temperatureCheckBox.Value
        If myRef Then
            myMinTemp = CInt(.minTempEdit.Value)
            myMaxTemp = CInt(.maxTempEdit.Value)
        End If
    End With
    
    
    Dim sheet As Worksheet
    Set sheet = ActiveSheet
    
    With sheet
        Dim i As Integer
        Dim lastRow As Long
        Dim rw As Range
        
        Dim weight, volume, length As Double
        Dim minTemp, maxTemp As Integer
        Dim start, dest As String
        Dim ref, accept As Boolean
        
        lastRow = .Cells(.Rows.Count, "A").End(xlUp).Row
    
        For i = 4 To lastRow Step 1
            ref = False
            
            start = CStr(.Cells(i, "B").Value)
            dest = CStr(.Cells(i, "C").Value)
            weight = CDbl(.Cells(i, "F").Value)
            volume = CDbl(.Cells(i, "D").Value)
            If IsNumeric(.Cells(i, "E").Value) Then
                length = CDbl(.Cells(i, "E").Value)
            Else
                length = 0
            End If
            
            If Not IsEmpty(.Cells(i, "G").Value) And Not IsEmpty(.Cells(i, "H").Value) And _
                 IsNumeric(.Cells(i, "G").Value) And IsNumeric(.Cells(i, "H").Value) Then
                ref = True
                minTemp = CInt(.Cells(i, "G").Value)
                maxTemp = CInt(.Cells(i, "H").Value)
            End If
            
            accept = False
            
            Dim ok As Boolean
            ok = myWeight >= weight And myLength >= length And myVolume >= volume
            ok = ok And ((ref And myRef And myMinTemp <= maxTemp And myMaxTemp >= minTemp) Or Not ref)
            ok = ok And (myStart = "Any" Or myStart = start) And (myDest = "Any" Or myDest = dest)
            'Debug.Print (myStart + " " + start + " " + myDest + " " + dest + "\n")
            
            
            
            If ok Then
                'MsgBox (.Cells(i, "A").Value)
                pushRow (.Rows(i))
            End If
        Next i
    End With
    
    Unload Me
End Sub

Function CreateSheetIf(strSheetName As String) As Boolean
    Dim wsTest As Worksheet
    CreateSheetIf = False
    
    Set wsTest = Nothing
    On Error Resume Next
    Set wsTest = ActiveWorkbook.Worksheets(strSheetName)
    On Error GoTo 0
     
    If wsTest Is Nothing Then
        CreateSheetIf = True
        Worksheets.Add.Name = strSheetName
    End If

End Function

Private Sub pushRow(ByRef rw As Range)
    With ThisWorkbook
        Dim ws As Worksheet
        Dim sheetName As String
                
        'CreateSheetIf ("Results")
    
        Set ws = .Sheets("Results")
                'ws.UsedRange.ClearContents ' Deleting old info
        Dim lastRow As Integer
        lastRow = ws.Cells(Rows.Count, "A").End(xlUp).Row + 1
        rw.EntireRow.Copy (ws.Rows(lastRow))
        
    End With
End Sub

' Temperature enabled
Private Sub temperatureCheckBox_Click()
    If CargoFinderForm.temperatureCheckBox.Value = True Then
        With CargoFinderForm
            .minTempEdit.Locked = False
            .maxTempEdit.Locked = False
        End With
    Else
        With CargoFinderForm
            .minTempEdit.Locked = True
            .maxTempEdit.Locked = True
            .minTempEdit.Value = ""
            .maxTempEdit.Value = ""
        End With
    End If
    
End Sub

