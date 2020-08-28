VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "List"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'''<classSummary> Collection�Ƀ��\�b�h���g������List�^�A�L�[�͎g�p�ł��܂���B
'''<updateDate> 2020/8/28
'''<version> Ver.102

Enum ComparisonOperatorsEnum
    equal = 1
    notEqual = 2
    over = 3
    under = 4
    andOver = 5
    andUnder = 6
End Enum

Private Coll As Collection

'''<summary> ������Ԃ����߂̂���
'''<param> �Ȃ�
'''<returns> ���ȎQ��
Public Property Get self() As List
    Set self = Me
End Property

'''<summary> �I�u�W�F�N�g���Z�b�g
'''<param> �Ȃ�
'''<returns> �Ȃ�
Private Sub Class_Initialize()
    Set Coll = New Collection
End Sub

'''<summary> �v�f��ǉ�����
'''<param> �ǉ�����v�f (�I�u�W�F�N�g��z�񂻂̂��̂�����)
'''<returns> �Ȃ�
Public Function Add(ByVal Item As Variant)
    Coll.Add Item
End Function

'''<summary> �z��̒l�ARange�̒l�A�I�u�W�F�N�g�̊��胁���o�[�̒l���i�[����
'''<param> �ǉ�����v�f(Range)
'''<returns> �Ȃ�
Public Function AddValue(ByVal Items As Variant)
    On Error GoTo err
    Dim i
    If TypeName(Items) = "Range" Then
        Dim ItemArr() As Variant
        If Items.Count = 1 Then
            Coll.Add Items.Value
            Exit Function
        End If
        ItemArr() = Items.Value
        For Each i In ItemArr
            Coll.Add i
        Next
        Exit Function
    End If
    For Each i In Items
        Coll.Add i
    Next
    Exit Function
err:
    err.Raise Number:=1001, Description:="�N���X�FList�A���\�b�h�FAddValue�A�����̌^���K�؂ł͂���܂���B "
    
End Function

'''<summary> �v�f�̓��e��Ԃ�
'''<param> �C���f�b�N�X�ԍ�
'''<returns> ���e
'''<remarks> ���胁���o
Public Function Item(ByVal index As Long) As Variant
Attribute Item.VB_UserMemId = 0
    If VarType(Coll(index)) = vbObject Then
        Set Item = Coll(index)
    Else
        Item = Coll(index)
    End If
End Function

'''<summary> �v�f����Ԃ�
'''<param> �Ȃ�
'''<returns> �v�f��
Public Function Count() As Long
    Count = Coll.Count
End Function

'''<summary> �v�f�����폜����
'''<param> �폜����C���f�b�N�X�ԍ�
'''<returns> �Ȃ�
Public Function Remove(ByVal index As Long)
    Coll.Remove (index)
End Function

'''<summary> ���W����List���쐬����
'''<param> ��菜�������v�f��List
'''<returns> ��菜���ꂽList
Public Function Except(ByVal ExceptList As List) As List
    Dim lst As List
    Set lst = New List
    lst.AddValue Coll
    Dim e As Variant
    Dim index As Long
    For Each e In ExceptList
        index = 1
        Do While index <= lst.Count
            If e = lst(index) Then
                lst.Remove (index)
            Else
                index = index + 1
            End If
        Loop
    Next
    
    Set Except = lst

End Function

'''<summary> �v�f�ɏd�������邩���ׂ�
'''<param> �Ȃ�
'''<returns> �d��������ꍇ��True��Ԃ�
Public Function IsOverlap() As Boolean
    Dim buf As Collection
    Set buf = New Collection
    Dim c
    '�R���N�V�����̃L�[���d������ƃG���[�ɂȂ�Ȃ�̂𗘗p���Č�����
    On Error GoTo err
    For Each c In Coll
        buf.Add c, CStr(c)
    Next
    IsOverlap = False
    Exit Function
err:
    IsOverlap = True
End Function

'''<summary> �d�����Ȃ�List���쐬����
'''<param> �Ȃ�
'''<returns> �d�����폜����List
Public Function RemoveOverlap() As List
    Dim buf As Collection
    Set buf = New Collection
    Dim c As Variant
    '�R���N�V�����̃L�[���d������ƃG���[�ɂȂ�Ȃ�̂𗘗p���Č�����
    On Error Resume Next
    For Each c In Coll
        buf.Add c, CStr(c)
    Next
    Dim lst As List
    Set lst = New List
    lst.AddValue buf
    Set RemoveOverlap = lst
End Function

