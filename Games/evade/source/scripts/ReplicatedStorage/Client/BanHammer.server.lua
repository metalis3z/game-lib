--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")
local ContentProvider = game:GetService("ContentProvider")

print("🔨 Ban Hammer Script: Starting...")

-- // 1. SAFE ASSET LOADING //
local function GetAssetFolder()
	local assets = ReplicatedStorage:WaitForChild("Assets", 5)
	if not assets then warn("❌ Missing ReplicatedStorage.Assets folder!"); return nil end

	local tools = assets:WaitForChild("Tools", 5)
	if not tools then warn("❌ Missing Assets.Tools folder!"); return nil end

	local banHammer = tools:WaitForChild("Ban Hammer", 5)
	if not banHammer then warn("❌ Missing 'Ban Hammer' folder in Tools!"); return nil end

	return banHammer
end

local BanHammerAssets = GetAssetFolder()

-- If assets are missing, stop script to prevent errors
if not BanHammerAssets then 
	warn("⚠️ Script stopped due to missing assets.")
	return 
end

print("✅ Assets Found!")

-- Load Flags (or default)
local Flags = {
	ChargeTime = 2,
	MinRadius = 5,
	MaxRadius = 25,
	SlamOffset = CFrame.new(0,0,-5)
}
pcall(function()
	local flagModule = BanHammerAssets:WaitForChild("Flags", 1)
	if flagModule then Flags = require(flagModule) end
end)

-- Load Assets
local IndicatorTemplate = BanHammerAssets:WaitForChild("Indicator", 5)

local Anims = {
	Idle = BanHammerAssets:WaitForChild("IdleAnimation", 5),
	Run = BanHammerAssets:WaitForChild("RunningAnimation", 5),
	Charge = BanHammerAssets:WaitForChild("ChargingAnimation", 5),
	Slam = BanHammerAssets:WaitForChild("SlamAnimation", 5),
	BigSlam = BanHammerAssets:WaitForChild("BigSlamAnimation", 5),
}

local Sounds = {
	Charge = BanHammerAssets:WaitForChild("ChargingSound", 5),
	Max = BanHammerAssets:WaitForChild("MaxChargeSound", 5),
	Slam = BanHammerAssets:WaitForChild("SlamSound", 5),
	BigSlam = BanHammerAssets:WaitForChild("BigSlamSound", 5),
}

-- // VARIABLES //
local Tool = script.Parent
local Player = Players.LocalPlayer
local Character = nil
local Humanoid = nil
local RootPart = nil
local Animator = nil

local Tracks = {}
local Connections = {}
local IsAttacking = false
local ChargeStartTime = 0

-- // HELPER FUNCTIONS //

local function PlaySound(soundObj)
	if not soundObj then return end
	local s = soundObj:Clone()
	s.Parent = Tool:FindFirstChild("Handle") or RootPart
	s:Play()
	game.Debris:AddItem(s, 5)
end

local function LoadTracks()
	if not Animator then return end
	for name, anim in pairs(Anims) do
		if anim then
			Tracks[name] = Animator:LoadAnimation(anim)
		else
			warn("Missing Animation Asset: " .. name)
		end
	end
end

local function PlayTrack(name)
	if Tracks[name] then Tracks[name]:Play(0.1) end
end

local function StopTrack(name)
	if Tracks[name] then Tracks[name]:Stop(0.2) end
end

-- // MAIN ACTION //

