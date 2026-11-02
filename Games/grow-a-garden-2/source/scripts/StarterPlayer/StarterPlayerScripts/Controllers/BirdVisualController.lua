--credit to prince games studio
local t = {
	StartOrder = 4
}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Robin = Assets:WaitForChild("Pets"):WaitForChild("Robin")
local PopVFX = Assets:WaitForChild("PopVFX")
local Birds = workspace:WaitForChild("Birds")
local BirdVisuals = Instance.new("Folder")

BirdVisuals.Name = "BirdVisuals"
BirdVisuals.Parent = workspace

local t2 = {}
local t3 = {}

Networking.Bird.Positions.OnClientEvent:Connect(function(p1) --[[ Line: 36 | Upvalues: t3 (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	for v1, v2 in p1 do
		local v3 = v2[1]
		local v4 = v2[2]

		if typeof(v3) == "Instance" and (v3:IsA("BasePart") and typeof(v4) == "Vector3") then
			t3[v3] = v4
		end
	end
end)
Networking.Bird.FruitEaten.OnClientEvent:Connect(function(p1) --[[ Line: 47 | Upvalues: PopVFX (copy), BirdVisuals (copy) ]]
	if typeof(p1) ~= "Vector3" then
		return
	end

	local v1 = PopVFX:Clone()

	if v1:IsA("BasePart") then
		v1.CFrame = CFrame.new(p1)
		v1.Parent = BirdVisuals
		game.Debris:AddItem(v1, 3)

		return
	end

	if not v1:IsA("Model") then
		local Model = Instance.new("Model")

		v1.Parent = Model
		Model.Parent = BirdVisuals
		Model:PivotTo(CFrame.new(p1))
		game.Debris:AddItem(Model, 3)

		return
	end

	v1:PivotTo(CFrame.new(p1))
	v1.Parent = BirdVisuals
	game.Debris:AddItem(v1, 3)

	for v2, v3 in v1:GetDescendants() do
		if v3:IsA("ParticleEmitter") then
			v3:Emit(v3:GetAttribute("EmitCount") or 50)
		end
	end
end)

local function setupVisualBird(p1) --[[ setupVisualBird | Line: 72 | Upvalues: t2 (copy), Robin (copy), t3 (copy), BirdVisuals (copy), SoundService (copy) ]]
	if t2[p1] then
		return
	end

	local v1 = Robin:Clone()

	v1.Name = "BirdVisual_" .. p1.Name

	local PrimaryPart = v1.PrimaryPart

	if PrimaryPart then
		PrimaryPart.Anchored = true
	end

	for v2, v3 in v1:GetDescendants() do
		if v3:IsA("BasePart") then
			v3.CanCollide = false
			v3.CanQuery = false
			v3.CanTouch = false

			if v3 ~= PrimaryPart then
				v3.Anchored = false
			end
		end
	end

	local v4 = t3[p1] or p1.Position
	local v5 = CFrame.new(v4)

	if PrimaryPart then
		v1:PivotTo(v5)
	end

	v1.Parent = BirdVisuals

	local v6

	if PrimaryPart then
		local Sound = Instance.new("Sound")

		Sound.SoundId = "rbxassetid://100707184833885"
		Sound.Volume = 0.2
		Sound.PlaybackSpeed = 1
		Sound.RollOffMaxDistance = 400
		Sound.RollOffMode = Enum.RollOffMode.InverseTapered
		Sound.Looped = true
		Sound.SoundGroup = SoundService:FindFirstChild("SFXGroup")
		Sound.Parent = PrimaryPart
		Sound:Play()
		v6 = Sound
	else
		v6 = nil
	end

	t2[p1] = {
		Part = p1,
		Model = v1,
		CurrentCF = v5,
		LastTargetPos = v4,
		Sound = v6
	}
end

local function cleanupVisualBird(p1) --[[ cleanupVisualBird | Line: 124 | Upvalues: t2 (copy), t3 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	if v1.Sound then
		v1.Sound:Stop()
	end

	if not v1.Model then
		t3[p1] = nil
		t2[p1] = nil

		return
	end

	v1.Model:Destroy()
	t3[p1] = nil
	t2[p1] = nil
end

function t.Init(p1) --[[ Init | Line: 133 ]] end
function t.Start(p1) --[[ Start | Line: 136 | Upvalues: Birds (copy), setupVisualBird (copy), t2 (copy), t3 (copy), RunService (copy) ]]
	for v1, v2 in Birds:GetChildren() do
		if v2:IsA("BasePart") then
			setupVisualBird(v2)
		end
	end

	Birds.ChildAdded:Connect(function(p1) --[[ Line: 143 | Upvalues: setupVisualBird (ref) ]]
		if not p1:IsA("BasePart") then
			return
		end

		setupVisualBird(p1)
	end)
	Birds.ChildRemoved:Connect(function(p1) --[[ Line: 149 | Upvalues: t2 (ref), t3 (ref) ]]
		if not p1:IsA("BasePart") then
			return
		end

		local v1 = t2[p1]

		if not v1 then
			return
		end

		if v1.Sound then
			v1.Sound:Stop()
		end

		if v1.Model then
			v1.Model:Destroy()
		end

		t3[p1] = nil
		t2[p1] = nil
	end)
	RunService.RenderStepped:Connect(function(p1) --[[ Line: 155 | Upvalues: t2 (ref), t3 (ref) ]]
		debug.profilebegin("Controllers/BirdVisualController/RenderStepped")

		local v1 = math.min(1, 14 * p1)

		for v3, v4 in t2 do
			local v2

			if v3 and v3.Parent then
				local Model = v4.Model

				if Model and Model.PrimaryPart then
					local v5 = t3[v3] or v3.Position
					local v6 = v4.CurrentCF.Position:Lerp(v5, v1)
					local v7 = v5.X - v4.LastTargetPos.X
					local v8 = v5.Z - v4.LastTargetPos.Z

					if v7 * v7 + v8 * v8 > 0.0001 then
						v2 = CFrame.lookAt(v6, v6 + Vector3.new(v7, (v5.Y - v4.LastTargetPos.Y) * 0.5, v8))
					else
						local _, v12, _2 = v4.CurrentCF:ToEulerAnglesYXZ()

						v2 = CFrame.new(v6) * CFrame.Angles(0, v12, 0)
					end

					v4.CurrentCF = v2
					Model.PrimaryPart.CFrame = v2
					v4.LastTargetPos = v5
				end

				continue
			end

			local v13 = t2[v3]

			if v13 then
				if v13.Sound then
					v13.Sound:Stop()
				end

				if v13.Model then
					v13.Model:Destroy()
				end

				t3[v3] = nil
				t2[v3] = nil
			end
		end

		debug.profileend()
	end)
end

return t