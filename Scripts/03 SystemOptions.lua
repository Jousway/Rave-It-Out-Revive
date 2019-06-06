--ScreenFilter (requested by Cortes)		by NeobeatIKK, based on BGAMode by Alisson A2 (Alisson de Oliveira)
--Modified by Accelerator, now only sets TextureResolution because color depth is pointless

--By Accelerator, same as above
function SpecialModeConfig()
	local t = {
		Name = "SpecialModeConfig";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		--False exports on screen exit
		ExportOnChange = false;
		Choices = {"Off", "On"};
		
		-- Used internally, this will set the selection on the screen when it is loaded.
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("SpecialModeEnabled") == "false" then
				list[1] = true;
			else
				list[2] = true;
			end;
		end;
		
		
		SaveSelections = function(self, list, pn)
			if list[2] then
				WritePrefToFile("SpecialModeEnabled","true");
			else
				WritePrefToFile("SpecialModeEnabled","false");
			end;
		end;
	};
	setmetatable( t, t );
	return t;
end;