--credit to leon games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local function ResolveBirdAsset() --[[ ResolveBirdAsset | Line: 12 | Upvalues: Assets (copy) ]]
	local Pets = Assets:FindFirstChild("Pets")

	if not Pets then
		return Assets:WaitForChild("Robin")
	end

	local Robin = Pets:FindFirstChild("Robin")

	if Robin then
		return Robin
	end

	return Assets:WaitForChild("Robin")
end

local Pets = Assets:FindFirstChild("Pets")
local v1

if Pets then
	local Robin = Pets:FindFirstChild("Robin")

	v1 = Robin or Assets:WaitForChild("Robin")
else
	v1 = Assets:WaitForChild("Robin")
end

local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local v2 = CFrame.Angles(0, 0, -1.5707963267948966)

function t.Init(p1) --[[ Init | Line: 35 ]] end
function t.Start(p1) --[[ Start | Line: 39 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 45 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 50 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 62 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
	p2.Massless = true
end
function t.DisableVFX(p1, p2) --[[ DisableVFX | Line: 71 ]]
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
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 84 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 88 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 96 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" then
			return true
		end
	end

	return false
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 104 | Upvalues: t4 (copy), v1 (copy), LocalPlayer (copy), v2 (copy) ]]
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

	if not p2:GetAttribute("Bird") then
		t4[p2] = nil

		return
	end

	local Build = v1:Clone()

	p1:DisableVFX(Build)

	local Handle = Build.PrimaryPart

	if not Handle then
		Build:Destroy()
		t4[p2] = nil

		return
	end

	for v3, v4 in Build:GetDescendants() do
		if v4:IsA("BasePart") then
			p1:PreparePartForTool(v4)
		end
	end

	local v5 = Build:FindFirstChildOfClass("AnimationController") or Instance.new("AnimationController")
	local Animator = v5:FindFirstChildOfClass("Animator")

	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = v5
	end

	local Animations = Build:FindFirstChild("Animations")
	local v6 = (if Animations then Animations:FindFirstChild("Fly") else nil) or Build:FindFirstChild("Fly")

	Build.Name = "Build"
	Build.Parent = p2
	Handle.Name = "Handle"
	Handle.Parent = p2
	v5.Parent = Handle
	p2.Grip = v2

	if not (LocalPlayer and LocalPlayer.Character == p3) then
		Handle.CFrame = v12.CFrame * CFrame.new(0, -1, 0) * v2

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = v12
		WeldConstraint.Part1 = Handle
		WeldConstraint.Parent = Handle
	end

	if not (v6 and v6:IsA("Animation")) then
		t4[p2] = nil

		return
	end

	local ok, result = pcall(function() --[[ Line: 200 | Upvalues: Animator (ref), v6 (ref) ]]
		return Animator:LoadAnimation(v6)
	end)

	if not (ok and result) then
		t4[p2] = nil

		return
	end

	result.Looped = true
	result:Play(0)
	t4[p2] = nil
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 214 | Upvalues: t4 (copy), t3 (copy) ]]
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
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 234 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
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
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 247 ]]
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 253 ]]
	return p2:GetAttribute("Bird") ~= nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 258 | Upvalues: t3 (copy), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 266 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 267 | Upvalues: p2 (ref), t3 (ref), p1 (ref) ]]
			if not (p2 and t3[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))
	t2[p2] = t
	task.defer(function() --[[ Line: 278 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 286 | Upvalues: Players (copy) ]]
	task.defer(function() --[[ Line: 287 | Upvalues: p2 (copy), p1 (copy), Players (ref) ]]
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

		p2.ChildAdded:Connect(function(p12) --[[ Line: 308 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
				return
			end

			task.defer(function() --[[ Line: 310 | Upvalues: p12 (copy), p2 (ref), p1 (ref) ]]
				if not (p12 and (p12.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p12, p2)
			end)
		end)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 321 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 327 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 332 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 334 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t