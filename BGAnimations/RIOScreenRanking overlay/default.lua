local DifficultyFrame = {}

local GameStepTypes = { ["dance"] = "StepsType_Dance_Single", ["pump"] = "StepsType_Pump_Single" }
local GetScore = function(pid,Diff,Grade)
	return PROFILEMAN:GetLocalProfile(pid):GetTotalStepsWithTopGrade(GameStepTypes[GAMESTATE:GetCurrentGame():GetName()],Diff,Grade)
end

if Var "LoadingScreen" == "RIOScreenRanking" then
	local Difficulties = { "Beginner", "Easy", "Medium", "Hard", "Challenge" }
	local DiffCon = Def.ActorFrame{}
	local DiffScores = Def.ActorFrame{}
	
	for i, Diff in ipairs(Difficulties) do
		DiffCon[#DiffCon+1] = Def.BitmapText{
			Font="venacti/_venacti 26px bold diffuse",
			Text = string.upper( Diff ),
			InitCommand=function(self) self:xy(SCREEN_CENTER_X+scale(i,1,4,120*-2,120*1),56):diffuse(0,0,0,1):shadowlength(0):zoom(.55) end
		}
		local DiffContainer = {}	
		local DiffSorting = {}
				
		for _,pid in ipairs(PROFILEMAN:GetLocalProfileIDs()) do
			DiffContainer[#DiffContainer+1] = {GetScore(pid,Diff,0) + GetScore(pid,Diff,1) + GetScore(pid,Diff,2) + GetScore(pid,Diff,3), PROFILEMAN:GetLocalProfile(pid):GetDisplayName()}
		end		
		
		for keys in pairs(DiffContainer) do table.insert(DiffSorting, keys) end
		table.sort(DiffSorting, function(a, b) return DiffContainer[a][1] > DiffContainer[b][1] end)
		for i2 = 1,10 do
			DiffScores[#DiffScores+1] = Def.ActorFrame{
				OnCommand=function(self) 
					self:x(800):sleep(7*(i-1)+(0.2*i2)):decelerate(1):x(0):sleep(5):accelerate(1):x(-800)
				end,
				Def.BitmapText{
					Font="venacti/_venacti 26px bold diffuse",
					Text=string.upper(Diff),
					InitCommand=function(self) 
						self:xy(SCREEN_CENTER_X-260,70+34*i2):diffuse(1,1,1,1):shadowlength(0):halign(0)
					end
				},
				Def.BitmapText{
					Font="venacti/_venacti 26px bold diffuse",
					Text="RIO",
					InitCommand=function(self) 
						if DiffContainer[i2] then self:settext(DiffContainer[i2][2]) end
						self:xy(SCREEN_CENTER_X-60,70+34*i2):diffuse(1,1,1,1):shadowlength(0):halign(0)
					end
				},
				Def.BitmapText{
					Font="venacti/_venacti 26px bold diffuse",
					Text=0,
					InitCommand=function(self)
						if DiffContainer[i2] then self:settext(DiffContainer[i2][1]) end
						self:xy(SCREEN_CENTER_X+260,70+34*i2):diffuse(1,1,1,1):shadowlength(0):halign(1)
					end
				}
			}
		end
	end
	
	DifficultyFrame = Def.ActorFrame{
		Def.Sprite{
			Texture="difficulty frame normal.png",
			InitCommand = function(self) self:xy(SCREEN_CENTER_X,SCREEN_TOP+56) end
		},
		DiffCon,
		DiffScores
	}
else
	DifficultyFrame = Def.ActorFrame{
		Def.Sprite{
			Texture="difficulty frame course.png",
			InitCommand = function(self) self:xy(SCREEN_CENTER_X,SCREEN_TOP+56) end
		},
		Def.BitmapText{
			Font="venacti/_venacti 26px bold diffuse",
			Text = string.upper("PROGRESSIVE"),
			InitCommand=function(self) self:xy(SCREEN_CENTER_X+scale(3,1,4,120*-2,120*1),56):diffuse(0,0,0,1):shadowlength(0):zoom(.55) end
		}
	}
end

return Def.ActorFrame{
	OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(RIO.Input(self)) self:sleep(38):queuecommand("Start") end,
	StartCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end,
	Def.Sprite{
		Texture="top.png",
		InitCommand=function(self) self:valign(0):xy(SCREEN_CENTER_X,SCREEN_TOP) end
	},
	Def.Sprite{
		Texture="bottom.png",
		InitCommand=function(self) self:valign(1):xy(SCREEN_CENTER_X,SCREEN_BOTTOM+8) end
	},
	DifficultyFrame
}