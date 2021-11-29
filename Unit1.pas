unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,unit3,unit4, unit7, Menus;

type
  TForm1 = class(TForm)
    ButtonBit: TButton;
    ButtonSkid: TButton;
    ButtonXod: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HumanClick(Sender: TObject);
    procedure ButtonXodClick(Sender: TObject);
    procedure ButtonSkidClick(Sender: TObject);
    procedure ButtonBitClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    {procedure FormActivate(Sender: TObject);}

  private
    { Private declarations }
  public
    { Public declarations }
     PROCEDURE Main;
  end;
type TPlayerStolMas=array[1..4,1..2] of byte;//Заводим массив стола на 8 элементов, где 4 для их масти и 4 элемнта для значения карт.
type CardRec = Record //Заводим запись
   Mast:byte; //Масть карты
   Wes:byte; //Вес карты
   CardsState:byte;
   Hidden:Boolean;
   ImageForm:TImage;//ЖК экран для показа карты
end;
type PlayerRec = Record
   OnGame:Boolean;
   Human:Boolean;
   Name:string;
   Vzatka:array[1..36] of byte;
   Cards:array[1..4] of CardRec;
   Stol:array[1..4,1..2] of byte;
//   Stol:TPlayerStolMas;
   Answer:Boolean;
   UkVzatki:byte;
   GameScore:byte;
   RoundScore:byte;
   end;
var
  T1:MainThread;
  Form1: TForm1;
  f1,f2:HWND;
  ImageCards:array[1..41] of TBitMap;//Хранилище картинок
  Players:array[1..4] of PlayerRec;
  Koloda:array[1..36,1..2] of byte;
  buffer:array[1..36] of byte;
  NamePlayer:array [1..4] of TLabel;
  ImageKozir:TImage;
  x1,y1:word;
  GameOver,HumanClickLock:Boolean;
  AnswerPlayer,sxodili,Pobil,Ksk,WhoIAm,maxplayers,card,kozir,ukkart,xod,nextplayer:byte;
  ystola:integer;
implementation

uses Unit2, Unit5, Unit6;

{$R *.DFM}
//FUNCTION DllBitSkidNextplayer(ksk,kozir:byte;
//                              var NextPlayerStol:TPlayerStolMas;
//                              var PobilStol:TPlayerStolMas):byte;external 'mydll.dll' name 'DllBitSkidNextplayer';
FUNCTION DllBitSkidNextplayer(ksk,kozir:byte;
                              NextPlayerStol:TPlayerStolMas;
                              PobilStol:TPlayerStolMas):byte;
                              external 'mind.dll' name 'DllBitSkidNextplayer';


FUNCTION DllXodNextPlayer(kozir:byte;var ksk:byte;var ystola:integer;var Stol:TPlayerStolMas):byte;
                              external 'mind.dll' name 'DllXodNextPlayer';

PROCEDURE PutImage(numplayer:byte);
var n:byte;
BEGIN
For n:=1 to 4 do
   begin
   Case Players[numplayer].Cards[n].Hidden of
   true:
        begin
        Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[41]);
        if Players[numplayer].Cards[n].Wes=0 then
        Players[numplayer].Cards[n].ImageForm.Visible:=false;
//        form1.Memo1.Lines.Add('Players['+inttostr(numplayer)+'].Cards['+
//                              inttostr(n)+'].ImageForm.Visible:=false');
        end;
   false:
         begin
         Case Players[numplayer].Cards[n].Wes of
      0:begin
         Players[numplayer].Cards[n].ImageForm.Visible:=false;
         form2.Memo2.Lines.Add('Players['+inttostr(numplayer)+'].Cards['+
                                inttostr(n)+'].ImageForm.Visible:=false;');
         end;
      49:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[1]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[2]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[3]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[4]);
         end;
         end;
      50:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[5]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[6]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[7]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[8]);
         end;
         end;
      51:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[9]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[10]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[11]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[12]);
         end;
         end;
      52:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[13]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[14]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[15]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[16]);
         end;
         end;
      53:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[17]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[18]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[19]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[20]);
         end;
         end;
      54:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[21]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[22]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[23]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[24]);
         end;
         end;
      55:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[25]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[26]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[27]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[28]);
         end;
         end;
      56:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[29]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[30]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[31]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[32]);
         end;
         end;
      57:begin
         Case Players[numplayer].Cards[n].Mast of
         65:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[33]);
         66:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[34]);
         67:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[35]);
         68:Players[numplayer].Cards[n].ImageForm.Picture.Assign(ImageCards[36]);
         end;
         end;
         end;
      end;
      end;
   end;
END;

PROCEDURE Names(n:byte;x,y:integer;Name:string);
BEGIN
NamePlayer[n].Left:=x;
NamePlayer[n].Top:=y;
NamePlayer[n].Color:=clGreen;
NamePlayer[n].Font.Color:=clWhite;
NamePlayer[n].Caption:=Name;
//NamePlayer[n].Caption:=Players[n].Name:=Name;
END;

PROCEDURE VivodCards(igrok:byte;x,y:integer;shagx,shagy:byte);
var
j:byte;
BEGIN
For j:=1 to 4 do
   begin
   Players[igrok].Cards[j].ImageForm.BringToFront;
   Players[igrok].Cards[j].ImageForm.Left:=x;
   Players[igrok].Cards[j].ImageForm.Top:=y;
   x:=x+shagx;
   y:=y+shagy;
   end;
END;

PROCEDURE CopyCardsToStol(Numplayer:byte);
var
i:byte;
BEGIN
For i:=1 to 4 do
   begin
   Players[Numplayer].Stol[i,1]:=Players[Numplayer].Cards[i].Wes;
   Players[Numplayer].Stol[i,2]:=Players[Numplayer].Cards[i].Mast;
   end;
END;

FUNCTION GetNumberCard(NumPlayer,Wes,Mast:byte):byte;
var
i:byte;
BEGIN
RESULT:=1;
For i:=1 to 4 do
   begin
   If (Players[Numplayer].Cards[i].Wes=Wes) and (Players[Numplayer].Cards[i].Mast=Mast) then
      begin
      RESULT:=i;
      Break;
      end;
   end;
END;

