program trouduk;

uses
  Forms,
  main in 'main.pas' {Form1},
  newgame in 'newgame.pas' {Connexion},
  choosegame in 'choosegame.pas' {gamelist},
  wait in 'wait.pas' {waitgame},
  apropos in 'apropos.pas' {about},
  passdlg in 'passdlg.pas' {PasswordDlg},
  anerror in 'anerror.pas' {Erreur},
  config in 'config.pas' {cfg},
  infoserver in 'infoserver.pas' {serverinfo},
  update in 'update.pas' {upgrade},
  changelog in 'changelog.pas' {Changes},
  regnick in 'regnick.pas' {register},
  listusers in 'listusers.pas' {userlist},
  choosebackcarte in 'choosebackcarte.pas' {takebackcarte},
  statsshow in 'statsshow.pas' {showstats};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Trouduk';
  Application.CreateForm(TConnexion, Connexion);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tgamelist, gamelist);
  Application.CreateForm(Twaitgame, waitgame);
  Application.CreateForm(Tabout, about);
  Application.CreateForm(TPasswordDlg, PasswordDlg);
  Application.CreateForm(TErreur, Erreur);
  Application.CreateForm(Tcfg, cfg);
  Application.CreateForm(Tserverinfo, serverinfo);
  Application.CreateForm(Tupgrade, upgrade);
  Application.CreateForm(TChanges, Changes);
  Application.CreateForm(Tregister, register);
  Application.CreateForm(Tuserlist, userlist);
  Application.CreateForm(Ttakebackcarte, takebackcarte);
  Application.CreateForm(Tshowstats, showstats);
  Changes.show_changelog;
  Application.Run;
end.
