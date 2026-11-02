--credit to leon games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	StartOrder = 7
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local SharedModules = ReplicatedStorage:WaitForChild("SharedModules")
local Networking = require(SharedModules:WaitForChild("Networking"))
local RarityVisuals = require(SharedModules:WaitForChild("RarityVisuals"))
local PetModules = require(SharedModules:WaitForChild("PetModules"))
local PetSizes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetSizes"))
local PetTypes = require(ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("PetTypes"))
local PetLeaveTimer = ReplicatedStorage.Assets.PetLeaveTimer
local PetCostTimer = ReplicatedStorage.Assets.PetCostTimer
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Pets = Assets:FindFirstChild("Pets")
local t2 = {
	[2] = UDim2.new(0.2, 0, 0.722, 0),
	[3] = UDim2.new(0.3, 0, 0.722, 0),
	[4] = UDim2.new(0.375, 0, 0.722, 0),
	[5] = UDim2.new(0.5, 0, 0.722, 0),
	[6] = UDim2.new(0.575, 0, 0.722, 0),
	[7] = UDim2.new(0.65, 0, 0.722, 0)
}
local t3 = {}
local v1 = nil

local function v25(p1) --[[ v25 | Line: 32 ]]
	local v3 = tostring((math.floor((math.abs(p1)))))
	local v4

	while true do
		local v5

		v4, v5 = string.gsub(v3, "^(%d+)(%d%d%d)", "%1,%2")

		if v5 == 0 then
			break
		end

		v3 = v4
	end

	return v4
end

local function _(p1) --[[ _ | Line: 41 | Upvalues: v25 (copy) ]]
	return "\194\162" .. v25(p1)
end

local function _2(p1) --[[ _ | Line: 45 ]]
	return #tostring((math.floor((math.abs(p1)))))
end

local function _3(p1) --[[ _ | Line: 48 | Upvalues: t2 (copy) ]]
	if p1 <= 2 then
		return t2[2]
	end

	if t2[p1] then
		return t2[p1]
	end

	return UDim2.new((p1 - 7) * 0.075 + 0.65, 0, 0.722, 0)
end

local t4 = {
	[2] = UDim2.new(0.225, 0, 0.722, 0),
	[3] = UDim2.new(0.3, 0, 0.722, 0),
	[4] = UDim2.new(0.56, 0, 0.722, 0),
	[5] = UDim2.new(0.56, 0, 0.722, 0)
}

local function _4(p1) --[[ _ | Line: 65 | Upvalues: t4 (copy) ]]
	if p1 <= 2 then
		return t4[2]
	end

	if p1 >= 5 then
		return t4[5]
	end

	return t4[p1]
end

local function v40(p1) --[[ v40 | Line: 75 ]]
	local v2 = math.max(0, (math.ceil(p1)))

	if not (v2 >= 60) then
		return string.format("%ds", v2)
	end

	local v3 = math.floor(v2 / 60)
	local v4 = v2 % 60

	if v4 == 0 then
		return string.format("%dm", v3)
	end

	return string.format("%dm %ds", v3, v4)
end

local function v43() --[[ v43 | Line: 89 | Upvalues: v1 (ref) ]]
	if v1 and v1.Parent then
		return v1
	end

	local Map = workspace:WaitForChild("Map", 30)
	local WildPetSpawns = Map:FindFirstChild("WildPetSpawns")

	if WildPetSpawns and WildPetSpawns:IsA("Folder") then
		v1 = WildPetSpawns
	else
		v1 = Instance.new("Folder")
		v1.Name = "WildPetSpawns"
		v1.Parent = Map
	end

	return v1
end

local function _5() --[[ _ | Line: 106 ]]
	local Temporary = workspace:FindFirstChild("Temporary")

	if Temporary and Temporary:IsA("Folder") then
		return Temporary
	end

	local Temporary2 = Instance.new("Folder")

	Temporary2.Name = "Temporary"
	Temporary2.Parent = workspace

	return Temporary2
end

local function v57(p1) --[[ v57 | Line: 117 | Upvalues: Assets (copy), Debris (copy) ]]
	local Poof = Assets:FindFirstChild("Poof")

	if not Poof then
		return
	end

	local v1 = Poof:Clone()

	if v1:IsA("BasePart") then
		v1.Anchored = true
		v1.CanCollide = false
		v1.CanQuery = false
		v1.CanTouch = false
		v1.Massless = true
		v1.CFrame = p1
	elseif v1:IsA("Model") then
		for v2, v3 in v1:GetDescendants() do
			if v3:IsA("BasePart") then
				v3.Anchored = true
				v3.CanCollide = false
				v3.CanQuery = false
				v3.CanTouch = false
				v3.Massless = true
			end
		end

		v1:PivotTo(p1)
	end

	local Temporary = workspace:FindFirstChild("Temporary")
	local v4

	if Temporary and Temporary:IsA("Folder") then
		v4 = Temporary
	else
		local Temporary2 = Instance.new("Folder")

		Temporary2.Name = "Temporary"
		Temporary2.Parent = workspace
		v4 = Temporary2
	end

	v1.Parent = v4
	task.spawn(function() --[[ Line: 154 | Upvalues: v1 (copy) ]]
		task.wait()

		if not (v1 and v1.Parent) then
			return
		end

		for v2, v3 in v1:GetDescendants() do
			local v12

			if v3:IsA("ParticleEmitter") then
				v12 = v3.Rate > 0 and math.max(3, (math.floor(v3.Rate))) or 5
				v3:Emit(v12)
			end
		end
	end)
	Debris:AddItem(v1, 5)