PROCEDURE VivodStola(NumPlayer:byte;x,y:integer;shagx,shagy:byte);
var
i,num:byte;
BEGIN
For i:=1 to 4{ksk} do
   begin
   If Players[NumPlayer].Stol[i,1]<>0 then
      begin
      num:=GetNumberCard(NumPlayer,Players[NumPlayer].Stol[i,1],Players[NumPlayer].Stol[i,2]);
      Players[NumPlayer].Cards[num].ImageForm.BringToFront;
      Players[NumPlayer].Cards[num].ImageForm.Left:=x;
      Players[NumPlayer].Cards[num].ImageForm.Top:=y;
      x:=x+shagx;
      y:=y+shagy;
      end;
   end;
PutImage(Numplayer);
END;

PROCEDURE UDPUSTO(Numplayer:byte);
var
i,j:byte;
BEGIN
For j:=1 to 4 do
   begin
   For i:=1 to 3 do
      begin
      If Players[NumPlayer].Stol[i,1]=0 then
         begin
         Players[NumPlayer].Stol[i,1]:=Players[NumPlayer].Stol[i+1,1];
         Players[NumPlayer].Stol[i,2]:=Players[NumPlayer].Stol[i+1,2];
         Players[NumPlayer].Stol[i+1,1]:=0;
         Players[NumPlayer].Stol[i+1,2]:=0;
         end;
      end;
   end;
END;

PROCEDURE UDPUSTOCARDS(Numplayer:byte);
var
i,j:byte;
BEGIN
For j:=1 to 4 do
   begin
   For i:=1 to 3 do
      begin
      If Players[NumPlayer].Cards[i].Wes=0 then
         begin
         Players[NumPlayer].Cards[i].Wes:=Players[NumPlayer].Cards[i+1].Wes;
         Players[NumPlayer].Cards[i].Mast:=Players[NumPlayer].Cards[i+1].Mast;
         Players[NumPlayer].Cards[i+1].Wes:=0;
         Players[NumPlayer].Cards[i+1].Mast:=0;
         end;
      end;
   end;
END;

PROCEDURE Vzatka;
var
i,j,n:byte;
BEGIN
n:=Players[Pobil].UkVzatki;
For i:=1 to maxplayers do
   begin
   UdPusto(i);
   end;
For j:=1 to maxplayers do
   begin
   For i:=1 to ksk do
      begin
      Players[Pobil].Vzatka[n]:=Players[j].Stol[i,1];
      Players[j].Stol[i,1]:=0;
      Players[j].Stol[i,2]:=0;
      n:=n+1;
      end;
   end;
Players[Pobil].UkVzatki:=n;
END;

PROCEDURE EndNextplayer(NextPlayer:byte);
var
i,j:byte;
BEGIN
For i:=1 to ksk do
   begin
   For j:=1 to 4 do
      begin
      If Players[Nextplayer].Human=true then Players[Nextplayer].Cards[j].CardsState:=1;
      If (Players[Nextplayer].Stol[i,1]=Players[Nextplayer].Cards[j].Wes)
      and (Players[Nextplayer].Stol[i,2]=Players[Nextplayer].Cards[j].Mast) then
         begin
         Players[Nextplayer].Cards[j].Wes:=0;
         Players[Nextplayer].Cards[j].Mast:=0;
         end;
      end;
   end;
END;

PROCEDURE ClearStol(Nextplayer:byte);
var
i:byte;
BEGIN
If ksk<4 then
begin
For i:=ksk+1 to 4 do
   begin
   Players[Nextplayer].Stol[i,1]:=0;
   Players[Nextplayer].Stol[i,2]:=0;
   end;
end;
END;

PROCEDURE SortStolNextplayer(Nextplayer:byte);
var
i,j,space:byte;
BEGIN
For j:=1 to 8 Do
   begin
   For i:=1 to 3 Do
      begin
      If (Players[Nextplayer].Stol[i,2]<>kozir)
         and (Players[Nextplayer].Stol[i+1,2]=kozir) then
         begin
         space:=Players[Nextplayer].Stol[i,1];
         Players[Nextplayer].Stol[i,1]:=Players[Nextplayer].Stol[i+1,1];
         Players[Nextplayer].Stol[i+1,1]:=space;
         space:=Players[Nextplayer].Stol[i,2];
         Players[Nextplayer].Stol[i,2]:=Players[Nextplayer].Stol[i+1,2];
         Players[Nextplayer].Stol[i+1,2]:=space;
         end;
      If (Players[Nextplayer].Stol[i,2]=kozir)
         and (Players[Nextplayer].Stol[i+1,2]=kozir)
         and (Players[Nextplayer].Stol[i+1,1]>Players[Nextplayer].Stol[i,1]) then
         begin
         space:=Players[Nextplayer].Stol[i,1];
         Players[Nextplayer].Stol[i,1]:=Players[Nextplayer].Stol[i+1,1];
         Players[Nextplayer].Stol[i+1,1]:=space;
         space:=Players[Nextplayer].Stol[i,2];
         Players[Nextplayer].Stol[i,2]:=Players[Nextplayer].Stol[i+1,2];
         Players[Nextplayer].Stol[i+1,2]:=space;
         end;
      end;
   end;
For j:=1 to 8 Do
   begin
   For i:=1 to 3 Do
      begin
      If (Players[Nextplayer].Stol[i,2]<>kozir)
         and (Players[Nextplayer].Stol[i,2]<>Players[Pobil].Stol[1,2])
         and (Players[Nextplayer].Stol[i+1,2]=Players[Pobil].Stol[1,2]) then
         begin
         space:=Players[Nextplayer].Stol[i,1];
         Players[Nextplayer].Stol[i,1]:=Players[Nextplayer].Stol[i+1,1];
         Players[Nextplayer].Stol[i+1,1]:=space;
         space:=Players[Nextplayer].Stol[i,2];
         Players[Nextplayer].Stol[i,2]:=Players[Nextplayer].Stol[i+1,2];
         Players[Nextplayer].Stol[i+1,2]:=space;
         end;
      If (Players[Nextplayer].Stol[i,2]<>kozir)
      and (Players[Nextplayer].Stol[i,2]=Players[Pobil].Stol[1,2])
      and (Players[Nextplayer].Stol[i+1,2]=Players[Pobil].Stol[1,2])
      and (Players[Nextplayer].Stol[i+1,1]>Players[Nextplayer].Stol[i,1]) then
         begin
         space:=Players[Nextplayer].Stol[i,1];
         Players[Nextplayer].Stol[i,1]:=Players[Nextplayer].Stol[i+1,1];
         Players[Nextplayer].Stol[i+1,1]:=space;
         space:=Players[Nextplayer].Stol[i,2];
         Players[Nextplayer].Stol[i,2]:=Players[Nextplayer].Stol[i+1,2];
         Players[Nextplayer].Stol[i+1,2]:=space;
         end;
      end;
   end;
