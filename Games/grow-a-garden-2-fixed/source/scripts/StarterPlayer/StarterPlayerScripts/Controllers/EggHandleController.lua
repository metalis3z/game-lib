--credit to quartz games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Eggs = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Eggs")
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = false
local v2 = false
local v3 = CFrame.new(0.75, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
local v4 = CFrame.new(0, 0, 0) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)

function t.Init(p1) --[[ Init | Line: 26 ]] end
function t.Start(p1) --[[ Start | Line: 29 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 34 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 38 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 49 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
end
function t.DisableVFX(p1, p2) --[[ DisableVFX | Line: 56 ]]
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
function t.ClearVisual(p1, p2) --[[ ClearVisual | Line: 68 ]]
	for v1, v2 in p2:GetChildren() do
		if v2:GetAttribute("_EggVisual") then
			v2.Parent = nil
			task.defer(function() --[[ Line: 72 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasVisual(p1, p2) --[[ HasVisual | Line: 81 ]]
	for v1, v2 in p2:GetChildren() do
		if v2:GetAttribute("_EggVisual") then
			return true
		end
	end

	return false
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 90 | Upvalues: t4 (copy), Eggs (copy), LocalPlayer (copy), v3 (copy), v4 (copy) ]]
	if t4[p2] then
		return
	end

	t4[p2] = true
	p1:ClearVisual(p2)

	local Handle = p2:FindFirstChild("Handle")

	if not Handle then
		t4[p2] = nil

		return
	end

	local v1 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

	if not v1 then
		t4[p2] = nil

		return
	end

	local v2 = p2:GetAttribute("Egg")

	if not v2 then
		t4[p2] = nil

		return
	end

	local v32 = Eggs:FindFirstChild(v2)

	if not v32 then
		t4[p2] = nil

		return
	end

	local v42 = v32:Clone()

	p1:DisableVFX(v42)

	local v5 = v42.PrimaryPart or v42:FindFirstChild("Handle") or v42:FindFirstChildWhichIsA("BasePart", true)

	if not v5 then
		v42:Destroy()
		t4[p2] = nil

		return
	end

	for v6, v7 in v42:GetDescendants() do
		if v7:IsA("BasePart") then
			p1:PreparePartForTool(v7)
		end
	end

	local Weld = Instance.new("Weld")

	Weld.Part0 = v5
	Weld.Part1 = Handle
	Weld.Parent = v5
	v42:SetAttribute("_EggVisual", true)
	v42.Parent = p2

	if LocalPlayer and LocalPlayer.Character == p3 then
		p2.Grip = v3
	else
		v5.CFrame = v1.CFrame * v4

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = v5
		WeldConstraint.Part1 = v1
		WeldConstraint.Parent = v5
	end

	t4[p2] = nil
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 159 | Upvalues: t4 (copy), t3 (copy) ]]
	if t4[p2] then
		return
	end

	local v1 = t3[p2]

	if not v1 then
		return
	end

	local v2 = if p2.Parent == v1 then true else false
	local v3 = p1:HasVisual(p2)

	if v2 and not v3 then
		p1:SpawnHandle(p2, v1)

		return
	end

	if v2 or not v3 then
		return
	end

	p1:ClearVisual(p2)
end
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 175 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
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
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 187 ]]
	p1:ClearVisual(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 192 ]]
	return p2:GetAttribute("Egg") ~= nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 196 | Upvalues: t3 (copy), LocalPlayer (copy), v1 (ref), Networking (copy), v2 (ref), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 202 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 203 | Upvalues: p2 (ref), t3 (ref), p1 (ref) ]]
			if not (p2 and t3[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))

	local function openOnce(p1) --[[ openOnce | Line: 210 | Upvalues: LocalPlayer (ref), v1 (ref), Networking (ref) ]]
		if LocalPlayer:GetAttribute("LoadingScreenActive") then
			return false
		end

		if v1 then
			return false
		end

		v1 = true

		local ok, result = pcall(function() --[[ Line: 215 | Upvalues: Networking (ref), p1 (copy) ]]
			return Networking.Egg.OpenEgg:Fire(p1)
		end)

		if not ok then
			warn((("[EggHandleController] OpenEgg invoke errored (%*): %*"):format(p1, result)))
		end

		v1 = false

		return if ok then if result then result.Success == true else result else ok
	end

	local function f3() --[[ Line: 226 | Upvalues: p2 (copy), v2 (ref), openOnce (copy) ]]
		local v1 = p2:GetAttribute("Egg")

		if not v1 or v2 then
			return
		end

		v2 = true

		if not openOnce(v1) then
			v2 = false

			return
		end

		local v22 = tick()

		while v2 and tick() - v22 < 1 do
			task.wait()
		end

		while v2 do
			local v3 = p2:GetAttribute("Egg")

			if not (v3 and openOnce(v3)) then
				break
			end

			local v4 = tick()

			while v2 and tick() - v4 < 0.2 do
				task.wait()
			end
		end
	end

	table.insert(t, p2.Activated:Connect(f3))

	local function f4() --[[ Line: 257 | Upvalues: v2 (ref) ]]
		v2 = false
	end

	table.insert(t, p2.Deactivated:Connect(f4))
	t2[p2] = t
	task.defer(function() --[[ Line: 263 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 270 | Upvalues: Players (copy) ]]
	task.defer(function() --[[ Line: 271 | Upvalues: p2 (copy), p1 (copy), Players (ref) ]]
		if not (p2 and p2.Parent) then
			return
		end

		for v1, v2 in p2:GetChildren() do
			if v2:IsA("Tool") and p1:IsTrackedTool(v2) then
				p1:SetupTool(v2, p2)
			end
		end

		local v3 = Players:GetPlayerFromCharacter(p2)

		if not (v3 and v3.Backpack) then
			p2.ChildAdded:Connect(function(p13) --[[ Line: 289 | Upvalues: p1 (ref), p2 (ref) ]]
				if not (p13:IsA("Tool") and p1:IsTrackedTool(p13)) then
					return
				end

				task.defer(function() --[[ Line: 291 | Upvalues: p13 (copy), p2 (ref), p1 (ref) ]]
					if not (p13 and (p13.Parent and (p2 and p2.Parent))) then
						return
					end

					p1:SetupTool(p13, p2)
				end)
			end)

			return
		end

		for v4, v5 in v3.Backpack:GetChildren() do
			if v5:IsA("Tool") and p1:IsTrackedTool(v5) then
				p1:SetupTool(v5, p2)
			end
		end

		p2.ChildAdded:Connect(function(p13) --[[ Line: 289 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p13:IsA("Tool") and p1:IsTrackedTool(p13)) then
				return
			end

			task.defer(function() --[[ Line: 291 | Upvalues: p13 (copy), p2 (ref), p1 (ref) ]]
				if not (p13 and (p13.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p13, p2)
			end)
		end)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 301 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 306 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 310 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 312 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t