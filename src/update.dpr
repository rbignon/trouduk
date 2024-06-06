program update;

uses
  SysUtils, Windows, ShellApi, Dialogs;

  { Paramstr(1) = 'launch'
    Paramstr(2) = executable
    Paramstr(3) = patch }
begin
  if(Paramcount <> 3) or (Paramstr(1) <> 'launch') then
    halt;
  if(FileExists(Paramstr(3)) = false) then halt; // fichier introuvable
  sleep(1000);
  if(FileExists(Paramstr(2))) then
    if(DeleteFile(pchar(Paramstr(2))) = false) then
    begin
      MessageDlg('Veuillez quitter le trou du cul...', mterror, [mbok], 0);
      halt;
    end;
  RenameFile(Paramstr(3), Paramstr(2));
  Winexec(pchar(Paramstr(2)), 0);
end.
