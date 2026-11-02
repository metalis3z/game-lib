local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local Tool = script.Parent
local Player = Players.LocalPlayer
local Character = nil
local RootPart = nil
local Humanoid = nil
local Animator = nil
local Camera = workspace.CurrentCamera

local Handle = Tool:WaitForChild("Handle")
local Outline = Tool:FindFirstChild("Outline") or Handle:FindFirstChild("Outline")

local ToolAssetsFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Ban Hammer")

local Config = {
	Tier1HoldTime = 0.5,
	BurnDuration = 2,
	Cooldown = 2,
	MaxDiameter = 25,
	GrowSpeed = 0.1,

	JumpHeight = 2.3,
	SlamSpeed = 30,
	HoverTime = 0.0005,

	HighlightColor = Color3.fromRGB(255, 50, 50),
	MaxHighlightDistance = 25,

	Colors = {
		Start = Color3.new(1, 1, 1),
		End = Color3.fromRGB(80, 200, 255),
		Black = Color3.new(0.1, 0.1, 0.1),
		Grey = Color3.fromRGB(150, 150, 150),
		Blue = Color3.fromRGB(82, 145, 216)
	}
}

local ChargePart = nil
local Emitter = nil
local ChargeHighlight = nil
local ChargingEmitter = nil
local HighlightedPlayers = {}

local IsCharging = false
local HasPopped = false
local IsOverheated = false
local ChargeStartTime = 0
local LoadedTracks = {}
local LoadedVFX = {}

local OriginalWalkSpeed = 34
local OriginalJumpPower = 50

local FLAT_ROTATION = CFrame.Angles(0, 0, math.pi / 2)

local function ShakeCamera(duration, intensity)
	task.spawn(function()
		local startTime = os.clock()
		while os.clock() - startTime < duration do
			local offset = Vector3.new(
				math.random(-100, 100)/100 * intensity,
				math.random(-100, 100)/100 * intensity,
				math.random(-100, 100)/100 * intensity
			)
			Camera.CFrame = Camera.CFrame * CFrame.new(offset * 0.1)
			RunService.RenderStepped:Wait()
		end
	end)
end

local function PlaySound(name)
	local soundTemplate = ToolAssetsFolder:FindFirstChild(name)
	if soundTemplate then
		local sound = Handle:FindFirstChild(name)
		if not sound then
			sound = soundTemplate:Clone()
			sound.Name = name
			sound.Parent = Handle
		end
		sound:Play()
	end
end

local function StopSound(name)
	if Handle then
		local sound = Handle:FindFirstChild(name)
		if sound then sound:Stop() end
	end
end

local function TweenColor(part, targetColor, duration)
	if part then
		TweenService:Create(part, TweenInfo.new(duration), {Color = targetColor}):Play()
	end
end

local function GetFloorPosition()
	if not RootPart then return CFrame.new(0, -5, 0), CFrame.new(0, -5, 0) * FLAT_ROTATION end
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {Character, ChargePart}
	params.FilterType = Enum.RaycastFilterType.Exclude

	local result = workspace:Raycast(RootPart.Position, Vector3.new(0, -100, 0), params)

	if result then
		local floorCF_unrotated = CFrame.new(result.Position + Vector3.new(0, 0.1, 0))
		return floorCF_unrotated, floorCF_unrotated * FLAT_ROTATION
	else
		local fallbackCF_unrotated = CFrame.new(RootPart.Position.X, RootPart.Position.Y - 3, RootPart.Position.Z)
		return fallbackCF_unrotated, fallbackCF_unrotated * FLAT_ROTATION
	end
end