Form2.Memo1.Lines.Add('Stol:');
Form2.Memo1.Lines.Add(IntToStr(Players[Nextplayer].Stol[1,1])+' '+
                      IntToStr(Players[Nextplayer].Stol[2,1])+' '+
                      IntToStr(Players[Nextplayer].Stol[3,1])+' '+
                      IntToStr(Players[Nextplayer].Stol[4,1]));
Form2.Memo1.Lines.Add(IntToStr(Players[Nextplayer].Stol[1,2])+' '+
                      IntToStr(Players[Nextplayer].Stol[2,2])+' '+
                      IntToStr(Players[Nextplayer].Stol[3,2])+' '+
                      IntToStr(Players[Nextplayer].Stol[4,2]));

END;

PROCEDURE MySort;
var
i,j:byte;
BEGIN
For i:=1 to 4 do
   begin
   if Players[WhoIAm].Cards[i].CardsState=2 then
      begin
      Players[WhoIAm].Stol[i,1]:=Players[WhoIAm].Cards[i].Wes;
      Players[WhoIAm].Stol[i,2]:=Players[WhoIAm].Cards[i].Mast;
      end;
   end;
SortStolNextplayer(WhoIAm);
END;

FUNCTION BitSkidNextplayer(Nextplayer:byte):byte;
BEGIN
Result:=DllBitSkidNextplayer(ksk,kozir,
                             TPlayerStolMas(Players[Nextplayer].Stol),
                             TPlayerStolMas(Players[Pobil].Stol));
END;

{FUNCTION BitSkidNextplayer(Nextplayer:byte):byte;
var
i,j,kbk:byte;
BEGIN
kbk:=0;
i:=ksk;
For j:=4 downto 1 Do
   begin
      If (Players[Nextplayer].Stol[j,2]=Players[Pobil].Stol[i,2])
      and (Players[Pobil].Stol[i,1]<Players[Nextplayer].Stol[j,1]) then
         begin
         kbk:=kbk+1;
         i:=i-1;
         If i<1 then
            begin
            i:=1;
            break;
            end;
         end;
      If (Players[Nextplayer].Stol[j,2]=kozir)
      and (Players[Pobil].Stol[i,2]<>kozir) then
         begin
         kbk:=kbk+1;
         i:=i-1;
         If i<1 then
            begin
            i:=1;
            break;
            end;
         end;
   end;
Form2.Memo1.Lines.Add('ksk='+Inttostr(ksk));
Form2.Memo1.Lines.Add('kbk='+Inttostr(kbk));
RESULT:=Kbk;
END;}

PROCEDURE BitNextPlayer(NextPlayer,playerkbk:byte);
var
i,n:byte;
BEGIN
Form2.Memo1.Lines.Add('Игрок '+Inttostr(Nextplayer)+' бью');
For i:=playerkbk+1 to 4 do
   begin
   Players[Nextplayer].Stol[i,1]:=0;
   Players[Nextplayer].Stol[i,2]:=0;
   end;
If playerkbk>ksk then
   begin
   For i:=1 to playerkbk-ksk do
      begin
      Players[Nextplayer].Stol[i,1]:=0;
      Players[Nextplayer].Stol[i,2]:=0;
      end;
   end;
For i:=1 to 4 do
   begin
   if Players[Nextplayer].Stol[i,1]<>0 then
      begin
      n:=GetNumberCard(Nextplayer,Players[Nextplayer].Stol[i,1],Players[Nextplayer].Stol[i,2]);
      Players[Nextplayer].Cards[n].Hidden:=false;
      end;
   end;
Pobil:=Nextplayer;
UdPusto(Nextplayer);
Form2.Memo1.Lines.Add('Pobil='+Inttostr(Pobil));
END;

PROCEDURE SkidNextplayer(NextPlayer:byte);
var
i,j,space:byte;
BEGIN
CopyCardsToStol(Nextplayer);
Form2.Memo1.Lines.Add('Скидываю '+Inttostr(Nextplayer));
For j:=1 to 4 Do
   begin
   For i:=1 to 3 Do
      begin
      if (Players[Nextplayer].Stol[i,1]>Players[Nextplayer].Stol[i+1,1]) and
         (Players[Nextplayer].Stol[i+1,1]>0) then
         begin
         space:=Players[Nextplayer].Stol[i,1];
         Players[Nextplayer].Stol[i,1]:=Players[Nextplayer].Stol[i+1,1];
         Players[Nextplayer].Stol[i+1,1]:=space;
         space:=Players[Nextplayer].Stol[i,2];
         Players[Nextplayer].Stol[i,2]:=Players[Nextplayer].Stol[i+1,2];
         Players[Nextplayer].Stol[i+1,2]:=space;
         end;
      end;
   end;
ClearStol(NextPlayer);
END;

PROCEDURE SORTSTOL(Numplayer:byte);
var
i,j,space:byte;
BEGIN
For j:=1 to 4 do
   begin
   For i:=1 to 3 do
      begin
      If Players[NumPlayer].Stol[i+1,1]>Players[NumPlayer].Stol[i,1] then
         begin
         space:=Players[Numplayer].Stol[i,1];
         Players[Numplayer].Stol[i,1]:=Players[Numplayer].Stol[i+1,1];
         Players[Numplayer].Stol[i+1,1]:=space;
         space:=Players[Numplayer].Stol[i,2];
         Players[Numplayer].Stol[i,2]:=Players[Numplayer].Stol[i+1,2];
         Players[Numplayer].Stol[i+1,2]:=space;
         end;
      end;
   end;
END;

PROCEDURE XodNextPlayer(XoditIgrok:byte);
var
i,n,mast,max:byte;
Statistica:array[1..4] of byte;
BEGIN
CopyCardsToStol(XoditIgrok);
DllXodNextPlayer(kozir,ksk,
ystola,
TPlayerStolMas(Players[XoditIgrok].Stol));
   Form2.Memo1.Lines.Add(IntToStr(Players[XoditIgrok].Stol[1,1])+' '+
                         IntToStr(Players[XoditIgrok].Stol[2,1])+' '+
                         IntToStr(Players[XoditIgrok].Stol[3,1])+' '+
                         IntToStr(Players[XoditIgrok].Stol[4,1]));
   Form2.Memo1.Lines.Add(IntToStr(Players[XoditIgrok].Stol[1,2])+' '+
                         IntToStr(Players[XoditIgrok].Stol[2,2])+' '+
                         IntToStr(Players[XoditIgrok].Stol[3,2])+' '+
                         IntToStr(Players[XoditIgrok].Stol[4,2]));
