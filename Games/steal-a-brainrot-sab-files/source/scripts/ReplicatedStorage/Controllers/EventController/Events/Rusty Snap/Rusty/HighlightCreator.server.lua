

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerData = require(ReplicatedStorage.Datas.ServerData)

if script:IsDescendantOf(workspace) then
	local Highlight = Instance.new("Highlight")

	Highlight.Name = "Highlight"

	if ServerData.IsTsunamiServer() then
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	else
		Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	end

	Highlight.FillTransparency = 1
	Highlight.OutlineColor = Color3.fromRGB(255, 247, 1)
	Highlight.Parent = script.Parent
end
