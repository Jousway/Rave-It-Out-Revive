local LowSpec = { [true] = "BGADArcade.jpg", [false] = "RIOArcade.avi" }
local ShowConfig = ToBoolean(RIO.Config("ShowScreenStartupConfiguration","true"))

return Def.ActorFrame{
	Def.Sprite{
		Texture=THEME:GetPathG("","_BGMovies/"..LowSpec[RIO.LowSpec]),
		OnCommand=function(self) 
			self:Center():FullScreen():loop(false) 
			if RIO.LowSpec then self:diffusealpha(0):linear(2):diffusealpha(1):sleep(3):linear(2):diffusealpha(0) end
		end
	},
	Def.BitmapText{
		Font="venacti/_venacti 26px bold diffuse",
		Text="WARNING!",
		OnCommand=function(self) self:diffuse(1,0,0,1):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-120) end
	},
	Def.BitmapText{
		Font="venacti/_venacti 26px bold diffuse",
		Text="This Theme has custom preference,\nWhen you press the START button you agree with these preference\nand it will overwrite your Preference.ini\nThese preference include timing window\nand judgment modifications,\nif you want to reset these settings\nDelete the values in Preference.ini\n\nIf you do not want to change your preference,\nBut instead just want to use the theme,\nPress the BACK button.",
		OnCommand=function(self) self:diffuse(1,1,1,1):zoom(.5):xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+20) end
	},
	OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(RIO.Input(self)) if not ShowConfig then SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end Config.Save("ShowScreenStartupConfiguration","false",THEME:GetCurrentThemeDirectory().."/Config.ini") end,
	StartCommand=function(self) loadfile(THEME:GetPathO("","Scripts/Configure.lua"))() SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end,
	BackCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end
}