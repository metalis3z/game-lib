--credit to leon games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local t = {}
local t2 = {}

local function GetAssets() --[[ GetAssets | Line: 26 | Upvalues: ReplicatedStorage (copy) ]]
	return ReplicatedStorage:FindFirstChild("Assets")
end

local function FindDragonModel(p1) --[[ FindDragonModel | Line: 33 ]]
	local _PetVisualClient = workspace:FindFirstChild("_PetVisualClient")
	local v1 = if _PetVisualClient then _PetVisualClient:FindFirstChild("Models") else _PetVisualClient

	if not v1 then
		return nil
	end

	local v2 = p1.Parent and p1.Parent.Name

	for k, v in pairs(v1:GetChildren()) do
		if v:IsA("Model") and (v:GetAttribute("OwnerSlot") == p1.Name and (not v2 or v:GetAttribute("Owner") == v2)) then
			return v
		end
	end

	return nil
end

local function FindMouthPart(p1) --[[ FindMouthPart | Line: 49 ]]
	for k, v in pairs({ "Mouth", "FireOrigin", "Head" }) do
		local v1 = p1:FindFirstChild(v, true)

		if v1 and v1:IsA("BasePart") then
			return v1
		end
	end

	return p1.PrimaryPart
end

local function FindFireEmitterTemplate() --[[ FindFireEmitterTemplate | Line: 57 | Upvalues: ReplicatedStorage (copy) ]]
	local Assets = ReplicatedStorage:FindFirstChild("Assets")
	local v1 = if Assets then Assets:FindFirstChild("VFX") else Assets

	if not v1 then
		return nil
	end

	local OtherStorage = v1:FindFirstChild("OtherStorage")
	local v2 = if OtherStorage then OtherStorage:FindFirstChild("FireEmitter") else OtherStorage

	if v2 and v2:IsA("Attachment") then
		return v2
	end

	local StatusVFX = v1:FindFirstChild("StatusVFX")
	local v3 = if StatusVFX then StatusVFX:FindFirstChild("BurningVFX") else StatusVFX
	local v4 = if v3 then v3:FindFirstChild("fire") else v3

	if v4 and v4:IsA("ParticleEmitter") then
		return v4
	end

	return nil
end

local function GetHRP(p1) --[[ GetHRP | Line: 74 ]]
	if not p1 then
		return nil
	end

	local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
		return HumanoidRootPart
	end

	return nil
end

local function PlayFireBreath(p1, p2) --[[ PlayFireBreath | Line: 82 ]]
	local AnimationController = p1:FindFirstChildOfClass("AnimationController")
	local v1 = AnimationController and AnimationController:FindFirstChildOfClass("Animator")

	if not v1 then
		return
	end

	local Animations = p1:FindFirstChild("Animations")
	local v2 = p1:FindFirstChild("Animations") and Animations:FindFirstChild("FireBreath") or p1:FindFirstChild("FireBreath")

	if not (v2 and v2:IsA("Animation")) then
		return
	end

	local ok, result = pcall(function() --[[ Line: 92 | Upvalues: v1 (copy), v2 (copy) ]]
		return v1:LoadAnimation(v2)
	end)

	if ok and result then
		result.Looped = true
		result.Priority = Enum.AnimationPriority.Action
		result:Play(0.15)
		task.delay(p2, function() --[[ Line: 99 | Upvalues: result (copy) ]]
			if not (result and result.IsPlaying) then
				return
			end

			result:Stop(0.2)
		end)
	end
end

