local teleport = script.Parent

local TeleportService = game:GetService('TeleportService')

local placeID = 17559712568   ---change the ID to the ID of your game
	
local canTeleport = true

local function otherGame (otherPart)
	local player = game.Players:FindFirstChild(otherPart.Parent.Name)
	if player and canTeleport then
		canTeleport = false
		TeleportService:Teleport(placeID, player)
	end
end

teleport.Touched:Connect(otherGame)