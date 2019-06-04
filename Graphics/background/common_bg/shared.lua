return Def.ActorFrame{
	Def.Sprite{
		Texture=THEME:GetPathG("","_BGMovies/Arcade"),
		InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH,SCREEN_HEIGHT+10) end
	},
	Def.Sprite{
		Texture="fade.png",
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0.6) end
	}
}