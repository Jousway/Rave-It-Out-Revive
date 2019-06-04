return Def.Quad{
	OnCommand=function(self)
		self:FullScreen()
			:diffuse(0,0,0,0)
			:zoomx(SCREEN_WIDTH+(SCREEN_WIDTH*RIO.ScreenOutRatio*1.25))
			:fadeleft(RIO.ScreenOutRatio)
			:x(SCREEN_CENTER_X*3+(SCREEN_WIDTH*(RIO.ScreenOutRatio*0.5)))
			:decelerate(RIO.AnimationOutLength)
			:x(-SCREEN_CENTER_X-(SCREEN_WIDTH*(RIO.ScreenOutRatio*0.5))*0.9166666666666667)
	end
}