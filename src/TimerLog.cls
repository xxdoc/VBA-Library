VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TimerLog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'''<classSummary> �C�~�f�B�G�C�g�E�B���h�E�ɏ������Ԃɕ\������N���X
'''<updateDate> 2020/9/2
'''<version> Ver.100
'''<remarks> �֐��̈�ԍŏ��� `Dim log As New TimerLog: log.Constructor ("test")`�Ƃ��邱�ƂŌv���ł���

Private Declare PtrSafe Function GetTickCount Lib "kernel32" () As Long

Private FunctionName_ As String
Private Begin As Long
Private Finish As Long

'''<summary> �����I�ȃR���X�g���N�^ �v���J�n
'''<param> ���Ԃƈꏏ�ɕ\������镶����(�֐����Ȃ�)
'''<returns> �Ȃ�
Public Function Constructor(ByVal FunctionName As String)
    FunctionName_ = FunctionName
    Begin = GetTickCount
    Debug.Print "[Begin] " & FunctionName
End Function

''<summary> �v�����Ԃ̌��ʂ�Ԃ� �\�ɕ\�����������Ƃ�����
'''<param> �Ȃ�
'''<returns> �������� [ms]
''<remarks> �C�~�f�B�G�C�g�E�B���h�E�ɕ\���������(�f�X�g���N�^)�Ƃ͕ʂɏ������s���Ă���
Public Function FinishTime() As Long
    Dim stopTime As Long
    stopTime = GetTickCount
    FinishTime = stopTime - Begin
End Function

'''<summary> �f�X�g���N�^ ���̃I�u�W�F�N�g���j�����ꂽ�Ƃ��Ɍv���I������
'''<param> �Ȃ�
'''<returns> �Ȃ�
Private Sub Class_Terminate()
    Finish = GetTickCount
    Debug.Print "[Finish] " & FunctionName_ & " , " & (Finish - Begin) & "[ms]"
End Sub