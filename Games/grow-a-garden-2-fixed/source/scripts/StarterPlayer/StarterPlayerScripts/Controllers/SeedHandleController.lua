--credit to leon games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Seeds = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Seeds")
local BackpackListener = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("BackpackListener"))
local t2 = {}
local LocalPlayer = Players.LocalPlayer
local t3 = {}
local t4 = {}
local t5 = {}

local function PlaySFX(p1, p2) --[[ PlaySFX | Line: 28 | Upvalues: SoundService (copy) ]]
	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		local Sound = Instance.new("Sound")

		Sound.SoundId = p2
		Sound.PlaybackSpeed = 1 + math.random(-15, 15) * 0.01
		Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		Sound.Parent = HumanoidRootPart
		Sound:Play()
		game.Debris:AddItem(Sound, Sound.TimeLength / math.max(Sound.PlaybackSpeed, 0.01) + 1)
	end
end

local v1 = CFrame.new(0, -0.5, 0.25)
local v2 = CFrame.new(0, -1.25, -0.5) * CFrame.Angles(-1.5707963267948966, 0, 0)

function t.Init(p1) --[[ Init | Line: 44 ]] end
function t.Start(p1) --[[ Start | Line: 47 | Upvalues: Players (copy), t3 (copy) ]]
	for v1, v2 in Players:GetPlayers() do
		p1:SetupPlayer(v2)
	end

	Players.PlayerAdded:Connect(function(p12) --[[ Line: 52 | Upvalues: p1 (copy) ]]
		p1:SetupPlayer(p12)
	end)
	Players.PlayerRemoving:Connect(function(p12) --[[ Line: 56 | Upvalues: t3 (ref), Players (ref), p1 (copy) ]]
		for v1 in t3 do
			if (Players:GetPlayerFromCharacter(v1.Parent) or v1.Parent and (v1.Parent:IsA("Backpack") and Players:GetPlayerFromCharacter(v1.Parent.Parent))) == p12 then
				p1:CleanupTool(v1)
			end
		end
	end)
end
function t.PreparePartForTool(p1, p2) --[[ PreparePartForTool | Line: 67 ]]
	p2.Anchored = false
	p2.CanCollide = false
	p2.CanQuery = false
	p2.CanTouch = false
