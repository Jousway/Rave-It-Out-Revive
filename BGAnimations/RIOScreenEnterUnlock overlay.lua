return Def.ActorFrame{
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(RIO.Input(self))
		SCREENMAN:AddNewScreenToTop("ScreenTextEntry")
		SCREENMAN:GetTopScreen():Load({ Question = "Enter a cheat code.", MaxInputLength = 255, OnOK = function(answer) self:GetChild("Result"):playcommand("ScreenOver",{answer=answer}) end })
	end,
	StartCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end,
	Def.BitmapText{
		Font="Common Normal",
		Name="Result",
		OnCommand=function(self) self:Center() end,
		ScreenOverCommand=function(self, params)
			self:GetParent():GetChild("Info"):visible(true)
			local Cheats = {
				["DebugOn"] = function() RIO.DoDebug = true self:settext("Debug Enabled.") end,
				["DebugOff"] = function() RIO.DoDebug = false self:settext("Debug Disabled.") end,
				["ExportData"] = function() parseData() end,
				["Assemble"] = function() AssembleDefaultGroups() self:settext("Groups generated.") end,
			}
			if Cheats[params.answer] then Cheats[params.answer]() return end
			self:settext("Invalid unlock code.")
		end,
	},
	Def.BitmapText{
		Name="Info",
		Font="Common Normal",
		Text="Press START to exit.",
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+60):visible(false) end
	},
}