end

local function v63(p1) --[[ v63 | Line: 172 | Upvalues: Assets (copy), Debris (copy) ]]
	local PopVFXModel = Assets:FindFirstChild("PopVFXModel")

	if not PopVFXModel then
		return
	end

	local v1 = PopVFXModel:Clone()

	if v1:IsA("Model") then
		pcall(function() --[[ Line: 180 | Upvalues: v1 (copy), p1 (copy) ]]
			v1:PivotTo(CFrame.new(p1))
		end)
	elseif v1:IsA("BasePart") then
		v1.CFrame = CFrame.new(p1)
	end

	v1.Parent = workspace
	task.spawn(function() --[[ Line: 188 | Upvalues: v1 (copy) ]]
		task.wait()

		if not (v1 and v1.Parent) then
			return
		end

		for v12, v2 in v1:GetDescendants() do
			if v2:IsA("ParticleEmitter") then
				v2:Emit(v2:GetAttribute("EmitCount") or 1)
			end
		end
	end)
	Debris:AddItem(v1, 5)
end

local function v69(p1, p2) --[[ v69 | Line: 206 | Upvalues: SoundService (copy) ]]
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Transparency = 1
	Part.Size = Vector3.new(1, 1, 1)
	Part.CFrame = CFrame.new(p2)
	Part.Parent = workspace

	local Sound = Instance.new("Sound")

	Sound.SoundId = p1
	Sound.Volume = 1
	Sound.RollOffMaxDistance = 200
	Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
	Sound.Parent = Part
	task.spawn(function() --[[ Line: 223 | Upvalues: Sound (copy), Part (copy) ]]
		if not Sound.IsLoaded then
			Sound.Loaded:Wait()
		end

		Sound:Play()
		task.wait(math.max(Sound.PlaybackSpeed * Sound.TimeLength, 0.5) + 0.1)

		if not (Part and Part.Parent) then
			return
		end

		Part:Destroy()
	end)
end

