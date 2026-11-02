--credit to prince games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Mushrooms = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Mushrooms")
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = CFrame.new(0, 0, 0)
local v2 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)

local function ScaleGripTranslation(p1, p2) --[[ ScaleGripTranslation | Line: 20 ]]
	return CFrame.new(p1.Position * p2) * p1.Rotation
end

function t.Init(p1) --[[ Init | Line: 24 ]] end
function t.Start(p1) --[[ Start | Line: 27 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 32 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 36 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 47 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
end
function t.DisableVFX(p1, p2) --[[ DisableVFX | Line: 54 ]]
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
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 66 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 70 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 79 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" then
			return true
		end
	end

	return false
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 88 | Upvalues: t4 (copy), Mushrooms (copy), LocalPlayer (copy), v1 (copy), v2 (copy) ]]
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

	local v22 = p2:GetAttribute("Mushroom")

	if not v22 then
		t4[p2] = nil

		return
	end

	local v3 = Mushrooms:FindFirstChild(v22)

	if not v3 then
		t4[p2] = nil

		return
	end

	local Build = v3:Clone()

	p1:DisableVFX(Build)

	local v4 = p3:GetScale()

	if math.abs(v4 - 1) > 0.0001 then
		Build:ScaleTo(v4)
	end

	local Handle = Build.PrimaryPart

	if not Handle then
		Build:Destroy()
		t4[p2] = nil

		return
	end

	for v6, v7 in Build:GetDescendants() do
		if v7:IsA("BasePart") then
			p1:PreparePartForTool(v7)
		end
	end

	for v8, v9 in Build:GetDescendants() do
		if v9:IsA("BasePart") and v9 ~= Handle then
			local WeldConstraint = Instance.new("WeldConstraint")

			WeldConstraint.Part0 = Handle
			WeldConstraint.Part1 = v9
			WeldConstraint.Parent = v9
		end
	end

	Build.Name = "Build"
	Build.Parent = p2
	Handle.Name = "Handle"
	Handle.Parent = p2

	if LocalPlayer and LocalPlayer.Character == p3 then
		local v10 = v1

		p2.Grip = CFrame.new(v10.Position * v4) * v10.Rotation
	else
		local v11 = v2

		Handle.CFrame = v12.CFrame * (CFrame.new(v11.Position * v4) * v11.Rotation)

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = Handle
		WeldConstraint.Part1 = v12
		WeldConstraint.Parent = Handle
	end

	t4[p2] = nil
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 166 | Upvalues: t4 (copy), t3 (copy) ]]
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

	p1:ClearHandle(p2)
end
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 182 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
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
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 194 ]]
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 199 ]]
	return p2:GetAttribute("Mushroom") ~= nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 203 | Upvalues: t3 (copy), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 209 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 210 | Upvalues: p2 (ref), t3 (ref), p1 (ref) ]]
			if not (p2 and t3[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))
	t2[p2] = t
	task.defer(function() --[[ Line: 219 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 226 | Upvalues: Players (copy), RunService (copy) ]]
	task.defer(function() --[[ Line: 227 | Upvalues: p2 (copy), p1 (copy), Players (ref), RunService (ref) ]]
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

		p2.ChildAdded:Connect(function(p12) --[[ Line: 246 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
				return
			end

			task.defer(function() --[[ Line: 248 | Upvalues: p12 (copy), p2 (ref), p1 (ref) ]]
				if not (p12 and (p12.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p12, p2)
			end)
		end)
		v4 = p2:GetScale()
		v5 = nil
		v5 = RunService.Heartbeat:Connect(function() --[[ Line: 258 | Upvalues: p2 (ref), v5 (ref), p1 (ref), v4 (ref) ]]
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
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 300 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 305 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 309 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 311 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t