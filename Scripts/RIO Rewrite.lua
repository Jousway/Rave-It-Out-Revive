ToBoolean = function(value) if value == "true" then return true else return false end end

RIO = {}

RIO.Noteskin = 1
RIO.NoteskinsEnabled = false
RIO.NoteskinList = {}

RIO.Config = function(Key,Value)
	local Ret = Config.Load(Key,THEME:GetCurrentThemeDirectory().."/Config.ini")
	if Ret then return Ret end
	Config.Save(Key,Value,THEME:GetCurrentThemeDirectory().."/Config.ini")
	return Value
end

RIO.LoadNoteskins = function()
	RIO.NoteskinList = {}
	for _,v in ipairs(NOTESKIN:GetNoteSkinNames()) do
		local ToAdd = true
		for DisabledSkin in string.gmatch(RIO.Config("DisabledNoteskins","delta-routine-p1,delta-routine-p2,cmd-routine-p1,cmd-routine-p2,routine-p1,routine-p2,rio-p1,rio-p2,rio-p3,rio-p4,rio-p5,perfor1,perfor2,perfor3,_disabled")..",", "(.-),") do
			if v == DisabledSkin then ToAdd = false end
		end
		if ToAdd then RIO.NoteskinList[#RIO.NoteskinList+1] = v end
	end
end	

RIO.LowSpec = ToBoolean(RIO.Config("LowSpec","false"))
RIO.DoDebug = ToBoolean(RIO.Config("DebugMode","false"))

RIO.InternalName = RIO.Config("InternalName","RIOS2")
RIO.Version = RIO.Config("Version","Storm 2019")

RIO.LockSongs = ToBoolean(RIO.Config("LockSongs","true"))
RIO.NumSongsToLevelUp = RIO.Config("NumSongsToLevelUp",4)
RIO.SpecialSongs = ToBoolean(RIO.Config("SpecialModeEnabled","true"))
RIO.MaxLevel = RIO.Config("MaxLevel",100)

RIO.GamePlayMenu = ToBoolean(RIO.Config("GamePlayMenu","false"))
RIO.MissToBreak = RIO.Config("MissToBreak",51)
RIO.ForcedTimingScale = RIO.Config("ForcedTimingScale",1.000000)

RIO.OpQuadWidth = RIO.Config("OpQuadWidth",185)
RIO.ScreenInRatio =  RIO.Config("FadeInRatio",0.25)
RIO.AnimationInLength = RIO.Config("FadeInTween",0.25)
RIO.ScreenOutRatio =  RIO.Config("FadeOutRatio",0.25)
RIO.AnimationOutLength = RIO.Config("FadeOutTween",0.25)

RIO.Hearts = {
	["HeartsLeft"] = { tonumber(RIO.Config("HeartsPerPlay",6)), tonumber(RIO.Config("HeartsPerPlay",6)) },
	["BonusHearts"] = {0,0},
	["HeartsRemoved"] = {0,0}
}

RIO.HeartSys = function(Type,Amount,pn)
	RIO.Hearts[Type][pn] = RIO.Hearts[Type][pn] + Amount
	return RIO.Hearts[Type][pn] >= tonumber(RIO.Config("HeartsPerPlay",6))
end

RIO.CheckHearts = function() return RIO.HeartSys("HeartsRemoved",0,1) or RIO.HeartSys("HeartsRemoved",0,1) end

RIO.SongHearts = function() if GAMESTATE:GetCurrentSong() then return GetSongExtraData(GAMESTATE:GetCurrentSong(), "Hearts") else return 0 end end

RIO.MaxHeartsLeftForAnyPlayer = function() 
	local IHP = function(p) return GAMESTATE:IsHumanPlayer(p) end
	if IHP(PLAYER_1) and IHP(PLAYER_2) then return math.max(RIO.Hearts["HeartsLeft"][1],RIO.Hearts["HeartsLeft"][2]) end
	return RIO.Hearts["HeartsLeft"][tonumber(string.match(GAMESTATE:GetMasterPlayerNumber(),"%d"))]
end

RIO.Acc = {0,0}

RIO.BonusHearts = function(pn)
	if RIO.Hearts["BonusHearts"][pn] < 2 or GAMESTATE:IsSideJoined("PlayerNumber_P"..pn) then
		return RIO.Acc[pn] > 90 or ToBoolean(RIO.Config("AlwaysGetBonusHearts","false"))
	end
end

RIO.UnlockedOMES = function()
	return false -- need to properly rewrite this, disable for now
end

RIO.IsMemcardEnabled = PREFSMAN:GetPreference("MemoryCards") and PREFSMAN:GetPreference("MemoryCardProfiles")

RIO.TitleMenu = function()
	if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
		return "RIOScreenTitleMenu"
	end
	if GAMESTATE:GetCoinsNeededToJoin() > GAMESTATE:GetCoins() then
		return "RIOScreenTitleJoin"
	else
		return "RIOScreenTitleJoin"
	end
end

RIO.AfterInit = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
		return RIO.TitleMenu()
	else
		return "RIOScreenInit"
	end
end

RIO.UnlockCheck = function(LockedSong)
	for _,song in ipairs(SONGMAN:GetAllSongs()) do
		if string.find(song:GetDisplayMainTitle(), LockedSong) then	
			return UNLOCKMAN:IsSongLocked(song)
		end
	end
	return -1
end

RIO.Input = function(self)
	return function(event)
		if not event.PlayerNumber then return end
		self.pn = event.PlayerNumber		
		if ToEnumShortString(event.type) == "FirstPress" or ToEnumShortString(event.type) == "Repeat" then
			self:queuecommand(event.GameButton)			
		end
		if ToEnumShortString(event.type) == "Release" then
			self:queuecommand(event.GameButton.."Release")	
		end
	end
end

RIO.NoteSkins = function()
	RIO.LoadNoteskins()
	local t = {
		Name="NoteskinsCustom",
		LayoutType="ShowAllInRow",
		SelectType="SelectOne",
		OneChoiceForAllPlayers=false,
		ExportOnChange=false,
		Choices=RIO.NoteskinList,
		LoadSelections=function(self, list, pn)
			for i=1,#list do
				if RIO.NoteskinList[i] == GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):NoteSkin() then
					list[i] = true
					return
				end
			end
			print("Noteskin Not Found!, Using first value as fallback.")
			list[1] = true
		end,
		SaveSelections=function(self, list, pn)
			for i=1,#list do
				if list[i] == true then
					GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):NoteSkin(RIO.NoteskinList[i]);
				end
			end
		end
	}
	setmetatable(t, t)
	return t
