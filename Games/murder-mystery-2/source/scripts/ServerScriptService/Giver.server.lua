-- Recode by AniDarkness (Champulse, Do NOT steal my Giver)
local GiverGui = script:WaitForChild('GiverGui')
local GiftGui = script:WaitForChild('GiftGUI')
local QuantityGui = script:WaitForChild('QuantityGUI')
local BanGui = script:WaitForChild('BanGui')
local SpecialGui = script:WaitForChild('SpecialGUI')
local LeaderboardGui = script:WaitForChild('LeaderboardGUI')
local Module = require(script.Parent.GameScript.DataModule)
local Chance = require(script.Parent.GameScript.GameFunctions.Chance)
local Players = game:GetService('Players')
local DataStoreService = game:GetService('DataStoreService')
local TeleportService = game:GetService('TeleportService')
local BanStore = DataStoreService:GetDataStore('JMM2GiverBans')
local ReasonStore = DataStoreService:GetDataStore('JMM2GiverReasons')
local webhookURL = 'https://discord.com/api/webhooks/REDACTED'
local HttpService = game:GetService('HttpService')
local EmbedColor = 4886754

local Data

local Whitelisted = {
	[875946823] = true, -- Ieqhz 
	[113847493] = true, -- IJayd_nBeast
	[3688084889] = true,
	[525111307] = true, -- pres
	[2380244082] = true;
	[4464074579] = true;
	[3582027804] = true;
	[4464074579] = true;
	[702952403] = true; -- RhavizinNxtrixz
	[4664957679] = true; --Rhavi's Alt
	[169641570] = true; 
}

game.Players.PlayerAdded:Connect(function(player)
	local userId = player.userId
	local banned, reason
	local success, err = pcall(function()
		banned = BanStore:GetAsync(userId)
		reason = ReasonStore:GetAsync(userId)
	end)
	if banned == true then
		player:Kick('You are banned from Jays Murder Mystery. Reason: '.. reason)
	end
	player.Chatted:Connect(function(message)
		if message:lower() == '/e giver' then
			if Whitelisted[player.UserId] then
				local clone = GiverGui:Clone()
				clone.Parent = player.PlayerGui
				clone.Enabled = true
			end
		end
		if message:lower() == '/e gift' then
			if Whitelisted[player.UserId] then
				local clone = GiftGui:Clone()
				clone.Parent = player.PlayerGui
				clone.Enabled = true
			end
		end
		if message:lower() == '/e quan' then
			if Whitelisted[player.UserId] then
				local clone = QuantityGui:Clone()
				clone.Parent = player.PlayerGui
				clone.Enabled = true
			end
		end
		if message:lower() == '/e ban' then
			if Whitelisted[player.UserId] then
				local clone = BanGui:Clone()
				clone.Parent = player.PlayerGui
				clone.Enabled = true 
			end
		end
		if message:lower() == '/e special' then
			if Whitelisted[player.UserId] then
				local clone = SpecialGui:Clone()
				clone.Parent = player.PlayerGui
				clone.Enabled = true
			end
		end
		if message:lower() == '/e lb' then
			if Whitelisted[player.UserId] then
				local clone = LeaderboardGui:Clone()
				clone.Parent = player.PlayerGui
				clone.Enabled = true
			end
		end
	end)
end)

game.ReplicatedStorage:WaitForChild('LoadGiverGui').OnServerEvent:Connect(function(SpawnerPlayers, Player)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	local clone = GiverGui:Clone()
	clone.Parent = Player.PlayerGui
	clone.Enabled = true
end)

game.ReplicatedStorage:WaitForChild('SpawnWeapons').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive, AmountToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'ClassicPack' then
		Module.GiveItem(game.Players[PlayerToGive],'BloodKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'GhostKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Knife1', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'ShadowKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'TimeKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'AmericaGun', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'GoldenGun', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Gun1', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Phaser', AmountToGive,'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Disint', AmountToGive, 'Weapons')
		Module.SaveData(PlayerToGive)
	end
	if ItemToGive == 'test' then
		Module.GiveItem(game.Players[PlayerToGive],'BloodKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'GhostKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Knife1', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'ShadowKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'TimeKnife', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'AmericaGun', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'GoldenGun', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Gun1', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Phaser', AmountToGive,'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Disint', AmountToGive, 'Weapons')
		Module.SaveData(PlayerToGive)
	end
	if ItemToGive == 'SparklePack' then
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle1', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle2', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle3', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle4', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle5', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle6', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle7', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle8', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle9', AmountToGive,'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Sparkle10', AmountToGive, 'Weapons')
		Module.SaveData(PlayerToGive)
	end
	if ItemToGive == 'SkatePack' then
		Module.GiveItem(game.Players[PlayerToGive],'Sidewinder', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Grind', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Euro', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Ollie', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Tailslide', AmountToGive, 'Weapons')
		Module.GiveItem(game.Players[PlayerToGive],'Indy', AmountToGive, 'Weapons')
		Module.SaveData(PlayerToGive)
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 1, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons')
	Module.SaveData(PlayerToGive)
end)

