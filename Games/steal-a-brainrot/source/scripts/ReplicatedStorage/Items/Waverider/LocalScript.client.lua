local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local Spring = require(ReplicatedStorage.Packages.Spring)

local Tool = script.Parent
local Player = nil
if Tool.Parent:IsA("Model") then
	Player = Players:GetPlayerFromCharacter(Tool.Parent)
else
	Player = Tool.Parent.Parent
end

assert(Player and Player:IsA("Player"), "Could not find Player for Waverider")

if Player ~= Players.LocalPlayer then
	return
end

local Character = Player.Character or Player.CharacterAdded:Wait()
local RootPart = assert(Character:WaitForChild("HumanoidRootPart", 5))
local Humanoid = assert(Character:WaitForChild("Humanoid", 5))
local Animator = assert(Humanoid:WaitForChild("Animator", 5))

local ToolAssets = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Waverider")
local IdleAnimation = ToolAssets:WaitForChild("IdleAnimation")
local MovingAnimation = ToolAssets:WaitForChild("MovingAnimation")

local WaveriderBoost = Player.PlayerGui:WaitForChild("ToolsFrames"):WaitForChild("WaveriderBoost")

local IsFlying = false
local ToolEquipped = false
local JumpConnection = nil
local FlightMonitor = nil
local IdleTrack = nil
local MovingTrack = nil
local SpeedMultiplier = 1.65

local function IsPC()
	return UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled
end

local function UpdateBoostButtonText()
	local activate = WaveriderBoost:FindFirstChild("Activate")
	if activate then
		local txt = activate:FindFirstChild("Txt")
		if txt then
			txt.Text = IsPC() and "Boost [E]" or "Boost"
		end
	end
end

-- FOV effect
local FovConnection = nil
local OriginalFov = nil
local FovSpring = nil

local function CheckIfAlive()
	return Character and Character.Parent and Humanoid and Humanoid.Parent and Humanoid.Health > 0 and RootPart and RootPart.Parent and Player and Player.Parent
end

local function IsPlayable(anim)
	local id = anim.AnimationId
	return id ~= "" and id ~= "rbxassetid://0"
end

local function LoadTracks()
	if not IdleTrack and IsPlayable(IdleAnimation) then
		IdleTrack = Animator:LoadAnimation(IdleAnimation)
		IdleTrack.Looped = true
		IdleTrack.Priority = Enum.AnimationPriority.Idle
	end
	if not MovingTrack and IsPlayable(MovingAnimation) then
		MovingTrack = Animator:LoadAnimation(MovingAnimation)
		MovingTrack.Looped = true
		MovingTrack.Priority = Enum.AnimationPriority.Movement
	end
end

local function StopTracks()
	if IdleTrack then IdleTrack:Stop(0.2) end
	if MovingTrack then MovingTrack:Stop(0.2) end
end

local function UpdateFlightAnimation(speed, mult)
	if Tool:GetAttribute("Boosting") ~= true then
		SpeedMultiplier = mult
	end

	if speed > 5 then
		if IdleTrack and IdleTrack.IsPlaying then
			IdleTrack:Stop(0.2)
		end
		if MovingTrack then
			if MovingTrack.IsPlaying then
				local target = 60 * SpeedMultiplier
				MovingTrack:AdjustSpeed(math.clamp(speed / math.max(target, 1), 0.1, 4))
			else
				MovingTrack:Play(0.2)
				local target = 60 * SpeedMultiplier
				MovingTrack:AdjustSpeed(math.clamp(speed / math.max(target, 1), 0.1, 4))
			end
		end
	else
		if MovingTrack and MovingTrack.IsPlaying then
			MovingTrack:Stop(0.2)
		end
		if IdleTrack and not IdleTrack.IsPlaying then
			IdleTrack:Play(0.2)
		end
	end
end

local function DisableJump(enable)
	if JumpConnection then
		JumpConnection:Disconnect()
		JumpConnection = nil
	end
	if enable then
		JumpConnection = Humanoid.Changed:Connect(function(prop)
			if prop == "Jump" then
				Humanoid.Jump = false
			end
		end)
	end
end