local function HandleAction(actionName, inputState, inputObject)
	if actionName ~= "BanHammerAction" then return end

	if inputState == Enum.UserInputState.Begin then
		-- PRESSED (START CHARGE)
		if IsAttacking then return end
		IsAttacking = true
		ChargeStartTime = os.clock()

		PlaySound(Sounds.Charge)
		PlayTrack("Charge")

		-- Create Indicator
		local indicator = nil
		local mainPart = nil

		if IndicatorTemplate then
			indicator = IndicatorTemplate:Clone()
			mainPart = indicator.Main
			indicator.Parent = workspace
			-- Fade In
			local fadeIn = TweenService:Create(mainPart, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0.5})
			fadeIn:Play()
		end

		local maxChargeTriggered = false

		-- Render Loop
		local renderConn
		renderConn = RunService.RenderStepped:Connect(function()
			if not IsAttacking then 
				if renderConn then renderConn:Disconnect() end
				return 
			end

			-- Calculate Charge
			local duration = os.clock() - ChargeStartTime
			local percent = math.clamp(duration / Flags.ChargeTime, 0, 1)

			-- Indicator Logic
			if indicator and mainPart and RootPart then
				local currentRadius = Flags.MinRadius + ((Flags.MaxRadius - Flags.MinRadius) * percent)
				local offset = Humanoid.HipHeight + (RootPart.Size.Y * 0.5)
				local slamOffset = Flags.SlamOffset or CFrame.new(0, 0, -5)

				indicator:PivotTo(RootPart.CFrame * CFrame.new(0, -offset, 0) * slamOffset)

				local size = currentRadius * 2
				mainPart.Size = Vector3.new(mainPart.Size.X, size, size)

				if percent >= 1 and not maxChargeTriggered then
					maxChargeTriggered = true
					PlaySound(Sounds.Max)
					TweenService:Create(mainPart, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						["Transparency"] = 0.2, ["Color"] = Color3.fromRGB(97, 173, 255)
					}):Play()
				end
			end
		end)

		-- Cleanup Logic
		table.insert(Connections, {
			Disconnect = function()
				if renderConn then renderConn:Disconnect() end
				if indicator then
					if mainPart then
						local fadeOut = TweenService:Create(mainPart, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1})
						fadeOut:Play()
					end
					game.Debris:AddItem(indicator, 0.5)
				end
			end
		})

	elseif inputState == Enum.UserInputState.End then
		-- RELEASED (ATTACK)
		if IsAttacking then
			IsAttacking = false
			StopTrack("Charge")

			local duration = os.clock() - ChargeStartTime
			local percent = math.clamp(duration / Flags.ChargeTime, 0, 1)

			-- Cleanup Visuals
			for _, conn in pairs(Connections) do
				if conn.Disconnect then conn.Disconnect() end
			end
			Connections = {}

			-- Play Animations based on charge
			if percent >= 1 then
				PlayTrack("BigSlam")
				PlaySound(Sounds.BigSlam)
			else
				PlayTrack("Slam")
				PlaySound(Sounds.Slam)
			end
		end
	end
end

-- // EVENTS //

Tool.Equipped:Connect(function()
	print("🔨 Tool Equipped")
	Character = Players.LocalPlayer.Character
	if not Character then return end

	Humanoid = Character:WaitForChild("Humanoid")
	RootPart = Character:WaitForChild("HumanoidRootPart")
	Animator = Humanoid:WaitForChild("Animator")

	LoadTracks()
	PlayTrack("Idle")

	-- [[ SYNC LOGIC (NON-BLOCKING) ]] --
	task.spawn(function()
		-- We try to find the event for 2 seconds. If missing, we ignore it so tool doesn't break.
		local clientFolder = ReplicatedStorage:WaitForChild("Client", 2)
		if clientFolder then
			local hammerFolder = clientFolder:WaitForChild("BanHammer", 2)
			if hammerFolder then
				local equippedEvent = hammerFolder:WaitForChild("Equipped", 2)
				if equippedEvent then
					print("✅ Synced with Framework")
					equippedEvent:Fire(Tool)
				end
			end
		else
			warn("⚠️ Framework folder not found - Running standalone mode")
		end
	end)

	-- Run Animation Logic
	local runConn = Humanoid.Running:Connect(function(speed)
		if speed > 0.1 then
			if Tracks.Run and not Tracks.Run.IsPlaying then PlayTrack("Run") end
			StopTrack("Idle")
		else
			StopTrack("Run")
			if Tracks.Idle and not Tracks.Idle.IsPlaying then PlayTrack("Idle") end
		end
	end)

	table.insert(Connections, runConn)

	ContextActionService:BindAction("BanHammerAction", HandleAction, true, Enum.UserInputType.MouseButton1)
end)

Tool.Unequipped:Connect(function()
	IsAttacking = false
	ContextActionService:UnbindAction("BanHammerAction")

	for _, conn in pairs(Connections) do
		if typeof(conn) == "RBXScriptConnection" then conn:Disconnect() end
		if type(conn) == "table" and conn.Disconnect then conn.Disconnect() end
	end
	Connections = {}

	for _, track in pairs(Tracks) do
		track:Stop()
	end
end)