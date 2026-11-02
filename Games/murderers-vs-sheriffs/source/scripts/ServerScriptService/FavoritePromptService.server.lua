local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Extras = Remotes:WaitForChild("Extras")
local FavoritePromptRequest = Extras:FindFirstChild("FavoritePromptRequest")

if not FavoritePromptRequest then
	FavoritePromptRequest = Instance.new("RemoteFunction")
	FavoritePromptRequest.Name = "FavoritePromptRequest"
	FavoritePromptRequest.Parent = Extras
end

local shownStore = DataStoreService:GetDataStore("FavoritePromptShown_v1")
local sessionShown = {}
local sessionBusy = {}

FavoritePromptRequest.OnServerInvoke = function(player)
	if not player then
		return false
	end

	local userId = player.UserId
	if sessionShown[userId] or sessionBusy[userId] then
		return false
	end

	sessionBusy[userId] = true
	local key = tostring(userId)
	local shouldShow = false

	local ok, result = pcall(function()
		return shownStore:UpdateAsync(key, function(oldValue)
			shouldShow = oldValue ~= true
			return true
		end)
	end)

	sessionBusy[userId] = nil

	if not ok then
		warn("[FavoritePromptService] Could not save favorite prompt state for " .. player.Name .. ": " .. tostring(result))
		shouldShow = not sessionShown[userId]
	end

	sessionShown[userId] = true
	return shouldShow
end
