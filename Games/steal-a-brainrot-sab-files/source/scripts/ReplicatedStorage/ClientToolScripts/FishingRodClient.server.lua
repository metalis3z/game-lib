

local UserInputService = game:GetService("UserInputService")

game:GetService("ServerScriptService")

local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Trove = require(ReplicatedStorage.Packages.Trove)
local RegisterTool = require(ReplicatedStorage.Shared.RegisterTool)

require(ReplicatedStorage.Controllers.AnimalController)

local FishingController = require(ReplicatedStorage.Controllers.FishingController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)

require(ReplicatedStorage.Shared.PID)

local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Net = require(ReplicatedStorage.Packages.Net)
local Spring = require(ReplicatedStorage.Packages.Spring)
local _ = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Fishing = LocalPlayer.PlayerGui.ToolGuis.Fishing
local v17 = Net:RemoteEvent("FishingRod.Cast")
local v18 = Net:RemoteEvent("FishingRod.Cancel")
local v19 = Net:RemoteEvent("FishingRod.SetupBobber")
local v20 = Net:RemoteEvent("FishingRod.MinigameClick")
local v21 = Net:RemoteEvent("FishingRod.Reward")
local v22 = Net:RemoteEvent("FishingRod.BiteGot")

Random.new()

local v23 = Spring.new()

v23.Speed = 45
v23.Damper = 0.8

local v24 = Spring.new(0.1)

v24.Speed = 2
v24.Damper = 1

local v25 = Spring.new(70)

v25.Speed = 30
v25.Damper = 1

local Mover = Fishing.Fillbar.Mover
local u27 = false
local u28 = false

RunService.Heartbeat:Connect(function()
	if u27 then
		Mover.Rotation = v23.p
		v25.t = 80 + 10 * v24.p
		u28 = true

		return
	end

	if u28 then
		u28 = false
		v25.t = 70
		v25.p = 70
		v25.v = 0
	end
end)

local function QuadInOut_Clamped(p1)
	if p1 >= 0.85 then
		return 1
	end

	local v32 = p1 / 0.85

	if v32 < 0.5 then
		return 2 * v32 * v32
	end

	return -1 + (4 - 2 * v32) * v32
end

local t1 = {}