end
function t.ClearHandle(p1, p2) --[[ ClearHandle | Line: 74 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" or (v2.Name == "Build" or v2:IsA("Model")) then
			v2.Parent = nil
			task.defer(function() --[[ Line: 78 | Upvalues: v2 (copy) ]]
				if not v2 then
					return
				end

				v2:Destroy()
			end)
		end
	end
end
function t.HasHandle(p1, p2) --[[ HasHandle | Line: 87 ]]
	for v1, v2 in p2:GetChildren() do
		if v2.Name == "Handle" then
			return true
		end
	end

	return false
end
function t.SpawnHandle(p1, p2, p3) --[[ SpawnHandle | Line: 96 | Upvalues: t5 (copy), t2 (copy), Seeds (copy), LocalPlayer (copy), PlaySFX (copy), v1 (copy), v2 (copy) ]]
	if t5[p2] then
		return
	end

	t5[p2] = true
	p1:ClearHandle(p2)

	local v12 = p2:GetAttribute("SeedTool")

	if not v12 then
		t5[p2] = nil

		return
	end

	local v22 = Seeds:FindFirstChild(t2[v12] or v12)

	if not v22 then
		t5[p2] = nil

		return
	end

	local v3 = p3:FindFirstChild("Right Arm") or p3:FindFirstChild("RightHand")

	if not v3 then
		t5[p2] = nil

		return
	end

	-- Offset segun el rig: el brazo R6 ("Right Arm", 1x2x1) tiene la mano ~1 stud
	-- por debajo del centro; la mano R15 ("RightHand") es pequena. Ajustamos para
	-- que la semilla quede en la palma y no colgando lejos.
	local HeldOffset = if v3.Name == "Right Arm" then CFrame.new(0, -1, -0.35) * CFrame.Angles(-math.pi / 2, 0, 0) else CFrame.new(0, -0.35, -0.1) * CFrame.Angles(-math.pi / 2, 0, 0)

	local Build = v22:Clone()

	PlaySFX(p3, "rbxassetid://85584987915775")

	if Build:IsA("BasePart") then
		p1:PreparePartForTool(Build)
		Build.Name = "Handle"
		Build.Parent = p2

		-- Soldamos SIEMPRE manualmente (incluido el jugador local): el Tool tiene
		-- RequiresHandle=false, asi que Roblox NO crea el RightGrip por su cuenta y
		-- setear Grip no engancha nada -> la semilla no salia en la propia mano.
		Build.CFrame = v3.CFrame * HeldOffset

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = Build
		WeldConstraint.Part1 = v3
		WeldConstraint.Parent = Build
	elseif Build:IsA("Model") then
		local Handle = Build.PrimaryPart

		if not Handle then
			Build:Destroy()
			t5[p2] = nil

			return
		end

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

		-- Mismo motivo que arriba: weld manual para todos (RequiresHandle=false).
		Handle.CFrame = v3.CFrame * HeldOffset

		local WeldConstraint = Instance.new("WeldConstraint")

		WeldConstraint.Part0 = Handle
		WeldConstraint.Part1 = v3
		WeldConstraint.Parent = Handle
	end

	t5[p2] = nil
end
function t.UpdateToolState(p1, p2) --[[ UpdateToolState | Line: 187 | Upvalues: t5 (copy), t4 (copy), PlaySFX (copy) ]]
	if t5[p2] then
		return
	end

	local v1 = t4[p2]

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

	PlaySFX(v1, "rbxassetid://120414358030957")
	p1:ClearHandle(p2)
end
function t.DisconnectTool(p1, p2) --[[ DisconnectTool | Line: 204 | Upvalues: t3 (copy), t4 (copy), t5 (copy) ]]
	local v1 = t3[p2]

	if v1 then
		for v2, v3 in v1 do
			v3:Disconnect()
		end

		t3[p2] = nil
	end

	t4[p2] = nil
	t5[p2] = nil
end
function t.CleanupTool(p1, p2) --[[ CleanupTool | Line: 216 ]]
	p1:ClearHandle(p2)
	p1:DisconnectTool(p2)
end
function t.IsTrackedTool(p1, p2) --[[ IsTrackedTool | Line: 221 ]]
	return p2:GetAttribute("SeedTool") ~= nil
end
function t.SetupTool(p1, p2, p3) --[[ SetupTool | Line: 225 | Upvalues: t4 (copy), t3 (copy) ]]
	p1:DisconnectTool(p2)

	local t = {}

	t4[p2] = p3

	local function f2() --[[ Line: 231 | Upvalues: p2 (copy), t4 (ref), p1 (copy) ]]
		task.defer(function() --[[ Line: 232 | Upvalues: p2 (ref), t4 (ref), p1 (ref) ]]
			if not (p2 and t4[p2]) then
				return
			end

			p1:UpdateToolState(p2)
		end)
	end

	table.insert(t, p2:GetPropertyChangedSignal("Parent"):Connect(f2))
	t3[p2] = t
	task.defer(function() --[[ Line: 241 | Upvalues: p2 (copy), t4 (ref), p1 (copy) ]]
		if not (p2 and t4[p2]) then
			return
		end

		p1:UpdateToolState(p2)
	end)
end
function t.SetupCharacter(p1, p2) --[[ SetupCharacter | Line: 248 | Upvalues: Players (copy) ]]
	task.defer(function() --[[ Line: 249 | Upvalues: p2 (copy), p1 (copy), Players (ref) ]]
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

		p2.ChildAdded:Connect(function(p12) --[[ Line: 268 | Upvalues: p1 (ref), p2 (ref) ]]
			if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
				return
			end

			task.defer(function() --[[ Line: 270 | Upvalues: p12 (copy), p2 (ref), p1 (ref) ]]
				if not (p12 and (p12.Parent and (p2 and p2.Parent))) then
					return
				end

				p1:SetupTool(p12, p2)
			end)
		end)
	end)
end
function t.SetupPlayer(p1, p2) --[[ SetupPlayer | Line: 280 | Upvalues: BackpackListener (copy) ]]
	if p2.Character then
		p1:SetupCharacter(p2.Character)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 285 | Upvalues: p1 (copy) ]]
		p1:SetupCharacter(p12)
	end)
	BackpackListener.bind(p2, function(p12) --[[ Line: 289 | Upvalues: p1 (copy), p2 (copy) ]]
		if not (p12:IsA("Tool") and p1:IsTrackedTool(p12)) then
			return
		end

		task.defer(function() --[[ Line: 291 | Upvalues: p2 (ref), p12 (copy), p1 (ref) ]]
			local Character = p2.Character

			if not (p12 and (p12.Parent and (Character and Character.Parent))) then
				return
			end

			p1:SetupTool(p12, Character)
		end)
	end)
end

return t