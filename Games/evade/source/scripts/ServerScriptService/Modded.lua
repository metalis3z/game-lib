--local Modded = {}

script.Resources.Commands.Parent = game:GetService("TextChatService")

local ServerScriptService = game:GetService("ServerScriptService")
local StarterGui = game:GetService("StarterGui")

local Guis = script.Parent:WaitForChild("Modded"):WaitForChild("Resources"):WaitForChild("Guis")

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