local player = game.Players.LocalPlayer
local character = player.Character
local inventory = player.Backpack

local function saveTool()
	local Carti = character:FindFirstChild("Carti")
	if Carti then
		
		Carti.Parent = inventory
	end
end


player.Leaving:Connect(saveTool)



character.Died:Connect(function()

   player.Leaving:Disconnect()
end)