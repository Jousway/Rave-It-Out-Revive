return Def.ActorFrame{
	Condition=RIO.IsMemcardEnabled,
	InitCommand=function(self) self:xy(THEME:GetMetric("RIOScreenTitleJoin","ScrollerX"),THEME:GetMetric("RIOScreenTitleJoin","ScrollerY")+80) end,
	OnCommand=function(self) self:diffuseshift():effectcolor1(1,1,1,1):effectcolor2(0,0,0,0):effectperiod(2) end,
	Def.BitmapText{
		Font="letters/_ek mukta Bold 48px",
		InitCommand=function(self) self:zoom(.5) end,
		Text="Insert                to save progress"
	},
	Def.Sprite{
		Texture=THEME:GetPathG("USB","icon"),
		InitCommand=function(self) self:zoom(.2):xy(-57,-5) end
	}
}