unit uCarro;

interface

uses
  Data.SqlExpr, SysUtils;

type
  TCarro = class

private
    FAnoLancamento: TDateTime;
    FModelo: String;
    FCodigoCarro: Integer;
    FQuantidade: Integer;
    procedure SetAnoLancamento(const Value: TDateTime);
    procedure SetModelo(const Value: String);
    procedure SetQuantidade(const Value: Integer);

public
  property codigoCarro : Integer read FCodigoCarro;
  property modelo : String read FModelo write SetModelo;
  property anoLancamento : TDateTime read FAnoLancamento write SetAnoLancamento;
  property quantidade : Integer read FQuantidade write SetQuantidade;
  constructor Create();
  destructor Destroy; override;
  procedure InserirDadosBD(pModelo: string;
                              pAnoLancamento: TDate;
                              pQuantidade: Integer);
  procedure ExecutarSQL();
  end;

implementation

{ TCarro }

constructor TCarro.Create();
begin

end;

destructor TCarro.Destroy;
begin

  inherited;
end;

procedure TCarro.ExecutarSQL();
var
  Query : TSQLQuery;
const
  select = 'SELECT CODIGOCARRO, MODELO, ANOLANCAMENTO, QUANTIDADE' +
           'FROM CARRO';
begin
   Query := TSQLQuery.Create(nil);

   try
     Query.SQL.Add(select);
     Query.ExecSQL();

     FCodigoCarro   := Query.FieldByName('CODIGOCARRO').AsInteger;
     FModelo        := Query.FieldByName('MODELO').AsString;
     FAnoLancamento := Query.FieldByName('ANOLANCAMENTO').AsDateTime;
     FQuantidade    := Query.FieldByName('QUANTIDADE').AsInteger;
   finally
     FreeAndNil(Query);
   end;
end;

procedure TCarro.InserirDadosBD(pModelo: string;
                                   pAnoLancamento: TDate;
                                   pQuantidade: integer);
var
  Query : TSQLQuery;
const
  InsertInto = 'INSERT INTO CARRO ' +
               '  (MODELO, ANOLANCAMENTO, QUANTIDADE) ' +
               'VALUES ' +
	             '(:PMODELO, :PANOLANCAMENTO, :PQUANTIDADE) ';
begin
  Query := TSQLQuery.Create(nil);
  try
    Query.SQL.Add(insertInto);
    Query.ParamByName(':PMODELO').AsString := pModelo;
    Query.ParamByName(':PANOLANCAMENTO').AsDateTime := pAnoLancamento;
    Query.ParamByName(':PQUANTIDADE').AsInteger := pQuantidade;

    Query.ExecSQL()

  finally
    FreeAndNil(Query);
  end;
end;

procedure TCarro.SetAnoLancamento(const Value: TDateTime);
begin
  FAnoLancamento := Value;
end;

procedure TCarro.SetModelo(const Value: String);
begin
  FModelo := Value;
end;

procedure TCarro.SetQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

end.
