VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "RangeLib"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'''<classSummary>Range���g���Ă悭�s�����\�b�h���܂Ƃ߂� �ÓI�N���X
'''<updateDate>2020/9/1
'''<version> Ver.100
'''<remarks> ���̃N���X�̓C���X�^���X���Z�b�g���Ȃ��Ă��g�p�ł���B�G�N�Z���݂̂Ŏg�p�\

'''<summary> �ŏI�s���擾����
'''<param> ��_�ɂ���Cell
'''<returns> �ŏI�s�̔ԍ�
'''<remarks>�t�B���^�����Ă��Ȃ�����
Public Function RowBottom(ByVal Cell As Range) As Long
    RowBottom = Cell.End(xlDown).Row
End Function

'''<summary> �ŏI����擾����
'''<param> ��_�ɂ���Cell
'''<returns> �ŏI��̔ԍ�
'''<remarks>�t�B���^�����Ă��Ȃ�����
Public Function RightCol(ByVal Cell As Range) As Long
    RightCol = Cell.End(xlToRight).Column
End Function

'''<summary> Range��CurrentRegion�̉��ǔŁA��_�ɂ���Cell���A���A��ɂ͎擾���Ȃ��B��͎w����\
'''<param> ��_�ɂ���Cell�A[��̎w��]
'''<returns> �󔒂̍s�Ƌ󔒂̗�̔C�ӂ̑g�ݍ��킹�ň͂܂ꂽ�͈�
'''<remarks>�t�B���^�����Ă��Ȃ����ƁB��̎w�肪�Ȃ��ꍇ�͋󔒂̗�܂ł͈̔�
Public Function CurrentRegion(ByVal Cell As Range, Optional ByVal Col As Long = -1) As Range

    If Col < 1 Then Col = Me.RightCol(Cell)
    Dim cell2 As Range
    Set cell2 = Cell.Parent.Cells(Me.RowBottom(Cell), Col)
    Set CurrentRegion = Range(Cell, cell2)
    
End Function

'''<summary> ��_�ƂȂ�s�̉��ɍs��ǉ����āA�R�s�[����
'''<param> �R�s�[���ƂȂ�s�A�ǉ�����s��
'''<returns> �Ȃ�
Public Function InsertRowCopy(ByVal SourceRows As Range, ByVal AddRows As Long)
    Dim insertRows As String
    insertRows = CStr(SourceRows.Row + 1) & ":" & CStr(SourceRows.Row + AddRows)
    Cells.Rows(insertRows).Insert
    Cells.Rows(SourceRows.Row).Copy Cells.Rows(insertRows)
End Function

'''<summary> Range�̗�ԍ�(�A���t�@�x�b�g)�𐔒l�ɕϊ�����
'''<param> ��ԍ�(�A���t�@�x�b�g)
'''<returns> ��ԍ�(���l)
Public Function ColToInt(ByVal ColAlphabet As String) As Long
    ColToInt = Range(ColAlphabet & "1").Column
End Function