Form2.Memo1.Lines.Add('ksk ='+IntToStr(ksk));
For i:=1 to 4 do
   begin
   if Players[XoditIgrok].Stol[i,1]<>0 then
      begin
      n:=GetNumberCard(XoditIgrok,Players[XoditIgrok].Stol[i,1],Players[XoditIgrok].Stol[i,2]);
      Players[XoditIgrok].Cards[n].Hidden:=false;
      end;
   end;
VivodStola(XoditIgrok,200,ystola,60,0);
EndNextplayer(XoditIgrok);
ystola:=ystola+30;
END;

{Сортируем карты компа перед тем как побить}
PROCEDURE NextPlayers(SubNextplayer:byte);
var
kbk:byte;
BEGIN
If Xod=SubNextplayer then XodNextPlayer(SubNextplayer)
else
   begin
   kbk:=0;
   Form2.Memo1.Lines.Add('Ответ игрока '+Inttostr(SubNextplayer));
   CopyCardsToStol(SubNextplayer);
   SortStolNextplayer(SubNextplayer);
   kbk:=BitSkidNextplayer(SubNextplayer);
   If kbk>=ksk then BitNextplayer(SubNextplayer,kbk)
      else SkidNextplayer(SubNextplayer);
   VivodStola(SubNextplayer,200,ystola,60,0);
   ystola:=ystola+30;
   EndNextplayer(SubNextplayer);
   Form2.Memo1.Lines.Add('Cards:');
   Form2.Memo1.Lines.Add(IntToStr(Players[SubNextplayer].cards[1].Wes)+' '+
                         IntToStr(Players[SubNextplayer].cards[2].Wes)+' '+
                         IntToStr(Players[SubNextplayer].cards[3].Wes)+' '+
                         IntToStr(Players[SubNextplayer].cards[4].Wes));
   Form2.Memo1.Lines.Add(IntToStr(Players[SubNextplayer].cards[1].Mast)+' '+
                         IntToStr(Players[SubNextplayer].cards[2].Mast)+' '+
                         IntToStr(Players[SubNextplayer].cards[3].Mast)+' '+
                         IntToStr(Players[SubNextplayer].cards[4].Mast));
   end;
END;

PROCEDURE MyAnswer;
var
i,j,selectcards:byte;
BEGIN
selectcards:=0;
      For j:=1 to 4 do
         begin
         Players[WhoIAm].Stol[j,1]:=0;
         Players[WhoIAm].Stol[j,2]:=0;
         end;
For i:=1 to 4 do
   begin
   If Players[WhoIAm].Cards[i].CardsState=2 then selectcards:=selectcards+1;
   end;
If selectcards=ksk then
   begin
   Form1.ButtonSkid.Enabled:=true;
   MySort;
   If BitSkidNextplayer(WhoIAm)=ksk then Form1.ButtonBit.Enabled:=true
      else
      begin
      Form1.ButtonBit.Enabled:=false;
      end;
   end
   else
   begin
   Form1.ButtonSkid.Enabled:=false;
   Form1.ButtonBit.Enabled:=false;
   end;
END;

PROCEDURE ProvXod;
var
i,mastxoda,kom:byte;
BEGIN
mastxoda:=0;
kom:=0;
ksk:=0;
For i:=1 to 4 do
   begin
   If Players[WhoIAm].Cards[i].CardsState=2 then
      begin
      mastxoda:=Players[WhoIAm].Cards[i].Mast;
      inc(ksk);
      end;
   end;
For i:=1 to 4 do
   begin
   If (Players[WhoIAm].Cards[i].Mast=mastxoda) and (Players[WhoIAm].Cards[i].CardsState=2) then
      begin
      inc(kom);
      end;
   end;
Form1.ButtonXod.Enabled:=false;
If (ksk<>0) and (ksk=kom) then Form1.ButtonXod.Enabled:=true;
END;

PROCEDURE TForm1.HumanClick(Sender: TObject);
var
cardtag:byte;
cardnumber:byte;
playernumber:byte;
BEGIN
cardtag:=(sender as TImage).tag;
cardnumber:=(cardtag mod 4);
if (cardtag mod 4)=0 then playernumber:=(cardtag div 4) else playernumber:=(cardtag div 4)+1;
if cardnumber=0 then cardnumber:=4;
Form2.Memo1.Lines.Add('Было Cardstate= '+Inttostr(Players[playernumber].Cards[cardnumber].CardsState));

if HumanClickLock=false then
begin
   case Players[playernumber].Cards[cardnumber].CardsState of
      1:begin
        Players[playernumber].Cards[cardnumber].CardsState:=2;
        Players[playernumber].Cards[cardnumber].ImageForm.Left:=
        Players[playernumber].Cards[cardnumber].ImageForm.Left+0;
        Players[playernumber].Cards[cardnumber].ImageForm.Top:=
        Players[playernumber].Cards[cardnumber].ImageForm.Top-10;
        end;
      2:begin
        Players[playernumber].Cards[cardnumber].CardsState:=1;
        Players[playernumber].Cards[cardnumber].ImageForm.Left:=
        Players[playernumber].Cards[cardnumber].ImageForm.Left+0;
        Players[playernumber].Cards[cardnumber].ImageForm.Top:=
        Players[playernumber].Cards[cardnumber].ImageForm.Top+10;
        end;
   end;
If xod=WhoIAm then ProvXod
   else MyAnswer;
end;
     Form2.Edit1.Text:='tag='+Inttostr(cardtag)+
        ' Players['+
        inttostr(playernumber)+
        ']'+'.Cards['+inttostr(cardnumber)+']';
Form2.Memo1.Lines.Add('Стало Cardstate= '+
        Inttostr(Players[playernumber].Cards[cardnumber].CardsState));
END;

FUNCTION PrPustoIgroka(numplayer:byte):byte;
var
i:byte;
BEGIN
For i:=1 to 4 Do
begin
If Players[numplayer].Cards[i].Wes=0 then
   begin
   RESULT:=i;
   break;
   end
