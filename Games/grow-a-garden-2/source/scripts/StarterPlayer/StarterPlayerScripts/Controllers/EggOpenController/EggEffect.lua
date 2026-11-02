--credit to quartz games studio
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local Bezier = require(ReplicatedStorage.ClientModules.Bezier)
local EggHatchAnim = require(script.Parent.EggHatchAnim)
local EggScreenShake = require(script.Parent.EggScreenShake)
local PetModules = require(ReplicatedStorage.SharedModules.PetModules)
local PetData = require(ReplicatedStorage.SharedData.PetData)
local PetSizes = require(ReplicatedStorage.SharedData.PetSizes)
local AnimatedGradient = require(ReplicatedStorage.SharedModules.AnimatedGradient)
local v1 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 128, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 0)),
	ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 128, 255)),
	ColorSequenceKeypoint.new(0.83, Color3.fromRGB(128, 0, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Eggs = Assets:WaitForChild("Eggs")
local Pets = Assets:WaitForChild("Pets")
local RarityData = ReplicatedStorage.SharedModules.RarityData
local EggEffects = Assets:FindFirstChild("EggEffects")
local Quad = Enum.EasingStyle.Quad
local v2 = Random.new()
local Exponential = Enum.EasingStyle.Exponential
local Quad2 = Enum.EasingStyle.Quad
local t2 = { "rbxassetid://89897463147043", "rbxassetid://84124106284739", "rbxassetid://109098770620406", "rbxassetid://109098770620406" }
local t3 = { "rbxassetid://92457414302766", "rbxassetid://105505525581659", "rbxassetid://105012703607081", "rbxassetid://105012703607081" }
local t4 = { "rbxassetid://88608751101502", "rbxassetid://78796672742221" }
local LocalPlayer = Players.LocalPlayer
local EggOpenSoundCache = Instance.new("Folder")

EggOpenSoundCache.Name = "EggOpenSoundCache"
EggOpenSoundCache.Parent = SoundService

local t5 = {}

local function RegisterSoundTemplate(p1) --[[ RegisterSoundTemplate | Line: 155 | Upvalues: t5 (copy), EggOpenSoundCache (copy) ]]
	if not t5[p1] then
		local Sound = Instance.new("Sound")

		Sound.SoundId = p1
		Sound.Parent = EggOpenSoundCache
		t5[p1] = Sound
	end
end

if not t5["rbxassetid://121132824785522"] then
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://121132824785522"
	Sound.Parent = EggOpenSoundCache
	t5["rbxassetid://121132824785522"] = Sound
end

if not t5["rbxassetid://104869826618847"] then
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://104869826618847"
	Sound.Parent = EggOpenSoundCache
	t5["rbxassetid://104869826618847"] = Sound
end

if not t5["rbxassetid://78426714974899"] then
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://78426714974899"
	Sound.Parent = EggOpenSoundCache
	t5["rbxassetid://78426714974899"] = Sound
end

if not t5["rbxassetid://116376053254864"] then
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://116376053254864"
	Sound.Parent = EggOpenSoundCache
	t5["rbxassetid://116376053254864"] = Sound
end

if not t5["rbxassetid://131003613792899"] then
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://131003613792899"
	Sound.Parent = EggOpenSoundCache
	t5["rbxassetid://131003613792899"] = Sound
end

if not t5["rbxassetid://93813602862073"] then
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxassetid://93813602862073"
	Sound.Parent = EggOpenSoundCache
	t5["rbxassetid://93813602862073"] = Sound
end

for v3, v4 in t2 do
	if not t5[v4] then
		local Sound = Instance.new("Sound")

		Sound.SoundId = v4
		Sound.Parent = EggOpenSoundCache
		t5[v4] = Sound
	end
end

for v5, v6 in t3 do
	if not t5[v6] then
		local Sound = Instance.new("Sound")

		Sound.SoundId = v6
		Sound.Parent = EggOpenSoundCache
		t5[v6] = Sound
	end
end

for v7, v8 in t4 do
	if not t5[v8] then
		local Sound = Instance.new("Sound")

		Sound.SoundId = v8
		Sound.Parent = EggOpenSoundCache
		t5[v8] = Sound
	end
end

local function CreateSFX(p1, p2, p3) --[[ CreateSFX | Line: 181 | Upvalues: SoundService (copy) ]]
	local Sound = Instance.new("Sound")

	Sound.SoundId = p2
	Sound.Volume = 1.75
	Sound.RollOffMaxDistance = 200
	Sound.Looped = if p3 == true then true else false

	local SFXGroup = SoundService:FindFirstChild("SFXGroup")

	if SFXGroup and SFXGroup:IsA("SoundGroup") then
		Sound.SoundGroup = SFXGroup
	end

	Sound.Parent = p1

	return Sound
end

local function PlaySFX(p1, p2) --[[ PlaySFX | Line: 195 | Upvalues: SoundService (copy), Debris (copy) ]]
	if not p1 then
		return
	end

	if not p2 or (p2 == "" or p2 == "rbxassetid://0") then
		return
	end

	local Sound = Instance.new("Sound")

	Sound.SoundId = p2
	Sound.Volume = 1.75
	Sound.RollOffMaxDistance = 200
	Sound.Looped = false

	local SFXGroup = SoundService:FindFirstChild("SFXGroup")

	if SFXGroup and SFXGroup:IsA("SoundGroup") then
		Sound.SoundGroup = SFXGroup
	end

	Sound.Parent = p1
	Sound:Play()
	Debris:AddItem(Sound, 5)
end

local function PlayOwnerAwareSFX(p1, p2, p3, p4) --[[ PlayOwnerAwareSFX | Line: 203 | Upvalues: t5 (copy), SoundService (copy), Debris (copy) ]]
	local v1 = t5[p3]
	local v2 = if v1 then v1:Clone() else Instance.new("Sound")

	v2.SoundId = p3
	v2.Volume = p4 or 2

	local SFXGroup = SoundService:FindFirstChild("SFXGroup")

	if SFXGroup and SFXGroup:IsA("SoundGroup") then
		v2.SoundGroup = SFXGroup
	end

	v2.RollOffMaxDistance = 250
	v2.Parent = p1
	v2:Play()
	Debris:AddItem(v2, 5)
end

local function SetTrailEnabled(p1, p2) --[[ SetTrailEnabled | Line: 221 ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("Trail") or (v2:IsA("ParticleEmitter") or v2:IsA("Beam")) then
			v2.Enabled = p2
		end
	end
end

local function GroundBelow(p1) --[[ GroundBelow | Line: 231 ]]
	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Exclude

	local Temporary = workspace:FindFirstChild("Temporary")

	if Temporary then
		v1.FilterDescendantsInstances = { Temporary }
	end

	local v2 = workspace:Raycast(p1 + Vector3.new(0, 5, 0), Vector3.new(0, -50, 0), v1)

	if v2 then
		return v2.Position
	end

	return p1
end

local function PivotCFrameFor(p1) --[[ PivotCFrameFor | Line: 245 ]]
	local v1 = if p1 then p1.Pivot else p1

	if typeof(v1) == "Vector3" then
		return CFrame.Angles(math.rad(v1.X), math.rad(v1.Y), (math.rad(v1.Z)))
	end

	return CFrame.identity
end

local function EnsureAnimator(p1) --[[ EnsureAnimator | Line: 253 ]]
	local AnimationController = p1:FindFirstChildOfClass("AnimationController")

	if not AnimationController then
		local AnimationController2 = Instance.new("AnimationController")

		AnimationController2.Parent = p1
		AnimationController = AnimationController2
	end

	local Animator = AnimationController:FindFirstChildOfClass("Animator")

	if not Animator then
		local Animator2 = Instance.new("Animator")

		Animator2.Parent = AnimationController
		Animator = Animator2
	end

	return Animator
end

local function FindWalkAnimation(p1, p2) --[[ FindWalkAnimation | Line: 270 ]]
	local Animations = p1:FindFirstChild("Animations")

	local function lookup(p12) --[[ lookup | Line: 272 | Upvalues: Animations (copy), p1 (copy) ]]
		if not p12 or p12 == "" then
			return nil
		end

		local v1 = Animations and Animations:FindFirstChild(p12) or p1:FindFirstChild(p12)

		if v1 and v1:IsA("Animation") then
			return v1
		end

		return nil
	end

	local v1 = if p2 then p2.Animations else p2
	local v2 = Animations and Animations:FindFirstChild("Walk") or p1:FindFirstChild("Walk")
	local v3 = if v2 and v2:IsA("Animation") then v2 else nil

	if not v3 and v1 then
		local Walk = v1.Walk

		if Walk and Walk ~= "" then
			local v4 = Animations and Animations:FindFirstChild(Walk) or p1:FindFirstChild(Walk)

			v3 = if v4 and v4:IsA("Animation") then v4 else nil
		else
			v3 = nil
		end

		if not v3 then
			local Fly = v1.Fly

			if Fly and Fly ~= "" then
				local v5 = Animations and Animations:FindFirstChild(Fly) or p1:FindFirstChild(Fly)

				v3 = if v5 and v5:IsA("Animation") then v5 else nil
			else
				v3 = nil
			end

			if not v3 then
				local GroundIdle = v1.GroundIdle

				if GroundIdle and GroundIdle ~= "" then
					local v6 = Animations and Animations:FindFirstChild(GroundIdle) or p1:FindFirstChild(GroundIdle)

					v3 = if v6 and v6:IsA("Animation") then v6 else nil
				else
					v3 = nil
				end

				if not v3 then
					local Idle = v1.Idle

					if Idle and Idle ~= "" then
						local v7 = Animations and Animations:FindFirstChild(Idle) or p1:FindFirstChild(Idle)

						v3 = if v7 and v7:IsA("Animation") then v7 else nil
					else
						v3 = nil
					end
				end
			end
		end
	elseif not v3 then
		v3 = v1
	end

	if v3 then
		return v3
	end

	if Animations then
		for v8, v9 in Animations:GetChildren() do
			if v9:IsA("Animation") then
				return v9
			end
		end
	end

	for v10, v11 in p1:GetDescendants() do
		if v11:IsA("Animation") then
			return v11
		end
	end

	return nil
end

local function FindIdleAnimation(p1, p2) --[[ FindIdleAnimation | Line: 296 ]]
	local Animations = p1:FindFirstChild("Animations")

	local function lookup(p12) --[[ lookup | Line: 298 | Upvalues: Animations (copy), p1 (copy) ]]
		if not p12 or p12 == "" then
			return nil
		end

		local v1 = Animations and Animations:FindFirstChild(p12) or p1:FindFirstChild(p12)

		if v1 and v1:IsA("Animation") then
			return v1
		end

		return nil
	end

	local v1 = if p2 then p2.Animations else p2
	local v2 = Animations and Animations:FindFirstChild("Idle") or p1:FindFirstChild("Idle")
	local v3 = if v2 and v2:IsA("Animation") then v2 else nil

	if not v3 and v1 then
		local Idle = v1.Idle

		if Idle and Idle ~= "" then
			local v4 = Animations and Animations:FindFirstChild(Idle) or p1:FindFirstChild(Idle)

			v3 = if v4 and v4:IsA("Animation") then v4 else nil
		else
			v3 = nil
		end

		if not v3 then
			local GroundIdle = v1.GroundIdle

			if GroundIdle and GroundIdle ~= "" then
				local v5 = Animations and Animations:FindFirstChild(GroundIdle) or p1:FindFirstChild(GroundIdle)

				v3 = if v5 and v5:IsA("Animation") then v5 else nil
			else
				v3 = nil
			end

			if not v3 then
				local Fly = v1.Fly

				if not Fly or Fly == "" then
					return nil
				end

				local v6 = Animations and Animations:FindFirstChild(Fly) or p1:FindFirstChild(Fly)

				if v6 and v6:IsA("Animation") then
					return v6
				end

				v3 = nil
			end
		end
	elseif not v3 then
		v3 = v1
	end

	return v3
end

local function LowestWorldY(p1) --[[ LowestWorldY | Line: 312 ]]
	local v1 = (1 / 0)

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("BasePart") then
			local v4 = v3.CFrame
			local Size = v3.Size
			local v5 = Size.X / 2
			local v6 = Size.Y / 2
			local v7 = Size.Z / 2

			for i = -1, 1, 2 do
				for j = -1, 1, 2 do
					local Y = (v4 * Vector3.new(i * v5, j * v6, -1 * v7)).Y

					if Y < v1 then
						v1 = Y
					end

					local Y2 = (v4 * Vector3.new(i * v5, j * v6, 1 * v7)).Y

					if Y2 < v1 then
						v1 = Y2
					end
				end
			end
		end
	end

	return v1
end

local function HighestWorldY(p1) --[[ HighestWorldY | Line: 333 ]]
	local v1 = (-1 / 0)

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("BasePart") then
			local v4 = v3.CFrame
			local Size = v3.Size
			local v5 = Size.X / 2
			local v6 = Size.Y / 2
			local v7 = Size.Z / 2

			for i = -1, 1, 2 do
				for j = -1, 1, 2 do
					local Y = (v4 * Vector3.new(i * v5, j * v6, -1 * v7)).Y

					if v1 < Y then
						v1 = Y
					end

					local Y2 = (v4 * Vector3.new(i * v5, j * v6, 1 * v7)).Y

					if v1 < Y2 then
						v1 = Y2
					end
				end
			end
		end
	end

	return v1
end

local function SetLabelText(p1, p2) --[[ SetLabelText | Line: 353 ]]
	if not p1 then
		return
	end

	if p1:IsA("TextLabel") then
		p1.Text = p2
	end

	local TextLabel = p1:FindFirstChild("TextLabel")

	if not (TextLabel and TextLabel:IsA("TextLabel")) then
		return
	end

	TextLabel.Text = p2
end

local function SetLabelScale(p1, p2) --[[ SetLabelScale | Line: 360 ]]
	if not p1 then
		return
	end

	local UIScale = p1:FindFirstChild("UIScale")

	if not (UIScale and UIScale:IsA("UIScale")) then
		return
	end

	UIScale.Scale = p2
end

local function ApplyRainbow(p1) --[[ ApplyRainbow | Line: 371 | Upvalues: v1 (copy), AnimatedGradient (copy) ]]
	if not p1 then
		return
	end

	local function apply(p1) --[[ apply | Line: 373 | Upvalues: v1 (ref), AnimatedGradient (ref) ]]
		if p1 and p1:IsA("TextLabel") then
			p1.TextColor3 = Color3.new(255/255, 255/255, 255/255)

			local UIGradient = Instance.new("UIGradient")

			UIGradient.Color = v1
			UIGradient.Parent = p1
			AnimatedGradient:Add(UIGradient)
		end
	end

	for v12, v2 in p1:GetChildren() do
		if v2:IsA("TextLabel") then
			apply(v2)
		end
	end
end

local function CreateLabel(p1, p2, p3, p4) --[[ CreateLabel | Line: 389 | Upvalues: Assets (copy), PetData (copy), ApplyRainbow (copy), RarityData (copy), TweenService (copy), Debris (copy) ]]
	local SeedNameAttachment = Assets:FindFirstChild("SeedNameAttachment")

	if not SeedNameAttachment then
		return nil
	end

	local v1 = SeedNameAttachment:Clone()

	v1.Position = p3

	local BillboardGui = v1:FindFirstChild("BillboardGui")

	if not BillboardGui then
		v1.Parent = workspace.Temporary

		return v1, function() --[[ Line: 399 | Upvalues: v1 (copy) ]]
			v1:Destroy()
		end
	end

	local Seed_Name = BillboardGui:FindFirstChild("Seed_Name")
	local Rarity_Name = BillboardGui:FindFirstChild("Rarity_Name")
	local v2

	if p2 and (p2 ~= "" and (Rarity_Name and Rarity_Name:IsA("GuiObject"))) then
		local function fitLine(p1) --[[ fitLine | Line: 409 ]]
			p1.Size = UDim2.new(p1.Size.X.Scale, p1.Size.X.Offset, 0.3, 0)
		end

		local Type_Name = Rarity_Name:Clone()

		Type_Name.Name = "Type_Name"
		Type_Name.LayoutOrder = 1
		Type_Name.Size = UDim2.new(Type_Name.Size.X.Scale, Type_Name.Size.X.Offset, 0.3, 0)
		Type_Name.Parent = BillboardGui
		v2 = Type_Name
		Rarity_Name.LayoutOrder = 2
		Rarity_Name.Size = UDim2.new(Rarity_Name.Size.X.Scale, Rarity_Name.Size.X.Offset, 0.3, 0)

		if Seed_Name and Seed_Name:IsA("GuiObject") then
			Seed_Name.LayoutOrder = 0
			Seed_Name.Size = UDim2.new(Seed_Name.Size.X.Scale, Seed_Name.Size.X.Offset, 0.3, 0)
		end

		if BillboardGui:IsA("BillboardGui") then
			BillboardGui.Size = UDim2.new(BillboardGui.Size.X.Scale, BillboardGui.Size.X.Offset, 4.5, 0)
		end
	else
		v2 = nil
	end

	if Seed_Name then
		local UIScale = Seed_Name:FindFirstChild("UIScale")

		if UIScale and UIScale:IsA("UIScale") then
			UIScale.Scale = 0
		end
	end

	if Rarity_Name then
		local UIScale = Rarity_Name:FindFirstChild("UIScale")

		if UIScale and UIScale:IsA("UIScale") then
			UIScale.Scale = 0
		end
	end

	local v3 = v2

	if v3 then
		local UIScale = v3:FindFirstChild("UIScale")

		if UIScale and UIScale:IsA("UIScale") then
			UIScale.Scale = 0
		end
	end

	local v4 = PetData.GetDisplayName(p1, p4)

	if Seed_Name then
		if Seed_Name:IsA("TextLabel") then
			Seed_Name.Text = v4
		end

		local TextLabel = Seed_Name:FindFirstChild("TextLabel")

		if TextLabel and TextLabel:IsA("TextLabel") then
			TextLabel.Text = v4
		end
	end

	if v2 then
		local v5 = v2

		if v5 then
			if v5:IsA("TextLabel") then
				v5.Text = p2
			end

			local TextLabel = v5:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.Text = p2
			end
		end

		ApplyRainbow(v2)
	end

	local v6 = PetData[p1] and PetData[p1].Rarity

	if v6 then
		if Rarity_Name then
			if Rarity_Name:IsA("TextLabel") then
				Rarity_Name.Text = v6
			end

			local TextLabel = Rarity_Name:FindFirstChild("TextLabel")

			if TextLabel and TextLabel:IsA("TextLabel") then
				TextLabel.Text = v6
			end
		end

		local Gradients = RarityData:FindFirstChild("Gradients")
		local v7 = if Gradients then Gradients:FindFirstChild(v6) else Gradients

		if v7 and Rarity_Name then
			local TextLabel = Rarity_Name:FindFirstChild("TextLabel")

			if TextLabel then
				v7:Clone().Parent = TextLabel
			end

			v7:Clone().Parent = Rarity_Name
		end
	end

	v1.Parent = workspace.Temporary

	local function popIn(p1, p2) --[[ popIn | Line: 463 | Upvalues: TweenService (ref) ]]
		if not p1 then
			return
		end

		local UIScale = p1:FindFirstChild("UIScale")

		if not (UIScale and UIScale:IsA("UIScale")) then
			return
		end

		task.delay(p2, function() --[[ Line: 467 | Upvalues: UIScale (copy), TweenService (ref) ]]
			if not UIScale.Parent then
				return
			end

			TweenService:Create(UIScale, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
				Scale = 1
			}):Play()
		end)
	end

	popIn(Seed_Name, 0)
	popIn(v2, 0.1)
	popIn(Rarity_Name, 0.15)

	return v1, function() --[[ popOut | Line: 478 | Upvalues: TweenService (ref), Seed_Name (copy), v2 (ref), Rarity_Name (copy), Debris (ref), v1 (copy) ]]
		local function shrink(p1) --[[ shrink | Line: 479 | Upvalues: TweenService (ref) ]]
			if not p1 then
				return
			end

			local UIScale = p1:FindFirstChild("UIScale")

			if not (UIScale and UIScale:IsA("UIScale")) then
				return
			end

			TweenService:Create(UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
				Scale = 0
			}):Play()
		end

		shrink(Seed_Name)
		shrink(v2)
		shrink(Rarity_Name)
		Debris:AddItem(v1, 0.6000000000000001)
	end
end

local function PreparePet(p1) --[[ PreparePet | Line: 497 ]]
	local v1 = p1.PrimaryPart or (p1:FindFirstChild("Torso") or (p1:FindFirstChild("HumanoidRootPart") or (p1:FindFirstChild("RootPart") or p1:FindFirstChildWhichIsA("BasePart"))))

	if not v1 then
		return nil
	end

	p1.PrimaryPart = v1

	for v2, v3 in p1:GetDescendants() do
		if v3:IsA("BasePart") then
			v3.CanCollide = false
			v3.CanQuery = false
			v3.CanTouch = false
			v3.Massless = true
			v3.Anchored = v3 == v1
		end
	end

	return v1
end

local function PlayReveal(p1, p2, p3, p4, p5, p6) --[[ PlayReveal | Line: 523 | Upvalues: PetModules (copy), Pets (copy), Assets (copy), PreparePet (copy), PetSizes (copy), LowestWorldY (copy), EnsureAnimator (copy), FindIdleAnimation (copy), CreateLabel (copy), HighestWorldY (copy), RunService (copy), FindWalkAnimation (copy), TweenService (copy), Quad2 (copy) ]]
	local v1 = PetModules[p1]
	local v2, v3, v4

	if Pets then
		v2 = Pets:FindFirstChild(v1 and v1.AssetName or p1)

		if not v2 then
			v3 = Assets
			v4 = v1 and v1.AssetName or p1
			v2 = Assets:FindFirstChild(v4)
		end
	else
		v3 = Assets
		v4 = v1 and v1.AssetName or p1
		v2 = Assets:FindFirstChild(v4)
	end

	if not (v2 and v2:IsA("Model")) then
		return
	end

	local v7 = v2:Clone()
	local v8 = PreparePet(v7)

	if not v8 then
		v7:Destroy()

		return
	end

	local v11 = PetSizes.GetScale(p5, if v1 then {
	Big = v1.BigScale,
	Huge = v1.HugeScale
} else nil)

	if v11 ~= 1 then
		v7:ScaleTo(v11)
	end

	local v12 = if v1 then v1.Pivot else v1
	local v13 = if typeof(v12) == "Vector3" then CFrame.Angles(math.rad(v12.X), math.rad(v12.Y), (math.rad(v12.Z))) else CFrame.identity
	local v16 = p2 + Vector3.new(0, 0, 0)

	local function resolveHrp() --[[ resolveHrp | Line: 545 | Upvalues: p4 (copy) ]]
		local v1 = p4 and p4.Character
		local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1

		if v2 and v2:IsA("BasePart") then
			return v2
		end

		return nil
	end

	local v17 = if p4 then p4.Character else p4
	local v18 = if v17 then v17:FindFirstChild("HumanoidRootPart") else v17
	local v19 = if v18 and v18:IsA("BasePart") then v18 else nil

	v7:PivotTo(CFrame.lookAt(v16, v19 and Vector3.new(v19.Position.X, v16.Y, v19.Position.Z) or v16 + p3 * Vector3.new(1, 0, 1)) * v13)
	v7.Parent = workspace.Temporary

	local v21 = LowestWorldY(v7)

	if v21 ~= (1 / 0) then
		local v22 = p2.Y + 0 - v21

		if math.abs(v22) > 0.001 then
			v7:PivotTo(v7:GetPivot() + Vector3.new(0, v22, 0))
		end
	end

	if p6 == "Rainbow" then
		v7:AddTag("PetRainbow")
	end

	local v23 = EnsureAnimator(v7)
	local v24 = FindIdleAnimation(v7, v1)
	local v25

	if v24 then
		local v26 = v23:LoadAnimation(v24)

		v26.Looped = true
		v26:Play()
		v25 = v26
	else
		v25 = nil
	end

	local v27, v28 = CreateLabel(p1, p6, v16, p5)
	local v29 = HighestWorldY(v7)
	local v30 = 3
	local v31

	if v27 then
		local BillboardGui = v27:FindFirstChild("BillboardGui")

		if BillboardGui and BillboardGui:IsA("BillboardGui") then
			v30 = BillboardGui.Size.Y.Scale
		end

		v31 = v29 - v8.Position.Y + v30 / 2 + 1
		v27.Position = v8.Position + Vector3.new(0, v31, 0)
	else
		v31 = 1
	end

	local v32 = true
	local v33 = RunService.RenderStepped:Connect(function(p1) --[[ Line: 609 | Upvalues: v32 (ref), v8 (copy), p4 (copy), v13 (copy), v27 (copy), v31 (ref) ]]
		if not v32 then
			return
		end

		if not (v8 and v8.Parent) then
			return
		end

		local v1 = p4 and p4.Character
		local v2 = if v1 then v1:FindFirstChild("HumanoidRootPart") else v1
		local v3 = if v2 and v2:IsA("BasePart") then v2 else nil
		local Position = v8.Position

		if v3 then
			v8.CFrame = v8.CFrame:Lerp(CFrame.lookAt(Position, (Vector3.new(v3.Position.X, Position.Y, v3.Position.Z))) * v13, (math.clamp(p1 * 8, 0, 1)))
		end

		if not (v27 and v27.Parent) then
			return
		end

		v27.Position = Position + Vector3.new(0, v31, 0)
	end)

	task.wait(5)
	v32 = false

	if v33 then
		v33:Disconnect()
	end

	if v28 then
		v28()
	end

	if v25 then
		v25:Stop(0.1)
	end

	local function leapScale(p1) --[[ leapScale | Line: 633 | Upvalues: v11 (copy) ]]
		return math.max(v11 * ((if p1 > 0.7 then (p1 - 0.7) / 0.30000000000000004 else 0) * -0.95 + 1), 0.01)
	end

	local v34 = if p4 then p4.Character else p4
	local v35 = if v34 then v34:FindFirstChild("HumanoidRootPart") else v34

	if if v35 and v35:IsA("BasePart") then v35 else nil then
		local v37 = FindWalkAnimation(v7, v1)
		local v38

		if v37 then
			local v39 = v23:LoadAnimation(v37)

			v39.Looped = true
			v39:Play()
			v38 = v39
		else
			v38 = nil
		end

		local Position = v8.Position
		local sum = 0

		while sum < 0.6 do
			local v40

			sum = sum + RunService.Heartbeat:Wait()

			local v41 = TweenService:GetValue(sum / 0.6, Quad2, Enum.EasingDirection.Out)
			local v42 = if p4 then p4.Character else p4
			local v43 = if v42 then v42:FindFirstChild("HumanoidRootPart") else v42

			v40 = if v43 and v43:IsA("BasePart") then v43 else nil

			local v44 = v40 and v40.Position or Position
			local v45 = (1 - v41) ^ 2 * Position + 2 * (1 - v41) * v41 * ((Position + v44) / 2 + Vector3.new(0, 8, 0)) + v41 ^ 2 * v44

			v7:ScaleTo((math.max(v11 * ((if v41 > 0.7 then (v41 - 0.7) / 0.30000000000000004 else 0) * -0.95 + 1), 0.01)))

			local v47 = Vector3.new(v44.X, v45.Y, v44.Z)

			if (v47 - v45).Magnitude > 0.001 then
				v8.CFrame = CFrame.lookAt(v45, v47) * v13
			else
				v8.CFrame = CFrame.new(v45) * v8.CFrame.Rotation
			end
		end

		if v38 then
			v38:Stop(0)
		end
	else
		local sum = 0

		while sum < 0.6 do
			sum = sum + RunService.Heartbeat:Wait()

			local v48 = TweenService:GetValue(sum / 0.6, Quad2, Enum.EasingDirection.Out)

			v7:ScaleTo((math.max(v11 * ((if v48 > 0.7 then (v48 - 0.7) / 0.30000000000000004 else 0) * -0.95 + 1), 0.01)))
		end
	end

	v7:Destroy()
end

function t.Open(p1, p2, p3, p4, p5, p6, p7, p8) --[[ Open | Line: 690 | Upvalues: Eggs (copy), GroundBelow (copy), EggEffects (copy), SetTrailEnabled (copy), PlayOwnerAwareSFX (copy), Bezier (copy), RunService (copy), TweenService (copy), Quad (copy), t2 (copy), EggScreenShake (copy), t3 (copy), t4 (copy), EggHatchAnim (copy), Exponential (copy), v2 (copy), PlayReveal (copy) ]]
	local v1 = Eggs:FindFirstChild(p2)

	if not v1 then
		return
	end

	local v22 = GroundBelow(p5.Position)
	local v4 = Vector3.new(p5.Position.X, v22.Y + 0, p5.Position.Z)
	local v5 = CFrame.new(v4, v4 + p5.LookVector * Vector3.new(1, 0, 1))
	local v6 = v1:Clone()
	local v7 = v5

	for v8, v9 in v6:GetDescendants() do
		if v9:IsA("BasePart") then
			v9.Anchored = true
			v9.CanCollide = false
			v9.CanQuery = false
			v9.CanTouch = false
		end
	end

	local v10 = v6.PrimaryPart or (v6:FindFirstChild("Handle") or v6:FindFirstChildWhichIsA("BasePart"))

	if not v10 then
		v6:Destroy()

		return
	end

	if EggEffects and EggEffects:FindFirstChild("Attachment") then
		EggEffects.Attachment:Clone().Parent = v10
	end

	local v11 = EggEffects.Shake:Clone()

	v11.Parent = v10

	local v12 = EggEffects.Highlight:Clone()

	v12.Parent = v10
	v12.DepthMode = Enum.HighlightDepthMode.Occluded
	v12.FillTransparency = 1
	v12.OutlineTransparency = 1
	v6:PivotTo(CFrame.new(p4, p4 + v7.LookVector * Vector3.new(1, 0, 1)))
	v6.Parent = workspace.Temporary
	SetTrailEnabled(v6, true)
	PlayOwnerAwareSFX(v10, p6, "rbxassetid://121132824785522")

	local v14 = Bezier.new(p4, (p4 + v7.Position) / 2 + Vector3.new(0, 16, 0), v7.Position)
	local sum = 0

	while sum < 0.3 do
		sum = sum + RunService.Heartbeat:Wait()

		local v15 = v14:CalculatePositionAt((TweenService:GetValue(sum / 0.3, Quad, Enum.EasingDirection.Out)))

		v6:PivotTo(CFrame.new(v15, v15 + v7.LookVector))
	end

	v6:PivotTo(v7)
	PlayOwnerAwareSFX(v10, p6, "rbxassetid://104869826618847")
	SetTrailEnabled(v6, false)

	for i = 1, 2 do
		local v16 = 0.45 ^ (i - 1) * 2.5

		if v16 <= 0 then
			break
		end

		local v17 = math.sqrt(v16 / 2.5) * 0.2
		local sum2 = 0

		while sum2 < v17 do
			sum2 = sum2 + RunService.Heartbeat:Wait()

			local v18 = math.clamp(sum2 / v17, 0, 1)

			v6:PivotTo(v7 * CFrame.new(0, v16 * 4 * v18 * (1 - v18), 0))
		end

		v6:PivotTo(v7)
	end

	task.wait(1)

	local v19 = t2
	local v20 = 0

	local function f21() --[[ Line: 784 | Upvalues: v10 (copy), v20 (ref), v19 (ref), PlayOwnerAwareSFX (ref), p6 (copy), v12 (copy), v11 (copy) ]]
		v20 = v20 + 1

		local v1 = v19[v20]

		if v1 then
			PlayOwnerAwareSFX(v10, p6, v1)
		end

		v12.FillTransparency = 0
		v12.OutlineTransparency = 0.5
		game.TweenService:Create(v12, TweenInfo.new(0.3), {
			FillTransparency = 1,
			OutlineTransparency = 1
		}):Play()

		for v2, v3 in v11:GetChildren() do
			if v3:IsA("ParticleEmitter") then
				v3:Emit(v3:GetAttribute("EmitCount"))
			end
		end
	end

	local v222 = EggScreenShake.begin(v7.Position, p7)
	local t = {
		onWobbleBeat = function(p1) --[[ onWobbleBeat | Line: 807 | Upvalues: v222 (copy) ]]
			v222:onWobbleBeat(p1)
		end,
		onGrowStart = function(p1, p2) --[[ onGrowStart | Line: 810 | Upvalues: PlayOwnerAwareSFX (ref), v10 (copy), p6 (copy), v19 (ref), t3 (ref), v20 (ref), t4 (ref) ]]
			if p1 == 1 then
				PlayOwnerAwareSFX(v10, p6, "rbxassetid://131003613792899", 4)
				v19 = t3
				v20 = 0

				return
			end

			if p1 ~= 2 then
				return
			end

			PlayOwnerAwareSFX(v10, p6, "rbxassetid://93813602862073", 4)
			v19 = t4
			v20 = 0
		end,
		onGrowBeat = function(p1, p2) --[[ onGrowBeat | Line: 821 | Upvalues: v222 (copy) ]]
			v222:onGrowBeat(p1, p2)
		end
	}

	if p7 == "Big" then
		EggHatchAnim.RunBigPreHatchSequence(v6, v7, f21, t)
	elseif p7 == "Huge" then
		EggHatchAnim.RunHugePreHatchSequence(v6, v7, f21, t)
	else
		EggHatchAnim.RunPreHatchSequence(v6, v7, EggHatchAnim.NormalPreHatchConfig, f21, t)
	end

	v222:onHatch(p7)

	if math.abs(v6:GetScale() - 1) <= 0.001 then
		v6:PivotTo(v7)
	end

	if p7 == "Big" then
		PlayOwnerAwareSFX(v10, p6, "rbxassetid://78426714974899", 4)
	elseif p7 == "Huge" then
		PlayOwnerAwareSFX(v10, p6, "rbxassetid://116376053254864", 4)
	end

	local t5 = {}

	for v24, v25 in v6:GetDescendants() do
		if v25:IsA("BasePart") then
			v25.Color = Color3.new(255/255, 255/255, 255/255)

			if v25:IsA("MeshPart") then
				v25.TextureID = ""
			end

			table.insert(t5, {
				Part = v25,
				Start = v25.Transparency
			})

			continue
		end

		if v25:IsA("Decal") or (v25:IsA("Texture") or v25:IsA("SurfaceAppearance")) then
			v25:Destroy()
		end
	end

	local v26 = v6:GetScale()
	local v27 = EggHatchAnim.ResolveHatchTargetScale(p7, v26)

	if p7 ~= "Huge" then
		task.spawn(function() --[[ Line: 865 | Upvalues: RunService (ref), TweenService (ref), Exponential (ref), v6 (copy), v26 (copy), v27 (copy), t5 (copy) ]]
			local sum = 0

			while sum < 0.6 do
				sum = sum + RunService.Heartbeat:Wait()

				local v1 = TweenService:GetValue(math.clamp(sum / 0.6, 0, 1), Exponential, Enum.EasingDirection.Out)

				v6:ScaleTo(v26 + (v27 - v26) * v1)

				for v2, v3 in t5 do
					if v3.Part.Parent then
						v3.Part.Transparency = v3.Start + (1 - v3.Start) * v1
					end
				end
			end

			v6:Destroy()
		end)
	end

	if p7 == "Huge" then
		local v28 = 0

		game.TweenService:Create(v12, TweenInfo.new(0.6), {
			FillTransparency = 0,
			OutlineTransparency = 0
		}):Play()

		local v29 = true

		task.spawn(function() --[[ Line: 894 | Upvalues: v28 (ref), v29 (ref), RunService (ref), TweenService (ref), Exponential (ref), v6 (copy), v26 (copy) ]]
			while v28 < 1.2 and v29 do
				v28 = v28 + RunService.Heartbeat:Wait()
				v6:ScaleTo(v26 + (0.2 - v26) * TweenService:GetValue(math.clamp(v28 / 0.6, 0, 1), Exponential, Enum.EasingDirection.Out))
			end

			v28 = 0

			while v28 < 3 and v29 do
				v28 = v28 + RunService.Heartbeat:Wait()
				v6:ScaleTo(0.2 + (v26 - 0.2) * TweenService:GetValue(math.clamp(v28 / 3, 0, 1), Exponential, Enum.EasingDirection.Out))
			end
		end)

		local v30 = game.ReplicatedStorage.Assets.EggEffects.HugeUnlock:Clone()

		v30.Parent = workspace.Temporary
		v30:PivotTo(v6:GetPivot())

		local v31 = v6:GetPivot()
		local v32 = v30.ScaleMe:GetPivot()

		for v33, v34 in v30.HugeEffect:GetChildren() do
			TweenService:Create(v34, TweenInfo.new(0.8), {
				TimeScale = 1
			}):Play()
		end

		for v35, v36 in v30.Floor:GetChildren() do
			TweenService:Create(v36, TweenInfo.new(3), {
				TimeScale = 1
			}):Play()
		end

		for v37, v38 in v30.ScaleMe.HugeEffect.Attachment:GetChildren() do
			TweenService:Create(v38, TweenInfo.new(3), {
				TimeScale = 1
			}):Play()
		end

		local sum2 = 0
		local sum3 = 0

		while sum2 < 2 do
			local v39 = RunService.Heartbeat:Wait()

			sum2 = sum2 + v39
			sum3 = sum3 + 1080 * (v39 * sum2 / 2)

			local v40 = TweenService:GetValue(math.clamp(sum2 / 2, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
			local v41 = CFrame.new(v2:NextNumber(-1, 1) * v40 * 0.5, v2:NextNumber(-1, 1) * v40 * 0.5, v2:NextNumber(-1, 1) * v40 * 0.5)

			v6:PivotTo(v31:Lerp(v32, v40) * v41 * CFrame.Angles(0, math.rad(sum3), 0))
			v30.HugeEffect:PivotTo(CFrame.new(v6.PrimaryPart.Position))
			v30.ScaleMe:PivotTo(CFrame.new(v6.PrimaryPart.Position))
			v30.ScaleMe:ScaleTo(v40)
		end

		local v42 = v6:GetScale()

		task.delay(1.3, function() --[[ Line: 964 | Upvalues: v30 (copy) ]]
			for v1, v2 in v30:GetDescendants() do
				if v2:IsA("ParticleEmitter") then
					v2.Enabled = false
				end
			end
		end)

		local sum4 = 0

		while sum4 < 1.5 do
			local v43 = RunService.Heartbeat:Wait()

			sum4 = sum4 + v43

			local v44 = CFrame.new(v2:NextNumber(-1, 1) * 0.5, v2:NextNumber(-1, 1) * 0.5, v2:NextNumber(-1, 1) * 0.5)

			sum3 = sum3 + 1080 * v43

			if sum4 > 1.1 then
				local v45 = sum4 - 1.1

				v29 = false
				v6:ScaleTo(v42 + (0.1 - v42) * TweenService:GetValue(math.clamp(v45 / 0.4, 0, 1), Exponential, Enum.EasingDirection.Out))
				v6:PivotTo(v32:Lerp(v31, (TweenService:GetValue(math.clamp(v45 / 0.4, 0, 1), Enum.EasingStyle.Back, Enum.EasingDirection.In))) * v44 * CFrame.Angles(0, math.rad(sum3), 0))
				v30.HugeEffect:PivotTo(CFrame.new(v6.PrimaryPart.Position))
				v30.ScaleMe:PivotTo(CFrame.new(v6.PrimaryPart.Position))
			else
				v6:PivotTo(v32 * v44 * CFrame.Angles(0, math.rad(sum3), 0))
			end
		end

		local v46 = EggEffects.Huge:Clone()

		v46.Parent = workspace.Terrain
		v46.WorldPosition = v6:GetPivot().Position
		v6:Destroy()

		for v47, v48 in v46:GetChildren() do
			if v48:IsA("ParticleEmitter") then
				v48:Emit(v48:GetAttribute("EmitCount"))

				continue
			end

			if v48:IsA("PointLight") then
				TweenService:Create(v48, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Range = 0,
					Brightness = 1
				}):Play()
			end
		end

		game.Debris:AddItem(v46, 7)
		v6:Destroy()
	else
		local v49 = p7 == "Big" and EggEffects.Big:Clone() or EggEffects.Common:Clone()

		v49.Parent = workspace.Terrain
		v49.WorldPosition = v6:GetPivot().Position

		for v50, v51 in v49:GetChildren() do
			if v51:IsA("ParticleEmitter") then
				v51:Emit(v51:GetAttribute("EmitCount"))

				continue
			end

			if v51:IsA("PointLight") then
				TweenService:Create(v51, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Range = 0,
					Brightness = 1
				}):Play()
			end
		end

		game.Debris:AddItem(v49, 7)
	end

	if p7 == "Big" or p7 == "Huge" then
		v222:onPetRevealed()
	end

	task.wait(0.1)
	PlayReveal(p3, Vector3.new(v7.Position.X, v22.Y, v7.Position.Z), v7.LookVector, p6, p7, p8)
end
task.spawn(function() --[[ Line: 1069 | Upvalues: t5 (copy), ContentProvider (copy) ]]
	local t = {}

	for v1, v2 in t5 do
		table.insert(t, v2)
	end

	local t2 = {}
	local ok, result = pcall(function() --[[ Line: 1076 | Upvalues: ContentProvider (ref), t (copy), t2 (copy) ]]
		ContentProvider:PreloadAsync(t, function(p1, p2) --[[ Line: 1077 | Upvalues: t2 (ref) ]]
			if p2 ~= Enum.AssetFetchStatus.Failure and p2 ~= Enum.AssetFetchStatus.TimedOut then
				return
			end

			table.insert(t2, p1)
		end)
	end)

	if not ok then
		warn((("[EggEffect] Sound preload errored: %*"):format(result)))

		return
	end

	if not (#t2 > 0) then
		return
	end

	warn((("[EggEffect] %* egg-open sound(s) failed to preload: %*"):format(#t2, (table.concat(t2, ", ")))))
end)

return t