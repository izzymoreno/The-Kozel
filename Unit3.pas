unit Unit3;

interface

uses
  Classes;

type
  MainThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation
uses unit1;
{ MainThread }
procedure MainThread.Execute;
begin
While not Terminated do
Synchronize(Form1.main);
end;

end.
