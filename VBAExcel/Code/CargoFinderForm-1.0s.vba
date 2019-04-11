Private Sub submitButton_Click()
    Dim mainSheet, resultSheet As Worksheet
    Set mainSheet = Worksheets("MainTable")
    Set resultSheet = Worksheets("Results")

    resultSheet.UsedRange.ClearContents  

    resultSheet.Cells(1, "A") = Cells(3, "A")
    resultSheet.Cells(1, "B") = Cells(3, "B")
    resultSheet.Cells(1, "C") = Cells(3, "C")
    resultSheet.Cells(1, "D") = Cells(3, "D")
    resultSheet.Cells(1, "E") = Cells(3, "E")
    resultSheet.Cells(1, "F") = Cells(3, "F")
    resultSheet.Cells(1, "G") = Cells(3, "G")
    resultSheet.Cells(1, "H") = Cells(3, "H")
    resultSheet.Cells(1, "I") = Cells(3, "I")


    Dim myStart, myDest As String
    Dim myWeight, myVolume, myLength As Double
    Dim myRef As Boolean
    Dim myMinTemp, myMaxTemp As Integer

    myStart = startBox
    myDest = destinationBox
    myWeight = Val(weightEdit)
    myVolume = Val(volumeEdit)
    myLength = Val(lengthEdit)
    myRef = temperatureCheckBox
    If myRef Then
        myMinTemp = Val(minTempEdit)
        myMaxTemp = Val(maxTempEdit)
    End If

    Worksheets("MainTable").Activate

    Dim weight, volume, length As Double
    Dim minTemp, maxTemp, i, resultsLastRow As Integer
    Dim start, dest As String
    Dim ref As Boolean

    resultsLastRow = 2

    For i = 4 To 1000 ' for example
        ref = False
        
        start = Cells(i, "B")
        dest = Cells(i, "C")
        weight = Val(Cells(i, "F"))
        volume = Val(Cells(i, "D"))
        length = Val(Cells(i, "E"))
        
        If Not Cells(i, "G") = "" And Not Cells(i, "H") = "" Then
            minTemp = Val(Cells(i, "G"))
            maxTemp = Val(Cells(i, "H"))
            ref = True
        End If

        Dim ok1, ok2, ok3 As Boolean
        ok1 = myWeight >= weight And myLength >= length And myVolume >= volume
        ok2 = (ref And myRef And myMinTemp <= maxTemp And myMaxTemp >= minTemp) Or Not ref
        ok3 = (myStart = "" Or myStart = start) And (myDest = "" Or myDest = dest)
        
        If ok1 And ok2 And ok3 Then             
            resultSheet.Cells(resultsLastRow, "A") = Cells(i, "A")
            resultSheet.Cells(resultsLastRow, "B") = Cells(i, "B")
            resultSheet.Cells(resultsLastRow, "C") = Cells(i, "C")
            resultSheet.Cells(resultsLastRow, "D") = Cells(i, "D")
            resultSheet.Cells(resultsLastRow, "E") = Cells(i, "E")
            resultSheet.Cells(resultsLastRow, "F") = Cells(i, "F")
            resultSheet.Cells(resultsLastRow, "G") = Cells(i, "G")
            resultSheet.Cells(resultsLastRow, "H") = Cells(i, "H")
            resultSheet.Cells(resultsLastRow, "I") = Cells(i, "I")
            resultsLastRow = resultsLastRow + 1
        End If
    Next i

    resultSheet.Range("A1:I1").EntireColumn.AutoFit

    Unload Me
End Sub