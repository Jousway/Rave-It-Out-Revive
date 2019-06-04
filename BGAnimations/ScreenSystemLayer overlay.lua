return Def.ActorFrame {
	ScreenChangedMessageCommand=function(self) self:visible(SCREENMAN:GetTopScreen():GetScreenType() ~= 'ScreenType_Attract') end,
	loadfile(THEME:GetPathB("ScreenSystemLayer","aux"))(),
	Def.Sprite{
		Texture=THEME:GetPathG("","credits"),
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM):zoom(0.5):valign(1) end
	},
	Def.BitmapText{
		Font="Common Normal",
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_BOTTOM-10):zoom(0.45):valign(1) end,
		OnCommand=function(self)
			if GAMESTATE:GetCoinMode() == 'CoinMode_Pay' then
				self:settext('CREDIT(S) '..math.floor(GAMESTATE:GetCoins()/GAMESTATE:GetCoinsNeededToJoin())
				..' ['..math.floor(GAMESTATE:GetCoins() - math.floor(GAMESTATE:GetCoins()/GAMESTATE:GetCoinsNeededToJoin())*GAMESTATE:GetCoinsNeededToJoin())
				..'/'..GAMESTATE:GetCoinsNeededToJoin()..']')
			else
				local CoinMode = {
					['CoinMode_Home'] = { [true] = "HOME EVENT", [false] = "HOME MODE" },
					['CoinMode_Free'] = { [true] = "EVENT MODE", [false] = "FREE PLAY" }
				}
				self:settext(CoinMode[GAMESTATE:GetCoinMode()][GAMESTATE:IsEventMode()])
			end
		end,
		RefreshCreditTextMessageCommand = function(self) self:playcommand('On') end,
		CoinInsertedMessageCommand = function(self) self:playcommand('On') end,
		CoinModeChangedMessageCommand = function(self) self:playcommand('On') end,
		PlayerJoinedMessageCommand = function(self) self:playcommand('On') end,
		ScreenChangedMessageCommand = function(self) self:playcommand('On') end,
	},
	
	--Error Message Viewer.
	Def.Quad {
		Name="BG",
		InitCommand=function(self) self:zoomtowidth(SCREEN_WIDTH):zoomtoheight(35):horizalign(0):vertalign(0):y(SCREEN_TOP-35):diffuse(0,0,0,.5) end,
		OnCommand=function(self) self:finishtweening():decelerate(0.25):y(SCREEN_TOP) end,
		OffCommand=function(self) self:sleep(3):accelerate(0.5):y(SCREEN_TOP-35) end
	},
	Def.BitmapText{
		Font="Common Normal",
		Name="Text",
		InitCommand=function(self) self:zoom(0.8):horizalign(0):xy(SCREEN_LEFT+25,SCREEN_TOP-17.5):maxwidth(SCREEN_WIDTH*0.9) end,
		OnCommand=function(self) self:finishtweening():decelerate(0.25):y(SCREEN_TOP+17.5) end,
		OffCommand=function(self) self:sleep(3):accelerate(0.5):y(SCREEN_TOP-17.5) end
	},
	SystemMessageMessageCommand = function(self, params)
		self:GetChild("Text"):settext(params.Message)
		self:GetChild("BG"):playcommand("On"):queuecommand("Off")
		if params.NoAnimate then
			self:GetChild("BG"):finishtweening()
		end
	end,
	HideSystemMessageMessageCommand = function(self) self:finishtweening() end
}