local function StartBeam(p1, p2, p3, p4) --[[ StartBeam | Line: 105 | Upvalues: FindMouthPart (copy), FindFireEmitterTemplate (copy), t2 (copy), PlayFireBreath (copy), RunService (copy), Debris (copy) ]]
	local v1 = FindMouthPart(p2)

	if not v1 then
		return
	end

	local BlackDragonFireBeam = Instance.new("Part")

	BlackDragonFireBeam.Name = "BlackDragonFireBeam"
	BlackDragonFireBeam.Anchored = true
	BlackDragonFireBeam.CanCollide = false
	BlackDragonFireBeam.CanQuery = false
	BlackDragonFireBeam.CanTouch = false
	BlackDragonFireBeam.Massless = true
	BlackDragonFireBeam.Transparency = 1
	BlackDragonFireBeam.Size = Vector3.new(0.2, 0.2, 1)
	BlackDragonFireBeam.Parent = workspace

	local v2 = FindFireEmitterTemplate()

	if v2 then
		local v3 = v2:Clone()

		v3.Parent = BlackDragonFireBeam
		v3.Position = Vector3.new(0, 0, -0.5)
	end

	local t = {}
	local v4 = t2[p1]

	if v4 and v4.Beam then
		v4.Token = t

		if v4.Beam.Parent then
			v4.Beam:Destroy()
		end
	end

	t2[p1] = {
		Token = t,
		Beam = BlackDragonFireBeam
	}
	PlayFireBreath(p2, p4)

	local v5 = os.clock() + p4
	local v6 = nil

	v6 = RunService.RenderStepped:Connect(function() --[[ Line: 139 | Upvalues: t2 (ref), p1 (copy), t (copy), v5 (copy), BlackDragonFireBeam (copy), v1 (copy), v6 (ref), p3 (copy) ]]
		local v12 = t2[p1]

		if v12 and (v12.Token == t and (not (v5 <= os.clock()) and (BlackDragonFireBeam.Parent and v1.Parent))) then
			local Position = v1.Position
			local v2 = p3
			local v3

			if v2 then
				local HumanoidRootPart = v2:FindFirstChild("HumanoidRootPart")

				v3 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart else nil
			else
				v3 = nil
			end

			local v4 = if v3 then v3.Position else Position + v1.CFrame.LookVector * 10
			local v52 = math.min((v4 - Position).Magnitude, 60)

			if v52 < 0.1 then
				v52 = 0.1
			end

			BlackDragonFireBeam.Size = Vector3.new(0.2, 0.2, v52)
			BlackDragonFireBeam.CFrame = CFrame.lookAt(Position, v4) * CFrame.new(0, 0, -v52 * 0.5)
			BlackDragonFireBeam.FireEmitter.WorldCFrame = CFrame.lookAt(Position, v4)
		else
			if not v6 then
				return
			end

			v6:Disconnect()
		end
	end)
	task.delay(p4, function() --[[ Line: 156 | Upvalues: v6 (ref), t2 (ref), p1 (copy), t (copy), BlackDragonFireBeam (copy), Debris (ref) ]]
		if v6 then
			v6:Disconnect()
		end

		local v1 = t2[p1]

		if v1 and v1.Token ~= t then
			return
		end

		t2[p1] = nil

		for k, v in pairs(BlackDragonFireBeam:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end

		Debris:AddItem(BlackDragonFireBeam, 2)
	end)
end

local function SetBurning(p1, p2) --[[ SetBurning | Line: 171 | Upvalues: CollectionService (copy), ReplicatedStorage (copy), Players (copy), Debris (copy) ]]
	local v1

	if p1 then
		local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

		v1 = if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then HumanoidRootPart else nil
	else
		v1 = nil
	end

	if not v1 then
		return
	end

	if p2 then
		for k, v in pairs(CollectionService:GetTagged("BlackDragonBurn")) do
			if v:IsDescendantOf(p1) then
				return
			end
		end

		local Assets = ReplicatedStorage:FindFirstChild("Assets")
		local v2 = if Assets then Assets:FindFirstChild("PetEffects") else Assets
		local v3 = if v2 then v2:FindFirstChild("BlackDragonPlayerFire") else v2

		if not v3 then
			return
		end

		local v4 = game.SoundService.SFX.burnEffect:Clone()

		v4.Parent = v1
		v4.Looped = true
		v4:AddTag("BlackDragonBurn")

		if p1 == Players.LocalPlayer.Character then
			local FireVignette = game.ReplicatedStorage.Assets.Vignette:Clone()

			FireVignette.ImageLabel.ImageColor3 = Color3.fromRGB(255, 35, 35)
			FireVignette.Parent = game.Players.LocalPlayer.PlayerGui
			FireVignette.ImageLabel.ImageTransparency = 0.6
			FireVignette.Name = "FireVignette"
			FireVignette:AddTag("BlackDragonBurn")
			game.TweenService:Create(FireVignette.ImageLabel.UIScale, TweenInfo.new(0.5), {
				Scale = 1.01
			}):Play()
			game.TweenService:Create(FireVignette.ImageLabel, TweenInfo.new(0.5), {
				ImageTransparency = 0.8
			}):Play()
		end

		for k, v in pairs(v3:GetChildren()) do
			local v5 = v:Clone()

			v5.Parent = v1

			if v5:IsA("ParticleEmitter") then
				v5.Enabled = true
			end

			v5:AddTag("BlackDragonBurn")
		end
	else
		for k, v in pairs(CollectionService:GetTagged("BlackDragonBurn")) do
			if v:IsDescendantOf(p1) then
				v:RemoveTag("BlackDragonBurn")

				if v:IsA("ParticleEmitter") then
					v.Enabled = false
				end

				if v:IsA("ScreenGui") then
					game.TweenService:Create(v.ImageLabel.UIScale, TweenInfo.new(0.5), {
						Scale = 1.06
					}):Play()
					game.TweenService:Create(v.ImageLabel, TweenInfo.new(0.5), {
						ImageTransparency = 1
					}):Play()
				end

				Debris:AddItem(v, 1)
			end
		end
	end
end

function t.Init(p1) --[[ Init | Line: 232 ]] end
function t.Start(p1) --[[ Start | Line: 234 | Upvalues: Networking (copy), FindDragonModel (copy), StartBeam (copy), SetBurning (copy) ]]
	Networking.BlackDragon.BreathStart.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 235 | Upvalues: FindDragonModel (ref), StartBeam (ref) ]]
		if typeof(p1) ~= "Instance" then
			return
		end

		if type(p3) ~= "number" or p3 <= 0 then
			return
		end

		local v1 = FindDragonModel(p1)

		if v1 then
			StartBeam(p1, v1, p2, p3)
		end
	end)
	Networking.BlackDragon.Ignite.OnClientEvent:Connect(function(p1, p2) --[[ Line: 243 | Upvalues: SetBurning (ref) ]]
		if typeof(p1) ~= "Instance" then
			return
		end

		SetBurning(p1, p2 == true)
	end)
end

return t