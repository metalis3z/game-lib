local Module = {}

local Gets = script.Parent.Parent.Get

function Get(What)
	return Gets[What]:Invoke();
end

local ChatData = {};

local DataModule = require(script.Parent.Parent.DataModule);


Module.PlayerAdded = function(Player)
	ChatData[Player.Name] = {};
	ChatData[Player.Name].ChatCount = 0;
	ChatData[Player.Name].LastChatCount = time();
	ChatData[Player.Name].ChatCooldown = false;
end


Module.Chatted = function(Player,SentMessage)

	if not ChatData[Player.Name].ChatCooldown then
		if string.sub(SentMessage,1,3) == "/e " then
			if DataModule.CheckForItem(Player,string.sub(SentMessage,4),"Emotes") then
				game.ReplicatedStorage.DoEmote:FireClient(Player,string.sub(SentMessage,4));
			end;
			print(string.sub(SentMessage,4));
		else
            --[[local HasEmoji = false;
            if game.MarketplaceService:PlayerOwnsAsset(Player,196023345) then
                print("he has the emoji bro");
                HasEmoji = true;
            end]]
			if time()-ChatData[Player.Name].LastChatCount < 1 then
				ChatData[Player.Name].ChatCount = ChatData[Player.Name].ChatCount + 1;
			else
				ChatData[Player.Name].ChatCount = 0;
			end;

			ChatData[Player.Name].LastChatCount = time();

			if ChatData[Player.Name].ChatCount < 5 then

				local pData = game.ReplicatedStorage.GetPlayerData_REMOTE:Invoke();

				for _,cPlayer in pairs(game.Players:GetPlayers()) do
					local Message = SentMessage;
					--if not (cPlayer == Player) then
					Message = game:GetService("Chat"):FilterStringAsync(SentMessage,Player,cPlayer);
					--end;

					if pData[cPlayer.Name] then-- and _G.ServerSettings.Disguises == true then
						if pData[Player.Name] then
							if (pData[cPlayer.Name]["Dead"] == true) or _G.ServerSettings.DeadCanTalk == true then
								game.ReplicatedStorage.Chatted:FireClient(cPlayer,Player,Message,"",true,_G.ServerSettings.Disguises);
							elseif pData[cPlayer.Name]["Dead"] == false and pData[Player.Name]["Dead"] == false then
								game.ReplicatedStorage.Chatted:FireClient(cPlayer,Player,Message,"",true,_G.ServerSettings.Disguises);
							end;
						elseif pData[cPlayer.Name]["Dead"] == true then
							game.ReplicatedStorage.Chatted:FireClient(cPlayer,Player,Message,"",true,_G.ServerSettings.Disguises);
						end
					else
						game.ReplicatedStorage.Chatted:FireClient(cPlayer,Player,Message,"",true,_G.ServerSettings.Disguises);
					end;

				end;

			else
				game.ReplicatedStorage.Chatted:FireClient(Player,"Server","You are sending messages too quickly.");
				ChatData[Player.Name].ChatCooldown = true;
				wait(5);
				ChatData[Player.Name].ChatCooldown = false;
				ChatData[Player.Name].ChatCount = 0
			end;
		end;
	end;
end

game.ReplicatedStorage.Chatted.OnServerEvent:connect(Module.Chatted)


return Module;