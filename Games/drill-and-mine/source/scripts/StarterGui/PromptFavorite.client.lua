-- PromptFavorite: shows the NATIVE Roblox "favorite this experience" dialog
-- 240 seconds into each session, and never again once the player has favorited.
--
-- AvatarEditorService:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset,
-- true) is the community-standard way to open Roblox's real favorite prompt for
-- the current experience (the docs only mention avatar items, but passing the
-- PlaceId opens the game favorite dialog).
--
-- "Already favorited" is tracked with a persisted flag: when the native prompt
-- reports success we fire PlayerFavoritedGame, and the server sets
-- FavoritePromptDone so the prompt is skipped on future visits.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AvatarEditorService = game:GetService("AvatarEditorService")

local SHOW_AFTER_SECONDS = 240 -- per session; restarts every join

local player = Players.LocalPlayer
local favoritedRemote = ReplicatedStorage:WaitForChild("PlayerFavoritedGame")

-- Best-effort read of the persisted flag so we don't re-prompt someone who has
-- already favorited (and told us) on a previous visit.
local function alreadyFavorited()
	local dataRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlayerDataService")
	local requestData = dataRemotes:WaitForChild("RequestData")
	for _ = 1, 20 do
		local ok, data = pcall(function()
			return requestData:InvokeServer()
		end)
		if ok and type(data) == "table" then
			return data.FavoritePromptDone == true
		end
		task.wait(0.5)
	end
	return false
end

-- Record the favorite the moment the native prompt reports success, so it never
-- shows again. Connected before prompting so we don't miss the event.
local recorded = false
AvatarEditorService.PromptSetFavoriteCompleted:Connect(function(result)
	if recorded then
		return
	end
	if result == Enum.AvatarPromptResult.Success then
		recorded = true
		favoritedRemote:FireServer()
	end
end)

if alreadyFavorited() then
	return
end

task.wait(SHOW_AFTER_SECONDS)

if not player.Parent then
	return
end

local ok, err = pcall(function()
	AvatarEditorService:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true)
end)
if not ok then
	warn("[PromptFavorite] PromptSetFavorite failed: " .. tostring(err))
end
