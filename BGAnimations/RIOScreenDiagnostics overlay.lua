local EasyText = function(Text,Command)
	return Def.BitmapText{
		Font="Common Normal",
		Text=Text,
		InitCommand=Command
	}
end

local MemCards = Def.ActorFrame{}

for i = 1,2 do
	MemCards[#MemCards+1] = EasyText("",function(self) self:xy(20,175+((i-1)*25)):halign(0) end)..{
		OnCommand=cmd(settext,"Player_"..i.." Memory Card Status: "..ToEnumShortString(MEMCARDMAN:GetCardState(i-1))..MEMCARDMAN:GetName(i-1)),
		StorageDevicesChangedMessageCommand=function(self)
			self:playcommand("On")
			SCREENMAN:SystemMessage("Memory card state was changed")
		end
	}

end

local Windowed = { [true] = "Windowed", [false] = "Fullscreen" }

return Def.ActorFrame{
	OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(RIO.Input(self)) end,
	StartCommand=function(self)  SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end,
	EasyText("Press START to exit.",function(self) self:xy(SCREEN_CENTER_X,SCREEN_HEIGHT-50) end),
	EasyText("System Information",function(self) self:xy(SCREEN_CENTER_X,20) end),
	EasyText("Rave It Out version: "..RIO.Version,function(self) self:xy(SCREEN_CENTER_X,40) end),
	EasyText("StepMania build: "..ProductFamily().." "..ProductVersion(),function(self) self:xy(SCREEN_CENTER_X,60) end),
	EasyText("Game Mode: "..ToEnumShortString(GAMESTATE:GetCoinMode()),function(self) self:xy(20,100):halign(0) end),
	EasyText("Event Mode: "..tostring(GAMESTATE:IsEventMode()),function(self) self:xy(20,125):halign(0) end),
	EasyText("Memory Cards: "..tostring(PREFSMAN:GetPreference("MemoryCards")).." | Memory Card profiles: "..tostring(PREFSMAN:GetPreference("MemoryCardProfiles")),function(self) self:xy(20,150):halign(0) end),
	MemCards,
	EasyText("",function(self) self:xy(20,225):halign(0) end)..{
		OnCommand=function(self)
			local MemCardsFound = { [true] = {"Green","MemoryCard Profiles"}, [false] = {"Red","Local Profiles"} }
			self:diffuse(Color(MemCardsFound[PREFSMAN:GetPreference("MemoryCardProfiles")][1])):settext(MemCardsFound[PREFSMAN:GetPreference("MemoryCardProfiles")][2])
		end
	},
	EasyText("Resolution: "..PREFSMAN:GetPreference("DisplayWidth").."x"..PREFSMAN:GetPreference("DisplayHeight").." | Aspect ratio: "..round(GetScreenAspectRatio(),2).." | "..Windowed[PREFSMAN:GetPreference("Windowed")],function(self) self:xy(20,250):halign(0) end),
	EasyText("Songs: "..SONGMAN:GetNumSongs().."+"..SONGMAN:GetNumAdditionalSongs().." | Groups/Channels: "..SONGMAN:GetNumSongGroups(),function(self) self:xy(20,275):halign(0) end),
	EasyText("Courses/Music Trains: "..SONGMAN:GetNumCourses().."+"..SONGMAN:GetNumAdditionalCourses(),function(self) self:xy(20,300):halign(0) end),
	EasyText("",function(self) self:xy(20,325):halign(0) end)..{
		OnCommand=function(self)
			local FolderFound = { [true] = {"Green","Ok! | "..#SONGMAN:GetSongsInGroup(RIO_FOLDER_NAMES["EasyFolder"]).." songs"}, [false] = {"Red","Missing"} }
			self:diffuse(Color(FolderFound[SONGMAN:DoesSongGroupExist(RIO_FOLDER_NAMES["EasyFolder"])][1])):settext("Easy Group : "..FolderFound[SONGMAN:DoesSongGroupExist(RIO_FOLDER_NAMES["EasyFolder"])][2].." | "..RIO_FOLDER_NAMES["EasyFolder"])
		end
	},
	EasyText("",function(self) self:xy(20,350):halign(0) end)..{
		OnCommand=function(self)
			if RIO.SpecialSongs then
				local FolderFound = { [true] = {"Green","Ok! | "..#SONGMAN:GetSongsInGroup(RIO_FOLDER_NAMES["SpecialFolder"]).." songs"}, [false] = {"Red","Missing"} }
				self:diffuse(Color(FolderFound[SONGMAN:DoesSongGroupExist(RIO_FOLDER_NAMES["SpecialFolder"])][1])):settext("Special Group: "..FolderFound[SONGMAN:DoesSongGroupExist(RIO_FOLDER_NAMES["SpecialFolder"])][2].." | "..RIO_FOLDER_NAMES["SpecialFolder"])
			else
				self:settext("Special Group: Special mode is disabled");
			end
		end
	},
	EasyText("",function(self) self:xy(20,375):halign(0) end)..{
		OnCommand=function(self)
			local FolderFound = { [true] = {"Green","Ok! | "..#SONGMAN:GetSongsInGroup(RIO_FOLDER_NAMES["SnapTracksFolder"]).." songs"}, [false] = {"Red","Missing"} }
			self:diffuse(Color(FolderFound[SONGMAN:DoesSongGroupExist(RIO_FOLDER_NAMES["SnapTracksFolder"])][1])):settext("Snap Tracks Group: "..FolderFound[SONGMAN:DoesSongGroupExist(RIO_FOLDER_NAMES["SnapTracksFolder"])][2].." | "..RIO_FOLDER_NAMES["SnapTracksFolder"])
		end
	},
	EasyText("",function(self) self:xy(20,SCREEN_BOTTOM-65):halign(0):queuecommand("UpdateText") end)..{
		UpdateTextCommand=function(self)
			self:settext("Uptime: "..SecondsToHHMMSS(GetTimeSinceStart())):sleep(1):queuecommand("UpdateText")
		end
	},
	EasyText("",function(self) self:xy(20,SCREEN_BOTTOM-40):halign(0):queuecommand("UpdateText") end)..{
		UpdateTextCommand=function(self)
			self:settext("Time: "..Hour()..":"..Minute()..":"..Second()):sleep(1):queuecommand("UpdateText")
		end
	}
}