else RESULT:=0;
end;
END;

PROCEDURE RAZDACHA(s_igroka,kolcards:byte);
var
i,j,n:byte;
BEGIN
For i:=1 to maxplayers do
begin
UDPUSTOCARDS(i);
end;
if ukkart>16 then
   begin
   For i:=1 to maxplayers do
      begin
      Form2.Memo2.Lines.Add('До раздачи: Players '+IntToStr(i));
      Form2.Memo2.Lines.Add(IntToStr(Players[i].cards[1].Wes)+' '+
                            IntToStr(Players[i].cards[2].Wes)+' '+
                            IntToStr(Players[i].cards[3].Wes)+' '+
                            IntToStr(Players[i].cards[4].Wes));
      Form2.Memo2.Lines.Add(IntToStr(Players[i].cards[1].Mast)+' '+
                            IntToStr(Players[i].cards[2].Mast)+' '+
                            IntToStr(Players[i].cards[3].Mast)+' '+
                            IntToStr(Players[i].cards[4].Mast));
      end;
   end;

if ukkart<36 then
begin
For i:=1 to kolcards do
begin
 For j:=1 to maxplayers do
  begin
   n:=PrPustoIgroka(s_igroka);
   If n<>0 then
     begin
     Players[s_igroka].Cards[n].Wes:=koloda[ukkart,1];
     Players[s_igroka].Cards[n].Mast:=koloda[ukkart,2];
     If Players[s_igroka].Human=true then Players[s_igroka].Cards[n].CardsState:=1;
     Form1.Caption:='В колоде осталось: '+Inttostr(36-Ukkart);
     ukkart:=ukkart+1;
     if ukkart>36 then break;
     s_igroka:=s_igroka+1;
     If s_igroka>maxplayers then s_igroka:=1;
     end;
   end;
if ukkart>36 then break;
end;
end;
For i:=1 to 4 do
begin
Players[WhoIAm].Cards[i].CardsState:=1;
end;

if ukkart>16 then
begin
For i:=1 to maxplayers do
begin
   Form2.Memo2.Lines.Add('После раздачи: Players '+IntToStr(i));
   Form2.Memo2.Lines.Add(IntToStr(Players[i].cards[1].Wes)+' '+
                         IntToStr(Players[i].cards[2].Wes)+' '+
                         IntToStr(Players[i].cards[3].Wes)+' '+
                         IntToStr(Players[i].cards[4].Wes));
   Form2.Memo2.Lines.Add(IntToStr(Players[i].cards[1].Mast)+' '+
                         IntToStr(Players[i].cards[2].Mast)+' '+
                         IntToStr(Players[i].cards[3].Mast)+' '+
                         IntToStr(Players[i].cards[4].Mast));
end;
end;
{=====================}
For i:=1 to 4 do
   begin
   Players[WhoIAm].Cards[i].Hidden:=false;
   end;
END;

PROCEDURE PUTKOZIR(x,y:integer);
BEGIN
ImageKozir.Left:=x;
ImageKozir.Top:=y;
Case kozir of
   65:
   ImageKozir.Picture.Assign(Imagecards[37]);
   66:
   ImageKozir.Picture.Assign(Imagecards[38]);
   67:
   ImageKozir.Picture.Assign(Imagecards[39]);
   68:
   ImageKozir.Picture.Assign(Imagecards[40]);
   end;
END;

PROCEDURE TUSUEM;
var
i,card1,card2,space:byte;
BEGIN
Randomize;
For i:=1 to 36 do
     begin
     card1:=Random(35)+1;
     card2:=Random(35)+1;
     space:=koloda[card1,1];
     koloda[card1,1]:=koloda[card2,1];
     koloda[card2,1]:=space;
     space:=koloda[card1,2];
     koloda[card1,2]:=koloda[card2,2];
     koloda[card2,2]:=space;
     end;
Randomize;
kozir:=trunc(Random(99)/25)+65;
PutKozir(627,0);
END;

FUNCTION INITGAME:boolean;
VAR
i,j,tag:byte;
PathToGame:string;
BEGIN

{============================== Глобальные переменные ===================}
GameOver:=false;
maxplayers:=2;
tag:=1;
sxodili:=0;
ukkart:=1;
WhoIAm:=2;
Xod:=1;
Pobil:=Xod;
AnswerPlayer:=xod;
HumanClickLock:=false;
ystola:=114;
{========================================================================}
ImageKozir:=TImage.Create(Form1);
ImageKozir.Parent:=Form1;
For i:=1 to 41 do
   begin
   ImageCards[i]:=TBitMap.Create;
   ImageCards[i].LoadFromResourceID(HInstance,i);
   end;
For i:=1 to maxplayers do
   begin
   NamePlayer[i]:=TLabel.Create(Form1);
   NamePlayer[i].Parent:=Form1;
   for j:=1 to 4 do
      begin
      players[i].Cards[j].ImageForm:=TImage.Create(Form1);
      players[i].Cards[j].ImageForm.Parent:=Form1;
      players[i].Cards[j].ImageForm.AutoSize:=true;
      players[i].Cards[j].ImageForm.Align:=alNone;
      players[i].Cards[j].ImageForm.Tag:=tag;
      players[i].Cards[j].ImageForm.OnClick:=form1.HumanClick;
      players[i].Cards[j].ImageForm.OnDblClick:=form1.HumanClick;
      inc(tag);
      end;
   end;
{========================================================================}
For i:=1 to maxplayers do
   begin
   For j:=1 to 4 do
      begin
      If i<>WhoIAm then Players[i].Cards[j].Hidden:=true;
      end;
   end;
For i:=1 to maxplayers do
   begin
   Players[i].UkVzatki:=1;
   Players[i].Answer:=false;
   Players[i].OnGame:=true;
   if i<>WhoIAm then Players[i].Human:=false
   else
   Players[i].Human:=true;
   end;
if Players[1].OnGame=true then
   begin
   VivodCards(1,200,6,60,0);
   Names(1,154,6,'Игрок 1');
   end;
if Players[2].OnGame=true then
   begin
   VivodCards(2,200,360,60,0);
   Names(2,440,420,'Игрок 2');
   end;
if Players[3].OnGame=true then
   begin
   VivodCards(3,200,360,60,0);
   Names(3,440,420,'Игрок 3');
   end;
