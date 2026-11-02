local AvatarEditorService = game:GetService("AvatarEditorService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PromptFavoriteEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("PromptFavoriteEvent")

PromptFavoriteEvent.OnClientEvent:Connect(function()
	pcall(function()
		AvatarEditorService:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true)
	end)
end)