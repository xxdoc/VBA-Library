VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ListFunc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'''<classSummary> �R�[���o�b�N�p�̊֐����L�����邽�߂̃N���X
'''<updateDate> 2020/9/16
'''<version> Ver.100
'''<remarks> Lists�^���K�v�ł�

'''<summary>Sample
' Public Function Under(ByVal Args As Variant) As Variant 'Varinat Fixed
'     Dim Value As Variant
'     Dim Index As Long
'     Value = Args(0)    'Arg(0) Fixed value, List value
'     Index = Args(1)    'Arg(1) Fixed value, List index
'     Dim num As Long
'     num = Args(2)
'     If Value < num Then
'         Under = Value
'     End If
' End Function