if Players[4].OnGame=true then
   begin
   VivodCards(4,6,70,0,80);
   Names(4,20,394,'Игрок 4');
   end;
{============================ Работа с файлами ==========================}
PathToGame:=ExtractFilePath(Application.ExeName);
f1:=FileOpen(PathToGame+'cards.dat',fmOpenReadWrite);
f2:=FileOpen(PathToGame+'mast.dat',fmOpenReadWrite);
If FileExists(PathToGame+'cards.dat')=true then
FileRead(f1,buffer,36)
else
   begin
   Messagebox(Form1.Handle,PChar('Файл cards.dat не найден.'),'Ошибка.',MB_ICONSTOP);
   RESULT:=false;
   exit;
   end;
For i:=1 to 36 do
begin
koloda[i,1]:=buffer[i];
end;
If FileExists(PathToGame+'mast.dat')=true
then FileRead(f2,buffer,36)
else
   begin
   Messagebox(Form1.Handle,PChar('Файл mast.dat не найден.'),'Ошибка.',MB_ICONSTOP);
   RESULT:=false;
   exit;
   end;
For i:=1 to 36 do
begin
koloda[i,2]:=buffer[i];
end;
TUSUEM;
FileSeek (f1,0,SoFromBeginning);
FileSeek (f2,0,SoFromBeginning);
For i:=1 to 36 do
begin
buffer[i]:=koloda[i,1];
end;
FileWrite(f1,buffer,36);
For i:=1 to 36 do
begin
buffer[i]:=koloda[i,2];
end;
FileWrite(f2,buffer,36);
FileClose(f1);
FileClose(f2);
T1:=MainThread.Create(true);
T1.Priority:=tpIdle;//tpLower;
T1.Resume;
RESULT:=true;
END;

PROCEDURE VIVOD(igrok:byte);
BEGIN
PutImage(igrok);
END;

PROCEDURE INITNEWGAME;
VAR
i,j,tag:byte;
PathToGame:string;
BEGIN
{============================== Глобальные переменные ===================}
GameOver:=false;
maxplayers:=2;
tag:=1;
sxodili:=0;
ukkart:=1;
WhoIAm:=2;
Xod:=Pobil;
Pobil:=Xod;
AnswerPlayer:=xod;
HumanClickLock:=false;
ystola:=114;
{========================================================================}
For i:=1 to maxplayers do
   begin
   For j:=1 to 4 do
      begin
      If i<>WhoIAm then Players[i].Cards[j].Hidden:=true
      else Players[i].Cards[j].Hidden:=false;
      end;
   end;
For i:=1 to maxplayers do
   begin
   Players[i].UkVzatki:=1;
   Players[i].Answer:=false;
   Players[i].OnGame:=true;
   if i<>WhoIAm then Players[i].Human:=false
   else
   Players[i].Human:=true;
   end;
if Players[1].OnGame=true then
   begin
   VivodCards(1,200,6,60,0);
   Names(1,154,6,'Игрок 1');
   end;
if Players[2].OnGame=true then
   begin
   VivodCards(2,200,360,60,0);
   Names(2,440,420,'Игрок 2');
   end;
if Players[3].OnGame=true then
   begin
   VivodCards(3,200,360,60,0);
   Names(3,440,420,'Игрок 3');
   end;
if Players[4].OnGame=true then
   begin
   VivodCards(4,6,70,0,80);
   Names(4,20,394,'Игрок 4');
   end;
{============================ Работа с файлами ==========================}
PathToGame:=ExtractFilePath(Application.ExeName);
f1:=FileOpen(PathToGame+'cards.dat',fmOpenReadWrite);
f2:=FileOpen(PathToGame+'mast.dat',fmOpenReadWrite);
FileRead(f1,buffer,36);
For i:=1 to 36 do
begin
koloda[i,1]:=buffer[i];
end;
FileRead(f2,buffer,36);
For i:=1 to 36 do
begin
koloda[i,2]:=buffer[i];
end;
TUSUEM;
FileSeek (f1,0,SoFromBeginning);
FileSeek (f2,0,SoFromBeginning);
For i:=1 to 36 do
begin
buffer[i]:=koloda[i,1];
end;
FileWrite(f1,buffer,36);
For i:=1 to 36 do
begin
buffer[i]:=koloda[i,2];
end;
FileWrite(f2,buffer,36);
FileClose(f1);
FileClose(f2);
RAZDACHA(WhoIAm,4);
For i:=1 to maxplayers do
   begin
   If Players[i].OnGame=true then VIVOD(i);
   end;
For j:=1 to maxplayers do
   begin
   For i:=1 to 4 do
      begin
      Players[j].Cards[i].ImageForm.Visible:=true;
      end;
   end;
END;

procedure TForm1.FormCreate(Sender: TObject);
var
i:byte;
aClose:TcloseAction;
begin
aClose:=cafree;
If INITGAME=true then
  begin;
  RAZDACHA(WhoIAm,4);
  For i:=1 to maxplayers do
    begin
    If Players[i].OnGame=true then VIVOD(i);
    end;
  For i:=1 to 4 do
    begin
    Players[WhoIAm].Cards[i].ImageForm.Visible:=true;
    end;
  end;
//  else
//  form1.DoClose(aClose);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
i,j:byte;
begin
ImageKozir.Free;
For i:=1 to 41 do
   begin
   if ImageCards[i]<>nil then ImageCards[i].Free;
   end;

For i:=1 to maxplayers do
   begin
   for j:=1 to 4 do
      begin
      if players[i].Cards[j].ImageForm<>nil then players[i].Cards[j].ImageForm.Free;
      end;
      if NamePlayer[i]<>nil then NamePlayer[i].Free;
   end;
end;

procedure TForm1.ButtonXodClick(Sender: TObject);
var
i:byte;
begin
HumanClickLock:=true;
Form1.ButtonXod.Enabled:=false;
ystola:=114;
For i:=1 to 4 do
   begin
   If players[WhoIAm].Cards[i].CardsState=2 then
      begin
      Players[WhoIAm].Stol[i,1]:=Players[WhoIAm].Cards[i].Wes;
      Players[WhoIAm].Stol[i,2]:=Players[WhoIAm].Cards[i].Mast;
      end;
   end;
UDPUSTO(WhoIAm);
SortStol(WhoIAm);
VivodStola(WhoIAm,200,ystola,60,0);
ystola:=ystola+30;
Pobil:=Xod;
AnswerPlayer:=AnswerPlayer+1;
If AnswerPlayer>maxplayers then AnswerPlayer:=1;
sxodili:=sxodili+1;
EndNextPlayer(WhoIAm);
end;