local function TriggerVFX(vfxName, cframeLocation)
	local template = ToolAssetsFolder:FindFirstChild(vfxName)
	if not template then
		return
	end

	local vfx = template:Clone()
	vfx.Parent = workspace

	if vfx:IsA("Model") then
		vfx:SetPrimaryPartCFrame(cframeLocation)
	elseif vfx:IsA("BasePart") then
		vfx.CFrame = cframeLocation
		vfx.Anchored = true
		vfx.CanCollide = false
	end

	for _, child in pairs(vfx:GetDescendants()) do
		if child:IsA("ParticleEmitter") then
			local count = child:GetAttribute("EmitCount") or 20
			child:Emit(count)
			if child.Enabled == false then
				task.delay(0.1, function() child:Emit(count) end)
			end
		end
	end
	Debris:AddItem(vfx, 5)
end

local function SetMovement(enabled)
	if not Humanoid or not RootPart then return end
	if enabled then
		Humanoid.WalkSpeed = OriginalWalkSpeed
		Humanoid.JumpPower = OriginalJumpPower
		Humanoid.AutoRotate = true
		RootPart.Anchored = false
	else
		OriginalWalkSpeed = Humanoid.WalkSpeed
		OriginalJumpPower = Humanoid.JumpPower
		Humanoid.WalkSpeed = 0
		Humanoid.JumpPower = 0
		Humanoid.AutoRotate = false
	end
end

local function CleanupHighlights()
	for player, highlight in pairs(HighlightedPlayers) do
		if highlight and highlight.Parent then
			highlight:Destroy()
		end
	end
	HighlightedPlayers = {}
end

Tool.Equipped:Connect(function()
	Character = Player.Character
	if not Character then return end

	RootPart = Character:WaitForChild("HumanoidRootPart")
	Humanoid = Character:WaitForChild("Humanoid")
	Animator = Humanoid:WaitForChild("Animator")

	TweenColor(Handle, Config.Colors.Grey, 0)

	local animationNames = {"HitAnim", "SlamAnim", "BigSlamAnim", "ChargingAnim", "IdleAnim"}
	for _, name in pairs(animationNames) do
		local animObject = ToolAssetsFolder:FindFirstChild(name)
		if animObject then LoadedTracks[name] = Animator:LoadAnimation(animObject) end
	end

	local vfxNames = {"Impact1_NEW1", "LightningStrike", "Impact1", "BigSlamHighlight"}
	for _, name in pairs(vfxNames) do
		LoadedVFX[name] = ToolAssetsFolder:FindFirstChild(name)
	end

	task.wait(0.1) 

	if LoadedTracks["IdleAnim"] then LoadedTracks["IdleAnim"]:Play(0.2) end
end)

Tool.Unequipped:Connect(function()
	IsCharging = false
	SetMovement(true)
	if ChargePart then ChargePart:Destroy() ChargePart = nil end
	if ChargeHighlight then ChargeHighlight:Destroy() ChargeHighlight = nil end
	if ChargingEmitter then ChargingEmitter:Destroy() ChargingEmitter = nil end
	CleanupHighlights()

	for _, child in pairs(Handle:GetChildren()) do
		if child:IsA("Sound") then child:Stop() end
	end
	for _, track in pairs(LoadedTracks) do track:Stop() end
	LoadedTracks = {}
	LoadedVFX = {}
end)

