-- FavoritePromptServer: persists that the player has favorited the game so the
-- native favorite prompt (PromptFavorite LocalScript) is skipped on future
-- visits.
--
-- The client fires ReplicatedStorage.PlayerFavoritedGame when Roblox's native
-- favorite dialog reports success. We set FavoritePromptDone = true on the
-- player's profile (in GameConfig.Data.PlayerDataTemplate) and save.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)

local favoritedRemote = ReplicatedStorage:WaitForChild("PlayerFavoritedGame")

favoritedRemote.OnServerEvent:Connect(function(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data or data.FavoritePromptDone == true then
		return
	end
	-- Write straight to the profile table: SetStat only assigns when the key
	-- already exists on the loaded profile, so it silently drops the write on
	-- any profile where FavoritePromptDone hasn't been reconciled in yet.
	data.FavoritePromptDone = true
	PlayerDataService.ScheduleSave(player)
end)