local function StopFovEffect()
	if FovConnection then
		FovConnection:Disconnect()
		FovConnection = nil
	end
	local cam = workspace.CurrentCamera
	if cam and OriginalFov then
		cam.FieldOfView = OriginalFov
	end
	OriginalFov = nil
	FovSpring = nil
end

local function StartFovEffect()
	if FovConnection then return end
	local cam = workspace.CurrentCamera
	if cam then
		OriginalFov = cam.FieldOfView
		FovSpring = Spring.new(cam.FieldOfView)
		FovSpring.Speed = 12
		FovSpring.Damper = 0.65
		FovConnection = RunService.RenderStepped:Connect(function()
			local cam = workspace.CurrentCamera
			if not (cam and OriginalFov and FovSpring) then return end
			local target = OriginalFov
			if IsFlying and Humanoid.MoveDirection.Magnitude > 0.1 then
				local ratio = (tonumber(Tool:GetAttribute("SpeedMultiplier")) or 1.65) / 1.65
				target = OriginalFov + ratio * 6 + (if Tool:GetAttribute("Boosting") == true then math.sin(os.clock() * 3) * 1.5 + 15 else 0)
			end
			FovSpring.Target = target
			cam.FieldOfView = FovSpring.Position
		end)
	end
end

local function SetHandleVisible(visible)
	local handle = Tool:FindFirstChild("Handle")
	if handle and handle:IsA("BasePart") then
		handle.Transparency = if visible then 0 else 1
		for _, child in ipairs(handle:GetDescendants()) do
			if child:IsA("Decal") then
				child.Transparency = if visible then 0 else 1
			end
		end
	end
end

local function HandleFlight()
	if not CheckIfAlive() then return end
	if FlightMonitor then FlightMonitor:Disconnect() end

	FlightMonitor = RootPart.ChildAdded:Connect(function(child)
		if IsFlying then return end
		if child.Name ~= "FlightHold" then return end

		local FlightSpin = RootPart:FindFirstChild("FlightSpin")
		local FlightPower = RootPart:FindFirstChild("FlightPower")
		local FlightHold = RootPart:FindFirstChild("FlightHold")

		if not (FlightSpin and FlightPower and FlightHold) then return end

		IsFlying = true
		WaveriderBoost.Visible = true
		SetHandleVisible(false)

		Humanoid.WalkSpeed = 0
		Humanoid.PlatformStand = true
		Humanoid.AutoRotate = false
		DisableJump(true)

		RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

		local Camera = workspace.CurrentCamera
		assert(Camera)

		while IsFlying and FlightSpin.Parent and FlightPower.Parent and FlightHold.Parent do
			if not CheckIfAlive() then break end

			local speedMult = tonumber(Tool:GetAttribute("SpeedMultiplier")) or 1.65
			local push = Vector3.new(0, 0, 0)
			local camCFrame = Camera.CFrame
			local forwardVector = camCFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
			local sideVector = camCFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0))
			local localControl = CFrame.new(Vector3.new(0, 0, 0), camCFrame.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(Humanoid.MoveDirection)

			push = push + (forwardVector * (60 * speedMult) * -localControl.Z)
			push = push + (sideVector * (40 * speedMult) * -localControl.X)

			FlightSpin.CFrame = CFrame.new(Vector3.new(0, 0, 0), if push.Magnitude > 1 then push.Unit else forwardVector)

			if push.Magnitude < 1 then
				FlightHold.MaxForce = Vector3.new(FlightHold.P, FlightHold.P, FlightHold.P)
				FlightPower.MaxForce = Vector3.new(0, 0, 0)
				FlightHold.Position = RootPart.Position
			else
				FlightHold.MaxForce = Vector3.new(0, 0, 0)
				FlightPower.MaxForce = Vector3.new(FlightPower.P * 100, FlightPower.P * 100, FlightPower.P * 100)
			end

			FlightPower.Velocity = push
			UpdateFlightAnimation(push.Magnitude, speedMult)
			task.wait(1 / 60)
		end

		IsFlying = false
		WaveriderBoost.Visible = false
		SetHandleVisible(true)
		StopTracks()

		if CheckIfAlive() then
			RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			Humanoid.WalkSpeed = 16
			Humanoid.PlatformStand = false
			Humanoid.AutoRotate = true
			DisableJump(false)
			Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
		end
	end)
