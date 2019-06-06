return Def.ActorFrame{
	OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(RIO.Input(self)) end,
	StartCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end,
	Def.Sprite{
		Texture=THEME:GetPathG("","noise.png"),
		InitCommand=function(self) self:FullScreen():vibrate() end
	}
}