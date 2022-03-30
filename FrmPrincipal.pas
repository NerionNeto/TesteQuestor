unit FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCarro, uCliente, uVenda, Contnrs, System.Generics.Collections;

type
  TFrmPrincipalTaif = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure InserirDadosDB();
    procedure ExecutarSql();
    procedure CarregarDadosCarro();
    procedure CarregarDadosCliente();
    procedure CarregarDadosVenda();

    procedure InserirCincoCarros();
    procedure InserirCincoVendas();
    procedure InserirCincoClientes();
  public
    { Public declarations }
  end;

var
  FrmPrincipalTaif: TFrmPrincipalTaif;

implementation

{$R *.dfm}

procedure TFrmPrincipalTaif.Button1Click(Sender: TObject);
begin
  InserirDadosDB;
  ExecutarSql;
end;

procedure TFrmPrincipalTaif.CarregarDadosCarro;
var
  carro: TCarro;
  codigoCarro, quantidade: integer;
  modelo: string;
  anoLancamento: TDate;

begin

  try
    carro := TCarro.Create();
    carro.ExecutarSQL();

    codigoCarro   := carro.codigoCarro;
    modelo        := carro.modelo;
    anoLancamento := carro.anoLancamento;
    quantidade    := carro.quantidade;
  finally
    FreeAndNil(carro);
  end;

end;

procedure TFrmPrincipalTaif.CarregarDadosCliente;
var
  cliente: TCliente;
  codigoCliente: integer;
  nome, cpf: string;
begin

  try
    cliente := TCliente.Create();
    cliente.ExecutarSQL();

    codigoCliente := cliente.codigoCliente;
    nome          := cliente.nome;
    cpf           := cliente.cpf;
  finally
    FreeAndNil(cliente);
  end;

end;

procedure TFrmPrincipalTaif.CarregarDadosVenda;
var
  venda: TVenda;
  codigoVenda, codigoCliente, codigoCarro, quantidadeVenda: integer;
  dataVenda: TDate;
begin

  try
    venda := TVenda.Create();
    venda.ExecutarSQL();

    codigoVenda     := venda.codigoVenda;
    codigoCliente   := venda.codigoCliente;
    codigoCarro     := venda.codigoCarro;
    dataVenda       := venda.dataVenda;
    quantidadeVenda := venda.quantidadeVenda;
  finally
    FreeAndNil(venda);
  end;

end;

procedure TFrmPrincipalTaif.ExecutarSql;
begin
  CarregarDadosCarro();
  CarregarDadosCliente();
  CarregarDadosVenda();
end;

procedure TFrmPrincipalTaif.InserirCincoCarros();
var
  Lista : TList;
  carro : TCarro;
  i : Integer;
begin
  Lista := TObjectList.Create();

  try
    carro := TCarro.Create();
    carro.modelo        := 'Passat';
    carro.anoLancamento :=  StrToDate('01/01/2019');
    carro.quantidade    := 15;
    Lista.Add(carro);

    carro := TCarro.Create();
    carro.modelo        := 'Bravo';
    carro.anoLancamento :=  StrToDate('01/01/2011');
    carro.quantidade    := 15;
    Lista.Add(carro);

    carro := TCarro.Create();
    carro.modelo        := 'Fiesta';
    carro.anoLancamento :=  StrToDate('01/01/2017');
    carro.quantidade    := 15;
    Lista.Add(carro);

    carro := TCarro.Create();
    carro.modelo        := 'Focus';
    carro.anoLancamento :=  StrToDate('01/01/2019');
    carro.quantidade    := 15;
    Lista.Add(carro);

    carro := TCarro.Create();
    carro.modelo        := 'Tucson';
    carro.anoLancamento :=  StrToDate('01/01/2013');
    carro.quantidade    := 30;
    Lista.Add(carro);

    for i := 0 to Pred(Lista.Count) do
    begin
      carro.InserirDadosBD(TCarro(Lista[i]).modelo,
                              TCarro(Lista[i]).anoLancamento,
                              TCarro(Lista[i]).quantidade);

    end;
  finally
    FreeAndNil(Lista);
  end;

end;

procedure TFrmPrincipalTaif.InserirCincoClientes;
var
  Lista : TList;
  cliente : TCliente;
  i : Integer;
begin
  Lista := TObjectList.Create();

  try
    cliente := TCliente.Create();
    cliente.nome := 'Cliente1';
    cliente.cpf  :=  '00000000001';
    Lista.Add(cliente);

    cliente := TCliente.Create();
    cliente.nome := 'Cliente2';
    cliente.cpf  :=  '00000000002';
    Lista.Add(cliente);

    cliente := TCliente.Create();
    cliente.nome := 'Cliente3';
    cliente.cpf  :=  '00000000003';
    Lista.Add(cliente);

    cliente := TCliente.Create();
    cliente.nome := 'Cliente4';
    cliente.cpf  :=  '00000000004';
    Lista.Add(cliente);

    cliente := TCliente.Create();
    cliente.nome := 'Cliente5';
    cliente.cpf  :=  '00000000005';
    Lista.Add(cliente);

    for i := 0 to Pred(Lista.Count) do
    begin
      cliente.InserirDadosBD(TCliente(Lista[i]).nome,
                                TCliente(Lista[i]).cpf);

    end;
  finally
    FreeAndNil(Lista);
  end;

end;

procedure TFrmPrincipalTaif.InserirCincoVendas;
var
  Lista : TList;
  venda : TVenda;
  i : Integer;
begin
  Lista := TObjectList.Create();

  try
    venda := TVenda.Create();
    venda.codigoCliente    := 18;
    venda.codigoCarro      := 4;
    venda.dataVenda        := StrToDate('01/05/2021');
    venda.quantidadeVenda  := 1;
    Lista.Add(venda);

    venda := TVenda.Create();
    venda.codigoCliente    := 19;
    venda.codigoCarro      := 5;
    venda.dataVenda        := StrToDate('01/01/2022');
    venda.quantidadeVenda  := 1;
    Lista.Add(venda);

    venda := TVenda.Create();
    venda.codigoCliente    := 20;
    venda.codigoCarro      := 6;
    venda.dataVenda        := StrToDate('01/01/2022');
    venda.quantidadeVenda  := 1;
    Lista.Add(venda);

    venda := TVenda.Create();
    venda.codigoCliente    := 21;
    venda.codigoCarro      := 7;
    venda.dataVenda        := StrToDate('01/09/2022');
    venda.quantidadeVenda  := 1;
    Lista.Add(venda);

    venda := TVenda.Create();
    venda.codigoCliente    := 22;
    venda.codigoCarro      := 8;
    venda.dataVenda        := StrToDate('01/01/2022');
    venda.quantidadeVenda  := 1;
    Lista.Add(venda);

    for i := 0 to Pred(Lista.Count) do
    begin
      venda.InserirDadosBD(TVenda(Lista[i]).codigoCliente,
                              TVenda(Lista[i]).codigoCarro,
                              TVenda(Lista[i]).quantidadeVenda,
                              TVenda(Lista[i]).dataVenda);

    end;
  finally
    FreeAndNil(Lista);
  end;
end;

procedure TFrmPrincipalTaif.InserirDadosDB();
begin
  InserirCincoCarros();
  InserirCincoVendas();
  InserirCincoClientes();
end;

end.
