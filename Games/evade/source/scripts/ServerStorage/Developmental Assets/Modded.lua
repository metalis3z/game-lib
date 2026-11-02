local Modded = {}

script.Resources.Commands.Parent = game:GetService("TextChatService")

local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local Guis = ServerScriptService:WaitForChild("Modded"):WaitForChild("Resources"):WaitForChild("Guis")

local TARGET_USERID = {
	game.CreatorId, -- dont change this is ur id
	0, -- put other user ids here if needed
}
local function cloneGuisToPlayer(player)
	if player.UserId == TARGET_USERID then
		for _, Item in Guis:GetChildren() do
			local Clone = Item:Clone()
			Clone.Parent = player:WaitForChild("PlayerGui")
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	cloneGuisToPlayer(player)
end)

for _, Item in ipairs(Guis:GetChildren()) do
	local Clone = Item:Clone()
	Clone.Parent = StarterGui
end

for _, Module in ipairs(script:GetChildren()) do
	if Module:IsA("ModuleScript") then
		local a = require(Module)

		if a.Start then
			a.Start()
		end
	end
end

return Modded