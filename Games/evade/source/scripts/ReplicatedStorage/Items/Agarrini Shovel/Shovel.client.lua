local Tool = script.Parent
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local scriptName = "Graveyard"
local DigStartEvent = Net:RemoteEvent(("EventService/%s/DigStart"):format(scriptName))
local DigEndEvent = Net:RemoteEvent(("EventService/%s/DigEnd"):format(scriptName))
local ToolDisabled = Net:RemoteEvent(("EventService/%s/DigComplete"):format(scriptName))

local isEquipped = false
local mouse = LocalPlayer:GetMouse()

local function getTombstoneUnderPlayer()
	local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not HRP then return nil end

	for _, shard in ipairs(workspace:GetDescendants()) do
		if shard.Name == "Shard" and shard.Parent and shard.Parent.Name == "Shards" then
			local tombstone = shard.Parent.Parent
			if (HRP.Position - shard.Position).Magnitude < 5 then
				return tombstone
			end
		end
	end
end

local function handleDigClick()
	if not isEquipped then return end

	local tombstone = getTombstoneUnderPlayer()
	if not tombstone then return end

	DigStartEvent:FireServer(tombstone)
end

Tool.Equipped:Connect(function()
	isEquipped = true
end)

Tool.Unequipped:Connect(function()
	isEquipped = false
	ToolDisabled:FireServer()
end)

mouse.Button1Down:Connect(handleDigClick)
