local path =  "UserPrefs/" .. THEME:GetThemeDisplayName() .. "/"

-- Hook called during profile load
function LoadProfileCustom(profile, dir)

	local PrefPath =  dir .. path
	local pn

	-- we've been passed a profile object as the variable "profile"
	-- see if it matches against anything returned by PROFILEMAN:GetProfile(pn)
	local Players = GAMESTATE:GetHumanPlayers()

	if Players then
		for player in ivalues(Players) do
			if profile == PROFILEMAN:GetProfile(player) then
				pn = player;
			end
		end
	end


	-- ...and then, if a player profile exists, read .cfg files from it
	if pn then
		local pns = pname(pn); --pn = PlayerNumber_PX, pns = PX
		local f = RageFileUtil.CreateRageFile()
		local setting
		--This uses the ActiveModifiers table from PlayerOptions.lua
		for k,v in pairs( ActiveModifiers[pns] ) do

			local fullFilename = PrefPath..k..".cfg"

			if f:Open(fullFilename,1) then

				-- RageFile's Read() method always returns a string
				setting = f:Read()

				-- but maybe we don't want a string; attempt to convert
				if setting == "true" then setting = true
				elseif setting == "false" then setting = false
				end

				ActiveModifiers[pns][k] = setting
			else
				local fError = f:GetError()
				Trace( "[FileUtils] Error reading ".. fullFilename ..": ".. fError )
				f:ClearError()
			end
		end
		
		--Custom profile icon handling
		--Check for icons on a USB first (The function will return nil if it's not a USB profile, so it's fine)
		local profileIcon = getUSBProfileIcon(pn)
		if profileIcon then
			setenv("profile_icon_"..pns,profileIcon);
		else --None found, check if it's a built in profile icon in the ActiveModifiers table
			--Will return nil if there isn't a profile icon, but if there was one we want to check that the icon hasn't been removed or renamed
			if ActiveModifiers[pns]["ProfileIcon"] and FILEMAN:DoesFileExist(THEME:GetPathG("","USB_stuff/avatars").."/"..ActiveModifiers[pns]["ProfileIcon"]) then
				setenv("profile_icon_"..pns,ActiveModifiers[pns]["ProfileIcon"]);
			else --Still none found, just pick a random one
				setenv("profile_icon_"..pns,getRandomProfileIcon(pn));
			end;
		end;

		-- don't destroy the RageFile until we've tried to load all custom options
		-- and set them to the env table to make them accessible from anywhere in SM
		f:destroy()
	end

	return true
end

-- Hook called during profile save
function SaveProfileCustom(profile, dir)

	local PrefPath =  dir .. path
	local pn

	local Players = GAMESTATE:GetHumanPlayers()

	for player in ivalues(Players) do
		if profile == PROFILEMAN:GetProfile(player) then
			pn = ToEnumShortString(player)
		end
	end

	if pn then
		-- a generic ragefile (?)
		local f = RageFileUtil.CreateRageFile()

		-- then loop through the prefs, saving one .cfg file per available setting
		-- if a particular value is nil, nothing gets written
		for k,v in pairs( ActiveModifiers[pn] ) do

			local fullFilename = PrefPath..k..".cfg"

			if f:Open(fullFilename, 2) then
				--Warn("[FileUtils] Writing to"..fullFilename);
				-- if a setting exists (it should) write that to the .cfg file
				if v ~= nil then
					f:Write( tostring( v ) )
				end
			else
				local fError = f:GetError()
				Trace( "[FileUtils] Error writing to ".. fullFilename ..": ".. fError )
				f:ClearError()
			end
		end

		-- again, don't destroy the file until after we're done looping
		-- through all possible custom options
		f:destroy()
	end

	return true
end

Trace("[CustomProfiles] Loaded functions.")
