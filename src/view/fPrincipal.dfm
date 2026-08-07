object frmPricipal: TfrmPricipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Simulador de Minhoca'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 16
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    Color = clWhite
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    object pnlFundoDados: TPanel
      Left = 11
      Top = 11
      Width = 602
      Height = 96
      Align = alTop
      BevelOuter = bvNone
      Color = clBlack
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 622
      object pnlDados: TPanel
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 600
        Height = 94
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 9
        ExplicitWidth = 620
        ExplicitHeight = 104
        object lblProfundidade: TLabel
          Left = 16
          Top = 24
          Width = 120
          Height = 16
          Caption = 'Profundidade Buraco'
        end
        object lblAvanco: TLabel
          Left = 167
          Top = 24
          Width = 42
          Height = 16
          Caption = 'Avan'#231'o'
        end
        object lblQueda: TLabel
          Left = 319
          Top = 24
          Width = 38
          Height = 16
          Caption = 'Queda'
        end
        object edtProfundidade: TNumberBox
          Left = 15
          Top = 46
          Width = 121
          Height = 24
          TabOrder = 0
        end
        object edtAvanco: TNumberBox
          Left = 167
          Top = 46
          Width = 121
          Height = 24
          TabOrder = 1
        end
        object edtQueda: TNumberBox
          Left = 319
          Top = 46
          Width = 121
          Height = 24
          TabOrder = 2
        end
        object btnIniciar: TButton
          Left = 464
          Top = 24
          Width = 75
          Height = 47
          Caption = 'Iniciar'
          TabOrder = 3
        end
      end
    end
  end
end
