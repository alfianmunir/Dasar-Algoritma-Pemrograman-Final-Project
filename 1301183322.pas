program tubes;
uses dos, crt;
const max = 100;
type
  pegawai = record
    nip, tanggal : string;
    jml_lembar : integer;
  end;
  log = record
    nip, id, tanggal : string;
    jml_lembar : integer;
  end;
  datalog = array[1..max] of log;
  pegawai1 = array[1..max] of pegawai;

var
  log_pegawai : pegawai1;
  data_log : datalog;
  stat1, indeks, indeks_nip : integer;
  id : array of string;
  MM, YY, DD, h : word;
  gg : string;

function cek_nip(x : string) : boolean;
begin
  cek_nip := ((x[1] = '2') AND (length(x) = 8));
end;

function jumlah_lembar(x : integer) : boolean;
begin
  jumlah_lembar := ((x <= 1000) AND ( x > 0));
end;

function search(data_log : datalog; cari : string) : integer;
var
  i : integer;
begin
  i := 1;
  while ((i <= indeks) AND (data_log[i].nip <> cari)) do
    i := i + 1;
  if (data_log[i].nip = cari) then
    search := i
  else search := 0;
end;

function search4(data_log : pegawai1; cari : string) : integer;
var
  i : integer;
begin
  i := 1;
  while ((i <= indeks) AND (data_log[i].nip <> cari)) do
    i := i + 1;
  if (data_log[i].nip = cari) then
    search4 := i
  else search4 := 0;
end;

function search2(data_log : datalog; cari : string; indeks:integer) : boolean;
var
  i : integer;
begin
  i := 1;
  while ((i < indeks) AND (data_log[i].nip <> cari)) do
    i := i + 1;
  if (data_log[i].nip = cari) then
    search2 := TRUE
  else search2 := FALSE;
end;

function search3(data_log : pegawai1; cari : string; indeks:integer) : boolean;
var
  i : integer;
begin
  i := 1;
  while ((i < indeks) AND (data_log[i].nip <> cari)) do
    i := i + 1;
  if (data_log[i].nip = cari) then
    search3 := TRUE
  else search3 := FALSE;
end;

function count(data_log : datalog; hitung : string; indeks : integer) : integer;
var
  i, total : integer;
begin
  total := 0;
  for i := 1 to indeks do
    if (data_log[i].nip = hitung) then
      total := total + 1;
  count := total;
end;

procedure buat_id(var indeks : integer; MM, YY : word; var id : string);
var
  indeksex, MMex, YYex, x : string;
begin
  str(indeks,indeksex);
  {x := data_log[indeks-1].id[4] + data_log[indeks-1].id[5];}
  str(MM,MMex);
  {if (MMex <> x) then
    indeks := 1;}
  str(YY,YYex);
  if (indeks < 10) then
    id := 'FC-' + MMex + YYex[3] + YYex[4] + '-00' + indeksex
  else
    id := 'FC-' + MMex + YYex[3] + YYex[4] + '-0' + indeksex;
end;

procedure loginpeg(var data_log : datalog; var indeks, indeks_nip : integer);
var
  nippeg, status1 : string;
  jml, indeks2 : integer;
  DDex, MMex, YYex, tgl_sekarang : string;
