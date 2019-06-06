local function getWavyText(s,x,y)
	local letters = Def.ActorFrame{}
	for i = 1, #s do
		letters[i] = Def.BitmapText{
			Font ="soms2/_soms2 techy",
			Text=s:sub(i,i),
			InitCommand=function(self) self:xy(x-(#s)*15/2+i*15,y):effectoffset(i*.1):bob() end
		}
	end
	return letters
end

local xVelocity = 0
return Def.ActorFrame{
	Def.ActorFrame{
		FOV=90,
		Def.Sprite{
			Texture=THEME:GetPathG("","RL"),
			InitCommand=function(self) self:rainbow():customtexturerect(0,0,5,5):setsize(750,750):Center():texcoordvelocity(0,1.5):rotationx(-90/4*3.5):fadetop(1) end,
			OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(RIO.Input(self)) end,
			StartCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen") end,
			MenuLeftCommand=function(self) xVelocity=xVelocity+.5 self:texcoordvelocity(xVelocity,1.5) end,
			MenuRightCommand=function(self) xVelocity=xVelocity-.5 self:texcoordvelocity(xVelocity,1.5) end
		}
	},
	getWavyText("Rave It Out Revival",SCREEN_CENTER_X,SCREEN_CENTER_Y-100);
	getWavyText("Jousway and Accelerator",SCREEN_CENTER_X,SCREEN_CENTER_Y);
	getWavyText("Greetz to the other themers out there",SCREEN_CENTER_X,SCREEN_CENTER_Y+100);
}
