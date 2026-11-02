-- BanHammerScript.lua (MADE BY TVMM!!!)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local Net = require(ReplicatedStorage:WaitForChild("Packages").Net)

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
	Tier1HoldTime = 1,
	BurnDuration = 2,
	Cooldown = 2,
	MaxDiameter = 25,
	GrowSpeed = 0.15,
	JumpHeight = 2.3,
	SlamSpeed = 30,
	HoverTime = 0.0005,
	BigSlamImpactDelay = 0.5,
	HighlightColor = Color3.fromRGB(255, 50, 50),
	MaxHighlightDistance = 25,
	MaxChargeShake = 1.5,
	PulseSpeed = 10,
	Colors = {
		Start = Color3.new(1, 1, 1),
		End = Color3.fromRGB(80, 200, 255),
		Black = Color3.new(0.1, 0.1, 0.1),
		Grey = Color3.fromRGB(150, 150, 150),
		Blue = Color3.fromRGB(82, 145, 216)
	}
}

local ChargePart = nil
local ChargeHighlight = nil
local ChargingEmitter = nil
local HighlightedTargets = {}

local IsCharging = false
local HasPopped = false
local IsOverheated = false
local ChargeStartTime = 0
local LoadedTracks = {}
local LoadedVFX = {}
local MovementConnection = nil

local OriginalWalkSpeed = 35
local OriginalJumpPower = 50.145

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
	if not template then return end

	local vfx = template:Clone()

	if vfx:IsA("Model") then
		vfx:PivotTo(cframeLocation)
		vfx.Parent = workspace
	elseif vfx:IsA("BasePart") then
		vfx.CFrame = cframeLocation
		vfx.Anchored = true
		vfx.CanCollide = false
		vfx.Parent = workspace
	elseif vfx:IsA("Attachment") then
		vfx.Parent = workspace.Terrain
		vfx.WorldCFrame = cframeLocation
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
		RootPart.Anchored = true
	end
end

local function CleanupHighlights()
	for targetModel, highlight in pairs(HighlightedTargets) do
		if highlight and highlight.Parent then
			highlight:Destroy()
		end
	end
	HighlightedTargets = {}
end

local function StartCharge()
	if IsOverheated or not Humanoid or Humanoid.Health <= 0 then return end
	if not RootPart then return end
	if IsCharging then return end

	IsCharging = true
	HasPopped = false
	ChargeStartTime = os.clock()

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

	local startSize = Config.MaxDiameter / 2
	ChargePart.Size = Vector3.new(0.2, startSize, startSize)

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
			local chargePercent = math.clamp((currentRadius * 2) / maxDia, 0, 1)

			local shakeIntensity = chargePercent * Config.MaxChargeShake
			local offset = Vector3.new(
				math.random(-100, 100)/100 * shakeIntensity,
				math.random(-100, 100)/100 * shakeIntensity,
				math.random(-100, 100)/100 * shakeIntensity
			)
			Camera.CFrame = Camera.CFrame * CFrame.new(offset * 0.1)

			if currentRadius * 2 < maxDia then
				local newSize = currentRadius * 2 + Config.GrowSpeed
				ChargePart.Size = Vector3.new(0.2, newSize, newSize)
				ChargePart.Transparency = 1 - (chargePercent * 0.55)
				ChargePart.Color = Config.Colors.Start
			else
				if not HasPopped then
					HasPopped = true
					PlaySound("MaxChargeSound") 
					if ChargingEmitter then ChargingEmitter:Destroy(); ChargingEmitter = nil end
					TweenColor(ChargePart, Config.Colors.End, 0.3)
					ChargePart.Transparency = 0.45
				end
			end

			local overlapParams = OverlapParams.new()
			overlapParams.FilterType = Enum.RaycastFilterType.Exclude
			overlapParams.FilterDescendantsInstances = {Character, ChargePart}

			local partsInRange = workspace:GetPartBoundsInRadius(ChargePart.Position, currentRadius, overlapParams)
			local currentTickTargets = {}
			local pulse = (math.sin(os.clock() * Config.PulseSpeed) + 1) / 2 
			local dynamicTransparency = 0.3 + (pulse * 0.4)

			for _, part in ipairs(partsInRange) do
				local targetModel = part.Parent
				local targetHum = targetModel:FindFirstChildOfClass("Humanoid")

				if targetHum and targetModel ~= Character and not currentTickTargets[targetModel] then
					currentTickTargets[targetModel] = true

					if not HighlightedTargets[targetModel] then
						local highlight = Instance.new("Highlight")
						highlight.FillColor = Config.HighlightColor
						highlight.OutlineColor = Config.HighlightColor
						highlight.DepthMode = Enum.HighlightDepthMode.Occluded
						highlight.Adornee = targetModel
						highlight.Parent = targetModel
						HighlightedTargets[targetModel] = highlight
					end

					HighlightedTargets[targetModel].FillTransparency = dynamicTransparency
				end
			end

			for model, highlight in pairs(HighlightedTargets) do
				if not currentTickTargets[model] then
					if highlight then highlight:Destroy() end
					HighlightedTargets[model] = nil
				end
			end

			task.wait(0.02)
		end

		CleanupHighlights()
	end)