'''<summary> �d�������l�����X�g������
'''<param> �Ȃ�
'''<returns> �d�������l��List
Public Function OverlapList() As List
    Dim Overlap As List
    Set Overlap = New List
    Dim c1 As Variant
    Dim c2 As Variant
    Dim cnt As Long
    For Each c1 In Coll
        cnt = 0
        For Each c2 In Coll
            If c1 = c2 Then
                cnt = cnt + 1
                If cnt > 1 Then
                    Overlap.Add c1
                    Exit For
                End If
            End If
        Next
    Next
    Set Overlap = Overlap.RemoveOverlap

    Set OverlapList = Overlap
    
End Function

'''<summary> List�̒��Ɉ����ƃ}�b�`����v�f���ŏ��ɏo������C���f�b�N�X��Ԃ��܂��B������Ȃ��ꍇ�� -1 ��Ԃ��܂��B
'''<param> ����������������A���S��v�̏ꍇ��True������v�̏ꍇ��Flase
'''<returns> �C���f�b�N�X�ԍ�
Public Function IndexOf(ByVal Str As String, Optional ByVal PerfectMatching As Boolean = True) As Long

    Dim cnt As Long
    Dim Value As Variant
    If PerfectMatching Then
        For Each Value In Me
            cnt = cnt + 1
            If Str = Value Then
                IndexOf = cnt
                Exit Function
            End If
        Next
    Else
        For Each Value In Me
            cnt = cnt + 1
            If InStr(Value, Str) Then
                IndexOf = cnt
                Exit Function
            End If
        Next
    End If
    IndexOf = -1
End Function

'''<summary> List�̒��Ɉ����ƃ}�b�`����v�f�̗L����^�U�l�ŕԂ�
'''<param> ����������������A���S��v�̏ꍇ��True������v�̏ꍇ��Flase
'''<returns> ����ꍇTrue
Public Function Includes(ByVal Str As String, Optional ByVal PerfectMatching As Boolean = True) As Boolean

    Dim Value As Variant
    If PerfectMatching Then
        For Each Value In Me
            If Str = Value Then
                Includes = True
                Exit Function
            End If
        Next
    Else
        For Each Value In Me
            If InStr(Value, Str) Then
                Includes = True
                Exit Function
            End If
        Next
    End If
    Includes = False
End Function

'''<summary> List���m���������ĐV����List���쐬����
'''<param> ����������List
'''<returns> ��������List
Public Function Concat(ParamArray Lists() As Variant) As List

    Dim buf As List
    Set buf = New List
    buf.AddValue Me
    Dim l As Variant
    For Each l In Lists
        buf.AddValue l
    Next
    Set Concat = buf

End Function

'''<summary> List��A������������ŕԂ��܂�
'''<param> �A������ۂɑ}�����镶��
'''<returns> �A������������
Public Function Join(ByVal separator As String) As String

    Dim buf As String
    Dim Item As Variant
    For Each Item In Me
        If buf = "" Then
            buf = CStr(Item)
        Else
            buf = buf & separator & CStr(Item)
        End If
    Next
    Join = buf
    
End Function

'''<summary> List��z��ɕϊ����܂�
'''<param> �Ȃ�
'''<returns> �z�� Variant()�^
'''<remarks> �C���f�b�N�X�ԍ���1����n�܂�܂�
Public Function ToArray() As Variant()
    
    Dim buf() As Variant
    ReDim buf(1 To Me.Count)
    Dim i As Long
    For i = 1 To Me.Count
        If VarType(Me.Item(i)) = vbObject Then
            Set buf(i) = Me.Item(i)
        Else
            buf(i) = Me.Item(i)
        End If
    Next
    ToArray = buf()

End Function

'''<summary> �C���f�b�N�X�ԍ���StartIndex�Ԗڂ���EndIndex�Ԗڂ̗v�f��Ԃ�
'''<param> �擪�̃C���f�b�N�X�ԍ��A����̃C���f�b�N�X�ԍ�(�ȗ������ꍇ�͍Ō�܂�
'''<returns> List�^
Public Function Slice(ByVal StartIndex As Long, Optional ByVal EndIndex As Long = -1) As List

    If EndIndex = -1 Then EndIndex = Me.Count
    Dim buf As List
    Set buf = New List
    
    Dim i As Long
    For i = StartIndex To EndIndex
        buf.Add (Me(i))
    Next
    Set Slice = buf

End Function

'''<summary> �C�e���[�^ ���P�Ƃł͎g�p�ł��܂���
'''<param> �Ȃ�
'''<returns> �Ȃ�
Public Function NewEnum() As stdole.IUnknown
Attribute NewEnum.VB_UserMemId = -4
        Set NewEnum = Coll.[_NewEnum]
End Function