Tool.Activated:Connect(function()
	if IsOverheated or not Humanoid or Humanoid.Health <= 0 then return end
	if not RootPart then return end

	IsCharging = true
	HasPopped = false
	ChargeStartTime = os.clock()

	SetMovement(false)	
	PlaySound("ChargingSound")
	if LoadedTracks["ChargingAnim"] then LoadedTracks["ChargingAnim"]:Play(0.2) end

	ChargePart = Instance.new("Part", workspace)
	ChargePart.Name = "BanHammerCircle"
	ChargePart.Anchored = true
	ChargePart.CanCollide = false
	ChargePart.Shape = Enum.PartType.Cylinder

	ChargePart.Material = Enum.Material.Plastic

	ChargePart.Transparency = 0.5
	ChargePart.Color = Config.Colors.Start
	ChargePart.Size = Vector3.new(0.2, 1, 1)

	local _, floorCF_rotated = GetFloorPosition()
	ChargePart.CFrame = floorCF_rotated

	ChargingEmitter = Instance.new("ParticleEmitter", ChargePart)
	ChargingEmitter.Texture = "rbxassetid://292289455"
	ChargingEmitter.Rate = 0
	ChargingEmitter.Speed = NumberRange.new(10, 20)

	local highlightTemplate = LoadedVFX["BigSlamHighlight"] or ToolAssetsFolder:FindFirstChild("BigSlamHighlight")
	if highlightTemplate then
		ChargeHighlight = highlightTemplate:Clone()
		ChargeHighlight.Parent = ChargePart
		for _, p in ipairs(ChargeHighlight:GetDescendants()) do
			if p:IsA("BasePart") then p.Transparency = 1 end
		end
	end

	task.spawn(function()
		local maxDia = Config.MaxDiameter

		while IsCharging and ChargePart and RootPart do
			local _, currentFloorCF_rotated = GetFloorPosition()
			ChargePart.CFrame = currentFloorCF_rotated
			local currentRadius = ChargePart.Size.Y / 2

			if currentRadius * 2 < maxDia then
				local newSize = currentRadius * 2 + Config.GrowSpeed
				ChargePart.Size = Vector3.new(0.2, newSize, newSize)

				local chargeRatio = (currentRadius * 2) / maxDia
				ChargePart.Transparency = 1 - (chargeRatio * 0.55)
				ChargePart.Color = Config.Colors.Start

				if ChargeHighlight then
					for _, p in ipairs(ChargeHighlight:GetDescendants()) do
						if p:IsA("BasePart") then p.Transparency = 1 end
					end
				end
			else
				HasPopped = true

				if ChargingEmitter then
					ChargingEmitter:Destroy()
					ChargingEmitter = nil
				end

				TweenColor(ChargePart, Config.Colors.End, 0.3)
				ChargePart.Transparency = 0.45

				if ChargeHighlight then
					for _, p in ipairs(ChargeHighlight:GetDescendants()) do
						if p:IsA("BasePart") then p.Transparency = 0 end
					end
				end
			end

			for _, p in pairs(Players:GetPlayers()) do
				if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					local enemyRoot = p.Character.HumanoidRootPart
					local distance = (enemyRoot.Position - RootPart.Position).Magnitude

					if distance <= currentRadius then
						if not HighlightedPlayers[p] then
							local highlight = Instance.new("Highlight")
							highlight.FillColor = Config.HighlightColor
							highlight.OutlineColor = Config.HighlightColor
							highlight.DepthMode = Enum.HighlightDepthMode.Occluded
							highlight.FillTransparency = 0.6
							highlight.OutlineTransparency = 0
							highlight.Adornee = p.Character
							highlight.Parent = p.Character
							HighlightedPlayers[p] = highlight
						end
					elseif HighlightedPlayers[p] then
						if HighlightedPlayers[p] and p.Character then
							HighlightedPlayers[p]:Destroy()
							HighlightedPlayers[p] = nil
						end
					end
				end
			end

			task.wait(0.02)
		end

		CleanupHighlights()
		if ChargeHighlight then ChargeHighlight:Destroy() ChargeHighlight = nil end
	end)
end)

