local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

local timer  = 0

local timeNeeded = 60 * 16
UIS.InputBegan:Connect(function()
	timer = 0
end)

while wait(1) do
	timer += 1
	
	if timer >= timeNeeded then
		game:GetService('TeleportService'):Teleport(game.PlaceId, player)
		break
	end
end