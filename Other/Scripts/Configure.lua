-- HOME MODE OPTIONS
--PREFSMAN:SetPreference("CoinMode",'Home')
--PREFSMAN:SetPreference("EventMode",1)
--PREFSMAN:SetPreference("AllowW1",'AllowW1_Never')
--PREFSMAN:SetPreference("VideoRenderers","d3d") -- no, dont do d3d - Jous
--PREFSMAN:SetPreference("Vsync",0)

PREFSMAN:SetPreference("Center1Player",false)

PREFSMAN:SetPreference("HideIncompleteCourses",true)
	
PREFSMAN:SetPreference("SuperMeterPercentChangeCheckpointHit",0)
PREFSMAN:SetPreference("SuperMeterPercentChangeCheckpointMiss",0)
PREFSMAN:SetPreference("SuperMeterPercentChangeHeld",6)
PREFSMAN:SetPreference("SuperMeterPercentChangeHitMine",-8)
PREFSMAN:SetPreference("SuperMeterPercentChangeLetGo",0)
PREFSMAN:SetPreference("SuperMeterPercentChangeMiss",-2)
PREFSMAN:SetPreference("SuperMeterPercentChangeW1",10)
PREFSMAN:SetPreference("SuperMeterPercentChangeW2",8)
PREFSMAN:SetPreference("SuperMeterPercentChangeW3",6)
PREFSMAN:SetPreference("SuperMeterPercentChangeW4",2)
PREFSMAN:SetPreference("SuperMeterPercentChangeW5",-2)
	
PREFSMAN:SetPreference("TimeMeterSecondsChangeCheckpointHit",0)
PREFSMAN:SetPreference("TimeMeterSecondsChangeCheckpointMiss",0)
PREFSMAN:SetPreference("TimeMeterSecondsChangeHeld",3)
PREFSMAN:SetPreference("TimeMeterSecondsChangeHitMine",-2)
PREFSMAN:SetPreference("TimeMeterSecondsChangeLetGo",0)
PREFSMAN:SetPreference("TimeMeterSecondsChangeMiss",-2)
PREFSMAN:SetPreference("TimeMeterSecondsChangeW1",10)
PREFSMAN:SetPreference("TimeMeterSecondsChangeW2",8)
PREFSMAN:SetPreference("TimeMeterSecondsChangeW3",6)
PREFSMAN:SetPreference("TimeMeterSecondsChangeW4",2)
PREFSMAN:SetPreference("TimeMeterSecondsChangeW5",-2)

PREFSMAN:SetPreference("TimingWindowAdd",0)
PREFSMAN:SetPreference("TimingWindowScale",RIO.ForcedTimingScale)
PREFSMAN:SetPreference("TimingWindowSecondsAttack",0.135000)

PREFSMAN:SetPreference("TimingWindowSecondsHold",0.350)
PREFSMAN:SetPreference("TimingWindowSecondsMine",0.070)
PREFSMAN:SetPreference("TimingWindowSecondsRoll",0.350)
PREFSMAN:SetPreference("TimingWindowSecondsW1",0.026)
PREFSMAN:SetPreference("TimingWindowSecondsW2",0.055)
PREFSMAN:SetPreference("TimingWindowSecondsW3",0.100)
PREFSMAN:SetPreference("TimingWindowSecondsW4",0.145)
PREFSMAN:SetPreference("TimingWindowSecondsW5",0)
--PREFSMAN:SetPreference("TimingWindowSecondsHoldCheckpoint",0.060) --this value doesn't exist in SM5

PREFSMAN:SetPreference("MaxInputLatencySeconds",0)

--Input Options
PREFSMAN:SetPreference("AutoMapOnJoyChange",false)
PREFSMAN:SetPreference("DelayedBack",false)	--not verified
PREFSMAN:SetPreference("MusicWheelSwitchSpeed",15)

--Appearance Options
PREFSMAN:SetPreference("Announcer",nil) 		--not verified
PREFSMAN:SetPreference("PercentageScoring",true)	--doesn't work?
PREFSMAN:SetPreference("RandomBackgroundMode","RandomBackgroundMode_RandomMovies")
PREFSMAN:SetPreference("ShowDancingCharacters","ShowDancingCharacters_Off")
PREFSMAN:SetPreference("ShowBeginnerHelper",false)
PREFSMAN:SetPreference("NumBackgrounds",5)
--PREFSMAN:SetPreference("UseUnlockSystem",RIO.LockSongs) --Linked with metrics so we can execute debug from commandline.

--Graphic/Sound options
PREFSMAN:SetPreference("SmoothLines",true)
PREFSMAN:SetPreference("CelShadeModels",false)

--UI Options
PREFSMAN:SetPreference("ShowBanners",false)
PREFSMAN:SetPreference("ShowInstructions",false)
PREFSMAN:SetPreference("ShowNativeLanguage",true)
PREFSMAN:SetPreference("ShowSongOptions","Yes") --Only visible when in Debug mode

--Advanced Options
--PREFSMAN:SetPreference("AllowW1","AllowW1_Everywhere")
PREFSMAN:SetPreference("HiddenSongs",false)
PREFSMAN:SetPreference("EasterEggs",true)
PREFSMAN:SetPreference("AutogenSteps",false)
PREFSMAN:SetPreference("AutogenGroupCourses",false)
PREFSMAN:SetPreference("FastLoad",false)
PREFSMAN:SetPreference("FastLoadAdditionalSongs",false)
PREFSMAN:SetPreference("FastNoteRendering",true)

--Preferences.ini Exclusive START
PREFSMAN:SetPreference("FailOffForFirstStageEasy",true)	--TODO: Need verify
PREFSMAN:SetPreference("FailOffInBeginner",1)	--TODO: needs confirm if works
--Preferences.ini Exclusive END