begin
  clrscr;
  repeat
    begin
      clrscr;
      writeln('=============================================');
      writeln('|                INPUT NIP                  |');
      writeln('=============================================');
      writeln;
      write('      Masukan NIP anda    : ');
      readln(nippeg);
      if (not cek_nip(nippeg)) then begin
        writeln('NIP anda tidak valid');
        readln();
        end;
    end;
  until (cek_nip(nippeg));
  clrscr;
  repeat
    begin
      writeln;
      writeln('=============================================');
      writeln('|       INPUT JUMLAH LEMBAR FOTOKOPI        |');
      writeln('=============================================');
      writeln;
      write('     Masukan jumlah lembar fotokopi : ');
      readln(jml);
      if (not jumlah_lembar(jml)) then begin
        writeln('jumlah yang anda masukan tidak valid');
        readln();
        end;
      clrscr;
    end;
  until (jumlah_lembar(jml));
  str(YY,YYex);
  str(MM,MMex);
  str(DD,DDex);
  if (search3(log_pegawai,nippeg,indeks)) then
  begin
      indeks := indeks + 1;
      tgl_sekarang := DDex + '/' + MMex + '/' + YYex;
      buat_id(indeks,MM,YY,data_log[indeks].id);
      data_log[indeks].nip := nippeg;
      data_log[indeks].jml_lembar := jml;
      data_log[indeks].tanggal := tgl_sekarang;
      indeks2 := search4(log_pegawai, nippeg);
      log_pegawai[indeks2].jml_lembar := log_pegawai[indeks2].jml_lembar + jml;
  end
  else
    begin
      indeks := indeks + 1;
      indeks_nip := indeks_nip + 1;
      tgl_sekarang := DDex + '/' + MMex + '/' + YYex;
      buat_id(indeks,MM,YY,data_log[indeks].id);
      data_log[indeks].nip := nippeg;
      data_log[indeks].jml_lembar := jml;
      data_log[indeks].tanggal := tgl_sekarang;
      log_pegawai[indeks_nip].nip := nippeg;
      log_pegawai[indeks_nip].tanggal := tgl_sekarang;
      log_pegawai[indeks_nip].jml_lembar := jml;
    end;
end;

procedure sorting_nip1(var T : datalog; var indeks : integer);
{selection sort pegawai}
var
  imin, i, j, temp3 : integer;
  temp, temp2, temp4, min : string;
begin
  for i := 1 to indeks - 1 do
  begin
    min := T[i].nip;
    for j := i to indeks do
      if (T[j].nip < min) then 
      begin
        min := T[j].nip;
        imin := i;
      end;
    temp := T[imin].nip;
    temp2 := T[imin].tanggal;
    temp3 := T[imin].jml_lembar;
    temp4 := T[imin].id;
    T[imin].id := T[j].id;
    T[imin].jml_lembar := T[j].jml_lembar;
    T[imin].tanggal := T[j].tanggal;
    T[imin].nip := T[j].nip;
    T[j].id := temp4;
    T[j].nip := temp;
    T[j].jml_lembar := temp3;
    T[j].tanggal := temp2;
  end;
end;

procedure selection2(var T : datalog; indeks : integer);
{selection sort datalog}
var
  imin, i, j, pass, temp3, min : integer;
  temp, temp2, temp4 : string;
begin
  i := 1;
  for pass := 1 to indeks - 1 do
  begin
    min := T[pass].jml_lembar;
    for j := pass to indeks do
      if (T[j].jml_lembar < min) then begin
        min := T[j].jml_lembar;
        imin := j;
      end;
    temp := T[imin].nip;
    temp2 := T[imin].tanggal;
    temp3 := T[imin].jml_lembar;
    temp4 := T[imin].id;
    T[imin].id := T[pass].id;
    T[imin].jml_lembar := T[pass].jml_lembar;
    T[imin].tanggal := T[pass].tanggal;
    T[imin].nip := T[pass].nip;
    T[pass].id := temp4;
    T[pass].nip := temp;
    T[pass].jml_lembar := temp3;
    T[pass].tanggal := temp2;
  end;
end;

procedure insertion(var T : datalog; indeks : integer);
var
  i, j, y : integer;
  found : boolean;
  y1, y2, y3 : string;
begin
  for i := 2 to indeks do
    begin
      y := T[i].jml_lembar;
      y1 := T[i].id;
      y2 := T[i].nip;
      y3 := T[i].tanggal;
      j := i-1;
      found := false;
      while (j>=1) AND (not found) do
        if y < T[j].jml_lembar then begin
          T[j+1].jml_lembar := T[j].jml_lembar;
          T[j+1].nip := T[j].nip;
          T[j+1].id := T[j].id;
          T[j+1].tanggal := T[j].tanggal;
          j := j- 1;
        end
        else found := true;
      T[j+1].jml_lembar := y;
      T[j+1].id := y1;
      T[j+1].nip := y2;
      T[j+1].tanggal := y3;
    end;
