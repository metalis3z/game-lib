--credit to quartz games studio
local t = {
	StartOrder = 6
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local GardenSyncController = require(script.Parent.GardenSyncController)
local PlantVisualizerController = require(script.Parent.PlantVisualizerController)
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local NotificationController = require(script.Parent.NotificationController)
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local v1 = nil

local function GetLocalPlantsFolder() --[[ GetLocalPlantsFolder | Line: 20 | Upvalues: PlantVisualizerController (copy), LocalPlayer (copy) ]]
	return PlantVisualizerController:GetPlantsFolder(LocalPlayer.UserId)
end

local function ClearAllPrompts() --[[ ClearAllPrompts | Line: 25 | Upvalues: t2 (copy) ]]
	for v1, v2 in t2 do
		if v2 and v2.Parent then
			v2:Destroy()
		end

		t2[v1] = nil
	end
end

local function GetOrCreateHarvestPart(p1) --[[ GetOrCreateHarvestPart | Line: 35 ]]
	local HarvestPart = p1:FindFirstChild("HarvestPart")

	if HarvestPart and HarvestPart:IsA("BasePart") then
		return HarvestPart
	end

	local v1 = p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")

	if v1 then
		local HarvestPart2 = Instance.new("Part")

		HarvestPart2.Name = "HarvestPart"
		HarvestPart2.Size = Vector3.new(1, 1, 1)
		HarvestPart2.Transparency = 1
		HarvestPart2.Anchored = true
		HarvestPart2.CanCollide = false
		HarvestPart2.CanTouch = false
		HarvestPart2.CanQuery = false
		HarvestPart2.CFrame = v1.CFrame
		HarvestPart2.Parent = p1

		return HarvestPart2
	end

	return nil
end

local function v2(p1, p2) --[[ AddPromptToPlant | Line: 59 | Upvalues: t2 (copy), GetOrCreateHarvestPart (copy), CollectionService (copy), v2 (copy), GardenSyncController (copy), LocalPlayer (copy), SeedData (copy), NotificationController (copy), Networking (copy) ]]
	if t2[p2] then
		return
	end

	local v1 = GetOrCreateHarvestPart(p1)

	if not v1 then
		return
	end

	if not p1:HasTag("InitializationComplete") then
		local v22 = nil

		v22 = CollectionService:GetInstanceAddedSignal("InitializationComplete"):Connect(function(p12) --[[ Line: 70 | Upvalues: p1 (copy), v22 (ref), v2 (ref), p2 (copy) ]]
			if p12 == p1 then
				v22:Disconnect()
				v2(p1, p2)
			end
		end)

		return
	end

	local v4 = GardenSyncController:GetPlant(LocalPlayer.UserId, p2:match("^%d+_(.+)$") or p2)

	if not v4 then
		return
	end

	local v5 = nil

	for v6, v7 in SeedData do
		if v7.SeedName == v4.PlantName then
			v5 = v7

			break
		end
	end

	if not v5 or v5.IsSingleHarvest then
		return
	end

	if not v4.IsPotted then
		local PotPrompt = Instance.new("ProximityPrompt")

		PotPrompt.Name = "PotPrompt"
		PotPrompt.ActionText = "Pot Plant"
		PotPrompt.ObjectText = v4.PlantName or "Plant"
		PotPrompt.HoldDuration = 1
		PotPrompt.Enabled = true
		PotPrompt.MaxActivationDistance = 8
		PotPrompt.RequiresLineOfSight = false
		PotPrompt.Style = Enum.ProximityPromptStyle.Custom
		PotPrompt.Parent = v1
		PotPrompt.Triggered:Connect(function(p12) --[[ Line: 110 | Upvalues: LocalPlayer (ref), p1 (copy), v4 (copy), NotificationController (ref), p2 (copy), Networking (ref) ]]
			if p12 ~= LocalPlayer then
				return
			end

			local v1 = p1:GetAttribute("Age") or 0

			if v1 < (p1:GetAttribute("MaxAge") or v4.MaxAge or 0) then
				NotificationController:CreateNotification("This crop hasn\'t fully grown yet!")

				return
			end

			Networking.Garden.PotPlant:Fire(p2:match("^%d+_(.+)$") or p2)
		end)
		t2[p2] = PotPrompt
	end
end

local function AddPromptsToAllPlants() --[[ AddPromptsToAllPlants | Line: 132 | Upvalues: PlantVisualizerController (copy), LocalPlayer (copy), v2 (copy) ]]
	local v1 = PlantVisualizerController:GetPlantsFolder(LocalPlayer.UserId)

	if not v1 then
		return
	end

	for v22, v3 in v1:GetChildren() do
		if v3:IsA("Model") then
			v2(v3, v3.Name)
		end
	end
end

local function OnToolEquipped(p1) --[[ OnToolEquipped | Line: 146 | Upvalues: v1 (ref), AddPromptsToAllPlants (copy), PlantVisualizerController (copy), LocalPlayer (copy), v2 (copy) ]]
	if not p1:GetAttribute("EmptyPot") then
		return
	end

	v1 = p1
	AddPromptsToAllPlants()

	local v12 = PlantVisualizerController:GetPlantsFolder(LocalPlayer.UserId)

	if not v12 then
		return
	end

	v12.ChildAdded:Connect(function(p1) --[[ Line: 158 | Upvalues: v1 (ref), v2 (ref) ]]
		if not (v1 and p1:IsA("Model")) then
			return
		end

		v2(p1, p1.Name)
	end)
end

local function OnToolUnequipped(p1) --[[ OnToolUnequipped | Line: 167 | Upvalues: v1 (ref), t2 (copy) ]]
	if not p1:GetAttribute("EmptyPot") then
		return
	end

	v1 = nil

	for v12, v2 in t2 do
		if v2 and v2.Parent then
			v2:Destroy()
		end

		t2[v12] = nil
	end
end

function t.Init(p1) --[[ Init | Line: 176 ]] end
function t.Start(p1) --[[ Start | Line: 179 | Upvalues: LocalPlayer (copy), OnToolEquipped (copy), v1 (ref), t2 (copy), Networking (copy), ProximityPromptService (copy) ]]
	local v12 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

	local function SetupCharacter(p1) --[[ SetupCharacter | Line: 183 | Upvalues: OnToolEquipped (ref), v1 (ref), t2 (ref) ]]
		for v12, v2 in p1:GetChildren() do
			if v2:IsA("Tool") then
				OnToolEquipped(v2)
			end
		end

		p1.ChildAdded:Connect(function(p1) --[[ Line: 190 | Upvalues: OnToolEquipped (ref) ]]
			if not p1:IsA("Tool") then
				return
			end

			OnToolEquipped(p1)
		end)
		p1.ChildRemoved:Connect(function(p1) --[[ Line: 195 | Upvalues: v1 (ref), t2 (ref) ]]
			if not p1:IsA("Tool") then
				return
			end

			if not p1:GetAttribute("EmptyPot") then
				return
			end

			v1 = nil

			for v12, v2 in t2 do
				if v2 and v2.Parent then
					v2:Destroy()
				end

				t2[v12] = nil
			end
		end)
	end

	SetupCharacter(v12)
	LocalPlayer.CharacterAdded:Connect(SetupCharacter)
	Networking.Garden.PlantPotted.OnClientEvent:Connect(function(p1) --[[ Line: 207 | Upvalues: t2 (ref) ]]
		local v1 = t2[p1]

		if v1 and v1.Parent then
			v1:Destroy()
		end

		t2[p1] = nil
	end)
	ProximityPromptService.PromptTriggered:Connect(function(p1, p2) --[[ Line: 216 | Upvalues: LocalPlayer (ref), Networking (ref) ]]
		if p2 ~= LocalPlayer then
			return
		end

		if p1.Name ~= "PickUpPottedPlantPrompt" then
			return
		end

		local v1 = p1:FindFirstAncestorOfClass("Model")

		if not v1 then
			return
		end

		if v1 and v1.Name == "PotVisual" then
			v1 = v1:FindFirstAncestorOfClass("Model")
		end

		local v3 = v1:GetAttribute("PlantId")

		if v3 then
			Networking.PotPlacement.PickUpPottedPlant:Fire(v3)
		end
	end)
end

return t