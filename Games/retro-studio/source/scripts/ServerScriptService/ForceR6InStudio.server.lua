local players = game:GetService("Players")
local getHumanoidDescriptionFromUserId = players.GetHumanoidDescriptionFromUserId
local insert = game:GetService("InsertService")
local loadAsset = insert.LoadAsset
local starterPlayer = game:GetService("StarterPlayer")

local function getR6Avatar()
	local success, result = pcall(loadAsset, insert, 1785197)

	if success then
		if result then
			local starterCharacter = result:FindFirstChildOfClass("Model")
			if starterCharacter then
				starterCharacter.Name = "StarterCharacter"
				starterCharacter.Parent = game.StarterPlayer
				result:Destroy()
			end
		end
	else
		warn(result)
	end
end
getR6Avatar()