end;

procedure insertion2(var T : datalog; indeks : integer);
var
  i, j, y : integer;
  found : boolean;
  y1, y2, y3 : string;
begin
  for i := 2 to indeks do
    begin
      y := T[i].jml_lembar;
      y1 := T[i].id;
      y2 := T[i].nip;
      y3 := T[i].tanggal;
      j := i-1;
      found := false;
      while (j>=1) AND (not found) do
        if y2 < T[j].nip then begin
          T[j+1].jml_lembar := T[j].jml_lembar;
          T[j+1].nip := T[j].nip;
          T[j+1].id := T[j].id;
          T[j+1].tanggal := T[j].tanggal;
          j := j- 1;
        end
        else found := true;
      T[j+1].jml_lembar := y;
      T[j+1].id := y1;
      T[j+1].nip := y2;
      T[j+1].tanggal := y3;
    end;
end;

procedure insertion3(var T : datalog; indeks : integer);
var
  i, j, y2 : integer;
  y, y1, y3 : string;
  found : boolean;
begin
  for i := 2 to indeks do
    begin
      y := T[i].nip;
      y1 := T[i].tanggal;
      y2 := T[i].jml_lembar;
      y3 := T[i].id;
      j := i-1;
      found := false;
      while (j>=1) AND (not found) do
        if y < T[j].nip then begin
          T[j+1].jml_lembar := T[j].jml_lembar;
          T[j+1].nip := T[j].nip;
          T[j+1].tanggal := T[j].tanggal;
          T[j+1].id := T[j].id;
          j := j- 1;
        end
        else found := true;
      T[j+1].nip := y;
      T[j+1].tanggal := y1;
      T[j+1].jml_lembar := y2;
      T[j+1].id := y3;
    end;
end;

procedure data_pegawai(data_log : datalog);
var
  nip : string;
  i, idx, jumlah : integer;
begin
  idx := 0;
  jumlah := 0;
  repeat
    writeln('Masukan NIP pegawai : ');
    readln(nip);
    if (not cek_nip(nip)) then
      writeln('NIP yang anda masukan tidak valid');
  until (cek_nip(nip));
  if (search2(data_log,nip,indeks)) then
    begin
      idx := search(data_log,nip);
      jumlah := count(data_log,nip,indeks);
      writeln('Data Fotokopi untuk NIP ',nip);
      for i := 1 to jumlah do
      begin
        writeln(i,'. ',data_log[idx].id,' ',data_log[idx].jml_lembar,' ',data_log[idx].tanggal);
        idx := idx + 1;
      end;
    end
  else writeln('tak ada data fotokopi untuk NIP yang anda masukan');
end;

procedure login_admin(indeks_nip, indeks : integer);
var
  bulan, idx, acuan, acuan1 : string;
  stat, stat2, stat3, i, x, y, b, jumlahtot, a, c : integer;
