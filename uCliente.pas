unit uCliente;

interface

uses
  Data.SqlExpr, SysUtils;

  type TCliente = class

  private
    FCpf: string;
    FCodigoCliente: Integer;
    FNome: string;
    procedure SetCpf(const Value: string);
    procedure SetNome(const Value: string);

  public
    property codigoCliente : Integer read FCodigoCliente;
    property nome : string read FNome write SetNome;
    property cpf : string read FCpf write SetCpf;
    Constructor Create;
    Destructor Destroy; override;
    procedure InserirDadosBD(pNome: string;
                                pCPF: string);
    procedure ExecutarSQL();

  end;

implementation

{ TCliente }

constructor TCliente.Create;
begin

end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.ExecutarSQL();
var
  Query : TSQLQuery;
const
  select = 'SELECT CODIGOCLIENTE, NOME, CPF' +
           'FROM CLIENTE';
begin
   Query := TSQLQuery.Create(nil);

   try
     Query.SQL.Add(select);
     Query.ExecSQL();

     FCodigoCliente := Query.FieldByName('CODIGOCLIENTE').AsInteger;
     FNome          := Query.FieldByName('NOME').AsString;
     FCPF           := Query.FieldByName('CPF').AsString;
   finally
     FreeAndNil(Query);
   end;
end;

procedure TCliente.InserirDadosBD(pNome: string;
                                  pCPF: string);
var
  Query : TSQLQuery;
const
  insertInto = 'INSERT INTO CLIENTE  ' +
               '  (NOME, CPF) ' +
               'Values ' +
               '  (:PNOME, :PCPF)';
begin
  Query := TSQLQuery.Create(nil);
  try
    Query.SQL.Add(insertInto);
    Query.ParamByName(':PNOME').AsString := pNome;
    Query.ParamByName(':PCPF').AsString := pCPF;

    Query.ExecSQL()

  finally
    FreeAndNil(Query);
  end;
end;

procedure TCliente.SetCpf(const Value: string);
begin
  FCpf := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
