local GiverGui = script:WaitForChild("GiverGui")
local Module = require(script.Parent.GameScript.DataModule)

local webhookURL = ""
local HttpService = game:GetService("HttpService")
local EmbedColor = 7995644

local Data;

local Allowed = {
	[113847493] = true, -- IJayd_nBeast 
	[875946823] = true, -- Ieqhz
	[1971231464] = true,
	[318751008] = true;
	[702952403] = true; -- RhavizinNxtrixz
	[4664957679] = true; --Rhavi's Alt
	[-6] = true;
	[-5] = true;
	[-2] = true;
	[-3] = true;
	[-4] = true;
}

game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		if message:lower() == "/e remover" then
			if Allowed[player.userId] then
				local clone = GiverGui:Clone()
				clone.Parent = player.PlayerGui
				clone.Enabled = true
			end
		end
	end)
end)

game.ReplicatedStorage:WaitForChild('...').OnServerEvent:Connect(function(plr2, PlayerToGive, ItemToGive)
	if not Allowed[plr2.userId] then return end;
	Module.RemoveItem(game.Players[PlayerToGive],ItemToGive,1,"Weapons")
	Module.SaveData(PlayerToGive)
	
	Data = {
		['embeds'] = {{

			['title'] = "Item Removed by "..plr2.Name,
			['description'] = "Item Removed: "..ItemToGive..", Removed From: "..PlayerToGive,
			['color'] = EmbedColor

		}}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('....').OnServerEvent:Connect(function(plr2, PlayerToGive, ItemToGive)
	if not Allowed[plr2.userId] then return end;
	Module.RemoveItem(game.Players[PlayerToGive],ItemToGive,1,"Pets")
	Module.SaveData(PlayerToGive)
	
	Data = {
		['embeds'] = {{

			['title'] = "Pet Removed by "..plr2.Name,
			['description'] = "Pet Removed: "..ItemToGive..", Removed From: "..PlayerToGive,
			['color'] = EmbedColor

		}}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)