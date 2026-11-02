local AvatarEditorService = game:GetService("AvatarEditorService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Extras = Remotes:WaitForChild("Extras")
local FavoritePromptRequest = Extras:WaitForChild("FavoritePromptRequest", 30)

if not FavoritePromptRequest then
	return
end

task.wait(60)

local shouldShow = false
local ok, result = pcall(function()
	return FavoritePromptRequest:InvokeServer()
end)

if ok and result == true then
	shouldShow = true
end

if shouldShow then
	pcall(function()
		AvatarEditorService:PromptSetFavorite(
			game.PlaceId,
			Enum.AvatarItemType.Asset,
			true
		)
	end)
end
