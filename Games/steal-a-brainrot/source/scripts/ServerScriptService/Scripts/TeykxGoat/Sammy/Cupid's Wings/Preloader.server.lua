local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

local Tool = script.Parent
local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("CupidsWings")

local assets = {
	Tool,
	ToolAssets,
	ToolAssets:WaitForChild("WingsWooshStart"),
	ToolAssets:WaitForChild("WingsWooshEnd"),
	ToolAssets:WaitForChild("WingsIdleSound"),
	ToolAssets:WaitForChild("WingsIdleMagicSound")
}

task.spawn(function()
	ContentProvider:PreloadAsync(assets)
end)