end

local function OnEquipped()
	if CheckIfAlive() then
		ToolEquipped = true
		LoadTracks()
		StartFovEffect()
		task.spawn(HandleFlight)
	end
end

local function OnUnequipped()
	if not ToolEquipped then return end

	IsFlying = false
	WaveriderBoost.Visible = false
	SetHandleVisible(true)
	StopTracks()
	StopFovEffect()
	DisableJump(false)

	if FlightMonitor then
		FlightMonitor:Disconnect()
		FlightMonitor = nil
	end

	ToolEquipped = false
end

Tool.Equipped:Connect(OnEquipped)
Tool.Unequipped:Connect(OnUnequipped)

-- Boost button - direct binding (ToolActionInput modülü olmadan)
WaveriderBoost.Activate.MouseButton1Up:Connect(function()
	Net:RemoteEvent("Tools/Waverider/Boost"):FireServer()
end)

-- E key boost (PC only, while flying)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.E and IsFlying and ToolEquipped then
		Net:RemoteEvent("Tools/Waverider/Boost"):FireServer()
	end
end)

-- Update boost button text when frame becomes visible
WaveriderBoost:GetPropertyChangedSignal("Visible"):Connect(function()
	if WaveriderBoost.Visible then
		UpdateBoostButtonText()
	end
end)

Tool.Destroying:Connect(function()
	StopFovEffect()
end)

-- Cooldown UI
local function UpdateCooldown()
	local cooldownVal = tonumber(Tool:GetAttribute("CooldownTime")) or 0
	local Activate = WaveriderBoost.Activate

	if cooldownVal > 0 then
		Activate.ImageColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Icon.ImageColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Txt.TextColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Cooldown.Text = string.format("%0.1f", cooldownVal)
		Activate.Cooldown.Visible = true
	else
		Activate.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Cooldown.Visible = false
	end
end

Tool:GetAttributeChangedSignal("CooldownTime"):Connect(UpdateCooldown)
UpdateCooldown()--  █████╗ ███╗   ██╗ ██████╗ ███████╗██╗     ██╗   ██╗███████╗    ██████╗ ███████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ██╗██╗     ███████╗███████╗
-- ██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║     ██║   ██║██╔════╝    ██╔══██╗██╔════╝██╔════╝ ██╔═══██╗████╗ ████║██╔══██╗██║██║     ██╔════╝██╔════╝
-- ███████║██╔██╗ ██║██║  ███╗█████╗  ██║     ██║   ██║███████╗    ██║  ██║█████╗  ██║      ██║   ██║██╔████╔██║██████╔╝██║██║     █████╗  ███████╗
-- ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║     ██║   ██║╚════██║    ██║  ██║██╔══╝  ██║      ██║   ██║██║╚██╔╝██║██╔═══╝ ██║██║     ██╔══╝  ╚════██║
-- ██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗╚██████╔╝███████║    ██████╔╝███████╗╚██████╗ ╚██████╔╝██║ ╚═╝ ██║██║     ██║███████╗███████╗███████║
-- ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚══════╝    ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

-- @ Angelus Decompiles — @Chlorls & @imoRR
-- @ Discord : discord.gg/nDWm6PkFrT
-- @ Decompiled

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Net = require(ReplicatedStorage.Packages.Net)
local Spring = require(ReplicatedStorage.Packages.Spring)
local ToolActionInput = require(ReplicatedStorage.Shared.ToolActionInput)
local v1 = script.Parent
local v2 = if v1.Parent:IsA("Model") then Players:GetPlayerFromCharacter(v1.Parent) else v1.Parent.Parent

assert(v2 and v2:IsA("Player"))

if v2 ~= Players.LocalPlayer then
	return
end

