' USER FORM 1
Private Sub CommandButton1_Click()
Range("2:2").Clear
Range("2:2").Font.Name = "Impact"
Cells(2, 1).Font.Size = 10
  For I = 1 To Val(TextBox1)
  Range("2:2").Font.ColorIndex = 12
   Cells(2, I) = "hello"
   Cells(2, I + 1).Font.Size = Cells(2, I).Font.Size + I * 2
Next I
End Sub

Private Sub CommandButton2_Click()
TextBox2.MultiLine = True
TextBox2.WordWrap = True
TextBox2.ScrollBars = 3
TextBox2.Font.Bold = True
TextBox2.Font.Name = "Times New Roman"
TextBox2.FontSize = 8
TextBox2.ForeColor = vbBlue
TextBox2 = ""
For I = 1 To Val(TextBox1)
TextBox2 = TextBox2 & "hello" & Chr(13)
Next I
End Sub

Private Sub CommandButton4_Click()
'End
End Sub

Private Sub CommandButton5_Click()
Worksheets("Лист1").Activate
UserForm1.Caption = "печать приветов"
Range("A:A").Clear
Range("A:A").Font.Name = "Impact"
Cells(1, 1).Font.Size = 10
  For I = 1 To Val(TextBox1)
  Range("A:A").Font.ColorIndex = 10
   Cells(I, 1) = "hello"
   Cells(I + 1, 1).Font.Size = Cells(I, 1).Font.Size + I * 2
Next I
End Sub

Private Sub CommandButton6_Click()
TextBox2 = ""
For I = 0 To 25 Step 5
TextBox2 = TextBox2 & I & Chr(13)
Next I
End Sub

Private Sub CommandButton7_Click()
Range("2:2").Clear
I = 1
For j = 0 To 25 Step 5
Cells(I, 2) = j
I = I + 1
Next j
End Sub


' USER FORM 2
Private Sub CommandButton1_Click()
Dim Ss, kol, x As String
kol = 0
Ss = 0
TextBox1 = ""
x = Val(InputBox("введите очередное число, нажимая ОК" & _
Chr(13) & "для завершения ввода нажмите Cancel"))
   Do Until x = ""
    kol = kol + 1
    Ss = Ss + Val(x)
    TextBox1 = TextBox1 & x & ";"
    x = InputBox("введите очередное число")
    Loop
    TextBox2 = kol
    TextBox3 = Ss
    TextBox4 = Ss / kol
End Sub

Private Sub CommandButton2_Click()
Worksheets("Лист2").Activate
kol = 0
Ss = 0
  For I = 1 To 10
  x = Cells(I, 1)
  If x = "" Then Exit For
  kol = kol + 1
  Ss = Ss + x
  Next
    Cells(1, 3) = "количество чисел=" & kol
    Cells(2, 3) = "сумма чисел=" & Ss
    Cells(3, 3) = "среднее=" & Ss / kol
End Sub


' USER FORM 3
Private Sub CommandButton1_Click()
Dim n, K As Integer
Sum = 0
n = Val(TextBox1)
For K = 1 To n
Sum = Sum + ((2 * K + 1) / ((2 * K ^ 2 + 3) * K))
Next K
TextBox2 = Sum
End Sub

Private Sub CommandButton2_Click()
Dim n, K As Integer
e = Val(TextBox4)
n = Val(TextBox1)
Sum = 0
For K = 1 To n
If K >= e Then Sum = Sum + ((2 * K + 1) / ((2 * K ^ 2 + 3) * K))
Next K
TextBox3 = Sum
End Sub

Private Sub CommandButton3_Click()
TextBox1 = ""
TextBox2 = ""
TextBox3 = ""
TextBox4 = ""
End Sub

Private Sub CommandButton4_Click()
'End
End Sub