RegisterTool("FishingRod", function(p2)
	local v34 = Trove.new()
	local v35 = v34:Extend()
	local u36 = false
	local n1 = 0
	local n2 = 0
	local n3 = 0
	local Humanoid = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid")
	local t2 = {}

	local function reloadAnimations()
		local EquippedFishingRod = LocalPlayer:GetAttribute("EquippedFishingRod")

		for _, child in (script:FindFirstChild(EquippedFishingRod) or script["Ice Rod"]):GetChildren() do
			local childName = child.Name
			local track = Humanoid:LoadAnimation(child)

			track.Looped = child:GetAttribute("Looped")
			track.Priority = child:GetAttribute("Priority")

			local v80 = t2[childName]

			if v80 then
				if v80.IsPlaying and v80.Looped then
					track:Play()
				end

				v80:Stop()
			end

			t2[childName] = track
		end
	end

	reloadAnimations()
	v34:Add(LocalPlayer:GetAttributeChangedSignal("EquippedFishingRod"):Connect(reloadAnimations))
	v34:Add(RunService.Stepped:Connect(function()
		local Reeling = p2:FindFirstChild("Reeling", true)

		if Reeling then
			Reeling.PlaybackSpeed = 0.9 + v24.p * 0.1
			Reeling.Volume = 0.3 + v24.p * 0.3
		end

		t2.Reeling:AdjustSpeed(v24.p)
	end))

	local function updateMinigameHits()
		if not n1 then
			return
		end

		local v82 = n1 / p2:GetAttribute("minigameHP")

		if n1 > n3 then
			local v83 = 0.2 + 0.6 * v82

			v24.p = math.clamp(v24.p + v83, 0.1, 1.3)
			v24.t = 0.1
			SoundService:PlayLocalSound(Fishing.Click)
		end

		TweenService:Create(Fishing.Fillbar.Fill, TweenInfo.new(0.2), {
			Size = UDim2.fromScale(v82, 1)
		}):Play()
		TweenService:Create(Fishing.Fillbar.Mover, TweenInfo.new(0.25), {
			Position = UDim2.fromScale(math.lerp(0, 0.875, v82), 0.5)
		}):Play()
		n3 = n1
	end
	local function updateMinigameTotalClicks()
		if not n2 then
			return
		end

		if string.format("%.3d", n2) == 0 then
			Fishing.Fillbar.TextLabel.Text = "Click Anywhere!"
		else
			Fishing.Fillbar.TextLabel.Text = `Click Anywhere! (x{ n2 })`
		end

		Fishing.Fillbar.TextLabel.Size = UDim2.fromScale(0.568, 0.75)
		TweenService:Create(Fishing.Fillbar.TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
			Size = UDim2.fromScale(0.7, 0.85)
		}):Play()
	end

	v34:Add(p2:GetAttributeChangedSignal("minigameHits"):Connect(function()
		n1 = p2:GetAttribute("minigameHits")
		updateMinigameHits()
	end))
	v34:Add(p2:GetAttributeChangedSignal("minigameTotalHits"):Connect(function()
		n2 = p2:GetAttribute("minigameTotalHits")
		updateMinigameTotalClicks()
	end))
	v34:Add(p2:GetAttributeChangedSignal("minigame"):Connect(function()
		if not p2:GetAttribute("minigame") then
			t2.Reeling:Stop()
			Fishing.Fillbar.Visible = false
			u27 = false

			return
		end

		u27 = true
		t2.Reeling:Play()
		Fishing.Fillbar.Visible = true
	end))
	v34:Add(p2:GetAttributeChangedSignal("casted"):Connect(function()
		if p2:GetAttribute("casted") and not p2:GetAttribute("minigame") then
			v24.p = 0
			v24.v = 0
			v24.t = 0
			t2.Reeling:Play()

			return
		end

		if not p2:GetAttribute("casted") and not p2:GetAttribute("minigame") then
			t2.Reeling:Stop()
		end
	end))
	v34:Add(p2.Equipped:Connect(function()
		u36 = true
		Fishing.Enabled = true
		Fishing.Fillbar.Visible = false
		Fishing.CastBar.Enabled = false
		t2.Idle:Play()
	end))
	v34:Add(p2.Unequipped:Connect(function()
		u36 = false
		Fishing.Enabled = false
		v35:Destroy()

		for _, v85 in t2 do
			v85:Stop()
		end
	end))

	local u45 = false
	local n4 = -1

	local function onMouseDown()
		local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if p2:GetAttribute("minigame") then
			if time() - n4 < 0.1 then
				return
			end

			n4 = time()
			n1 += 1
			n2 += 1
			updateMinigameTotalClicks()
			updateMinigameHits()
			v20:FireServer()

			return
		end

		if p2:GetAttribute("casted") then
			v18:FireServer()

			return
		end

		if p2:GetAttribute("castCooldown") then
			return
		end

		if u45 then
			return
		end

		u45 = true
		Fishing.CastBar.Enabled = true
		Fishing.CastBar.Adornee = HumanoidRootPart
		v35:Add(function()
			Fishing.CastBar.Enabled = false
		end)

		local v87 = time()
		local n5 = nil
		local u89 = p2:GetAttribute("Luck") or 1

		v35:Add(p2:GetAttributeChangedSignal("Luck"):Connect(function()
			u89 = p2:GetAttribute("Luck") or 1
		end))
		t2.HoldingCast:Play()
		t2.HoldingCast:AdjustSpeed(1)
		v35:Add(function()
			t2.HoldingCast:Stop()
		end)

		while u45 and u36 do
			local v90 = (time() - v87) % 1

			if v90 > 0.5 then
				v90 = 1 - v90
			end

			local v91 = v90 / 0.5

			if v91 >= 0.85 then
				n5 = 1
			else
				local v92 = v91 / 0.85

				n5 = if not (v92 < 0.5) then -1 + (4 - 2 * v92) * v92 else 2 * v92 * v92
			end

			Fishing.CastBar.Bar.Bar.Fill.Size = UDim2.fromScale(1, n5)
			Fishing.CastBar.Bar.Luck.Size = UDim2.fromScale(8, 0.14 + 0.05 * n5)
			Fishing.CastBar.Bar.Luck.Text = `LUCK: { math.floor(math.lerp(1, u89, n5) * 100) / 100 }x`

			if not t2.HoldingCast.IsPlaying then
				t2.HoldingCast:Play()
				t2.HoldingCast.TimePosition = t2.HoldingCast.Length - 0.01
				t2.HoldingCast:AdjustSpeed(0)
			end

			task.wait()
		end

		v35:Destroy()

		if not u36 then
			return
		end

		t2.Cast:Play()
		v17:FireServer(n5)
	end
	local function onMouseUp()
		u45 = false
		v35:Destroy()
	end

	v34:Add(p2.Activated:Connect(onMouseDown))
	v34:Add(p2.Deactivated:Connect(onMouseUp))
	v34:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		if input.UserInputType == Enum.UserInputType.Touch then
			onMouseDown()
		end
	end))
	v34:Add(UserInputService.InputEnded:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		if input.UserInputType == Enum.UserInputType.Touch then
			u45 = false
			v35:Destroy()
		end
	end))
	t1[p2] = {
		animTracks = t2
	}
	v34:Add(function()
		u27 = false
		u36 = false
		Fishing.Enabled = false
		t1[p2] = nil

		for _, v98 in t2 do
			v98:Stop()
		end
	end)

	return v34:WrapClean()
