local AdminModule = {}

local Admins = {}

--[[
COMMAND FORMAT

["NAME"] = function(PlayerWhoSent : Player, Type : string)
		if Type:lower() == "me" then
			
		elseif Type:lower() == "ingame" then
			for _, plr in next, game.Players:GetPlayers() do
				if game.ReplicatedStorage.Remote.ReqPlayerState:InvokeClient(plr) == "Playing" then
					
				end
			end
		elseif Type:lower() == "all" then
			for _, plr in next, game.Players:GetPlayers() do
				
			end
		else
			if not game.Players:FindFirstChild(Type) then
				return
			end
		end
	end,


]]

local FE2Library = require(game.ReplicatedStorage.SharedModules.FE2Library)

local Commands = {
	["devtools"] = function(PlayerWhoSent : Player, Type : string)
		if Type:lower() == "me" then
			for _, tool in next, game.ServerStorage.DevTools:GetChildren() do
				tool:Clone().Parent = PlayerWhoSent.Backpack
			end
		elseif Type:lower() == "ingame" then
			for _, plr in next, game.Players:GetPlayers() do
				if game.ReplicatedStorage.Remote.ReqPlayerState:InvokeClient(plr) == "Playing" then
					for _, tool in next, game.ServerStorage.DevTools:GetChildren() do
						tool:Clone().Parent = PlayerWhoSent.Backpack
					end
				end
			end
		elseif Type:lower() == "all" then
			for _, plr in next, game.Players:GetPlayers() do
				for _, tool in next, game.ServerStorage.DevTools:GetChildren() do
					tool:Clone().Parent = PlayerWhoSent.Backpack
				end
			end
		else
			if not game.Players:FindFirstChild(Type) then
				return
			end
			for _, tool in next, game.ServerStorage.DevTools:GetChildren() do
				tool:Clone().Parent = game.Players[Type].Backpack
			end
		end
	end,
	["givegems"] = function(PlayerWhoSent : Player, Type : string)
		--TODO
	end,
	["givecoins"] = function(PlayerWhoSent : Player, Type : string)
		--TODO
	end,
	["setvote"] = function(PlayerWhoSent : Player, Type : number)
		game.ServerStorage.Bindables.UpdVotingTime:Fire(Type)
	end,
	["forcemap"] = function(PlayerWhoSent : Player, Type : string)
		local MapData = game.ServerStorage.Bindables.GetMapData:Invoke()
		local MapFounded = nil
		for _, v in next, MapData do
			for _, mapData in next, v do
				local name = mapData.name
				if Type ~= string.upper(Type) then
					name = string.lower(name)
				end
				if name:match(Type) then
					--print(mapData)
					MapFounded = mapData
					break
				end
			end
		end
		game.ServerStorage.Bindables.ForceMap:Fire(MapFounded)
	end,
	["kill"] = function(PlayerWhoSent : Player, Type : string)
		if Type:lower() == "me" then
			PlayerWhoSent.Character.Humanoid.Health = 0
		elseif Type:lower() == "ingame" then
			for _, plr in next, game.Players:GetPlayers() do
				if game.ReplicatedStorage.Remote.ReqPlayerState:InvokeClient(plr) == "Playing" then
					plr.Character.Humanoid.Health = 0
				end
			end
		elseif Type:lower() == "all" then
			for _, plr in next, game.Players:GetPlayers() do
				plr.Character.Humanoid.Health = 0
			end
		else
			if not game.Players:FindFirstChild(Type) then
				return
			end
			game.Players[Type].Character.Humanoid.Health = 0
		end
	end,
}

function AdminModule.DoAdmin(Player : Player, m : string)
	if table.find(Admins, Player.UserId) then
		local cmd = nil
		for name, _ in next, Commands do
			if string.match(m, name) then
				cmd = name
				break
			end
		end
		if cmd ~= nil then
			game.ReplicatedStorage.Remote.ChatAlert:FireAllClients({Text = "[GAME]: Performed '" ..  cmd .."'", Color = BrickColor.new("Bright blue").Color}, m)
			local args = nil
			if m:find(" ") then
				args = string.sub(m, m:find(" ")+1,-1)
			else
				args = "me"
			end
			Commands[cmd](Player, args)
		end
	end
end

return AdminModule