Tool.Deactivated:Connect(function()
	if not IsCharging then return end
	IsCharging = false
	CleanupHighlights()

	StopSound("ChargingSound")
	if LoadedTracks["ChargingAnim"] then LoadedTracks["ChargingAnim"]:Stop(0.1) end

	local FinalRadius = 0
	local HitCenter = Vector3.new()
	local HitCFrame = CFrame.new()

	if ChargePart then
		FinalRadius = ChargePart.Size.Y / 2
		HitCenter = ChargePart.Position

		HitCFrame, _ = GetFloorPosition()

		if ChargingEmitter then ChargingEmitter:Destroy() ChargingEmitter = nil end

		TweenService:Create(ChargePart, TweenInfo.new(0.3), {Transparency = 1}):Play()

		if ChargeHighlight then
			for _, p in ipairs(ChargeHighlight:GetDescendants()) do
				if p:IsA("BasePart") then
					TweenService:Create(p, TweenInfo.new(0.3), {Transparency = 1}):Play()
				end
			end
			Debris:AddItem(ChargeHighlight, 0.35)	
			ChargeHighlight = nil
		end

		Debris:AddItem(ChargePart, 0.35)
		ChargePart = nil
	else
		HitCenter = RootPart.Position
		HitCFrame, _ = GetFloorPosition()
	end

	local DurationHeld = os.clock() - ChargeStartTime
	local IsBigSlam = HasPopped

	if IsBigSlam then

		local launchVel = Instance.new("BodyVelocity")
		launchVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		launchVel.Velocity = Vector3.new(0, Config.JumpHeight, 0)
		launchVel.Parent = RootPart
		Debris:AddItem(launchVel, 0.25)

		PlaySound("SlashSound")	

		if LoadedTracks["BigSlamAnim"] then LoadedTracks["BigSlamAnim"]:Play(0) end

		task.wait(0.15)

		RootPart.Anchored = true
		task.wait(Config.HoverTime)

		local slamVel = Instance.new("BodyVelocity")
		slamVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		slamVel.Velocity = Vector3.new(0, -Config.SlamSpeed, 0)
		slamVel.Parent = RootPart
		Debris:AddItem(slamVel, 3)

		task.wait(0.05)

		local startTime = os.clock()
		local impactDetected = false

		while (os.clock() - startTime) < 3.0 do
			local floorCF_unrotated, _ = GetFloorPosition()

			if (RootPart.Position - floorCF_unrotated.Position).Magnitude < 1.5 and RootPart.Velocity.Y < 1.0 then
				impactDetected = true
				break
			end
			RunService.Heartbeat:Wait()
		end

		if slamVel and impactDetected then
			Debris:RemoveItem(slamVel)
			slamVel:Destroy()
		end

		RootPart.Anchored = false 

		HitCenter = RootPart.Position	

		HitCFrame, _ = GetFloorPosition()

		SetMovement(true)	

		ShakeCamera(0.5, 2)	

		TriggerVFX("Impact1_NEW1", HitCFrame)	
		TriggerVFX("LightningStrike", HitCFrame)

		PlaySound("BigSlamSound")


		local PushForce = 150
		local UpForce = 230
		for _, otherPlayer in pairs(Players:GetPlayers()) do
			if otherPlayer ~= Player and otherPlayer.Character then
				local enemyRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
				if enemyRoot and (enemyRoot.Position - HitCenter).Magnitude <= FinalRadius then
					local direction = (enemyRoot.Position - HitCenter).Unit
					local velocity = (direction * PushForce) + Vector3.new(0, UpForce, 0)
					local bv = Instance.new("BodyVelocity")
					bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
					bv.Velocity = velocity
					bv.Parent = enemyRoot
					Debris:AddItem(bv, 0.2)
					TriggerVFX("Impact1", enemyRoot.CFrame)
				end
			end
		end

		IsOverheated = true
		TweenColor(Handle, Config.Colors.Black, Config.BurnDuration * 0.25)
		if Outline then TweenColor(Outline, Config.Colors.Black, Config.BurnDuration * 0.25) end
		task.delay(Config.BurnDuration, function()
			TweenColor(Handle, Config.Colors.Grey, Config.Cooldown)
			if Outline then TweenColor(Outline, Config.Colors.Blue, Config.Cooldown) end
			task.wait(Config.Cooldown)
			IsOverheated = false
		end)

	elseif DurationHeld >= Config.Tier1HoldTime then
		SetMovement(true)
		if LoadedTracks["SlamAnim"] then LoadedTracks["SlamAnim"]:Play() end
		PlaySound("SlashSound")
		task.wait(0.5)
		PlaySound("SlamSound")

		ShakeCamera(0.2, 0.5)	
		TriggerVFX("Impact1", HitCFrame)

	else
		SetMovement(true)
	end
end)