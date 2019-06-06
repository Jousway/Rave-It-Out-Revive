local MemoryCards = Def.ActorFrame{}

for pn = 1,2 do
	MemoryCards[#MemoryCards+1] = Def.Sprite{
		Texture=THEME:GetPathG("", "USB icon.png"),
		InitCommand=function(self) 
			local Pos = { [1] = SCREEN_LEFT+10, [2] = SCREEN_RIGHT-10 }
			self:halign(pn-1):valign(1):xy(Pos[pn],SCREEN_BOTTOM-5):zoom(.2) 
		end,
		OnCommand=function(self) self:visible(ToEnumShortString(MEMCARDMAN:GetCardState(pn-1)) == 'ready') end,
		StorageDevicesChangedMessageCommand=function(self) self:playcommand("On") end
	}
end

return Def.ActorFrame{
	Def.BitmapText{
		Font="common normal",
		Text=RIO.InternalName.."-"..RIO.Version,
		InitCommand=function(self) self:xy(5,5):horizalign(0):vertalign(0):zoom(.5):strokecolor(0,0,0,1) end
	},
	Def.BitmapText{
		Font="common normal",
		InitCommand=function(self) self:xy(5,15):horizalign(0):vertalign(0):zoom(.5):strokecolor(0,0,0,1) end,
		OnCommand=function(self)
			local DisplayType = { [1.78] = "HD", [1.33] = "SD" }
			self:settext("DISPLAY TYPE: "..(DisplayType[round(GetScreenAspectRatio(),2)] or "???"))
		end
	},
	Def.BitmapText{
		Font="common normal",
		InitCommand=function(self) self:xy(5,25):horizalign(0):vertalign(0):zoom(.5):strokecolor(0,0,0,1) end,
		OnCommand=function(self)
			local GetVid = { [true] = "AUTO", [2048] = "HD", [1024] = "SD" }
			self:settext("TEXTURE MODE: "..GetVid[ToBoolean(RIO.Config("AutoVid","false")) or PREFSMAN:GetPreference("MaxTextureResolution")])
		end
	},
	Def.BitmapText{
		Font="common normal",
		InitCommand=function(self) self:xy(5,35):horizalign(0):vertalign(0):zoom(.5):strokecolor(0,0,0,1) end,
		OnCommand=function(self)
			local ExtraHearts = { [true] = "+" } --Who knows, for future values?
			self:settext("HEARTS PER PLAY: "..RIO.Config("HeartsPerPlay",6)..(ExtraHearts[PREFSMAN:GetPreference("AllowExtraStage")] or ""))
		end
	},
	--Unlock status data
	Def.BitmapText{
		Font="common normal",	
		Condition=RIO.DoDebug,
		InitCommand=function(self) self:xy(SCREEN_LEFT+10,SCREEN_TOP+10+30):vertalign(0):horizalign(0):zoom(0.5) end,
		OnCommand=function(self) self:settext("Total unlocks: "..UNLOCKMAN:GetNumUnlocks().."\nUnlocked items: "..UNLOCKMAN:GetNumUnlocked()) end
	},
	--Checkear unlock status de EntryID TT002
	Def.BitmapText{
		Font="common normal",	
		Condition=RIO.DoDebug,
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-40):zoom(0.5) end,
		OnCommand=function(self)
			local IsLocked = {
				[1] = "WHY ARE GORILLAS HERE? (EntryID TT002 is unlocked)",
				[0] = "OMG THIS ACTUALLY WORKED? CALL KOTAKU! (EntryID TT002 is locked)",
				[-1] = "Error Song Not Found!"
			}
			self:settext(IsLocked[RIO.UnlockCheck("TT002")])
		end
	},
	--Songs played (machine profile)
	Def.BitmapText{
		Font="common normal",	
		Condition=RIO.DoDebug,
		InitCommand=function(self) self:xy(SCREEN_LEFT+10,SCREEN_CENTER_Y+180):zoom(0.5):horizalign(0):settext("Songs played (machine profile): "..PROFILEMAN:GetMachineProfile():GetNumTotalSongsPlayed()) end,
	},	
	-- Memory cards
	MemoryCards
}