ToBoolean = function(value) if value == "true" then return true else return false end end

RIO = {}

RIO.Config = function(Key,Value)
	local Ret = Config.Load(Key,THEME:GetCurrentThemeDirectory().."/Config.ini")
	if Ret then return Ret end
	Config.Save(Key,Value,THEME:GetCurrentThemeDirectory().."/Config.ini")
	return Value
end

RIO.DoDebug = ToBoolean(RIO.Config("DebugMode","false"))
RIO.InternalName = RIO.Config("InternalName","RIOS2")
RIO.Version = RIO.Config("Version","Storm 2019")
RIO.ScreenRatio =  RIO.Config("FadeInRatio",0.25)
RIO.AnimationLength = RIO.Config("FadeInTween",0.25)


RIO.TitleMenu = function()
	if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
		return "RIOScreenTitleMenu"
	end
	if GAMESTATE:GetCoinsNeededToJoin() > GAMESTATE:GetCoins() then
		return "ScreenTitleJoin"
	else
		return "ScreenTitleJoin"
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