PROCEDURE RoundSchet;
var
i,j:byte;
BEGIN
For j:=1 to maxplayers do
   begin
   Players[j].RoundScore:=0;
   end;
For j:=1 to maxplayers do
   begin
   For i:=1 to 36 do
      begin
         case Players[j].Vzatka[i] of
         53:Players[j].RoundScore:=Players[j].RoundScore+2;
         54:Players[j].RoundScore:=Players[j].RoundScore+3;
         55:Players[j].RoundScore:=Players[j].RoundScore+4;
         56:Players[j].RoundScore:=Players[j].RoundScore+10;
         57:Players[j].RoundScore:=Players[j].RoundScore+11;
         end;
      end;
   end;
For j:=1 to maxplayers do
   begin
   For i:=1 to 36 do
      begin
      Players[j].Vzatka[i]:=0;
      end;
   end;
Form5.Edit1.Text:=Inttostr(Players[1].RoundScore);
Form5.Edit2.Text:=Inttostr(Players[2].RoundScore);
Form5.Edit3.Text:=Inttostr(Players[3].RoundScore);
Form5.Edit4.Text:=Inttostr(Players[4].RoundScore);
For i:=1 to 4 do
   begin
   If Players[i].OnGame=false then
      begin
      TEdit(Form5.FindComponent('edit'+Inttostr(i))).enabled:=false;
      TEdit(Form5.FindComponent('edit'+Inttostr(i))).color:=clInactiveCaptionText;
      TLabel(Form5.FindComponent('Label'+Inttostr(i))).enabled:=false;
      TEdit(Form5.FindComponent('edit'+Inttostr(i+4))).enabled:=false;
      TEdit(Form5.FindComponent('edit'+Inttostr(i+4))).color:=clInactiveCaptionText;
      TLabel(Form5.FindComponent('Label'+Inttostr(i+4))).enabled:=false;
      end;
   end;
For i:=1 to maxplayers do
   begin
   If (Players[i].RoundScore<60) and (Players[i].RoundScore>=31) then Players[i].GameScore:=Players[i].GameScore+2;
   If (Players[i].RoundScore>0) and (Players[i].RoundScore<31) then Players[i].GameScore:=Players[i].GameScore+4;
   If Players[i].RoundScore=0 then Players[i].GameScore:=Players[i].GameScore+6;
   If Players[i].GameScore=0 then Form7.Image1.Picture.LoadFromFile('Оленька#0.jpg');
   If Players[i].GameScore=2 then Form7.Image1.Picture.LoadFromFile('Оленька#1.jpg');
   If Players[i].GameScore=4 then Form7.Image1.Picture.LoadFromFile('Оленька#2.jpg');
   If Players[i].GameScore=6 then Form7.Image1.Picture.LoadFromFile('Оленька#3.jpg');
   If Players[i].GameScore=8 then Form7.Image1.Picture.LoadFromFile('Оленька#4.jpg');
   If Players[i].GameScore=10 then Form7.Image1.Picture.LoadFromFile('Оленька#5.jpg');
   If Players[i].GameScore=12 then Form7.Image1.Picture.LoadFromFile('Оленька#5.jpg');
   end;
Form5.Edit5.Text:=Inttostr(Players[1].Gamescore);
Form5.Edit6.Text:=Inttostr(Players[2].Gamescore);
Form5.Edit7.Text:=Inttostr(Players[3].Gamescore);
Form5.Edit8.Text:=Inttostr(Players[4].Gamescore);
Form5.ShowModal;
For i:=1 to maxplayers do
   begin
   If Players[i].GameScore>=12 then
      begin
      GameOver:=true;
      Form1.Caption:='Конец игры.';
      break;
      end;
   end;
   If GameOver=false then INITNEWGAME;
END;

PROCEDURE MALOTKA(Player:byte);
var
i,j,c,d:byte;
BEGIN
For c:=1 to maxplayers do
begin
j:=0;
For i:=1 to 4 do
   begin
   If (Players[player].Cards[1].Wes<>0) and (Players[player].Cards[1].Mast=Players[player].Cards[i].Mast) then j:=j+1;
   If j=4 then
      begin
      For d:=1 to 4 do
         begin
         Players[player].Stol[i,1]:=Players[player].Cards[i].Wes;
         Players[player].Stol[i,2]:=Players[player].Cards[i].Mast;
         end;
      Form1.Caption:='МАЛОТКА';
      Pobil:=Player;
      end;
   end;
Player:=Player+1;
If Player>maxplayers then Player:=1;
end;
END;

PROCEDURE TForm1.Main;
var
i,j:byte;
begin
  If (Players[1].Answer=false) and (Answerplayer=1) and (GameOver=false) then
     begin
     If Players[1].Human=false then
         begin
         nextplayers(1);
         sxodili:=sxodili+1;
         Players[1].Answer:=true;
         Answerplayer:=Answerplayer+1;
         If AnswerPlayer>maxplayers then AnswerPlayer:=1;
         end
         else
         begin
         HumanClickLock:=false;
         end;
         end;
     If (Players[2].Answer=false) and (Answerplayer=2) and (GameOver=false) then
         begin
         If Players[2].Human=false then
            begin
            nextplayers(2);
            sxodili:=sxodili+1;
            Players[2].Answer:=true;
            Answerplayer:=Answerplayer+1;
            If AnswerPlayer>maxplayers then AnswerPlayer:=1;
           end
           else
           begin
           HumanClickLock:=false;
           end;
        end;
      If (Players[3].Answer=false) and (Answerplayer=3) and (GameOver=false) then
         begin
         If Players[3].Human=false then
         begin
         nextplayers(3);
         sxodili:=sxodili+1;
         Players[3].Answer:=true;
         Answerplayer:=Answerplayer+1;
         If AnswerPlayer>maxplayers then AnswerPlayer:=1;
         end
         else
         begin
         HumanClickLock:=false;
         end;
         end;
      If (Players[4].Answer=false) and (Answerplayer=4) and (GameOver=false) then
         begin
         If Players[4].Human=false then
         begin
         nextplayers(4);
         sxodili:=sxodili+1;
         Players[4].Answer:=true;
         Answerplayer:=Answerplayer+1;
         If AnswerPlayer>maxplayers then AnswerPlayer:=1;
         end
         else
         begin
         HumanClickLock:=false;
         end;
         end;
