-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer
local AdminFunClient = ReplicatedStorage:WaitForChild("AdminRemotes"):WaitForChild("AdminFunClient")
local v1 = 0
local v2 = false

local function isInverted() --[[ isInverted | Line: 15 | Upvalues: v1 (ref) ]]
	return os.clock() < v1
end

local function setBound(p1) --[[ setBound | Line: 19 | Upvalues: v2 (ref), ContextActionService (copy) ]]
	if p1 and not v2 then
		ContextActionService:BindActionAtPriority("AdminFunInvertControls", function() --[[ Line: 23 ]]
			return Enum.ContextActionResult.Sink
		end, false, 3000, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D)
		v2 = true

		return
	end

	if p1 or not v2 then
		return
	end

	ContextActionService:UnbindAction("AdminFunInvertControls")
	v2 = false
end

local function getCharacterParts() --[[ getCharacterParts | Line: 40 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if Character then
		return Character:FindFirstChildOfClass("Humanoid"), Character:FindFirstChild("HumanoidRootPart")
	end

	return nil, nil
end

RunService.RenderStepped:Connect(function() --[[ Line: 51 | Upvalues: v1 (ref), setBound (copy), LocalPlayer (copy), UserInputService (copy) ]]
	local v12 = os.clock() < v1

	setBound(v12)

	if not v12 then
		return
	end

	local Character = LocalPlayer.Character
	local v2, v3

	if Character then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		v2 = Humanoid
		v3 = HumanoidRootPart
	else
		v2 = nil
		v3 = nil
	end

	if not (v2 and v3) then
		return
	end

	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return
	end

	local sum = Vector3.new(0, 0, 0)

	if UserInputService:IsKeyDown(Enum.KeyCode.W) then
		sum = sum - CurrentCamera.CFrame.LookVector
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.S) then
		sum = sum + CurrentCamera.CFrame.LookVector
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.A) then
		sum = sum + CurrentCamera.CFrame.RightVector
	end

	if UserInputService:IsKeyDown(Enum.KeyCode.D) then
		sum = sum - CurrentCamera.CFrame.RightVector
	end

	if sum.Magnitude > 0 then
		v2:Move(sum.Unit, false)
	else
		v2:Move(Vector3.new(0, 0, 0), false)
	end
end)
AdminFunClient.OnClientEvent:Connect(function(p1, p2) --[[ Line: 90 | Upvalues: v1 (ref) ]]
	if p1 == "Invert" then
		local v12 = tonumber(p2) or 10

		v1 = math.max(v1, os.clock() + v12)
	end
end)