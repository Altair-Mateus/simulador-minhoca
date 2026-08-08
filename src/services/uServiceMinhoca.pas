unit uServiceMinhoca;

interface

uses
  uMinhoca,
  uEnums;

type
  TEventoPosicaoMinhoca = procedure(const pPosicao: Double) of object;
  TEventoMinhoca = procedure of object;

  TServiceMinhoca = class
  private
    FMinhoca: TMinhoca;
    FEstado: TEstadoMinhoca;
    FOnPosicaoAlterada: TEventoPosicaoMinhoca;
    FOnChegadaMetade: TEventoMinhoca;
    FOnSaiuBuraco: TEventoMinhoca;
    FMomentoDaPausa: Cardinal;

    procedure ValidaEventos;
    procedure CriarMinhoca(const pProfundidade, pAvanco, pQueda: Double);
    function GetQtdSubida: Integer;

    procedure Subir;
    procedure Cair;
    procedure Pausar;

    procedure NotificarPosicao;
    procedure NotificarChegouNaMetade;
    procedure NotificarSaiuDoBuraco;

  public
    property QtdSubida: Integer read GetQtdSubida;

    constructor Create(const pProfundidade, pAvanco, pQueda: Double; const pOnPosAlterada: TEventoPosicaoMinhoca;
      const pOnChegadaMetda, pOnSaiuBuraco: TEventoMinhoca);

    destructor Destroy; override;

    procedure Executar;

  end;

implementation

uses
  System.SysUtils,
  Winapi.Windows;

{ TServiceMinhoca }

procedure TServiceMinhoca.Cair;
begin

  FMinhoca.Posicao := (FMinhoca.Posicao - FMinhoca.Queda);

  if (FMinhoca.Posicao < 0) then
    FMinhoca.Posicao := 0;

  NotificarPosicao;

  FEstado := emPausando;

  FMomentoDaPausa := GetTickCount;

end;

constructor TServiceMinhoca.Create(const pProfundidade, pAvanco, pQueda: Double;
  const pOnPosAlterada: TEventoPosicaoMinhoca;
  const pOnChegadaMetda, pOnSaiuBuraco: TEventoMinhoca);
begin

  FOnPosicaoAlterada := pOnPosAlterada;
  FOnChegadaMetade := pOnChegadaMetda;
  FOnSaiuBuraco := pOnSaiuBuraco;

  ValidaEventos;

  CriarMinhoca(pProfundidade, pAvanco, pQueda);

end;

procedure TServiceMinhoca.CriarMinhoca(const pProfundidade, pAvanco, pQueda: Double);
begin
  FMinhoca := TMinhoca.Create;

  FMinhoca.Profundidade := pProfundidade;
  FMinhoca.Avanco := pAvanco;
  FMinhoca.Queda := pQueda;
  FMinhoca.QtdSubidas := 0;
  FEstado := emSubindo;
end;

destructor TServiceMinhoca.Destroy;
begin
  FMinhoca.Free;
  inherited;
end;

procedure TServiceMinhoca.Executar;
begin
  case FEstado of
    emSubindo:
      Subir;
    emCaindo:
      Cair;
    emPausando:
      Pausar;
    emFinalizada:
      Exit;
  end;
end;

function TServiceMinhoca.GetQtdSubida: Integer;
begin
  Result := FMinhoca.QtdSubidas;
end;

procedure TServiceMinhoca.NotificarChegouNaMetade;
begin
  FOnChegadaMetade;
end;

procedure TServiceMinhoca.NotificarPosicao;
begin
  FOnPosicaoAlterada(FMinhoca.Posicao);
end;

procedure TServiceMinhoca.NotificarSaiuDoBuraco;
begin
  FOnSaiuBuraco;
end;

procedure TServiceMinhoca.Pausar;
begin
  if ((GetTickCount - FMomentoDaPausa) >= 1000) then
    FEstado := emSubindo;
end;

procedure TServiceMinhoca.Subir;
begin
  FMinhoca.Posicao := (FMinhoca.Posicao + FMinhoca.Avanco);

  FMinhoca.IncSubida;

  if (FMinhoca.Posicao >= FMinhoca.Profundidade) then
  begin
    FMinhoca.Posicao := FMinhoca.Profundidade;

    NotificarPosicao;
    NotificarSaiuDoBuraco;

    FEstado := emFinalizada;

    Exit;
  end;

  NotificarPosicao;

  if (FMinhoca.Posicao >= (FMinhoca.Profundidade / 2)) then
    NotificarChegouNaMetade;

  FEstado := emCaindo;
end;

procedure TServiceMinhoca.ValidaEventos;
begin
  if not(Assigned(FOnPosicaoAlterada)) then
    raise Exception.Create('Falha ao inicializar movimento da minhoca.');

  if not(Assigned(FOnChegadaMetade)) then
    raise Exception.Create('Falha ao inicializar movimento de chegada na metade do caminho.');

  if not(Assigned(FOnSaiuBuraco)) then
    raise Exception.Create('Falha ao inicializar movimento de saída do buraco');
end;

end.