game.ReplicatedStorage:WaitForChild('SpawnPets').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 1, 'Pets')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Pets')
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Pet Given by '..SpawnerPlayers.Name,
				['description'] = '`Pet Given:` **'..ItemToGive..'**, `Pet Given To:` **'..PlayerToGive..'**',
				['color'] = 4886754
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('RemoveWeapons').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.RemoveItem(game.Players[PlayerToGive], ItemToGive, 1, 'Weapons')
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Weapon Removed by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Removed:` **'..ItemToGive..'**, `Weapon Removed from:` **'..PlayerToGive..'**',
				['color'] = 13632027
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveEffect').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.GiveOther(game.Players[PlayerToGive], ItemToGive, 'Effects')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Effects')
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Effect given by '..SpawnerPlayers.Name,
				['description'] = '`Effect Given:` **'..ItemToGive..'**, `Effect Given to:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('SpawnLevels').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.GiveMaxLevel(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Levels Given by '..SpawnerPlayers.Name,
				['description'] = '`Levels given to:` **'..PlayerToGive..'**',
				['color'] = 16098851
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('RemoveData').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToRemove)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.WipeLeaderboardTokens(PlayerToRemove)
	_G.WipeData(PlayerToRemove)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Data Removed by '..SpawnerPlayers.Name,
				['description'] = '`User that got their data removed:` **'..PlayerToRemove..'**',
				['color'] = 1
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveCoins').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.Give(game.Players[PlayerToGive], 'Credits', ItemToGive)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Credits Given by '..SpawnerPlayers.Name,
				['description'] = '`Credits Amount Given:` **'..ItemToGive..'**, `Coins Given To:` **'..PlayerToGive..'**',
				['color'] = 16312092
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveGems').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.Give(game.Players[PlayerToGive], 'Gems', ItemToGive)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Gems Given by '..SpawnerPlayers.Name,
				['description'] = '`Gems Amount Given:` **'..ItemToGive..'**, `Gems Given To:` **'..PlayerToGive..'**',
				['color'] = 5301186
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveElitePass').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.GiveGamePassElite(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Elite Gamepass given by '..SpawnerPlayers.Name,
				['description'] = '`Elite Gamepass given to:` **'..PlayerToGive..'**',
				['color'] = 13632027
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveRadioPass').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.GiveGamePassRadio(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Radio Gamepass given by '..SpawnerPlayers.Name,
				['description'] = '`Radio Gamepass given to:` **'..PlayerToGive..'**',
				['color'] = 8311585
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveAllWeapons').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.GiveAllWeapons(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'All Weapons given by '..SpawnerPlayers.Name,
				['description'] = '`All Weapons given to:` **'..PlayerToGive..'**',
				['color'] = 9442302
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveKnife').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Data = {
		['embeds'] = {
			{
				['title'] = 'Knife given by '..SpawnerPlayers.Name,
				['description'] = '`Knife given to:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage:WaitForChild('GiveGun').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Data = {
		['embeds'] = {
			{
				['title'] = 'Gun given by '..SpawnerPlayers.Name,
				['description'] = '`Gun given to:` **'..PlayerToGive..'**',
				['color'] = 9131818
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

-- Doesn't exist LoL
game.ReplicatedStorage:WaitForChild('EndGame').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Data = {
		['embeds'] = {
			{
				['title'] = 'Game ended by '..SpawnerPlayers.Name,
				['description'] = '`This admin in a server ended the round:` **'..PlayerToGive..'**',
				['color'] = 1
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

-----------------------------------------------------------------------------------------------------------------------------------
--[[
Adriana here, we've made a new GUI for givers and extra stuff that we don't wanna add on the main GUI it's also for testing hence-
why most of the commands don't really work or break a lot. Every time you spawn anything make sure to check console if errors then
erase your data with the main GUI.
]]

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftWeapon').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	for _, Players in pairs(Players:GetPlayers()) do
		Module.GiveItem(Players, ItemToGive, 1, 'Weapons')
		Module.SaveData(Players)
		game.ReplicatedStorage.ItemGift:FireClient(Players, ItemToGive, 'Weapons')
	end
	Data = {
		['embeds'] = {
			{
				['title'] = 'Weapon Gifted by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Gifted:` **'..ItemToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftPet').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	for _, Players in pairs(Players:GetPlayers()) do
		Module.GiveItem(Players, ItemToGive, 1, 'Pets')
		Module.SaveData(Players)
		game.ReplicatedStorage.ItemGift:FireClient(Players, ItemToGive, 'Pets')
	end
	Data = {
		['embeds'] = {
			{
				['title'] = 'Pet Gifted by '..SpawnerPlayers.Name,
				['description'] = '`Pet Gifted:` **'..ItemToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftPerks').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.GiveOther(game.Players[PlayerToGive], ItemToGive, 'Perks')
	Module.SaveData(PlayerToGive)
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Perks')
	Data = {
		['embeds'] = {
			{
				['title'] = 'Perk Gifted by '..SpawnerPlayers.Name,
				['description'] = '`Perk Gifted:` **'..ItemToGive..'**, `Perk gifted to:` **'..PlayerToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftEmotes').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.GiveOther(game.Players[PlayerToGive], ItemToGive, 'Emotes')
	Module.SaveData(PlayerToGive)
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Emotes')
	Data = {
		['embeds'] = {
			{
				['title'] = 'Emote Gifted by '..SpawnerPlayers.Name,
				['description'] = '`Emote Gifted:` **'..ItemToGive..'**, `Emote gifted to:` **'..PlayerToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftEffect').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	for _, Players in pairs(Players:GetPlayers()) do
		Module.GiveOther(game.Players[PlayerToGive], ItemToGive, 'Effects')
		Module.SaveData(PlayerToGive)
	end
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Effects')
	Data = {
		['embeds'] = {
			{
				['title'] = 'Effect Gifted by '..SpawnerPlayers.Name,
				['description'] = '`Effect Gifted:` **'..ItemToGive..'**, `Effect gifted to:` **'..PlayerToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftToys').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.GiveOther(game.Players[PlayerToGive], ItemToGive, 'Toys')
	Module.SaveData(PlayerToGive)
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Toys')
	Data = {
		['embeds'] = {
			{
				['title'] = 'Toy Gifted by '..SpawnerPlayers.Name,
				['description'] = '`Toy Gifted:` **'..ItemToGive..'**, `Toy gifted to:` **'..PlayerToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftAllEffects').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.GiveAllEffects(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'All Effects given by '..SpawnerPlayers.Name,
				['description'] = '`All Effects given to:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('GiftRadio').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Module.GiveOther(game.Players[PlayerToGive], ItemToGive, 'Radios')
	Module.SaveData(PlayerToGive)
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Radios')
	Data = {
		['embeds'] = {
			{
				['title'] = 'Radio gifted by '..SpawnerPlayers.Name,
				['description'] = '`Radio Gifted:` **'..ItemToGive..'**, `Radio Gifted To:` **'..PlayerToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('ForceBonusRound').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	for _, Players in pairs(Players:GetPlayers()) do
		TeleportService:Teleport(ItemToGive, Players)
	end

end)

game.ReplicatedStorage.GiftGUI:WaitForChild('SetMap').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.ForceMap = ItemToGive
	Data = {
		['embeds'] = {
			{
				['title'] = 'Map setted by '..SpawnerPlayers.Name,
				['description'] = '`Map set to:` **'..ItemToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('ForceMurderer').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.ForceChance(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = 'Murderer set by '..SpawnerPlayers.Name,
				['description'] = '`Murderer:` **'..PlayerToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.GiftGUI:WaitForChild('ForceSheriff').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.ForceSheriff = PlayerToGive
	Data = {
		['embeds'] = {
			{
				['title'] = 'Sheriff set by '..SpawnerPlayers.Name,
				['description'] = '`Sheriff:` **'..PlayerToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)




game.ReplicatedStorage.QuantityGUI:WaitForChild('Five').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive, AmountToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 5
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 5, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons')
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('Ten').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 10
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 10, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 10)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('Twenty').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 20
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 20, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 20)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('Fifity').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 50
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 50, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 30)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('Hundred').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 100
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 100, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 100)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('TwoHundred').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 200
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 200, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 200)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('OneThousand').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 1000
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 1000, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 1000)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('TenThousand').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 1000000
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 10000, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 10000)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('OneHundredThousand').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 100000
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 100000, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 100000)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('FiveHundredThousand').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 500000
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 500000, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 500000)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('OneMillion').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 1000000
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons')
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 1000000, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 1000000)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.QuantityGUI:WaitForChild('TenMillion').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	if ItemToGive == 'Candies' then
		if _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = _G.Halloween2021Candies[game.Players[PlayerToGive]] + 10000000
		elseif not _G.Halloween2021Candies[game.Players[PlayerToGive]] then
			_G.Halloween2021Candies[game.Players[PlayerToGive]] = 1;
		end
		return
	end
	Module.GiveItem(game.Players[PlayerToGive], ItemToGive, 10000000, 'Weapons')
	game.ReplicatedStorage.ItemGift:FireClient(game.Players[PlayerToGive], ItemToGive, 'Weapons', 10000000)
	Module.SaveData(PlayerToGive)
	Data = {
		['embeds'] = {
			{
				['title'] = '[Quantity Spawner] Weapon Given by '..SpawnerPlayers.Name,
				['description'] = '`Weapon Given:` **'..ItemToGive..'**, `Weapon Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.LeaderboardGUI:WaitForChild('WipeLeaderboardTokens').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.WipeLeaderboardTokens(PlayerToGive)
end)

game.ReplicatedStorage.LeaderboardGUI:WaitForChild('GiveLeaderboardItem').OnServerEvent:Connect(function(SpawnerPlayers, PlayerToGive, ItemToGive, RankToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	Data = {
		['embeds'] = {
			{
				['title'] = 'Leaderboard Item Given by '..SpawnerPlayers.Name,
				['description'] = '`Leaderboard Item Given:` **'..ItemToGive..'**, `Leaderboard Item Given To:` **'..PlayerToGive..'**',
				['color'] = 10197915
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)



game.ReplicatedStorage.Remotes.Bans.BanUser.OnServerEvent:Connect(function(player, input, reason, isAutoBan)
	if Whitelisted[player.userId] then
		if Whitelisted[input] then return end
		local PlayerName = game.Players:GetNameFromUserIdAsync(input)
		if isAutoBan ~= nil and isAutoBan == 'IsAutoBan' then -- what is this even for?
			if player.userId ~= input then
				input = player.userId
				reason = 'You have been banned from Jays MM2.'
				player:Kick('We have good Anti-Cheat.')
			end
		end

		local sucess, err = pcall(function()
			BanStore:SetAsync(input, true)
			ReasonStore:SetAsync(input, reason)
		end)

		warn(PlayerName .. ' has been banned from Jays MM2.')

		if game.Players:FindFirstChild(PlayerName) then
			game.Players:WaitForChild(PlayerName):Kick('You are banned from Jays MM2. Reason: '.. reason)
		end
	end

	Data = {
		['embeds'] = {
			{
				['title'] = 'Player banned by '.. player.Name,
				['description'] = 'Player banned: '.. game.Players:GetNameFromUserIdAsync(input) ..', Reason: '.. reason,
				['color'] = 1
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.Remotes.Bans.UnbanUser.OnServerEvent:Connect(function(player, input)
	if Whitelisted[player.userId] then
		local PlayerName = game.Players:GetNameFromUserIdAsync(input)
		local success, err = pcall(function()
			BanStore:SetAsync(input, false)
		end)
		
		warn(PlayerName .. ' has been unbanned.')
		
		Data = {
			['embeds'] = {
				{
					['title'] = 'Player unbanned by '.. player.Name,
					['description'] = 'Player unbanned: '.. game.Players:GetNameFromUserIdAsync(input),
					['color'] = 8311585
				}
			}
		}
		
		local FinalData = HttpService:JSONEncode(Data)
		HttpService:PostAsync(webhookURL, FinalData)
	end
end)

game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceDodgeball').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.ForceDodgeball = ItemToGive
	Data = {
		['embeds'] = {
			{
				['title'] = 'Special map setted by '..SpawnerPlayers.Name,
				['description'] = '`Special map set to:` **'..ItemToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceInfection').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.ForceInfection = ItemToGive
	Data = {
		['embeds'] = {
			{
				['title'] = 'Special map setted by '..SpawnerPlayers.Name,
				['description'] = '`Special map set to:` **'..ItemToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceJuggernaut').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.ForceJuggernaut = ItemToGive
	Data = {
		['embeds'] = {
			{
				['title'] = 'Special map setted by '..SpawnerPlayers.Name,
				['description'] = '`Special map set to:` **'..ItemToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

game.ReplicatedStorage.SpecialGUI:WaitForChild('ForceMassacre').OnServerEvent:Connect(function(SpawnerPlayers, ItemToGive)
	if not Whitelisted[SpawnerPlayers.UserId] then return end
	_G.ForceMassacre = ItemToGive
	Data = {
		['embeds'] = {
			{
				['title'] = 'Special map setted by '..SpawnerPlayers.Name,
				['description'] = '`Special map set to:` **'..ItemToGive..'**',
				['color'] = 16777215
			}
		}
	}

	local FinalData = HttpService:JSONEncode(Data)
	HttpService:PostAsync(webhookURL, FinalData)
end)

--[[
Execute on the Server:

local Module = require(game.ServerScriptService.GameScript.DataModule)
Module.GiveItem(game.Players["RhavizinNxtrixz"], "Candies", 10000000, "Materials")

local Module = require(game.ServerScriptService.GameScript.DataModule)
Module.Give(game.Players["RhavizinNxtrixz"], "Gems", 100000)

_G.RhaviChance()

_G.SummerGifting[game.Players.ChampulseV0] = _G.SummerGifting[game.Players.ChampulseV0] + 250000;

]]