--credit to prince games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trowel = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Trowel")
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local Trowel_SFX = game.SoundService.SFX.Trowel_SFX
local Equip = Trowel_SFX.Equip
local Unequip = Trowel_SFX.Unequip
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = CFrame.new(0, 0, 0)
local v2 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)

function t.Init(p1) --[[ Init | Line: 25 ]] end
function t.Start(p1) --[[ Start | Line: 28 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 33 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 37 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 48 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
end
function t.DisableVFX(p1, p2) --[[ DisableVFX | Line: 55 ]]
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
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 67 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 71 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 80 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" then
			return true
		end
	end

	return false
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 89 | Upvalues: t4 (copy), Trowel (copy), LocalPlayer (copy), Equip (copy), v1 (copy), v2 (copy) ]]
	if t4[p2] then
		return
	end

	t4[p2] = true
	p1:ClearHandle(p2)

	local v12 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

	if not v12 then
		t4[p2] = nil

		return
	end

	local Build = Trowel:Clone()

	p1:DisableVFX(Build)

	local v22 = LocalPlayer and (if LocalPlayer.Character == p3 then true else false)
	local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		local v3 = Equip:Clone()

		v3.Parent = HumanoidRootPart
		v3.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		v3.Playing = true
		game.Debris:AddItem(v3, v3.PlaybackSpeed * v3.TimeLength)
	end

	if Build:IsA("BasePart") then
		p1:PreparePartForTool(Build)
		Build.Name = "Handle"
		Build.Parent = p2

		if v22 then
			p2.Grip = v1
		else
			Build.CFrame = v12.CFrame * v2

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = Build
			WeldConstraint.Part1 = v12
			WeldConstraint.Parent = Build
		end
	elseif Build:IsA("Model") then
		local Handle = Build.PrimaryPart

		if not Handle then
			Build:Destroy()
			t4[p2] = nil

			return
		end

		for v4, v5 in Build:GetDescendants() do
			if v5:IsA("BasePart") then
				p1:PreparePartForTool(v5)
			end
		end

		for v6, v7 in Build:GetDescendants() do
			if v7:IsA("BasePart") and v7 ~= Handle then
				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Part0 = Handle
				WeldConstraint.Part1 = v7
				WeldConstraint.Parent = v7
			end
		end

		Build.Name = "Build"
		Build.Parent = p2
		Handle.Name = "Handle"
		Handle.Parent = p2

		if v22 then
			p2.Grip = v1
		else
			Handle.CFrame = v12.CFrame * v2

			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = Handle
			WeldConstraint.Part1 = v12
			WeldConstraint.Parent = Handle
		end
	end

	t4[p2] = nil
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 176 | Upvalues: t4 (copy), t3 (copy), Unequip (copy) ]]
	if t4[p2] then
		return
	end

	local v1 = t3[p2]

	if not v1 then
		return
	end

	local v2 = if p2.Parent == v1 then true else false
	local v3 = p1:HasHandle(p2)

	if v2 and not v3 then
		p1:SpawnHandle(p2, v1)

		return
	end

	if v2 or not v3 then
		return
	end

	local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		local v4 = Unequip:Clone()

		v4.Parent = HumanoidRootPart
		v4.PlaybackSpeed = 1 + math.random(-15, 15) / 100
		v4.Playing = true
		game.Debris:AddItem(v4, v4.PlaybackSpeed * v4.TimeLength)
	end

	p1:ClearHandle(p2)
end
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 203 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
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
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 215 ]]
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 220 ]]
	return p2:GetAttribute("Trowel") ~= nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 224 | Upvalues: t3 (copy), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 230 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 231 | Upvalues: p2 (ref), t3 (ref), p1 (ref) ]]
			if not (p2 and t3[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))
	t2[p2] = t
	task.defer(function() --[[ Line: 240 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 247 | Upvalues: Players (copy) ]]
	task.defer(function() --[[ Line: 248 | Upvalues: p2 (copy), p1 (copy), Players (ref) ]]
		if not (p2 and p2.Parent) then
			return
		end

		for v1, v2 in p2:GetChildren() do
			if v2:IsA("Tool") and p1:IsTrackedTool(v2) then
				p1:SetupTool(v2, p2)
			end
		end

		local v3 = Players:GetPlayerFromCharacter(p2)

		if v3 and v3.Backpack then
			for v4, v5 in v3.Backpack:GetChildren() do
				if v5:IsA("Tool") and p1:IsTrackedTool(v5) then
					p1:SetupTool(v5, p2)
				end
			end
		end

		p2.ChildAdded:Connect(function(p12) --[[ Line: 267 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
				return
			end

			task.defer(function() --[[ Line: 269 | Upvalues: p12 (copy), p2 (ref), p1 (ref) ]]
				if not (p12 and (p12.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p12, p2)
			end)
		end)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 279 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 284 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 288 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 290 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t