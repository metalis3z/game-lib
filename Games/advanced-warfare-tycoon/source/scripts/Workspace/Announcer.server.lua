local get=function(d) return game:GetService(d) end;
local ms=get'MarketplaceService';

local game_dat=ms:GetProductInfo(game.PlaceId);
local prev_shout="";

local p=print;


while wait() do
	local suc,res=pcall(function() return ms:GetProductInfo(175122272) end);
	if not suc then
		p("[NOTICE] Unable to perform actions. Is MarketplaceService down?");
	else
		local dat;
		if type(res)=='string' then
			dat=get'HttpService':JSONDecode(dat).Description;
		elseif type(res)=='table' then
			dat=res.Description;
		else
			p("Bad response");
		end;
		if type(dat)=='string' then
			if dat:sub(0,20)==prev_shout then
				p"Already shouted";
			else
				prev_shout=dat:sub(0,20)
				coroutine.wrap(function()
					local msg=Instance.new("Message",Workspace);
					msg.Text="[GLOBAL] "..game_dat.Creator.Name.."!\n\n"..dat;
					Delay(#dat*.2,function() msg:Destroy() end);
				end)();
			end;
		else
			print'dat nil'
		end;
	end
	end