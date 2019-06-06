Config.Save('ShowScreenStartupConfiguration','true',THEME:GetCurrentThemeDirectory()..'/Config.ini')
return Def.ActorFrame{
	OnCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end
}