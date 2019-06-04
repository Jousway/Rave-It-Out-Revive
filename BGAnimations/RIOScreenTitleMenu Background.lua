return Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffuse(1,1,1,1):decelerate(0.75):diffusealpha(0):zoomy(0) end
	},
	Def.Sprite{
		Texture=THEME:GetPathG("","_BGMovies/RIOScreenTitleMenu.avi"),
		OnCommand=function(self) self:FullScreen():diffusealpha(0):accelerate(1):diffusealpha(1) end
	}
}