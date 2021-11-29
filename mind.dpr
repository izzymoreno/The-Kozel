library mind;


//uses
//  sysutils
//  ,messages;

type TPlayerStolMas=array[1..4,1..2] of byte;

FUNCTION DllBitSkidNextplayer(ksk,kozir:byte;
                              NextPlayerStol:TPlayerStolMas;
                              PobilStol:TPlayerStolMas):byte;
var
i,j,kbk:byte;
BEGIN
kbk:=0;
i:=ksk;
For j:=4 downto 1 Do
   begin
      If (NextPlayerStol[j,2]=PobilStol[i,2])
      and (PobilStol[i,1]<NextPlayerStol[j,1]) then
         begin
         kbk:=kbk+1;
         i:=i-1;
         If i<1 then
            begin
            i:=1;
            break;
            end;
         end;
      If (NextPlayerStol[j,2]=kozir)
      and (PobilStol[i,2]<>kozir) then
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
RESULT:=Kbk;
END;

FUNCTION UDPUSTO(var NextPlayerStol:TPlayerStolMas):boolean;
var
i,j:byte;
BEGIN
For j:=1 to 4 do
   begin
   For i:=1 to 3 do
      begin
      If NextPlayerStol[i,1]=0 then
         begin
         NextPlayerStol[i,1]:=NextPlayerStol[i+1,1];
         NextPlayerStol[i,2]:=NextPlayerStol[i+1,2];
         NextPlayerStol[i+1,1]:=0;
         NextPlayerStol[i+1,2]:=0;
         end;
      end;
   end;
END;

FUNCTION SORTSTOL(var NextPlayerStol:TPlayerStolMas):boolean;
var
i,j,space:byte;
BEGIN
For j:=1 to 4 do
   begin
   For i:=1 to 3 do
      begin
      If NextPlayerStol[i+1,1]>NextPlayerStol[i,1] then
         begin
         space:=NextPlayerStol[i,1];
         NextPlayerStol[i,1]:=NextPlayerStol[i+1,1];
         NextPlayerStol[i+1,1]:=space;
         space:=NextPlayerStol[i,2];
         NextPlayerStol[i,2]:=NextPlayerStol[i+1,2];
         NextPlayerStol[i+1,2]:=space;
         end;
      end;
   end;
END;

FUNCTION DllXodNextPlayer(var ksk:byte;var ystola:integer;var Stol:TPlayerStolMas):byte;
var
i,n,mast,max:byte;
Statistica:array[1..4] of byte;
BEGIN
ystola:=114;
ksk:=0;
max:=0;
mast:=0;
Statistica[1]:=0;
Statistica[2]:=0;
Statistica[3]:=0;
Statistica[4]:=0;
For i:=1 to 4 Do
   begin
   If Stol[i,2]=65 then
   Statistica[1]:=Statistica[1]+1;
   If Stol[i,2]=66 then
   Statistica[2]:=Statistica[2]+1;
   If Stol[i,2]=67 then
   Statistica[3]:=Statistica[3]+1;
   If Stol[i,2]=68 then
   Statistica[4]:=Statistica[4]+1;
   end;

For i:=1 to 4 Do
   begin
   If max<Statistica[i] then
      begin
      max:=Statistica[i];
      mast:=64+i;
      end;
   end;
For i:=1 to 4 Do
   begin
   If Stol[i,2]<>mast then
      begin
      Stol[i,1]:=0;
      Stol[i,2]:=0;
      end;
   end;
ksk:=max;
UdPusto(Stol);
SortStol(Stol);
END;

exports
DllBitSkidNextplayer index 1  name 'DllBitSkidNextplayer',
DllXodNextPlayer index 2 name 'DllXodNextPlayer';
end.