end)
v19.OnClientEvent:Connect(function(p3, p4)
	local PrimaryPart = p3.PrimaryPart

	PrimaryPart.AssemblyLinearVelocity = p4

	local BodyVelocity = Instance.new("BodyVelocity")

	BodyVelocity.MaxForce = Vector3.new(0, 0, 0)
	BodyVelocity.Velocity = Vector3.new(0, 0, 0)
	BodyVelocity.Parent = PrimaryPart
	require(ReplicatedStorage.Shared.PID).new(-16, 16, 36, 1.5, 0.1)

	local v53 = workspace:FindFirstChild("FishingMap") and workspace:FindFirstChild("FishingMap"):QueryDescendants("#CatchZone") or {}
	local connection = nil

	connection = RunService.Stepped:Connect(function(_)
		if not p3 or not p3:IsDescendantOf(workspace) then
			connection:Disconnect()

			return
		end

		local v100 = nil

		for _, v102 in v53 do
			if MathUtils.isPointInVolume(PrimaryPart.CFrame.Position, v102.CFrame, v102.Size + Vector3.new(0, 1.5, 0)) then
				v100 = v102

				break
			end
		end

		if v100 then
			BodyVelocity.MaxForce = Vector3.new(32 + PrimaryPart.AssemblyMass * 32, 1000000000, 32 + PrimaryPart.AssemblyMass * 32)

			local Y = FishingController:WaterSurfacePoint(PrimaryPart.Position).Y

			BodyVelocity.Velocity = Vector3.new(0, 0, 0)
			RunService.RenderStepped:Once(function()
				PrimaryPart.CFrame = CFrame.new(PrimaryPart.Position.X, Y, PrimaryPart.Position.Z)
			end)

			return
		end
	end)
end)
v21.OnClientEvent:Connect(function(p6, p7, p8, _, p10, _)
	if p6 == LocalPlayer then
		t1[p7].animTracks.Catch:Play()
	end

	local v61 = p6.Character and p6.Character:FindFirstChild("HumanoidRootPart")

	if not v61 then
		return
	end

	local v62 = v61.Position - Vector3.new(0, 3, 0)
	local v63 = v62:Lerp(p8, 0.3) + Vector3.new(0, 20, 0)
	local clone = ReplicatedStorage.Models.ToolsExtras.FishingCatch:Clone()

	clone.CFrame = CFrame.new(0, 10000, 0)
	clone.Transparency = 1
	clone.Parent = workspace.Debris

	local function Bezier(p12, p13, p14, p15)
		local v108 = 1 - p15

		return p12 * (v108 * v108) + p14 * (2 * v108 * p15) + p13 * (p15 * p15)
	end

	local Scale = nil
	local n6 = 0
	local connection = nil

	connection = RunService.PreRender:Connect(function(p16)
		n6 += p16

		if n6 >= 0.5 then
			if connection then
				connection:Disconnect()
			end

			task.wait(2)
			clone:Destroy()

			return
		end

		local v110 = p8
		local v111 = v62
		local v112 = v63
		local v113 = n6 / 0.5
		local v114 = 1 - v113
		local v115 = v110 * (v114 * v114) + v112 * (2 * v114 * v113) + v111 * (v113 * v113)
		local v116 = p8
		local v117 = v62
		local v118 = v63
		local v119 = n6 / 0.5 + 0.01
		local v120 = 1 - v119
		local v121 = v116 * (v120 * v120) + v118 * (2 * v120 * v119) + v117 * (v119 * v119)

		clone.CFrame = CFrame.lookAt(v115, v121)

		local v122 = ClientEventUtils.getAnimalModel(p10)

		if not v122 then
			return
		end

		if not Scale then
			Scale = v122:GetScale()
		end

		v122:ScaleTo((math.max(Scale * n6 / 0.5, 0.01)))
		v122:PivotTo(CFrame.new(v115))
	end)
end)
v22.OnClientEvent:Connect(function(p17, _)
	local Character = p17.Character

	assert(Character)

	local Head = Character:FindFirstChild("Head")

	assert(Head)

	local clone = script.FishingGotBite:Clone()

	clone.Adornee = Head
	clone.Parent = Head
	clone.Exclamation:Play()

	local TextLabel = clone.TextLabel

	TextLabel.Rotation = 15
	TextLabel.Size = UDim2.fromScale(0, 0)
	TextLabel.Position = UDim2.fromScale(0.5, 1)
	TweenService:Create(TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Rotation = 0,
		Size = UDim2.fromScale(1, 1)
	}):Play()
	task.delay(2, function()
		if TextLabel:IsDescendantOf(game) then
			TweenService:Create(TextLabel, TweenInfo.new(2), {
				TextTransparency = 1
			}):Play()
			TweenService:Create(TextLabel.UIStroke, TweenInfo.new(2), {
				Transparency = 1
			}):Play()
		end

		task.wait(2)
		clone:Destroy()
	end)
end)
