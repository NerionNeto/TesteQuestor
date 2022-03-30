unit uVenda;

interface

uses
  Data.SqlExpr, SysUtils;

type
  TVenda = class

private
    FCodigoVenda: Integer;
    FDataVenda: TDateTime;
    FCodigoCarro: Integer;
    FCodigoCliente: Integer;
    FQuantidadeVenda: Integer;
    procedure SetCodigoCarro(const Value: Integer);
    procedure SetDataVenda(const Value: TDateTime);
    procedure SetQuantidadeVenda(const Value: Integer);
    procedure SetCodigoCliente(const Value: Integer);

public
    property codigoVenda : Integer read FCodigoVenda;
    property codigoCliente : Integer read FCodigoCliente write SetCodigoCliente;
    property codigoCarro : Integer read FCodigoCarro write SetCodigoCarro;
    property dataVenda : TDateTime read FDataVenda write SetDataVenda;
    property quantidadeVenda : Integer read FQuantidadeVenda write SetQuantidadeVenda;
    constructor Create;
    destructor Destroy; override;
    procedure InserirDadosBD(pCodigoCliente,
                             pCodigoCarro,
                             pQuantidadeVenda: integer;
                             pDataVenda: TDateTime);
    procedure ExecutarSQL();
end;
implementation
{ TVenda }

constructor TVenda.Create;
begin

end;

destructor TVenda.Destroy;
begin

  inherited;
end;

procedure TVenda.ExecutarSQL;
var
  Query : TSQLQuery;
const
  select = 'SELECT CODIGOVENDA, DATAVENDA, CODIGOCARRO, CODIGOCLIENTE' +
           ' QUANTIDADEVENDA ' +
           'FROM VENDA';
begin
   Query := TSQLQuery.Create(nil);

   try
     Query.SQL.Add(select);
     Query.ExecSQL();

     FCodigoVenda     := Query.FieldByName('CODIGOVENDA').AsInteger;
     FDataVenda       := Query.FieldByName('DATAVENDA').AsDateTime;
     FCodigoCarro     := Query.FieldByName('CODIGOCARRO').AsInteger;
     FCodigoCliente   := Query.FieldByName('CODIGOCLIENTE').AsInteger;
     FQuantidadeVenda := Query.FieldByName('QUANTIDADEVENDA').AsInteger;
   finally
     FreeAndNil(Query);
   end;
end;

procedure TVenda.InserirDadosBD(pCodigoCliente,
                                   pCodigoCarro,
                                   pQuantidadeVenda: integer;
                                   pDataVenda: TDateTime);
var
  Query : TSQLQuery;
const
  insertInto = 'INSERT INTO VENDA ' +
	             '  (CODIGOCLIENTE, CODIGOCARRO, DATAVENDA, QUANTIDADEVENDA) ' +
               'VALUES ' +
               '  (:PCODIGOCLIENTE, :PCODIGOCARRO, :PDATAVENDA, :PQUANTIDADEVENDA)';
begin
  Query := TSQLQuery.Create(nil);
  try
    Query.SQL.Add(insertInto);
    Query.ParamByName(':PCODIGOCLIENTE').AsInteger := pCodigoCliente;
    Query.ParamByName(':PCODIGOCARRO').AsInteger := pCodigoCarro;
    Query.ParamByName(':PDATAVENDA').AsDateTime := pDataVenda;
    Query.ParamByName(':PQUANTIDADEVENDA').AsInteger := pQuantidadeVenda;

    Query.ExecSQL()

  finally
    FreeAndNil(Query);
  end;

end;

procedure TVenda.SetCodigoCarro(const Value: Integer);
begin
  FCodigoCarro := Value;
end;

procedure TVenda.SetCodigoCliente(const Value: Integer);
begin
  FCodigoCliente := Value;
end;

procedure TVenda.SetDataVenda(const Value: TDateTime);
begin
  FDataVenda := Value;
end;

procedure TVenda.SetQuantidadeVenda(const Value: Integer);
begin
  FQuantidadeVenda := Value;
end;

end.
