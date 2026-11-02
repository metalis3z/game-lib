-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local t = {}
local v2 = false
local v3 = false
local v4 = false

local function updateGiftableState() --[[ updateGiftableState | Line: 16 | Upvalues: v4 (ref), v2 (ref), v3 (ref) ]]
	v4 = v2 or v3
end

local function checkToolWeight() --[[ checkToolWeight | Line: 20 | Upvalues: v1 (ref), v2 (ref), v4 (ref), v3 (ref), Constants (copy) ]]
	local v12 = v1

	if v12 and v12.Parent then
		local v22 = v12:FindFirstChildWhichIsA("Tool")
		local v32 = if v22 then v22:GetAttribute("ItemType") else v22

		v2 = if v32 then Constants.SUPPORTED_GIFTS_TYPES[v32] ~= nil else v32
		v4 = v2 or v3
	else
		v2 = false
		v4 = v2 or v3
	end
end

local function disconnectCharacterConnections() --[[ disconnectCharacterConnections | Line: 46 | Upvalues: t (copy) ]]
	for i = #t, 1, -1 do
		t[i]:Disconnect()
		t[i] = nil
	end
end

local function disableLocalProximityPrompts(p1) --[[ disableLocalProximityPrompts | Line: 54 | Upvalues: t (copy) ]]
	local HumanoidRootPart = p1:WaitForChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local function clear() --[[ clear | Line: 57 | Upvalues: HumanoidRootPart (copy) ]]
		for i, v in ipairs(HumanoidRootPart:GetChildren()) do
			if v:IsA("ProximityPrompt") then
				v:Destroy()
			end
		end
	end

	clear()
	t[#t + 1] = HumanoidRootPart.ChildAdded:Connect(clear)
end

local function setupCharacter(p1) --[[ setupCharacter | Line: 72 | Upvalues: t (copy), v1 (ref), disableLocalProximityPrompts (copy), v2 (ref), v4 (ref), v3 (ref), Constants (copy), checkToolWeight (copy) ]]
	for i = #t, 1, -1 do
		t[i]:Disconnect()
		t[i] = nil
	end

	v1 = p1
	disableLocalProximityPrompts(p1)

	local v12 = p1

	if v12 and v12.Parent then
		local v22 = v12:FindFirstChildWhichIsA("Tool")
		local v32 = if v22 then v22:GetAttribute("ItemType") else v22

		v2 = if v32 then Constants.SUPPORTED_GIFTS_TYPES[v32] ~= nil else v32
		v4 = v2 or v3
	else
		v2 = false
		v4 = v2 or v3
	end

	t[#t + 1] = p1.ChildAdded:Connect(checkToolWeight)
	t[#t + 1] = p1.ChildRemoved:Connect(checkToolWeight)
end

LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 81 | Upvalues: setupCharacter (copy) ]]
	setupCharacter(p1)
end)

if v1 then
	setupCharacter(v1)
end

local function updateCarryingState() --[[ updateCarryingState | Line: 89 | Upvalues: v3 (ref), LocalPlayer (copy), v4 (ref), v2 (ref) ]]
	v3 = LocalPlayer:GetAttribute("CarryingPlotAsset") == true
	v4 = v2 or v3
end

LocalPlayer:GetAttributeChangedSignal("CarryingPlotAsset"):Connect(updateCarryingState)
v3 = if LocalPlayer:GetAttribute("CarryingPlotAsset") == true then true else false
v4 = v2 or v3
task.spawn(function() --[[ Line: 97 | Upvalues: Players (copy), LocalPlayer (copy), v4 (ref) ]]
	while true do
		task.wait(0.1)

		for i, v in ipairs((Players:GetPlayers())) do
			if v ~= LocalPlayer then
				local Character = v.Character

				if Character then
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

					if HumanoidRootPart then
						for i2, v2 in ipairs(HumanoidRootPart:GetChildren()) do
							if v2:IsA("ProximityPrompt") then
								v2.Enabled = v4
							end
						end
					end
				end
			end
		end
	end
end)