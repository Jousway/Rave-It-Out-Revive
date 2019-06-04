return Def.Sprite{
	Texture=THEME:GetPathG("","_BGMovies/RIOScreenOpening.avi"),
	OnCommand=function(self) self:Center():FullScreen():loop(false) end
}