end

local function ReleaseCharge()
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

	local chargePercent = 0.1
	if Config.MaxDiameter and FinalRadius > 0 then
		chargePercent = math.clamp((FinalRadius * 2) / Config.MaxDiameter, 0.1, 1)
	end
	if IsBigSlam then chargePercent = 1 end

	local StartCooldownEvent = Net:RemoteEvent("BanHammer/StartCooldown")
	if StartCooldownEvent then StartCooldownEvent:FireServer(chargePercent) end

	IsOverheated = true
	TweenColor(Handle, Config.Colors.Black, Config.BurnDuration * 0.25)
	if Outline then TweenColor(Outline, Config.Colors.Black, Config.BurnDuration * 0.25) end
	task.delay(Config.BurnDuration, function()
		TweenColor(Handle, Config.Colors.Grey, Config.Cooldown)
		if Outline then TweenColor(Outline, Config.Colors.Blue, Config.Cooldown) end
		task.wait(Config.Cooldown)
		IsOverheated = false
	end)

	if IsBigSlam then
		local launchVel = Instance.new("BodyVelocity")
		launchVel.MaxForce = Vector3.new(0, 1e5, 0)
		launchVel.Velocity = Vector3.new(0, Config.JumpHeight * 1.5, 0) 
		launchVel.Parent = RootPart
		Debris:AddItem(launchVel, 0.25)

		PlaySound("SlashSound")	
		if LoadedTracks["BigSlamAnim"] then 
			LoadedTracks["BigSlamAnim"]:Play(0) 
			LoadedTracks["BigSlamAnim"]:AdjustSpeed(2)
		end

		task.wait(0.15 + Config.HoverTime)

		local slamVel = Instance.new("BodyVelocity")
		slamVel.MaxForce = Vector3.new(0, 1e5, 0)
		slamVel.Velocity = Vector3.new(0, -Config.SlamSpeed * 2.5, 0)
		slamVel.Parent = RootPart
		Debris:AddItem(slamVel, 3)

		task.wait(0.05)
		local startTime = os.clock()
		local impactDetected = false

		while (os.clock() - startTime) < 3.0 do
			local floorCF_unrotated, _ = GetFloorPosition()
			if (RootPart.Position - floorCF_unrotated.Position).Magnitude < 3.5 and RootPart.Velocity.Y < 1.0 then
				impactDetected = true
				break
			end
			RunService.Heartbeat:Wait()
		end

		if slamVel and impactDetected then
			slamVel:Destroy()
		end

		if Config.BigSlamImpactDelay > 0 then
			task.wait(Config.BigSlamImpactDelay)
		end

		HitCenter = RootPart.Position	
		HitCFrame, _ = GetFloorPosition()

		ShakeCamera(0.5, 2)	
		TriggerVFX("Impact1_NEW1", HitCFrame)	
		TriggerVFX("LightningStrike", HitCFrame)
		PlaySound("BigSlamSound")

		local PushForce = 150
		local UpForce = 230
		local SlamEvent = Net:RemoteEvent("BanHammer/Slam")
		if SlamEvent then
			SlamEvent:FireServer(HitCenter, FinalRadius, PushForce, UpForce, chargePercent)
		end

		local overlapParams = OverlapParams.new()
		overlapParams.FilterType = Enum.RaycastFilterType.Exclude
		overlapParams.FilterDescendantsInstances = {Character}

		local hitModelsVFX = {}
		for _, part in ipairs(workspace:GetPartBoundsInRadius(HitCenter, FinalRadius, overlapParams)) do
			local targetModel = part.Parent
			local enemyRoot = targetModel:FindFirstChild("HumanoidRootPart")
			if enemyRoot and targetModel ~= Character and not hitModelsVFX[targetModel] then
				hitModelsVFX[targetModel] = true
				TriggerVFX("Impact1", enemyRoot.CFrame)
			end
		end
	else
		SetMovement(true)

		if DurationHeld < Config.Tier1HoldTime then
			if LoadedTracks["HitAnim"] then 
				LoadedTracks["HitAnim"]:Play() 
			elseif LoadedTracks["SlamAnim"] then
				LoadedTracks["SlamAnim"]:Play()
				LoadedTracks["SlamAnim"]:AdjustSpeed(1.5)
			end
		else
			if LoadedTracks["SlamAnim"] then 
				LoadedTracks["SlamAnim"]:Play() 
				LoadedTracks["SlamAnim"]:AdjustSpeed(1)
			end
		end

		PlaySound("SlashSound")
		task.wait(0.1)
		PlaySound("SlamSound")
		ShakeCamera(0.2, 0.2 + (0.5 * chargePercent))	
		TriggerVFX("Impact1", HitCFrame)

		local PushForce = 150
		local UpForce = 230
		local SlamEvent = Net:RemoteEvent("BanHammer/Slam")
		if SlamEvent then
			SlamEvent:FireServer(HitCenter, math.max(FinalRadius, 5), PushForce, UpForce, chargePercent)
		end
	end
