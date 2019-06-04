Setup()
return Def.Sprite{
	Texture=THEME:GetPathG("","_BGMovies/RIOScreenInit.avi"),
	OnCommand=function(self) self:Center():FullScreen():loop(false) end
}