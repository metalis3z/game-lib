--credit to prince games studio
local Players = game:GetService("Players")

game:GetService("RunService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local LocalPlayer = Players.LocalPlayer
local Gardens = workspace:WaitForChild("Gardens")
local Teleports = workspace:WaitForChild("Teleports")
local t = {
	GardenButton = true,
	SellButton = Teleports:WaitForChild("Sell"),
	SeedsButton = Teleports:WaitForChild("Seeds")
}
local t2 = {}
local Controllers = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Controllers")
local PetVisualController = require(Controllers:WaitForChild("PetVisualController"))

local function snapPetsAfterTeleport(p1) --[[ snapPetsAfterTeleport | Line: 21 | Upvalues: LocalPlayer (copy), PetVisualController (copy), Networking (copy) ]]
	local v1

	if p1 then
		v1 = p1
	else
		local Character = LocalPlayer.Character
		local v2 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

		v1 = if v2 then v2.Position else p1
	end

	if v1 then
		PetVisualController:SnapLocalPetsToFollow()
		Networking.Pets.SnapPets:Fire(v1)
	end
end

local v1 = CFrame.new(0, 5, 11) * CFrame.Angles(-0.32288591161895097, 0, 0)

local function getGardenSpawnPoint() --[[ getGardenSpawnPoint | Line: 36 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if not v1 then
		return nil
	end

	local v2 = Gardens:FindFirstChild("Plot" .. tostring(v1))

	if v2 then
		return v2:FindFirstChild("SpawnPoint")
	end

	return nil
end

local function isStealing() --[[ isStealing | Line: 44 | Upvalues: LocalPlayer (copy) ]]
	return if LocalPlayer:GetAttribute("IsStealingFruit") == true then true else LocalPlayer:GetAttribute("CarryingStolenFruit") == true
end

local function isCameraInFront(p1) --[[ isCameraInFront | Line: 49 ]]
	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return false
	end

	local CurrentCamera = workspace.CurrentCamera

	if not CurrentCamera then
		return false
	end

	return (CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Unit:Dot(HumanoidRootPart.CFrame.LookVector) > 0
end

local function snapCameraBehind(p1) --[[ snapCameraBehind | Line: 61 | Upvalues: v1 (copy) ]]
	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera then
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		CurrentCamera.CFrame = HumanoidRootPart.CFrame * v1
		task.defer(function() --[[ Line: 71 | Upvalues: CurrentCamera (copy) ]]
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end)
	end
end

local SideButtons = script.Parent.Parent.SideButtons

local function updateButtonVisibility() --[[ updateButtonVisibility | Line: 78 | Upvalues: LocalPlayer (copy), SideButtons (copy), t2 (copy) ]]
	local v1 = if LocalPlayer:GetAttribute("IsStealingFruit") == true then true else LocalPlayer:GetAttribute("CarryingStolenFruit") == true

	SideButtons.Visible = not v1

	for v2, v3 in t2 do
		v3.Visible = not v1
	end
end

local v2 = 0

for v3, v4 in t do
	local v5 = script.Parent:FindFirstChild(v3)

	if v5 and v5:IsA("TextButton") then
		table.insert(t2, v5)

		local BackgroundColor3 = v5.BackgroundColor3
		local v6 = Color3.new(BackgroundColor3.R * 0.7, BackgroundColor3.G * 0.7, BackgroundColor3.B * 0.7)

		v5.Activated:Connect(function() --[[ Line: 98 | Upvalues: LocalPlayer (copy), v2 (ref), v3 (copy), Gardens (copy), v4 (copy), snapCameraBehind (copy), snapPetsAfterTeleport (copy) ]]
			if if LocalPlayer:GetAttribute("IsStealingFruit") == true then true else LocalPlayer:GetAttribute("CarryingStolenFruit") == true then
				return
			end

			local Character = LocalPlayer.Character

			if not Character then
				return
			end

			if tick() - v2 < 0.25 then
				return
			end

			v2 = tick()

			local v22 = Character:FindFirstChildWhichIsA("Humanoid")

			if v22 and v22.Sit then
				v22.Sit = false
				task.wait()
			end

			local v32 = false
			local v42 = nil

			if v3 == "GardenButton" then
				local v5 = LocalPlayer:GetAttribute("PlotId")
				local v6

				if v5 then
					local v7 = Gardens:FindFirstChild("Plot" .. tostring(v5))

					v6 = if v7 then v7:FindFirstChild("SpawnPoint") else nil
				else
					v6 = nil
				end

				if v6 then
					local v8 = v6.CFrame + Vector3.new(0, 3, 0)

					v42 = v8.Position
					Character:PivotTo(v8)
					v32 = true
				end
			elseif typeof(v4) == "Instance" then
				local v10 = v4.CFrame + Vector3.new(0, 3, 0)

				v42 = v10.Position
				Character:PivotTo(v10)
				v32 = true
			end

			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			local v11

			if HumanoidRootPart then
				local CurrentCamera = workspace.CurrentCamera

				v11 = if CurrentCamera then if (CurrentCamera.CFrame.Position - HumanoidRootPart.Position).Unit:Dot(HumanoidRootPart.CFrame.LookVector) > 0 then true else false else false
			else
				v11 = false
			end

			if v11 then
				snapCameraBehind(Character)
			end

			if not v32 then
				return
			end

			task.spawn(snapPetsAfterTeleport, v42)
		end)
		v5.MouseButton1Down:Connect(function() --[[ Line: 139 | Upvalues: v5 (copy), v6 (copy) ]]
			v5.BackgroundColor3 = v6
		end)
		v5.MouseButton1Up:Connect(function() --[[ Line: 142 | Upvalues: v5 (copy), BackgroundColor3 (copy) ]]
			v5.BackgroundColor3 = BackgroundColor3
		end)
		v5.MouseLeave:Connect(function() --[[ Line: 145 | Upvalues: v5 (copy), BackgroundColor3 (copy) ]]
			v5.BackgroundColor3 = BackgroundColor3
		end)
	end
end

LocalPlayer:GetAttributeChangedSignal("IsStealingFruit"):Connect(updateButtonVisibility)
LocalPlayer:GetAttributeChangedSignal("CarryingStolenFruit"):Connect(updateButtonVisibility)

local v7 = if LocalPlayer:GetAttribute("IsStealingFruit") == true then true else LocalPlayer:GetAttribute("CarryingStolenFruit") == true

SideButtons.Visible = not v7

for v8, v9 in t2 do
	v9.Visible = not v7
end