begin
repeat
  clrscr;
  writeln('1. Data fotokopi setiap pegawai.');
  writeln('2. Data fotokopi setiap bulan.');
  writeln('3. Total lembar dan biaya fotokopi.');
  writeln('4. Semua data fotokopi.');
  writeln('5. Keluar.');
  writeln;
  write('Masukan menu pilihan anda : ');
  readln(stat);
  case stat of
  1 : 
  begin
    insertion2(data_log,indeks);
    data_pegawai(data_log);
    readln();
  end;
  2 :
  begin
    clrscr;
    write('Masukan bulan : ');
    readln(bulan);
    case bulan of
    'januari' : idx := '01';
    'februari' : idx := '02';
    'maret' : idx := '03';
    'april' : idx := '04';
    'mei' : idx := '05';
    'juni' : idx := '06';
    'juli' :  idx := '07';
    'agustus' : idx := '08';
    'september' : idx := '09';
    'oktober' : idx := '10';
    'november' : idx := '11';
    'desember' : idx := '12';
    end;
    c := 0;
    for a := 1 to indeks do
        begin
          acuan1 := data_log[a].id[4] + data_log[a].id[5];
          if (acuan1 = idx) then
            c := c + 1;
        end;
    if (c = 0 ) then begin
      writeln('Tak ada data fotokopi di bulan ini');
      readln();
    end
    else
    begin
      writeln;
      writeln('1. Urutkan berdasarkan NIP.');
      writeln('2. Urutkan berdasarkan jumlah fotokopi.');
      writeln;
      write('Masukan pilihan anda : ');
      readln(stat3);
      clrscr;
      case stat3 of
      1 :
      begin
        y := 1;
        sorting_nip1(data_log,indeks);
        for x := 1 to indeks do
          begin
            acuan := data_log[x].id[4] + data_log[x].id[5];
            if (acuan = idx) then begin
              writeln(y,' ',data_log[x].nip,' ',data_log[x].id,' ',data_log[x].jml_lembar,' ',data_log[x].tanggal);
              y := y + 1;
            end;
          end;
        readln();
      end;
      2 : 
      begin
        y := 1;
        selection2(data_log,indeks);
        for x := 1 to indeks do
          begin
            acuan := data_log[x].id[4] + data_log[x].id[5];
            if (acuan = idx) then begin
              writeln(y,' ',data_log[x].nip,' ',data_log[x].id,' ',data_log[x].jml_lembar,' ',data_log[x].tanggal);
              y := y + 1;
            end;
          end;
        readln();
      end;
      end;
    end;
  end;
  3 :
  begin
    jumlahtot := 0;
    for b := 1 to indeks_nip do
      jumlahtot := log_pegawai[b].jml_lembar + jumlahtot;
    writeln('Jumlah lembar fotokopi : ',jumlahtot);
    writeln('Total Biaya            : ',jumlahtot*200);
    readln();
  end;
  4 : 
  begin
    clrscr;
    writeln('1. Terurut berdasarkan NIP.');
    writeln('2. Terurut berdasarkan jumlah fotokopi.');
    writeln;
    write('Masukan pilihan anda : ');
    readln(stat2);
    clrscr;
    case stat2 of
    1 :
    begin
      insertion3(data_log,indeks);
      for i := 1 to indeks do
        writeln(i,' ',data_log[i].nip,' ',data_log[i].id,' ',data_log[i].jml_lembar,' ',data_log[i].tanggal);
      readln();
    end;
    2 : 
    begin
      insertion(data_log,indeks);
      for i := 1 to indeks do
        writeln(i,' ',data_log[i].nip,' ',data_log[i].id,' ',data_log[i].jml_lembar,' ',data_log[i].tanggal);
      readln();
    end;
    end;
  end;
  end;
until (stat = 5);
clrscr;
end;

begin
  {getDate(YY,MM,DD,h);}
  indeks := 0;
  indeks_nip := 0;
  repeat
      clrscr;
      getDate(YY,MM,DD,h);
      str(MM,gg);
      writeln('=============================================');
      writeln('|                  WELCOME                  |');
      writeln('=============================================');
      writeln('|                                           |');
      writeln('|            1. Login Pegawai               |');
      writeln('|             2. Login Admin                |');
      writeln('|               3. Keluar                   |');
      writeln('|                                           |');
      writeln('=============================================');
      write('  Masukan menu pilihan anda : ');
      readln(stat1);
      case stat1 of
      1 : loginpeg(data_log,indeks,indeks_nip);
      2 : login_admin(indeks_nip,indeks);
      end;
      if ((data_log[indeks].id[4]+data_log[indeks].id[5]) <> gg) then
        indeks := 0;
  until (stat1 = 3);
end.