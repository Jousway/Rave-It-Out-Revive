local GameDirections = { ["dance"] = "Down", ["pump"] = "UpLeft" }

return NOTESKIN:LoadActorForNoteSkin(GameDirections[GAMESTATE:GetCurrentGame():GetName()],"Tap Note",RIO.NoteskinList[RIO.Noteskin] or "default")