Application.ProcessMessages;
if sxodili=maxplayers then
   begin;
      Vzatka;
      For i:=1 to 36 do
         begin
         Form2.Memo1.Lines.Add('Vzatka: '+IntToStr(Players[Pobil].Vzatka[i]));
         end;
      Application.ProcessMessages;
      Sleep(2000);
      RAZDACHA(Pobil,ksk);
      MALOTKA(Pobil);
      Form2.Memo1.Lines.Add('Razdacha:');
      For i:=1 to maxplayers  do
         begin
         Form2.Memo1.Lines.Add('Player '+IntToStr(i));
         Form2.Memo1.Lines.Add(IntToStr(Players[i].cards[1].Wes)+' '+
                               IntToStr(Players[i].cards[2].Wes)+' '+
                               IntToStr(Players[i].cards[3].Wes)+' '+
                               IntToStr(Players[i].cards[4].Wes));
         Form2.Memo1.Lines.Add(IntToStr(Players[i].cards[1].Mast)+' '+
                               IntToStr(Players[i].cards[2].Mast)+' '+
                               IntToStr(Players[i].cards[3].Mast)+' '+
                               IntToStr(Players[i].cards[4].Mast));
         end;
For i:=1 to maxplayers do
   begin
   If WhoIAm<>i then
      begin
      For j:=1 to 4 do
         begin
         Players[i].Cards[j].Hidden:=true;
         end;
      end;
   end;
if Players[1].OnGame=true then
   begin
   VivodCards(1,200,6,60,0);
   Vivod(1);
   end;
if Players[2].OnGame=true then
   begin
   VivodCards(2,200,360,60,0);
   Vivod(2);
   end;
if Players[3].OnGame=true then
   begin
   VivodCards(3,200,360,60,0);
   Vivod(3);
   end;
if Players[4].OnGame=true then
   begin
   VivodCards(4,6,70,0,80);
   Vivod(4);
   end;
      AnswerPlayer:=pobil;
      Xod:=pobil;
      sxodili:=0;
      Players[1].Answer:=false;
      Players[2].Answer:=false;
      Players[3].Answer:=false;
      Players[4].Answer:=false;
      Form2.Memo1.Lines.Add('pobil = '+IntToStr(pobil));
      Form2.Memo1.Lines.Add('Xod = '+IntToStr(xod));
j:=0;
   For i:=1 to 4 do
   begin
   If (GameOver=false) and (Players[WhoIAm].Cards[i].Wes=0) then j:=j+1;
   end;
   If j=4 then
      begin
      RoundSchet;
      end
   else j:=0;
   end;
END;
procedure TForm1.ButtonSkidClick(Sender: TObject);
var
i:byte;
begin
HumanClickLock:=true;
For i:=1 to 4 do
   begin
   Players[WhoIAm].Stol[i,1]:=0;
   Players[WhoIAm].Stol[i,2]:=0;
   end;
For i:=1 to 4 do
   begin
   If Players[WhoIAm].Cards[i].CardsState=2 then
      begin
      Players[WhoIAm].Stol[i,1]:=Players[WhoIAm].Cards[i].Wes;
      Players[WhoIAm].Stol[i,2]:=Players[WhoIAm].Cards[i].Mast;
      end;
   end;
{=====================}
For i:=1 to 4 do
   begin
   If players[WhoIAm].Cards[i].CardsState=2 then
      begin
      Players[WhoIAm].Cards[i].Hidden:=true;
      end;
   end;
HumanClickLock:=true;
Form2.Memo1.Lines.Add('ystola:='+Inttostr(ystola));
VivodStola(WhoIAm,200,ystola,60,0);
ystola:=ystola+30;
Players[WhoIAm].Answer:=true;
Answerplayer:=Answerplayer+1;
If AnswerPlayer>maxplayers then AnswerPlayer:=1;
Form1.ButtonSkid.Enabled:=false;
Form1.ButtonBit.Enabled:=false;
sxodili:=sxodili+1;
Application.ProcessMessages;
UdPusto(WhoIAm);
EndNextPlayer(WhoIAm);
end;

procedure TForm1.ButtonBitClick(Sender: TObject);
var
n,i:byte;
begin
HumanClickLock:=true;
For i:=1 to 4 do
   begin
   Players[WhoIAm].Stol[i,1]:=0;
   Players[WhoIAm].Stol[i,2]:=0;
   end;
For i:=1 to 4 do
   begin
   If players[WhoIAm].Cards[i].CardsState=2 then
      begin
      Players[WhoIAm].Stol[i,1]:=Players[WhoIAm].Cards[i].Wes;
      Players[WhoIAm].Stol[i,2]:=Players[WhoIAm].Cards[i].Mast;
      end;
   end;
MySort;
UDPUSTO(WhoIAm);
{=====================}
For i:=1 to 4 do
   begin
   if players[WhoIAm].Cards[i].CardsState=2 then
      begin
      n:=GetNumberCard(Nextplayer,Players[WhoIAm].Stol[i,1],Players[WhoIAm].Stol[i,2]);
      Players[WhoIAm].Cards[n].Hidden:=false;
      end;
   end;
VivodStola(WhoIAm,200,ystola,60,0);
ystola:=ystola+30;
Players[WhoIAm].Answer:=true;
Answerplayer:=Answerplayer+1;
If AnswerPlayer>maxplayers then AnswerPlayer:=1;
Form1.ButtonSkid.Enabled:=false;
Form1.ButtonBit.Enabled:=false;
sxodili:=sxodili+1;
Application.ProcessMessages;
Sleep(2000);
EndNextPlayer(WhoIAm);
Pobil:=WhoIAm;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
Form4.ShowModal;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
Form6.ShowModal;
end;
procedure TForm1.N3Click(Sender: TObject);
var
i,j:byte;
begin
For i:=1 to maxplayers do
   begin
   Players[i].GameScore:=0;
   For j:=1 to 36 do
      begin
      Players[i].Vzatka[j]:=0;
      end;
   end;
For i:=1 to maxplayers do
   begin
   For j:=1 to 4 do
      begin
      Players[i].Cards[j].Wes:=0;
      Players[i].Cards[j].Mast:=0;
      Players[i].Stol[1,j]:=0;
      Players[i].Stol[2,j]:=0;
      end;
   end;
INITNEWGAME;
end;

end.
