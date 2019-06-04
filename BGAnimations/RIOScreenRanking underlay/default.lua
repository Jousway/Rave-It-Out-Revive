return Def.ActorFrame { 
	loadfile(THEME:GetPathG("","background/common_bg/shared"))()..{
		InitCommand=function(self) self:diffusealpha(0):linear(2):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.15):diffusealpha(0) end
	},
	loadfile(THEME:GetPathG("_frame", "1d"))({ 18/42, 6/42, 18/42 },
		Def.Sprite{
			Texture="back frame.png",
			InitCommand=function(self) self:GetParent():rotationz(0):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+10) end,
			BeginCommand=function(self)
				self:GetParent():playcommand("SetSize",{ Width=228, tween=function(self) self:stoptweening():diffusealpha(0) end })
					:playcommand("SetSize",{ Width=628, tween=function(self) self:linear(0.30):diffusealpha(1) end })
			end
		}
	),
	Def.Quad {
		InitCommand=function(self) self:valign(0):setsize(852,70):xy(SCREEN_CENTER_X,SCREEN_TOP):zwrite(true):blend("BlendMode_NoEffect") end
	},
	Def.Sprite{
	Texture="bottom mask.png",
		InitCommand=function(self) self:valign(1):xy(SCREEN_CENTER_X,SCREEN_BOTTOM+8):zwrite(true):blend("BlendMode_NoEffect") end
	}
}