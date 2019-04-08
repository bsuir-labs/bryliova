Public Function GetUniqueValues(ByVal values As Variant) As Collection
    Dim result As Collection
    Dim cellValue As Variant
    Dim cellValueTrimmed As String

    Set result = New Collection
    Set GetUniqueValues = result

    On Error Resume Next

    For Each cellValue In values
        cellValueTrimmed = Trim(cellValue)
        If cellValueTrimmed = "" Then GoTo NextValue
        result.Add cellValueTrimmed, cellValueTrimmed
NextValue:
    Next cellValue
    

    On Error GoTo 0
End Function

Sub Test()
    CargoFinderForm.startBox.AddItem ("Any")
    CargoFinderForm.destinationBox.AddItem ("Any")
    
    With CargoFinderForm
        Dim sh As Worksheet
        Set sh = ActiveSheet
        
        Dim uniqueFrom, uniqueTo As Collection
        Dim fromSource, destinationSource As Range
        Set fromSource = sh.Range("B4:B65536")
        Set destinationSource = sh.Range("C4:C65536")
        
        Set uniqueFrom = GetUniqueValues(fromSource.Value)
        Set uniqueTo = GetUniqueValues(destinationSource.Value)
        
        Dim x
        
        For Each x In uniqueFrom
            .startBox.AddItem (CStr(x))
        Next x
        
        For Each x In uniqueTo
            .destinationBox.AddItem (CStr(x))
        Next x
        
        .startBox.ListIndex = 0
        .destinationBox.ListIndex = 0
        
    End With
    
    CargoFinderForm.Show
    Worksheets("Results").Activate
End Sub