local v4 = v2.Character or v2.CharacterAdded:Wait()
local v5 = assert(v4:WaitForChild("HumanoidRootPart", 5))
local v6 = assert(v4:WaitForChild("Humanoid", 5))
local v7 = assert(v6:WaitForChild("Animator", 5))
local Waverider = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Waverider")
local IdleAnimation = Waverider:WaitForChild("IdleAnimation")
local MovingAnimation = Waverider:WaitForChild("MovingAnimation")
local WaveriderBoost = v2.PlayerGui:WaitForChild("ToolsFrames"):WaitForChild("WaveriderBoost")
local v8 = false
local v9 = false
local v10 = nil

local function CheckIfAlive() --[[ CheckIfAlive | Line: 53 | Upvalues: v4 (copy), v6 (copy), v5 (copy), v2 (copy) ]]
	return v4 and (v4.Parent and (v6 and (v6.Parent and (v6.Health > 0 and (v5 and (v5.Parent and (v2 and v2.Parent))))))) and true or false
end

local function GetSpeedMultiplier() --[[ GetSpeedMultiplier | Line: 57 | Upvalues: v1 (copy) ]]
	return tonumber(v1:GetAttribute("SpeedMultiplier")) or 1.65
end

local v11 = nil
local v12 = nil
local v13 = 1.65

local function IsPlayable(p1) --[[ IsPlayable | Line: 71 ]]
	local AnimationId = p1.AnimationId

	return if AnimationId == "" then false else AnimationId ~= "rbxassetid://0"
end

local function LoadTracks() --[[ LoadTracks | Line: 76 | Upvalues: v11 (ref), IdleAnimation (copy), v7 (copy), v12 (ref), MovingAnimation (copy) ]]
	if v11 == nil then
		local AnimationId = IdleAnimation.AnimationId

		if if AnimationId == "" then false else AnimationId ~= "rbxassetid://0" then
			local v2 = v7:LoadAnimation(IdleAnimation)

			v2.Looped = true
			v2.Priority = Enum.AnimationPriority.Idle
			v11 = v2
		end
	end

	if v12 ~= nil then
		return
	end

	local AnimationId = MovingAnimation.AnimationId

	if not (if AnimationId == "" then false else AnimationId ~= "rbxassetid://0") then
		return
	end

	local v4 = v7:LoadAnimation(MovingAnimation)

	v4.Looped = true
	v4.Priority = Enum.AnimationPriority.Movement
	v12 = v4
end

local function StopTracks() --[[ StopTracks | Line: 91 | Upvalues: v11 (ref), v12 (ref) ]]
	if v11 then
		v11:Stop(0.2)
	end

	if not v12 then
		return
	end

	v12:Stop(0.2)
end

local function UpdateFlightAnimation(p1, p2) --[[ UpdateFlightAnimation | Line: 102 | Upvalues: v1 (copy), v13 (ref), v11 (ref), v12 (ref) ]]
	if v1:GetAttribute("Boosting") ~= true then
		v13 = p2
	end

	if p1 > 5 then
		if v11 and v11.IsPlaying then
			v11:Stop(0.2)
		end

		if not v12 then
			return
		end

		local v14, v2

		if v12.IsPlaying then
			v14 = 60 * v13
			v2 = p1 / math.max(v14, 1)
			v12:AdjustSpeed((math.clamp(v2, 0.1, 4)))

			return
		end

		v12:Play(0.2)
		v14 = 60 * v13
		v2 = p1 / math.max(v14, 1)
		v12:AdjustSpeed((math.clamp(v2, 0.1, 4)))

		return
	end

	if v12 and v12.IsPlaying then
		v12:Stop(0.2)
	end

	if not v11 or v11.IsPlaying then
		return
	end

	v11:Play(0.2)
end

local function DisableJump(p1) --[[ DisableJump | Line: 129 | Upvalues: v10 (ref), v6 (copy) ]]
	if v10 then
		v10:Disconnect()
	end

	if not p1 then
		return
	end

	v10 = v6.Changed:Connect(function(p1) --[[ Line: 134 | Upvalues: v6 (ref) ]]
		if p1 ~= "Jump" then
			return
		end

		v6.Jump = false
	end)
end

local v14 = nil