end

RIO.VideoMode = function()
	local t = {
		Name = "Graphics Details",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"AUTO", "SD", "HD"},
		LoadSelections = function(self, list, pn)
			local CurSel = { [true] = 1, [2048] = 3, [1024] = 2 }
			list[CurSel[ToBoolean(RIO.Config("AutoVid","false")) or PREFSMAN:GetPreference("MaxTextureResolution")]] = true
		end,
		SaveSelections = function(self, list, pn)
			local DisplayType = { [1.78] = 2048, [1.33] = 1024 }
			local SavSel = { [3] = 2048, [2] = 1024 }
			for i,v in ipairs(list) do
				if v then 
					PREFSMAN:SetPreference("MaxTextureResolution",SavSel[i] or DisplayType[round(GetScreenAspectRatio(),2)] or 1024)
					Config.Save("AutoVid",tostring(list[1]),THEME:GetCurrentThemeDirectory().."/Config.ini")
				end
			end
			PREFSMAN:SetPreference("DisplayColorDepth",32)
			PREFSMAN:SetPreference("MovieColorDepth",32)
			PREFSMAN:SetPreference("TextureColorDepth",32)
			PREFSMAN:SavePreferences()
		end
	}
	setmetatable( t, t )
	return t
end

RIO.HeartsPerPlayConfig = function()
	local t = {
		Name = "HeartsPerPlay",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"2", "3", "4", "5", "6 (default)", "7", "8"},
		LoadSelections = function(self, list, pn)
			list[tonumber(RIO.Config("HeartsPerPlay",6))-1] = true
		end,
		SaveSelections = function(self, list, pn)
			for i,v in ipairs(list) do if v then Config.Save("HeartsPerPlay",i+1,THEME:GetCurrentThemeDirectory().."/Config.ini") end end
		end,
	};
	setmetatable( t, t );
	return t;
end;

RIO.Reset = function()

	RIO.Hearts = {
		["HeartsLeft"] = { tonumber(RIO.Config("HeartsPerPlay",6)), tonumber(RIO.Config("HeartsPerPlay",6)) },
		["BonusHearts"] = {0,0},
		["HeartsRemoved"] = {0,0}
	}

	--Reset PlayerOptions
	ActiveModifiers = {
		P1 = table.shallowcopy(PlayerDefaults),
		P2 = table.shallowcopy(PlayerDefaults),
		--MACHINE = table.shallowcopy(PlayerDefaults),
		--Save values here if editing profile
	}
	PerfectionistMode = {
		PlayerNumber_P1 = false,
		PlayerNumber_P2 = false
	}
	print("RIO Values Resetted")
end