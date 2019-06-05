RIO.Reset()

local LowSpec = { [true] = "BGADScreenInit.jpg", [false] = "RIOScreenInit.avi" }

return Def.Sprite{
	Texture=THEME:GetPathG("","_BGMovies/"..LowSpec[RIO.LowSpec]),
	OnCommand=function(self) 
		self:Center():FullScreen():loop(false) 
		if RIO.LowSpec then self:diffusealpha(0):linear(2):diffusealpha(1):sleep(3):linear(2):diffusealpha(0) end
	end
}