end

local function HandleAction(actionName, inputState, inputObject)
	if inputState == Enum.UserInputState.Begin then
		StartCharge()
	elseif inputState == Enum.UserInputState.End then
		ReleaseCharge()
	end
end

Tool.Equipped:Connect(function()
	Tool:SetAttribute("IsActive", true)
	Character = Player.Character
	if not Character then return end

	RootPart = Character:WaitForChild("HumanoidRootPart")
	Humanoid = Character:WaitForChild("Humanoid")
	Animator = Humanoid:WaitForChild("Animator")

	TweenColor(Handle, Config.Colors.Grey, 0)

	local animationNames = {"HitAnim", "SlamAnim", "BigSlamAnim", "ChargingAnim", "IdleAnim", "RunningAnim"}
	for _, name in pairs(animationNames) do
		local animObject = ToolAssetsFolder:FindFirstChild(name)
		if animObject then LoadedTracks[name] = Animator:LoadAnimation(animObject) end
	end

	local vfxNames = {"Impact1_NEW1", "LightningStrike", "Impact1", "BigSlamHighlight"}
	for _, name in pairs(vfxNames) do
		LoadedVFX[name] = ToolAssetsFolder:FindFirstChild(name)
	end

	task.wait(0.1) 

	local isWalking = false

	MovementConnection = RunService.Heartbeat:Connect(function()
		if not Humanoid or not LoadedTracks["IdleAnim"] or not LoadedTracks["RunningAnim"] then return end

		if Humanoid.MoveDirection.Magnitude > 0 then
			if not isWalking then
				isWalking = true
				LoadedTracks["IdleAnim"]:Stop(0.2)
				LoadedTracks["RunningAnim"]:Play(0.2)
			end
		else
			if isWalking or not LoadedTracks["IdleAnim"].IsPlaying then
				isWalking = false
				LoadedTracks["RunningAnim"]:Stop(0.2)
				LoadedTracks["IdleAnim"]:Play(0.2)
			end
		end
	end)

	ContextActionService:BindAction("BanHammerCharge", HandleAction, true, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch)
end)

Tool.Unequipped:Connect(function()
	Tool:SetAttribute("IsActive", false)
	ContextActionService:UnbindAction("BanHammerCharge")

	if IsCharging then
		ReleaseCharge() 
	end

	SetMovement(true)
	if ChargePart then ChargePart:Destroy() ChargePart = nil end
	if ChargeHighlight then ChargeHighlight:Destroy() ChargeHighlight = nil end
	if ChargingEmitter then ChargingEmitter:Destroy() ChargingEmitter = nil end
	CleanupHighlights()

	if MovementConnection then
		MovementConnection:Disconnect()
		MovementConnection = nil
	end

	for _, child in pairs(Handle:GetChildren()) do
		if child:IsA("Sound") then child:Stop() end
	end
	for _, track in pairs(LoadedTracks) do track:Stop() end
	LoadedTracks = {}
	LoadedVFX = {}
end)	