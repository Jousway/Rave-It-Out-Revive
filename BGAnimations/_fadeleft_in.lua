return Def.Quad{
	OnCommand=function(self)
		self:FullScreen()
			:diffuse(0,0,0,0)
			:zoomx(SCREEN_WIDTH+(SCREEN_WIDTH*RIO.ScreenRatio))
			:faderight(RIO.ScreenRatio)
			:x(SCREEN_CENTER_X+(SCREEN_WIDTH*(RIO.ScreenRatio*0.5)))
			:decelerate(RIO.AnimationLength)
			:x(-SCREEN_CENTER_X-(SCREEN_WIDTH*(RIO.ScreenRatio*0.5)))
	end
}
