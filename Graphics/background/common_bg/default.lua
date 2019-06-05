local LowSpec = { [true] = "BGADArcade.jpg", [false] = "RIOArcade.avi" }

return Def.ActorFrame{
	Def.Sprite{
		Texture=THEME:GetPathG("","_BGMovies/"..LowSpec[RIO.LowSpec]),
		InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH,SCREEN_HEIGHT+10) end
	}
}