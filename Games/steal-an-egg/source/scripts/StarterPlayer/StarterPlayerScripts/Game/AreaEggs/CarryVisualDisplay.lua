local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local EggRenderer = require(ReplicatedStorage.Library.Client.Eggs.EggRenderer)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

local CarryVisualDisplay = {}
local activeVisuals = {}

local function resolveAnchorCFrame(character)
	local head = character:FindFirstChild("Head")
	if head and head:IsA("BasePart") then
		return head.CFrame
	end
	local root = character:FindFirstChild("HumanoidRootPart")
	if root and root:IsA("BasePart") then
		return root.CFrame * CFrame.new(0, 2, 0)
	end
	return nil
end

local function clearVisual(userId)
	local visual = activeVisuals[userId]
	if not visual then return end
	activeVisuals[userId] = nil
	visual.Trove:Destroy()
end

local function createVisual(player, payload)
	clearVisual(player.UserId)
	if not player.Character then return end

	local trove = Trove.new()
	local result = EggRenderer.RenderVisual({
		OwnerUserId = player.UserId,
		ScaleAlpha = 0.6,
		UID = "CarryVisual_" .. player.UserId,
		ModelName = "CarryVisual_" .. player.UserId,
		Record = {
			AssetCategory = payload.AssetCategory,
			AssetScale = payload.AssetScale,
			AssetEyeColor = payload.AssetEyeColor,
			AssetColorSeed = payload.AssetColorSeed,
			AssetColorIndex = payload.AssetColorIndex,
			Mutations = payload.Mutations or {},
			BaseMutation = payload.BaseMutation,
		},
	}, Workspace, false)

	local model = result.Model
	trove:Add(model)
	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.CanCollide = false
			descendant.CanQuery = false
			descendant.CanTouch = false
		end
	end

	trove:Add(RunService.Heartbeat:Connect(function()
		local character = player.Character
		local anchor = character and resolveAnchorCFrame(character)
		if anchor then
			model:PivotTo(anchor * CFrame.new(0, 2.5, 0))
		end
	end))

	activeVisuals[player.UserId] = {Model = model, Trove = trove}
end

function CarryVisualDisplay.Start()
	EggCmds.AreaEggCarryVisualUpdated:Connect(function(payload)
		local player = Players:GetPlayerByUserId(payload.CarrierUserId)
		if not player then return end
		if payload.IsCarrying then
			createVisual(player, payload)
		else
			clearVisual(payload.CarrierUserId)
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		clearVisual(player.UserId)
	end)
end

return CarryVisualDisplay