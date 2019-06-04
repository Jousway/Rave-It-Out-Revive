local t = Def.ActorFrame{};

function parallelogramGen(width,height,clr)
	return Def.ActorFrame{
		Def.Quad{
			InitCommand=cmd(setsize,width-height,height;diffuse,clr);
		};
		Def.ActorMultiVertex{
			InitCommand=function(self)
				self:xy((width-height)/2,-height/2);
				self:SetDrawState{Mode="DrawMode_Triangles"}
				self:SetVertices({
					{{0, 0, 0}, clr},
					{{height, 0, 0}, clr},
					{{0, height, 0}, clr}
			
				});
			end;
		};
		Def.ActorMultiVertex{
			InitCommand=function(self)
				self:xy(-(width+height)/2,-height/2);
				self:SetDrawState{Mode="DrawMode_Triangles"}
				self:SetVertices({
					{{height, height, 0}, clr},
					{{0, height, 0}, clr},
					{{height, 0, 0}, clr}
				});
			end;
		};

	};
end


t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		--No Quest Mode BGA so we'll have to live with it
		Texture=THEME:GetPathG("","_BGMovies/Arcade.avi");
		InitCommand=cmd(Cover;)
	};
	--Header stuff
	LoadActor(THEME:GetPathB("","ScreenSelectMusic overlay/current_group"))..{
		InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_TOP+5;horizalign,left;vertalign,top;zoomx,1;cropbottom,0.3);
	};
	LoadFont("monsterrat/_montserrat light 60px")..{	
		InitCommand=cmd(uppercase,true;horizalign,left;x,SCREEN_LEFT+18;y,SCREEN_TOP+10;zoom,0.185;skewx,-0.1);
		OnCommand=function(self)
			self:uppercase(true);
			self:settext("QUEST MODE");
		end;
	};
	LoadFont("monsterrat/_montserrat semi bold 60px")..{	
		InitCommand=cmd(uppercase,true;horizalign,left;x,SCREEN_LEFT+16;y,SCREEN_TOP+30;zoom,0.6;skewx,-0.255);
		OnCommand=function(self)
			self:uppercase(true);
			self:settext("SELECT A MISSION");
		end;
	};
	
	--TIME
	--[[LoadFont("monsterrat/_montserrat light 60px")..{
			Text="TIME";
			InitCommand=cmd(x,SCREEN_CENTER_X-25;y,SCREEN_BOTTOM-92;zoom,0.6;skewx,-0.2);
	};]]
	
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,.5");setsize,300,50;xy,200,90;);
	};
	LoadFont("Common Normal")..{
		Text="Mission Group Name Goes here";
		InitCommand=cmd(xy,200,90;wrapwidthpixels,300);
	
	};
	Def.Quad{
		InitCommand=cmd(diffuse,color("0,0,0,.5");setsize,120,20;xy,200+160,90-50/2;horizalign,left;vertalign,top;);
	};
	Def.ActorMultiVertex{
		InitCommand=function(self)
			self:xy(200+160+120,90-50/2);
			self:SetDrawState{Mode="DrawMode_Triangles"}
            self:SetVertices({
                {{0, 0, 0}, color("0,0,0,.5")},
        		{{0, 20, 0}, color("0,0,0,.5")},
				{{20, 0, 0}, color("0,0,0,.5")}
            });
        end;
	};
	--Mission 2...
	parallelogramGen(130,20,color("0,0,0,.5"))..{
		InitCommand=cmd(xy,560,90-50/2+20/2;);
	};
	--Mission 3..
	parallelogramGen(130,20,color("0,0,0,.5"))..{
		InitCommand=cmd(xy,560+130+5,90-50/2+20/2;);
	};
	
	--Mission info..
	Def.Quad{
		InitCommand=cmd(setsize,410,300;diffuse,color("0,0,0,.5");xy,200+160,100;horizalign,left;vertalign,top;);
	};
	LoadFont("monsterrat/_montserrat semi bold 60px")..{	
		InitCommand=cmd(xy,200+160+10,110;horizalign,left;vertalign,top;zoom,0.6;skewx,-0.255;maxwidth,650);
		OnCommand=function(self)
			self:settext("Mission Title Goes Here");
			--self:uppercase(true);
		end;
	};
	Def.Quad{
		InitCommand=cmd(setsize,410,2;diffuse,color("1,1,1,1");xy,200+160,140;horizalign,left;vertalign,top;fadeleft,.8;faderight,.8;);
	};
	Def.Quad{
		InitCommand=cmd(setsize,410,80;diffuse,color("1,1,1,.2");xy,200+160,150;horizalign,left;vertalign,top;);
	};
};

--I don't think this is correct
local q = Def.ActorFrame{
	InitCommand=cmd(xy,75,100);
};
for i = 1,6 do
	q[i] = Def.ActorFrame{
		InitCommand=cmd(addy,35*i);
		Def.Quad{
			InitCommand=cmd(diffuse,color(".5,.5,.5,.5");setsize,30,30);
		};
		LoadFont("Common Normal")..{
			Text=i;
		};
		LoadFont("Common Normal")..{
			Text="Mission title goes here";
			InitCommand=cmd(horizalign,left;addx,20);
		};
	};
end;

t[#t+1] = q;

return t;
