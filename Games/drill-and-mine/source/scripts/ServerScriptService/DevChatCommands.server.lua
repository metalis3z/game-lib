-- Dev chat commands (restricted to ALLOWED_USER_IDS below):
--   ";reset <yourname>"  wipes the speaker's save data (and kicks them so the
--       rejoin spins up a fresh profile). The <name> argument must match the
--       speaker's username (case-insensitive) so a chat slip can't nuke data.
--   ";grantblock <legendary|godly|secret>"  grants one store loot block into
--       the speaker's inventory for testing the in-hand open flow before the
--       real gamepass ids are wired into GameConfig.Shop.LuckyBlockStore.

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local LootBlockService = require(ServerScriptService.Source.Services.LootBlockService)

-- lowercase arg -> GameConfig.Shop.LuckyBlockStore key
local STORE_KEYS = {
	legendary = "Legendary",
	godly = "Godly",
	secret = "Secret",
}

local ALLOWED_USER_IDS = {
	[605235231] = true,  -- AimbotJokers
	[125570361] = true, -- NotionScripts
}

local function handleChatted(player, message)
	if not ALLOWED_USER_IDS[player.UserId] then
		return
	end
	if type(message) ~= "string" then
		return
	end
	local cmd, arg = message:match("^%s*;(%w+)%s+(%S+)%s*$")
	if not cmd then
		return
	end
	cmd = cmd:lower()
	if cmd == "reset" then
		if arg:lower() ~= player.Name:lower() then
			return
		end
		PlayerDataService.WipePlayerData(player)
	elseif cmd == "grantblock" then
		local storeKey = STORE_KEYS[arg:lower()]
		if storeKey then
			LootBlockService.DevGrantBlock(player, storeKey, 1)
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		handleChatted(player, msg)
	end)
end)

for _, player in ipairs(Players:GetPlayers()) do
	player.Chatted:Connect(function(msg)
		handleChatted(player, msg)
	end)
end
