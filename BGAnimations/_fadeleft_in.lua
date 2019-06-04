return Def.Quad{
	OnCommand=function(self)
		self:FullScreen()
			:diffuse(0,0,0,0)
			:zoomx(SCREEN_WIDTH+(SCREEN_WIDTH*RIO.ScreenInRatio))
			:faderight(RIO.ScreenInRatio)
			:x(SCREEN_CENTER_X+(SCREEN_WIDTH*(RIO.ScreenInRatio*0.5)))
			:decelerate(RIO.AnimationInLength)
			:x(-SCREEN_CENTER_X-(SCREEN_WIDTH*(RIO.ScreenInRatio*0.5)))
	end
}
