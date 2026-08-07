unit uMinhoca;

interface

type
  TMinhoca = class
  private
    FProfundidade: Double;
    FAvanco: Double;
    FPosicao: Double;
    FQtdSubidas: Integer;
    FQueda: Double;

  public
    property Profundidade: Double read FProfundidade write FProfundidade;
    property Avanco: Double read FAvanco write FAvanco;
    property Queda: Double read FQueda write FQueda;
    property Posicao: Double read FPosicao write FPosicao;
    property QtdSubidas: Integer read FQtdSubidas write FQtdSubidas;

    procedure IncSubida;
  end;

implementation

{ TMinhoca }

procedure TMinhoca.IncSubida;
begin
  Inc(FQtdSubidas);
end;

end.
