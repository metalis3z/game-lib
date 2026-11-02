--credit to quartz games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Crates = Assets:WaitForChild("Crates")
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}
local t4 = {}
local v1 = CFrame.new(0, 0, 1.5)
local v2 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)

local function ResolveCrateTemplate(p1) --[[ ResolveCrateTemplate | Line: 25 | Upvalues: Assets (copy), Crates (copy) ]]
	local GuildCrates = Assets:FindFirstChild("GuildCrates")

	if GuildCrates then
		local v1 = GuildCrates:FindFirstChild(p1)

		if v1 and v1:IsA("Model") then
			return v1
		end
	end

	local v2 = Crates:FindFirstChild(p1)

	if v2 and v2:IsA("Model") then
		return v2
	end

	local v3 = Crates:FindFirstChild("Arch Crate")

	if v3 and v3:IsA("Model") then
		return v3
	end

	return nil
end

function t.Init(p1) --[[ Init | Line: 46 ]] end
function t.Start(p1) --[[ Start | Line: 49 | Upvalues: Players (copy), t2 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 54 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 58 | Upvalues: t2 (ref), Players (ref), p1 (copy) ]]
		for v1 in t2 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 69 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
end
function t.DisableVFX(p1, p2) --[[ DisableVFX | Line: 76 ]]
	for v1, v2 in p2:GetDescendants() do
		if v2:IsA("ParticleEmitter") or v2:IsA("Trail") then
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
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 89 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 93 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 102 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" then
			return true
		end
	end

	return false
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 111 | Upvalues: t4 (copy), ResolveCrateTemplate (copy), LocalPlayer (copy), v1 (copy), v2 (copy) ]]
	if t4[p2] then
		return
	end

	t4[p2] = true
	p1:ClearHandle(p2)

	local v12 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

	if v12 then
		local v22 = p2:GetAttribute("Crate")

		if v22 then
			local v3 = ResolveCrateTemplate(v22)

			if v3 then
				local Build = v3:Clone()

				p1:DisableVFX(Build)

				local v4 = LocalPlayer and LocalPlayer.Character == p3
				local Handle = Build.PrimaryPart

				if not Handle then
					Build:Destroy()
				else
					for v5, v6 in Build:GetDescendants() do
						if v6:IsA("BasePart") then
							p1:PreparePartForTool(v6)
						end
					end

					for v7, v8 in Build:GetDescendants() do
						if v8:IsA("BasePart") and v8 ~= Handle then
							local WeldConstraint = Instance.new("WeldConstraint")

							WeldConstraint.Part0 = Handle
							WeldConstraint.Part1 = v8
							WeldConstraint.Parent = v8
						end
					end

					Build.Name = "Build"
					Build.Parent = p2
					Handle.Name = "Handle"
					Handle.Parent = p2

					if v4 then
						p2.Grip = v1
					else
						Handle.CFrame = v12.CFrame * v2

						local WeldConstraint = Instance.new("WeldConstraint")

						WeldConstraint.Part0 = Handle
						WeldConstraint.Part1 = v12
						WeldConstraint.Parent = Handle
					end
				end
			end
		end
	end

	t4[p2] = nil
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 184 | Upvalues: t4 (copy), t3 (copy) ]]
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
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 200 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
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
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 212 ]]
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 217 ]]
	return p2:GetAttribute("Crate") ~= nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 221 | Upvalues: t3 (copy), t2 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t3[p2] = p3

	local function f2() --[[ Line: 227 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 228 | Upvalues: p2 (ref), t3 (ref), p1 (ref) ]]
			if not (p2 and t3[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))
	t2[p2] = t
	task.defer(function() --[[ Line: 237 | Upvalues: p2 (copy), t3 (ref), p1 (copy) ]]
		if not (p2 and t3[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 244 | Upvalues: Players (copy) ]]
	task.defer(function() --[[ Line: 245 | Upvalues: p2 (copy), p1 (copy), Players (ref) ]]
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
			p2.ChildAdded:Connect(function(p13) --[[ Line: 263 | Upvalues: p1 (ref), p2 (ref) ]]
				if not (p13:IsA("Tool") and p1:IsTrackedTool(p13)) then
					return
				end

				task.defer(function() --[[ Line: 265 | Upvalues: p13 (copy), p2 (ref), p1 (ref) ]]
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

		p2.ChildAdded:Connect(function(p13) --[[ Line: 263 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p13:IsA("Tool") and p1:IsTrackedTool(p13)) then
				return
			end

			task.defer(function() --[[ Line: 265 | Upvalues: p13 (copy), p2 (ref), p1 (ref) ]]
				if not (p13 and (p13.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p13, p2)
			end)
		end)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 275 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 280 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 287 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 289 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t