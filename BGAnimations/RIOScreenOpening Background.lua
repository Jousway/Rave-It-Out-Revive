return Def.Sprite{
	Texture=THEME:GetPathG("","_BGMovies/RIOScreenOpening.avi"),
	OnCommand=function(self) 
		self:Center():FullScreen():loop(false) 
		if RIO.LowSpec then SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end
	end
}