local function HandleFlightControl() --[[ HandleFlightControl | Line: 143 | Upvalues: v4 (copy), v6 (copy), v5 (copy), v2 (copy), v14 (ref), v8 (ref), WaveriderBoost (copy), v10 (ref), v1 (copy), UpdateFlightAnimation (copy), v11 (ref), v12 (ref) ]]
	local v13 = v4 and (v4.Parent and (v6 and (v6.Parent and (v6.Health > 0 and (v5 and (v5.Parent and (v2 and v2.Parent))))))) and true or false

	if not v13 then
		return
	end

	if not v14 then
		v14 = v5.ChildAdded:Connect(function(p13) --[[ Line: 150 | Upvalues: v8 (ref), v5 (ref), WaveriderBoost (ref), v6 (ref), v10 (ref), v4 (ref), v2 (ref), v1 (ref), UpdateFlightAnimation (ref), v11 (ref), v12 (ref) ]]
			if v8 then
				return
			end

			if p13.Name ~= "FlightHold" then
				return
			end

			local FlightSpin = v5:FindFirstChild("FlightSpin")
			local FlightPower = v5:FindFirstChild("FlightPower")
			local FlightHold = v5:FindFirstChild("FlightHold")

			if not (FlightSpin and (FlightPower and FlightHold)) then
				return
			end

			v8 = true
			WaveriderBoost.Visible = true
			v6.WalkSpeed = 0
			v6.PlatformStand = true
			v6.AutoRotate = false

			if v10 then
				v10:Disconnect()
			end

			v10 = v6.Changed:Connect(function(p1) --[[ Line: 134 | Upvalues: v6 (ref) ]]
				if p1 ~= "Jump" then
					return
				end

				v6.Jump = false
			end)
			v5.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			v5.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

			local v13 = assert(workspace.CurrentCamera)

			while v8 and (FlightSpin.Parent and (FlightPower.Parent and FlightHold.Parent)) do
				if not (v4 and (v4.Parent and (v6 and (v6.Parent and (v6.Health > 0 and (v5 and (v5.Parent and (v2 and v2.Parent)))))))) then
					break
				end

				local v42 = tonumber(v1:GetAttribute("SpeedMultiplier")) or 1.65
				local v52 = Vector3.new(0, 0, 0)
				local v62 = v13.CFrame
				local v7 = v62:VectorToWorldSpace(Vector3.new(0, 0, -1))
				local v82 = v62:VectorToWorldSpace(Vector3.new(-1, 0, 0))
				local v9 = CFrame.new(Vector3.new(0, 0, 0), v62.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(v6.MoveDirection)
				local v102 = v52 + (v7 * (60 * v42) * -v9.Z or v52)
				local v112 = v102 + (v82 * (40 * v42) * -v9.X or v102)

				FlightSpin.CFrame = CFrame.new(Vector3.new(0, 0, 0), if v112.Magnitude > 1 then v112.Unit else v7)

				if v112.Magnitude < 1 then
					FlightHold.MaxForce = Vector3.new(FlightHold.P, FlightHold.P, FlightHold.P)
					FlightPower.MaxForce = Vector3.new(0, 0, 0)
					FlightHold.Position = v5.Position
				else
					FlightHold.MaxForce = Vector3.new(0, 0, 0)
					FlightPower.MaxForce = Vector3.new(FlightPower.P * 100, FlightPower.P * 100, FlightPower.P * 100)
				end

				FlightPower.Velocity = v112
				UpdateFlightAnimation(v112.Magnitude, v42)
				task.wait(1 / 60)
			end

			v8 = false
			WaveriderBoost.Visible = false

			if v11 then
				v11:Stop(0.2)
			end

			if v12 then
				v12:Stop(0.2)
			end

			local v16 = v4 and (v4.Parent and (v6 and (v6.Parent and (v6.Health > 0 and (v5 and (v5.Parent and (v2 and v2.Parent))))))) and true or false

			if not v16 then
				return
			end

			v5.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			v5.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			v6.WalkSpeed = 16
			v6.PlatformStand = false
			v6.AutoRotate = true

			if v10 then
				v10:Disconnect()
			end

			v6:ChangeState(Enum.HumanoidStateType.Freefall)
		end)

		return
	end

	v14:Disconnect()
	v14 = v5.ChildAdded:Connect(function(p13) --[[ Line: 150 | Upvalues: v8 (ref), v5 (ref), WaveriderBoost (ref), v6 (ref), v10 (ref), v4 (ref), v2 (ref), v1 (ref), UpdateFlightAnimation (ref), v11 (ref), v12 (ref) ]]
		if v8 then
			return
		end

		if p13.Name ~= "FlightHold" then
			return
		end

		local FlightSpin = v5:FindFirstChild("FlightSpin")
		local FlightPower = v5:FindFirstChild("FlightPower")
		local FlightHold = v5:FindFirstChild("FlightHold")

		if not (FlightSpin and (FlightPower and FlightHold)) then
			return
		end

		v8 = true
		WaveriderBoost.Visible = true
		v6.WalkSpeed = 0
		v6.PlatformStand = true
		v6.AutoRotate = false

		if v10 then
			v10:Disconnect()
		end

		v10 = v6.Changed:Connect(function(p1) --[[ Line: 134 | Upvalues: v6 (ref) ]]
			if p1 ~= "Jump" then
				return
			end

			v6.Jump = false
		end)
		v5.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		v5.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

		local v13 = assert(workspace.CurrentCamera)

		while v8 and (FlightSpin.Parent and (FlightPower.Parent and FlightHold.Parent)) do
			if not (v4 and (v4.Parent and (v6 and (v6.Parent and (v6.Health > 0 and (v5 and (v5.Parent and (v2 and v2.Parent)))))))) then
				break
			end

			local v42 = tonumber(v1:GetAttribute("SpeedMultiplier")) or 1.65
			local v52 = Vector3.new(0, 0, 0)
			local v62 = v13.CFrame
			local v7 = v62:VectorToWorldSpace(Vector3.new(0, 0, -1))
			local v82 = v62:VectorToWorldSpace(Vector3.new(-1, 0, 0))
			local v9 = CFrame.new(Vector3.new(0, 0, 0), v62.LookVector * Vector3.new(1, 0, 1)):VectorToObjectSpace(v6.MoveDirection)
			local v102 = v52 + (v7 * (60 * v42) * -v9.Z or v52)
			local v112 = v102 + (v82 * (40 * v42) * -v9.X or v102)

			FlightSpin.CFrame = CFrame.new(Vector3.new(0, 0, 0), if v112.Magnitude > 1 then v112.Unit else v7)

			if v112.Magnitude < 1 then
				FlightHold.MaxForce = Vector3.new(FlightHold.P, FlightHold.P, FlightHold.P)
				FlightPower.MaxForce = Vector3.new(0, 0, 0)
				FlightHold.Position = v5.Position
			else
				FlightHold.MaxForce = Vector3.new(0, 0, 0)
				FlightPower.MaxForce = Vector3.new(FlightPower.P * 100, FlightPower.P * 100, FlightPower.P * 100)
			end

			FlightPower.Velocity = v112
			UpdateFlightAnimation(v112.Magnitude, v42)
			task.wait(1 / 60)
		end

		v8 = false
		WaveriderBoost.Visible = false

		if v11 then
			v11:Stop(0.2)
		end

		if v12 then
			v12:Stop(0.2)
		end

		local v16 = v4 and (v4.Parent and (v6 and (v6.Parent and (v6.Health > 0 and (v5 and (v5.Parent and (v2 and v2.Parent))))))) and true or false

		if not v16 then
			return
		end

		v5.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		v5.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		v6.WalkSpeed = 16
		v6.PlatformStand = false
		v6.AutoRotate = true

		if v10 then
			v10:Disconnect()
		end

		v6:ChangeState(Enum.HumanoidStateType.Freefall)
	end)
end

local v15 = nil
local v16 = nil
local v17 = nil

local function StopFovEffect() --[[ StopFovEffect | Line: 235 | Upvalues: v17 (ref), v15 (ref), v16 (ref) ]]
	if v17 then
		v17:Disconnect()
		v17 = nil
	end

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera and v15 then
		CurrentCamera.FieldOfView = v15
	end

	v15 = nil
	v16 = nil
end

local function StartFovEffect() --[[ StartFovEffect | Line: 248 | Upvalues: v17 (ref), v15 (ref), Spring (copy), v16 (ref), RunService (copy), v8 (ref), v6 (copy), v1 (copy) ]]
	if v17 then
		return
	end

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera then
		v15 = CurrentCamera.FieldOfView

		local v12 = Spring.new(CurrentCamera.FieldOfView)

		v12.Speed = 12
		v12.Damper = 0.65
		v16 = v12
		v17 = RunService.RenderStepped:Connect(function() --[[ Line: 263 | Upvalues: v15 (ref), v16 (ref), v8 (ref), v6 (ref), v1 (ref) ]]
			local CurrentCamera = workspace.CurrentCamera

			if not (CurrentCamera and (v15 and v16)) then
				return
			end

			local v12 = v15

			if v8 and v6.MoveDirection.Magnitude > 0.1 then
				local v3 = (tonumber(v1:GetAttribute("SpeedMultiplier")) or 1.65) / 1.65

				v12 = v15 + v3 * 6 + (if v1:GetAttribute("Boosting") == true then math.sin(os.clock() * 3) * 1.5 + 15 else 0)
			end

			v16.Target = v12
			CurrentCamera.FieldOfView = v16.Position
		end)
	end
end

local function Equipped() --[[ Equipped | Line: 286 | Upvalues: v4 (copy), v6 (copy), v5 (copy), v2 (copy), v9 (ref), LoadTracks (copy), StartFovEffect (copy), HandleFlightControl (copy) ]]
	if v4 and (v4.Parent and (v6 and (v6.Parent and (v6.Health > 0 and (v5 and (v5.Parent and (v2 and v2.Parent))))))) and true or false then
		v9 = true
		LoadTracks()
		StartFovEffect()
		task.spawn(HandleFlightControl)
	end
end

local function Unequipped() --[[ Unequipped | Line: 296 | Upvalues: v9 (ref), v8 (ref), WaveriderBoost (copy), v11 (ref), v12 (ref), v17 (ref), v15 (ref), v16 (ref), v10 (ref), v14 (ref) ]]
	if not v9 then
		return
	end

	v8 = false
	WaveriderBoost.Visible = false

	if v11 then
		v11:Stop(0.2)
	end

	if v12 then
		v12:Stop(0.2)
	end

	if v17 then
		v17:Disconnect()
		v17 = nil
	end

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera and v15 then
		CurrentCamera.FieldOfView = v15
	end

	v15 = nil
	v16 = nil

	for v1, v2 in { v10, v14 } do
		if v2 then
			v2:Disconnect()
		end
	end

	v9 = false
end

v1.Equipped:Connect(Equipped)
v1.Unequipped:Connect(Unequipped)

local v18 = ToolActionInput.bind(WaveriderBoost, WaveriderBoost.Activate, function() --[[ Line: 315 | Upvalues: Net (copy) ]]
	Net:RemoteEvent("Tools/Waverider/Boost"):FireServer()
end)

v1.Destroying:Connect(function() --[[ Line: 318 | Upvalues: v18 (copy), v17 (ref), v15 (ref), v16 (ref) ]]
	v18()

	if v17 then
		v17:Disconnect()
		v17 = nil
	end

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera and v15 then
		CurrentCamera.FieldOfView = v15
	end

	v15 = nil
	v16 = nil
end)

local function UpdateCooldown() --[[ UpdateCooldown | Line: 323 | Upvalues: v1 (copy), WaveriderBoost (copy) ]]
	local v2 = tonumber(v1:GetAttribute("CooldownTime") or 0) or 0
	local Activate = WaveriderBoost.Activate

	if v2 > 0 then
		Activate.ImageColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Icon.ImageColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Txt.TextColor3 = Color3.fromRGB(128, 128, 128)
		Activate.Cooldown.Text = string.format("%0.1f", v2)
		Activate.Cooldown.Visible = true
	else
		Activate.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Txt.TextColor3 = Color3.fromRGB(255, 255, 255)
		Activate.Cooldown.Visible = false
	end
end

v1:GetAttributeChangedSignal("CooldownTime"):Connect(UpdateCooldown)
UpdateCooldown()