local function v73(p1) --[[ v73 | Line: 236 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BodyMover") or (v2:IsA("VectorForce") or (v2:IsA("Torque") or (v2:IsA("LinearVelocity") or (v2:IsA("AngularVelocity") or (v2:IsA("AlignPosition") or v2:IsA("AlignOrientation")))))) then
			v2:Destroy()

			continue
		end

		if v2:IsA("BasePart") then
			v2.Massless = true
			v2.CanCollide = false
			v2.CanTouch = false
			v2.Anchored = false
			v2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			v2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		end
	end
end

local function v80(p1) --[[ v80 | Line: 250 | Upvalues: Assets (copy) ]]
	local PetTorso = Assets:FindFirstChild("PetTorso")

	if not PetTorso then
		return nil
	end

	local v1 = nil

	for v2, v3 in PetTorso:GetChildren() do
		local v4 = v3:Clone()

		v4.Parent = p1

		if v4.Name == "Tame" and v4:IsA("ParticleEmitter") then
			v4.Enabled = false
			v1 = v4
		end
	end

	return v1
end

local function _6(p1, p2) --[[ _ | Line: 268 ]]
	if not p1 then
		return
	end

	pcall(function() --[[ Line: 272 | Upvalues: p1 (copy), p2 (copy) ]]
		p1.Text = p2
	end)

	local TextLabel = p1:FindFirstChild("TextLabel")

	if not TextLabel then
		return
	end

	pcall(function() --[[ Line: 278 | Upvalues: TextLabel (copy), p2 (copy) ]]
		TextLabel.Text = p2
	end)
end

local function _7(p1, p2) --[[ _ | Line: 286 ]]
	if not p1 then
		return
	end

	table.insert(p2, p1)

	local TextLabel = p1:FindFirstChild("TextLabel")

	if not TextLabel then
		return
	end

	table.insert(p2, TextLabel)
end

local function v101(p1) --[[ v101 | Line: 307 ]]
	local v1 = (-1 / 0)
	local v2 = (1 / 0)

	for v3, v4 in p1:GetDescendants() do
		if v4:IsA("BasePart") then
			local Y = (v4.CFrame * CFrame.new(0, v4.Size.Y * 0.5, 0)).Y
			local Y2 = (v4.CFrame * CFrame.new(0, -v4.Size.Y * 0.5, 0)).Y

			if v1 < Y then
				v1 = Y
			end

			if Y2 < v2 then
				v2 = Y2
			end
		end
	end

	if v1 == (-1 / 0) then
		return 0
	end

	return v1 - v2
end

local function v117(p1, p2) --[[ v117 | Line: 328 | Upvalues: v101 (copy), PetCostTimer (copy), PetLeaveTimer (copy) ]]
	local v1 = v101(p1)
	local v2 = nil
	local v3 = nil
	local t = {}

	if PetCostTimer then
		local v4 = PetCostTimer:Clone()

		if v4:IsA("BillboardGui") then
			v4.StudsOffset = Vector3.new(0, v1 + 1, 0)
			v4.Adornee = p2
			v4.Parent = p2

			local TextLabel = v4:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("GuiObject") then
				v3 = TextLabel
			end

			if TextLabel and TextLabel:IsA("TextLabel") then
				table.insert(t, TextLabel)
			end

			if TextLabel then
				local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

				if TextLabel2 and TextLabel2:IsA("TextLabel") then
					table.insert(t, TextLabel2)
				end
			end

			v2 = v4
		else
			v4:Destroy()
		end
	end

	local v5 = nil
	local v6 = nil
	local t2 = {}

	if PetLeaveTimer then
		local v7 = PetLeaveTimer:Clone()

		if v7:IsA("BillboardGui") then
			v7.StudsOffset = Vector3.new(0, v1 + 1 + 1.5, 0)
			v7.Adornee = p2
			v7.Parent = p2

			local TextLabel = v7:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("GuiObject") then
				v6 = TextLabel
			end

			if TextLabel and TextLabel:IsA("TextLabel") then
				table.insert(t2, TextLabel)
			end

			if TextLabel then
				local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

				if TextLabel2 and TextLabel2:IsA("TextLabel") then
					table.insert(t2, TextLabel2)

					return v2, v3, t, v7, v6, t2
				end
			end

			v5 = v7
		else
			v7:Destroy()
		end
	end

	return v2, v3, t, v5, v6, t2
end

local function v130(p1) --[[ v130 | Line: 388 | Upvalues: v25 (copy), t2 (copy) ]]
	local RefPart = p1.RefPart

	if not (RefPart and RefPart.Parent) then
		return
	end

	local CostGui = p1.CostGui

	if not CostGui then
		return
	end

	if RefPart:GetAttribute("OwnerUserId") == nil then
		if not CostGui.Enabled then
			CostGui.Enabled = true
		end

		local v1 = RefPart:GetAttribute("Price")

		if type(v1) ~= "number" then
			return
		end

		local v2 = "\194\162" .. v25(v1)

		if v2 ~= p1.LastCostText then
			p1.LastCostText = v2

			for v3, v4 in p1.CostLabels do
				if v4 and v4.Parent then
					v4.Text = v2
				end
			end
		end

		local CostSizeTarget = p1.CostSizeTarget

		if not CostSizeTarget then
			return
		end

		local v7 = #tostring((math.floor((math.abs(v1)))))
		local v8 = if v7 <= 2 then t2[2] elseif t2[v7] then t2[v7] else UDim2.new((v7 - 7) * 0.075 + 0.65, 0, 0.722, 0)

		if CostSizeTarget.Size == v8 then
			return
		end

		pcall(function() --[[ Line: 434 | Upvalues: CostSizeTarget (copy), v8 (ref) ]]
			CostSizeTarget.Size = v8
		end)
	else
		if not CostGui.Enabled then
			return
		end

		CostGui.Enabled = false
	end
end

local function v143(p1) --[[ v143 | Line: 446 | Upvalues: v40 (copy), t4 (copy) ]]
	local RefPart = p1.RefPart

	if not (RefPart and RefPart.Parent) then
		return
	end

	local TimerGui = p1.TimerGui

	if not TimerGui then
		return
	end

	local v1 = RefPart:GetAttribute("OwnerUserId")

	if type(v1) == "number" and v1 ~= 0 then
		if not TimerGui.Enabled then
			return
		end

		TimerGui.Enabled = false
	else
		if not TimerGui.Enabled then
			TimerGui.Enabled = true
		end

		local v2 = RefPart:GetAttribute("SpawnedAt")
		local v3 = RefPart:GetAttribute("Lifetime")

		if type(v2) ~= "number" or type(v3) ~= "number" then
			return
		end

		local v4 = v40(v2 + v3 - os.time())

		if v4 == p1.LastTimerText then
			return
		end

		p1.LastTimerText = v4

		for v5, v6 in p1.TimerLabels do
			if v6 and v6.Parent then
				v6.Text = v4
			end
		end

		local TimerSizeTarget = p1.TimerSizeTarget

		if not TimerSizeTarget then
			return
		end

		local v7 = #v4
		local v8 = if v7 <= 2 then t4[2] elseif v7 >= 5 then t4[5] else t4[v7]

		if TimerSizeTarget.Size == v8 then
			return
		end

		pcall(function() --[[ Line: 486 | Upvalues: TimerSizeTarget (copy), v8 (copy) ]]
			TimerSizeTarget.Size = v8
		end)
	end
end

local function _8(p1) --[[ _ | Line: 499 | Upvalues: LocalPlayer (copy) ]]
	p1.Prompt.Enabled = p1.RefPart:GetAttribute("OwnerUserId") ~= LocalPlayer.UserId
end

local function _9(p1) --[[ _ | Line: 504 | Upvalues: v25 (copy) ]]
	local v1 = p1.RefPart:GetAttribute("Price")

	if type(v1) ~= "number" then
		return
	end

	p1.Prompt.ObjectText = "\194\162" .. v25(v1)
end

local function v163(p1, p2) --[[ v163 | Line: 511 ]]
	local v1 = (1 / 0)

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("BasePart") and v3.Transparency < 1 then
			local v4 = v3.CFrame
			local v5 = v3.Size.X * 0.5
			local v6 = v3.Size.Y * 0.5
			local v7 = v3.Size.Z * 0.5

			for i = -1, 1, 2 do
				for j = -1, 1, 2 do
					local Y = (v4 * CFrame.new(i * v5, j * v6, -1 * v7)).Y

					if Y < v1 then
						v1 = Y
					end

					local Y2 = (v4 * CFrame.new(i * v5, j * v6, 1 * v7)).Y

					if Y2 < v1 then
						v1 = Y2
					end
				end
			end
		end
	end

	if v1 == (1 / 0) then
		return
	end

	local v8 = p2.Position.Y - p2.Size.Y * 0.5 - v1

	if not (math.abs(v8) > 0.001) then
		return
	end

	p1:PivotTo(p1:GetPivot() + Vector3.new(0, v8, 0))
end

local function v176(p1) --[[ v176 | Line: 543 ]]
	local Y = p1:GetPivot().Position.Y
	local v1 = (1 / 0)

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("BasePart") and v3.Transparency < 1 then
			local v4 = v3.CFrame
			local v5 = v3.Size.X * 0.5
			local v6 = v3.Size.Y * 0.5
			local v7 = v3.Size.Z * 0.5

			for i = -1, 1, 2 do
				for j = -1, 1, 2 do
					local Y2 = (v4 * CFrame.new(i * v5, j * v6, -1 * v7)).Y

					if Y2 < v1 then
						v1 = Y2
					end

					local Y3 = (v4 * CFrame.new(i * v5, j * v6, 1 * v7)).Y

					if Y3 < v1 then
						v1 = Y3
					end
				end
			end
		end
	end

	if v1 == (1 / 0) then
		return 0
	end

	return Y - v1
end

local function v193(p1, p2, p3) --[[ v193 | Line: 572 ]]
	local t = {}
	local t2 = {}

	for v2, v3 in p2:GetChildren() do
		if v3:IsA("Animation") then
			t2[v3.Name] = v3
		end
	end

	local Animations = p2:FindFirstChild("Animations")

	if Animations then
		for v4, v5 in Animations:GetChildren() do
			if v5:IsA("Animation") then
				t2[v5.Name] = v5
			end
		end
	end

	for v6, v7 in p3 and p3.Animations or {} do
		local v8 = t2[v7]

		if v8 then
			local ok, result = pcall(function() --[[ Line: 592 | Upvalues: p1 (copy), v8 (copy) ]]
				return p1:LoadAnimation(v8)
			end)

			if ok and result then
				result.Looped = true
				t[v7] = result
			end
		end
	end

	return t
end

local t5 = { "Idle", "GroundIdle", "Fly" }
local t6 = { "Walk", "Fly", "GroundIdle" }

local function v206(p1, p2) --[[ v206 | Line: 614 | Upvalues: PetModules (copy), t5 (copy), t6 (copy) ]]
	if p1.CurrentState == p2 then
		return
	end

	p1.CurrentState = p2

	for v1, v2 in p1.Tracks do
		if v2.IsPlaying then
			v2:Stop(0.2)
		end
	end

	local v4 = PetModules[p1.PetName] and PetModules[p1.PetName].Animations or {}
	local v5 = nil

	if p2 == "idle" then
		v5 = t5
	elseif p2 == "walking" then
		v5 = t6
	end

	if v5 then
		for v6, v7 in v5 do
			local v8 = v4[v7]

			if v8 and p1.Tracks[v8] then
				p1.Tracks[v8]:Play(0.2)

				break
			end
		end
	end

	if p2 ~= "walking" then
		return
	end

	p1.NeedYawSnap = true
end

local function _10(p1) --[[ _ | Line: 648 ]]
	return if p1 == "walking_to_garden" then true else p1 == "wandering_walking"
end

local function v252(p1) --[[ v252 | Line: 655 | Upvalues: PetModules (copy), Pets (copy), v73 (copy), PetSizes (copy), v163 (copy), v176 (copy), v80 (copy), v117 (copy), v25 (copy), v43 (copy), PetTypes (copy), v193 (copy), v130 (copy), v143 (copy), v206 (copy), LocalPlayer (copy), Networking (copy), t3 (copy) ]]
	local v1 = p1:GetAttribute("PetName")

	if type(v1) ~= "string" or v1 == "" then
		return nil
	end

	local v2 = PetModules[v1]

	if not v2 then
		return nil
	end

	local v3 = Pets:FindFirstChild(v2.AssetName)

	if not (v3 and v3:IsA("Model")) then
		return nil
	end

	local v4 = p1:GetAttribute("Rarity")

	if type(v4) ~= "string" or v4 == "" then
		v4 = "Common"
	end

	local v5 = v3:Clone()

	v5.Name = "WildPet_" .. v1 .. "_" .. p1.Name
	v5:SetAttribute("PetName", v1)
	v5:SetAttribute("PetSize", p1:GetAttribute("PetSize"))
	v5:SetAttribute("PetType", p1:GetAttribute("PetType"))

	local PrimaryPart = v5.PrimaryPart

	if not PrimaryPart then
		local v6 = v5:FindFirstChild("RootPart") or v5:FindFirstChildWhichIsA("BasePart")

		if v6 then
			v5.PrimaryPart = v6
		end

		PrimaryPart = v6
	end

	if not PrimaryPart then
		v5:Destroy()

		return nil
	end

	v73(v5)
	PrimaryPart.Anchored = true

	local Pivot = v2.Pivot
	local identity = CFrame.identity

	if typeof(Pivot) == "Vector3" then
		identity = CFrame.Angles(math.rad(Pivot.X), math.rad(Pivot.Y), (math.rad(Pivot.Z)))
	end

	v5:PivotTo(p1.CFrame * identity)

	local v10 = PetSizes.GetScale(p1:GetAttribute("PetSize"), {
		Big = v2.BigScale,
		Huge = v2.HugeScale
	})

	if v10 ~= 1 then
		v5:ScaleTo(v10)
	end

	v163(v5, p1)

	local v11 = v176(v5)
	local v12 = v80(PrimaryPart)
	local Info_BB = PrimaryPart:FindFirstChild("Info_BB")

	if Info_BB then
		Info_BB:Destroy()
	end

	local function v225() --[[ v225 | Line: 713 ]] end

	local v13, v14, v15, v16, v17, v18 = v117(v5, PrimaryPart)
	local v19 = PrimaryPart:FindFirstChildOfClass("AnimationController") or v5:FindFirstChildOfClass("AnimationController")

	if not v19 then
		local AnimationController = Instance.new("AnimationController")

		AnimationController.Parent = v5
		v19 = AnimationController
	end

	local Animator = v19:FindFirstChildOfClass("Animator")

	if not Animator then
		local Animator2 = Instance.new("Animator")

		Animator2.Parent = v19
		Animator = Animator2
	end

	local BuyPrompt = Instance.new("ProximityPrompt")

	BuyPrompt.Name = "BuyPrompt"
	BuyPrompt.ActionText = "Buy"
	BuyPrompt.ObjectText = "\194\162" .. v25(p1:GetAttribute("Price") or 0)
	BuyPrompt.HoldDuration = 1
	BuyPrompt.MaxActivationDistance = 12
	BuyPrompt.RequiresLineOfSight = false
	BuyPrompt.Style = Enum.ProximityPromptStyle.Custom
	BuyPrompt.Parent = PrimaryPart
	v5.Parent = v43()

	if p1:GetAttribute("PetType") == PetTypes.Rainbow then
		v5:AddTag("PetRainbow")
	end

	local v20 = v193(Animator, v5, v2)
	local v21, v22, v23, v24, v252, v26, v27

	if v2.IsFlying == true then
		v21 = v16
		v22 = v17
		v23 = v18
		v24 = v13
		v252 = v14
		v26 = v15
		v27 = true
	else
		v21 = v16
		v22 = v17
		v23 = v18
		v24 = v13
		v252 = v14
		v26 = v15
		v27 = false
	end

	local v28 = if v27 then if v2.AlwaysFlying == true then true else false else v27
	local v29 = v27 and (v2.AirHeight or 5) * 0.6 or 0
	local t = {
		RefPart = p1,
		PetName = v1,
		Rarity = v4,
		Model = v5,
		Primary = PrimaryPart,
		Animator = Animator,
		Tracks = v20,
		CurrentState = "",
		CurrentCF = PrimaryPart.CFrame,
		LastYaw = 0,
		NeedYawSnap = true,
		FootOffset = v11,
		LastGroundY = nil,
		Prompt = BuyPrompt,
		TameParticle = v12,
		Connections = {},
		RarityCleanup = v225,
		CostGui = v24,
		CostSizeTarget = v252,
		CostLabels = v26,
		LastCostText = "",
		TimerGui = v21,
		TimerSizeTarget = v22,
		TimerLabels = v23,
		LastTimerText = "",
		IsFlying = v27,
		AlwaysFlying = v28,
		AirHeight = v29
	}

	t.LandDuration = v27 and v2.LandDuration or 0.8
	t.TakeoffDuration = v27 and v2.TakeoffDuration or 0.8
	t.FlightPhase = if v28 then "Flying" else "Grounded"
	t.FlightHeight = if v28 and v29 then v29 else 0
	t.FlightPhaseStartedAt = os.clock()
	t.LandingStartHeight = nil
	v130(t)
	v143(t)

	local v34 = v206
	local v35 = p1:GetAttribute("State")

	v34(t, if if v35 == "walking_to_garden" then true else v35 == "wandering_walking" then "walking" else "idle")
	t.Prompt.Enabled = if t.RefPart:GetAttribute("OwnerUserId") == nil then true else false

	local v40 = t.RefPart:GetAttribute("Price")

	if type(v40) == "number" then
		t.Prompt.ObjectText = "\194\162" .. v25(v40)
	end

	local function f42() --[[ Line: 800 | Upvalues: t (copy), v143 (ref), v130 (ref) ]]
		local v1 = t

		v1.Prompt.Enabled = v1.RefPart:GetAttribute("OwnerUserId") == nil
		v143(t)
		v130(t)
	end

	table.insert(t.Connections, p1:GetAttributeChangedSignal("OwnerUserId"):Connect(f42))

	local function f44() --[[ Line: 808 | Upvalues: v130 (ref), t (copy), v25 (ref) ]]
		v130(t)

		local v1 = t
		local v2 = v1.RefPart:GetAttribute("Price")

		if type(v2) ~= "number" then
			return
		end

		v1.Prompt.ObjectText = "\194\162" .. v25(v2)
	end

	table.insert(t.Connections, p1:GetAttributeChangedSignal("Price"):Connect(f44))

	local function f46() --[[ Line: 817 | Upvalues: p1 (copy), v206 (ref), t (copy) ]]
		local v1 = p1:GetAttribute("State")

		v206(t, if if v1 == "walking_to_garden" then true else v1 == "wandering_walking" then "walking" else "idle")
	end

	table.insert(t.Connections, p1:GetAttributeChangedSignal("State"):Connect(f46))

	local function f47(p12) --[[ Line: 828 | Upvalues: LocalPlayer (ref), Networking (ref), p1 (copy) ]]
		if p12 == LocalPlayer then
			Networking.Pets.WildPetTame:Fire(p1)
		end
	end

	table.insert(t.Connections, BuyPrompt.Triggered:Connect(f47))
	t3[p1] = t

	return t
end

local function v261(p1) --[[ v261 | Line: 844 | Upvalues: t3 (copy), v57 (copy) ]]
	local v1 = t3[p1]

	if not v1 then
		return
	end

	t3[p1] = nil

	if v1.Model and v1.Model.Parent then
		local ok, result = pcall(function() --[[ Line: 852 | Upvalues: v1 (copy) ]]
			return v1.Model:GetBoundingBox()
		end)

		if ok and result then
			v57(result)
		end
	end

	for v2, v3 in v1.Connections do
		pcall(function() --[[ Line: 861 | Upvalues: v3 (copy) ]]
			v3:Disconnect()
		end)
	end

	pcall(v1.RarityCleanup)

	for v4, v5 in v1.Tracks do
		pcall(function() --[[ Line: 868 | Upvalues: v5 (copy) ]]
			v5:Stop(0)
		end)
	end

	if not (v1.Model and v1.Model.Parent) then
		return
	end

	v1.Model:Destroy()
end

local v2 = RaycastParams.new()

v2.FilterType = Enum.RaycastFilterType.Exclude
v2.IgnoreWater = false
v2.RespectCanCollide = false

local v3 = RaycastParams.new()

v3.FilterType = Enum.RaycastFilterType.Exclude
v3.IgnoreWater = false
v3.RespectCanCollide = false

local function v270() --[[ v270 | Line: 887 | Upvalues: v1 (ref), Players (copy), v2 (copy) ]]
	local t = {}

	if v1 and v1.Parent then
		table.insert(t, v1)
	end

	local Map = workspace:FindFirstChild("Map")
	local v22 = if Map then Map:FindFirstChild("WildPetRef") else Map

	if v22 then
		table.insert(t, v22)
	end

	local v3 = if Map then Map:FindFirstChild("PetSpawn") else Map

	if v3 then
		table.insert(t, v3)
	end

	for v4, v5 in Players:GetPlayers() do
		if v5.Character then
			table.insert(t, v5.Character)
		end
	end

	v2.FilterDescendantsInstances = t
end

local function v278(p1, p2) --[[ v278 | Line: 909 | Upvalues: v2 (copy), v3 (copy) ]]
	local v1 = Vector3.new(p1.X, p2 + 10, p1.Z)
	local v22 = workspace:Raycast(v1, Vector3.new(0, -35, 0), v2)

	if not (v22 and v22.Instance) then
		return nil
	end

	local v32 = v22.Instance

	if v32.Transparency < 0.99 and v32.CanCollide then
		return v22.Position.Y
	end

	local v4 = table.clone(v2.FilterDescendantsInstances)

	table.insert(v4, v32)
	v3.FilterDescendantsInstances = v4

	for i = 1, 8 do
		local v5 = workspace:Raycast(v1, Vector3.new(0, -35, 0), v3)

		if not (v5 and v5.Instance) then
			break
		end

		local v6 = v5.Instance

		if v6.Transparency < 0.99 and v6.CanCollide then
			return v5.Position.Y
		end

		table.insert(v4, v6)
		v3.FilterDescendantsInstances = v4
	end

	return nil
end

local function v285(p1, p2) --[[ v285 | Line: 941 ]]
	local v1 = p1.AlwaysFlying or (if p1.CurrentState == "walking" then true else false)
	local FlightPhase = p1.FlightPhase

	if FlightPhase == "Grounded" then
		p1.FlightHeight = 0

		if v1 then
			p1.FlightPhaseStartedAt = p2
			FlightPhase = "Takeoff"
		end
	elseif FlightPhase == "Takeoff" then
		local v3 = math.clamp((p2 - p1.FlightPhaseStartedAt) / p1.TakeoffDuration, 0, 1)

		p1.FlightHeight = p1.AirHeight * v3

		if v1 then
			if v3 >= 1 then
				p1.FlightHeight = p1.AirHeight
				FlightPhase = "Flying"
			end
		else
			p1.FlightPhaseStartedAt = p2
			p1.LandingStartHeight = p1.FlightHeight
			FlightPhase = "Landing"
		end
	elseif FlightPhase == "Flying" then
		p1.FlightHeight = p1.AirHeight

		if not v1 then
			p1.FlightPhaseStartedAt = p2
			p1.LandingStartHeight = p1.AirHeight
			FlightPhase = "Landing"
		end
	elseif FlightPhase == "Landing" then
		local v5 = math.clamp((p2 - p1.FlightPhaseStartedAt) / p1.LandDuration, 0, 1)

		p1.FlightHeight = (p1.LandingStartHeight or p1.AirHeight) * (1 - v5)

		if v1 then
			p1.FlightPhaseStartedAt = p2
			FlightPhase = "Takeoff"
		elseif v5 >= 1 then
			p1.FlightHeight = 0
			FlightPhase = "Grounded"
		end
	end

	p1.FlightPhase = FlightPhase

	return p1.FlightHeight
end

local v4 = 0

local function v311(p1) --[[ v311 | Line: 983 | Upvalues: v4 (ref), t3 (copy), v143 (copy), v278 (copy), v285 (copy), PetModules (copy) ]]
	local v1 = math.min(1, p1 * 25)

	v4 = v4 + p1

	local v2 = v4 >= 0.25

	if v2 then
		v4 = 0
	end

	for v42, v5 in t3 do
		local v3

		if v42.Parent then
			if v2 then
				v143(v5)
			end

			local Model = v5.Model

			if Model and Model.PrimaryPart then
				local Position = v42.Position
				local v6 = v278(Position, Position.Y) or v5.LastGroundY or Position.Y
				local v7 = v5.LastGroundY or v6
				local v8 = v7 + (v6 - v7) * math.clamp(p1 * 18, 0, 1)

				v5.LastGroundY = v8

				local v10 = Vector3.new(Position.X, v8 + v5.FootOffset, Position.Z)

				v3 = if v5.IsFlying then v10 + Vector3.new(0, v285(v5, os.clock()), 0) else v10

				local Position2 = v5.CurrentCF.Position
				local v12 = Position2:Lerp(v3, v1)
				local v13 = v3.X - Position2.X
				local v14 = v3.Z - Position2.Z
				local v15 = if v13 * v13 + v14 * v14 > 0.01 then if v5.CurrentState == "walking" then true else false else false
				local LastYaw = v5.LastYaw

				if v15 then
					LastYaw = math.atan2(-v13, -v14)
				end

				if v5.NeedYawSnap and v15 then
					v5.LastYaw = LastYaw
					v5.NeedYawSnap = false
				else
					v5.LastYaw = v5.LastYaw + ((LastYaw - v5.LastYaw + math.pi) % 6.283185307179586 - math.pi) * math.clamp(p1 * 12, 0, 1)
				end

				local v19 = PetModules[v5.PetName]
				local v20 = if v19 then v19.Pivot else v19
				local identity = CFrame.identity

				if typeof(v20) == "Vector3" then
					identity = CFrame.Angles(math.rad(v20.X), math.rad(v20.Y), (math.rad(v20.Z)))
				end

				local v24 = CFrame.new(v12) * CFrame.Angles(0, v5.LastYaw, 0) * identity

				v5.CurrentCF = v24
				Model.PrimaryPart.CFrame = v24
			end
		end
	end
end

local function v314() --[[ v314 | Line: 1042 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character

	if not Character then
		return nil
	end

	local v1 = Character:FindFirstChild("RightHand") or (Character:FindFirstChild("Right Arm") or Character:FindFirstChild("HumanoidRootPart"))

	if v1 and v1:IsA("BasePart") then
		return v1.Position
	end

	return nil
end

local function v319(p1, p2) --[[ v319 | Line: 1056 | Upvalues: v63 (copy), v69 (copy), t3 (copy), LocalPlayer (copy), v314 (copy) ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("BasePart") then
		return
	end

	v63(p1.Position)
	v69("rbxassetid://88878105782114", p1.Position)

	local v1 = t3[p1]

	if v1 and (v1.TameParticle and v1.TameParticle.Parent) then
		v1.TameParticle:Emit(math.random(3, 4))
	end

	if p2 ~= LocalPlayer.UserId then
		return
	end

	local v2 = v314()

	if not v2 then
		return
	end

	v63(v2)
end

local function v324(p1) --[[ v324 | Line: 1076 | Upvalues: SoundService (copy) ]]
	if not (p1 and p1.Parent) then
		return
	end

	local HumanoidRootPart = (p1.Character or p1.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		local Sound = Instance.new("Sound")

		Sound.SoundId = "rbxassetid://80957204215480"
		Sound.Volume = 1
		Sound.RollOffMaxDistance = 700
		Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		Sound.Parent = HumanoidRootPart
		task.spawn(function() --[[ Line: 1091 | Upvalues: Sound (copy) ]]
			if not Sound.IsLoaded then
				Sound.Loaded:Wait()
			end

			Sound:Play()
			task.wait(math.max(if Sound.PlaybackSpeed > 0 then Sound.TimeLength / Sound.PlaybackSpeed or 0.5 else 0.5, 0.5) + 0.1)

			if not (Sound and Sound.Parent) then
				return
			end

			Sound:Destroy()
		end)
	end
end

local function v328(p1, p2) --[[ v328 | Line: 1107 | Upvalues: v324 (copy), LocalPlayer (copy), v314 (copy), v63 (copy) ]]
	v324(p1)

	if p1 ~= LocalPlayer then
		return
	end

	local v1 = v314()

	if not v1 then
		return
	end

	v63(v1)
end

local function v334(p1) --[[ v334 | Line: 1120 | Upvalues: PetTypes (copy), RunService (copy), RarityVisuals (copy), Debris (copy) ]]
	local Model = p1.Model

	if not (Model and Model.Parent) then
		return
	end

	local OwlAlertHighlight = Model:FindFirstChild("OwlAlertHighlight")

	if OwlAlertHighlight then
		OwlAlertHighlight:Destroy()
	end

	local OwlAlertHighlight2 = Instance.new("Highlight")

	OwlAlertHighlight2.Name = "OwlAlertHighlight"
	OwlAlertHighlight2.FillTransparency = 1
	OwlAlertHighlight2.OutlineTransparency = 0
	OwlAlertHighlight2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	OwlAlertHighlight2.Adornee = Model
	OwlAlertHighlight2.Parent = Model

	if p1.RefPart:GetAttribute("PetType") == PetTypes.Rainbow then
		local v1 = nil

		v1 = RunService.Heartbeat:Connect(function() --[[ Line: 1139 | Upvalues: OwlAlertHighlight2 (copy), v1 (ref) ]]
			if OwlAlertHighlight2.Parent then
				OwlAlertHighlight2.OutlineColor = Color3.fromHSV(tick() * 0.5 % 1, 1, 1)
			else
				v1:Disconnect()
			end
		end)
		task.delay(15, function() --[[ Line: 1149 | Upvalues: v1 (ref), OwlAlertHighlight2 (copy) ]]
			v1:Disconnect()

			if not (OwlAlertHighlight2 and OwlAlertHighlight2.Parent) then
				return
			end

			OwlAlertHighlight2:Destroy()
		end)
	else
		OwlAlertHighlight2.OutlineColor = RarityVisuals.GetStaticColor(p1.Rarity)
		Debris:AddItem(OwlAlertHighlight2, 15)
	end
end

local function v339(p1) --[[ v339 | Line: 1164 | Upvalues: t3 (copy), v334 (copy) ]]
	local v1 = os.clock() + 5

	while os.clock() < v1 do
		for v2, v3 in t3 do
			if v2.Name == p1 then
				v334(v3)

				return
			end
		end

		task.wait(0.05)
	end
end

function t.Init(p1) --[[ Line: 1181 ]] end
function t.Start(p1) --[[ Line: 1184 | Upvalues: v43 (copy), v270 (copy), Players (copy), v252 (copy), v261 (copy), RunService (copy), v311 (copy), Networking (copy), v319 (copy), v328 (copy), v339 (copy) ]]
	v43()
	v270()
	Players.PlayerAdded:Connect(v270)
	Players.PlayerRemoving:Connect(function(p1) --[[ Line: 1189 | Upvalues: v270 (ref) ]]
		task.defer(v270)
	end)

	for v1, v2 in Players:GetPlayers() do
		v2.CharacterAdded:Connect(function(p1) --[[ Line: 1194 | Upvalues: v270 (ref) ]]
			v270()
		end)
	end

	Players.PlayerAdded:Connect(function(p1) --[[ Line: 1199 | Upvalues: v270 (ref) ]]
		p1.CharacterAdded:Connect(function(p1) --[[ Line: 1201 | Upvalues: v270 (ref) ]]
			v270()
		end)
	end)
	task.spawn(function() --[[ Line: 1206 | Upvalues: v252 (ref), v261 (ref) ]]
		local Map = workspace:WaitForChild("Map", 30)

		if not Map then
			return
		end

		local function v354(p1) --[[ v354 | Line: 1212 | Upvalues: v252 (ref), v261 (ref) ]]
			for v1, v2 in p1:GetChildren() do
				if v2:IsA("BasePart") then
					v252(v2)
				end
			end

			p1.ChildAdded:Connect(function(p1) --[[ Line: 1219 | Upvalues: v252 (ref) ]]
				if not p1:IsA("BasePart") then
					return
				end

				v252(p1)
			end)
			p1.ChildRemoved:Connect(function(p1) --[[ Line: 1225 | Upvalues: v261 (ref) ]]
				if not p1:IsA("BasePart") then
					return
				end

				v261(p1)
			end)
		end

		local WildPetRef = Map:FindFirstChild("WildPetRef")

		if WildPetRef and WildPetRef:IsA("Folder") then
			v354(WildPetRef)
		else
			Map.ChildAdded:Connect(function(p1) --[[ Line: 1237 | Upvalues: v354 (copy) ]]
				if p1.Name ~= "WildPetRef" or not p1:IsA("Folder") then
					return
				end

				v354(p1)
			end)
		end
	end)
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 1247 | Upvalues: v311 (ref) ]]
		v311(p1)
	end)
	Networking.Pets.WildPetTameResult.OnClientEvent:Connect(function(p1, p2) --[[ Line: 1251 | Upvalues: v319 (ref) ]]
		pcall(v319, p1, p2)
	end)
	Networking.Pets.WildPetCollected.OnClientEvent:Connect(function(p1, p2) --[[ Line: 1255 | Upvalues: v328 (ref) ]]
		pcall(v328, p1, p2)
	end)
	Networking.SFX.OwlHoot.OnClientEvent:Connect(function(p1, p2) --[[ Line: 1259 | Upvalues: v339 (ref) ]]
		if type(p2) == "string" and p2 ~= "" then
			task.spawn(v339, p2)
		end
	end)
end

return t