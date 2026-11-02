--credit to leon games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Shovel = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Shovel")
local KingName = ReplicatedStorage.ServerValues.KingName
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local SFX = game.SoundService:FindFirstChild("SFX")
local v1 = if SFX then SFX:FindFirstChild("Shovel_SFX") else SFX
local v2 = v1 and v1:FindFirstChild("Equip")
local v3 = v1 and v1:FindFirstChild("Unequip")
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local v4 = CFrame.new(0, 0, 0)
local v5 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)

local function ScaleGripTranslation(p1, p2) --[[ ScaleGripTranslation | Line: 29 ]]
	return CFrame.new(p1.Position * p2) * p1.Rotation
end

local t5 = {}
local v6 = nil

local function applyKingVisual(p1) --[[ applyKingVisual | Line: 37 | Upvalues: t5 (copy) ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") and not t5[v2] then
			t5[v2] = {
				Material = v2.Material,
				MaterialVariant = v2.MaterialVariant,
				Color = v2.Color
			}
			v2.Material = Enum.Material.Foil
			v2.MaterialVariant = ""
			v2.Color = Color3.fromRGB(255, 200, 0)
		end
	end
end

local function removeKingVisual() --[[ removeKingVisual | Line: 52 | Upvalues: t5 (copy) ]]
	for v1, v2 in t5 do
		if v1.Parent then
			v1.Material = v2.Material
			v1.MaterialVariant = v2.MaterialVariant
			v1.Color = v2.Color
		end
	end

	table.clear(t5)
end

local function updateKingVisual() --[[ updateKingVisual | Line: 63 | Upvalues: LocalPlayer (copy), removeKingVisual (copy), v6 (ref), KingName (copy), applyKingVisual (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		removeKingVisual()
		v6 = nil

		return
	end

	local v1 = Character:FindFirstChildWhichIsA("Tool")

	if not (KingName.Value == LocalPlayer.Name and (v1 and v1:GetAttribute("Shovel"))) then
		removeKingVisual()
		v6 = nil

		return
	end

	if v6 == v1 then
		v6 = v1
		applyKingVisual(v1)

		return
	end

	removeKingVisual()
	v6 = v1
	applyKingVisual(v1)
end

function t.Init(p1) --[[ Init | Line: 86 | Upvalues: KingName (copy), updateKingVisual (copy) ]]
	KingName:GetPropertyChangedSignal("Value"):Connect(updateKingVisual)
end
function t.Start(p1) --[[ Start | Line: 90 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 95 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 99 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2, p3) --[[ PreparePartForTool | Line: 110 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = p3 == true
end
function t.DisableVFX(p1, p2) --[[ DisableVFX | Line: 117 ]]
	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("ParticleEmitter") or (v2:IsA("Trail") or v2:IsA("Beam")) then
			v2.Enabled = false

			continue
		end

		if v2:IsA("Fire") or (v2:IsA("Smoke") or v2:IsA("Sparkles")) then
			v2.Enabled = false

			continue
		end

		if v2:IsA("Light") then
			v2.Enabled = false
		end
	end
end
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 129 | Upvalues: v6 (ref), t5 (copy) ]]
	if p2 == v6 then
		table.clear(t5)
		v6 = nil
	end

	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 139 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 148 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" then
			return true
		end
	end

	return false
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 157 | Upvalues: t4 (copy), Shovel (copy), LocalPlayer (copy), v2 (copy), v4 (copy), v5 (copy), updateKingVisual (copy) ]]
	if t4[p2] then
		return
	end

	t4[p2] = true
	p1:ClearHandle(p2)

	local v1 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

	if not v1 then
		t4[p2] = nil

		return
	end

	local Build = Shovel:Clone()

	p1:DisableVFX(Build)

	local v22 = p3:GetScale()

	if math.abs(v22 - 1) > 0.0001 then
		if Build:IsA("Model") then
			Build:ScaleTo(v22)
		elseif Build:IsA("BasePart") then
			Build.Size = Build.Size * v22
		end
	end

	local v3 = LocalPlayer and (if LocalPlayer.Character == p3 then true else false)
	local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and v2 then
		local v42 = v2:Clone()

		v42.Parent = HumanoidRootPart
		v42.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		v42:Play()
		game.Debris:AddItem(v42, if v42.TimeLength > 0 then v42.TimeLength / v42.PlaybackSpeed else 2)
	end

	if Build:IsA("BasePart") then
		p1:PreparePartForTool(Build, v3)
		Build.Name = "Handle"
		Build.Parent = p2

		if v3 then
			local v6 = v4

			p2.Grip = CFrame.new(v6.Position * v22) * v6.Rotation
		else
			local v7 = v5

			Build.CFrame = v1.CFrame * (CFrame.new(v7.Position * v22) * v7.Rotation)

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = Build
			WeldConstraint.Part1 = v1
			WeldConstraint.Parent = Build
		end
	elseif Build:IsA("Model") then
		local Handle = Build.PrimaryPart

		if not Handle then
			Build:Destroy()
			t4[p2] = nil

			return
		end

		for v8, v9 in Build:GetDescendants() do
			if v9:IsA("BasePart") then
				p1:PreparePartForTool(v9, v3)
			end
		end

		for v10, v11 in Build:GetDescendants() do
			if v11:IsA("BasePart") and v11 ~= Handle then
				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Part0 = Handle
				WeldConstraint.Part1 = v11
				WeldConstraint.Parent = v11
			end
		end

		Build.Name = "Build"
		Build.Parent = p2
		Handle.Name = "Handle"
		Handle.Parent = p2

		if v3 then
			local v12 = v4

			p2.Grip = CFrame.new(v12.Position * v22) * v12.Rotation
		else
			local v13 = v5

			Handle.CFrame = v1.CFrame * (CFrame.new(v13.Position * v22) * v13.Rotation)

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = Handle
			WeldConstraint.Part1 = v1
			WeldConstraint.Parent = Handle
		end
	end

	t4[p2] = nil

	if not v3 then
		return
	end

	updateKingVisual()
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 259 | Upvalues: t4 (copy), t3 (copy), v3 (copy) ]]
	if t4[p2] then
		return
	end

	local v1 = t3[p2]

	if not v1 then
		return
	end

	local v2 = if p2.Parent == v1 then true else false
	local v32 = p1:HasHandle(p2)

	if v2 and not v32 then
		p1:SpawnHandle(p2, v1)

		return
	end

	if v2 or not v32 then
		return
	end

	local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and v3 then
		local v4 = v3:Clone()

		v4.Parent = HumanoidRootPart
		v4.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		v4:Play()
		game.Debris:AddItem(v4, if v4.TimeLength > 0 then v4.TimeLength / v4.PlaybackSpeed else 2)
	end

	p1:ClearHandle(p2)
end
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 289 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
	local v1 = t2[p2]

	if v1 then
		for v2, v3 in v1 do
			v3:Disconnect()
		end

		t2[p2] = nil
	end

	t3[p2] = nil
	t4[p2] = nil
end
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 301 ]]
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 306 ]]
	return p2:GetAttribute("Shovel") ~= nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 310 | Upvalues: t3 (copy), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 316 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 317 | Upvalues: p2 (ref), t3 (ref), p1 (ref) ]]
			if not (p2 and t3[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))
	t2[p2] = t
	task.defer(function() --[[ Line: 326 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 333 | Upvalues: Players (copy), RunService (copy) ]]
	task.defer(function() --[[ Line: 334 | Upvalues: p2 (copy), p1 (copy), Players (ref), RunService (ref) ]]
		if not (p2 and p2.Parent) then
			return
		end

		for v1, v2 in p2:GetChildren() do
			if v2:IsA("Tool") and p1:IsTrackedTool(v2) then
				p1:SetupTool(v2, p2)
			end
		end

		local v3 = Players:GetPlayerFromCharacter(p2)
		local v4, v5

		if v3 and v3.Backpack then
			for v6, v7 in v3.Backpack:GetChildren() do
				if v7:IsA("Tool") and p1:IsTrackedTool(v7) then
					p1:SetupTool(v7, p2)
				end
			end
		end

		p2.ChildAdded:Connect(function(p12) --[[ Line: 353 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
				return
			end

			task.defer(function() --[[ Line: 355 | Upvalues: p12 (copy), p2 (ref), p1 (ref) ]]
				if not (p12 and (p12.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p12, p2)
			end)
		end)
		v4 = p2:GetScale()
		v5 = nil
		v5 = RunService.Heartbeat:Connect(function() --[[ Line: 365 | Upvalues: p2 (ref), v5 (ref), p1 (ref), v4 (ref) ]]
			if not (p2 and p2.Parent) then
				v5:Disconnect()

				return
			end

			local v1 = false

			for v2, v3 in p2:GetChildren() do
				if v3:IsA("Tool") and p1:IsTrackedTool(v3) then
					v1 = true

					break
				end
			end

			if v1 then
				local v42 = p2:FindFirstChild("Right Arm") or p2:FindFirstChild("RightHand")

				if v42 then
					local RightGrip = v42:FindFirstChild("RightGrip")
					local RightGripAttachment = v42:FindFirstChild("RightGripAttachment")

					if RightGrip and (RightGrip:IsA("Weld") and RightGripAttachment) then
						local C0 = RightGrip.C0
						local Position = RightGripAttachment.CFrame.Position

						if (C0.Position - Position).Magnitude > 0.0001 then
							RightGrip.C0 = CFrame.new(Position) * (C0 - C0.Position)
						end
					end
				end
			end

			if not v1 then
				return
			end

			local v52 = p2:GetScale()

			if math.abs(v52 - v4) < 0.0001 then
				return
			end

			v4 = v52

			for v7, v8 in p2:GetChildren() do
				if v8:IsA("Tool") and p1:IsTrackedTool(v8) then
					p1:SpawnHandle(v8, p2)
				end
			end
		end)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 409 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 414 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 418 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 420 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t