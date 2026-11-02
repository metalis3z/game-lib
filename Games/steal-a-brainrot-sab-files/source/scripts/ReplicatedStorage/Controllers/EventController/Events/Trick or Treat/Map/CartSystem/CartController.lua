local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VFX = require(game:GetService("ReplicatedStorage").Shared.VFX)

local LightsModule = {}

local LightColors = {Color3.fromRGB(255, 174, 93), Color3.fromRGB(255, 81, 0)}
local OffColor = Color3.new(0, 0, 0)

local ridingPlayers = {}

local function BuildLightGroups(cart)
	local groups = {Light1 = {}, Light2 = {}}
	for _, part in ipairs(cart:GetDescendants()) do
		if part:IsA("BasePart") and (part.Name == "Light1" or part.Name == "Light2") then
			table.insert(groups[part.Name], part)
		end
	end
	return groups
end

local function TweenColor(targetPart, duration, color)
	return TweenService:Create(targetPart, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Color = color})
end

local function Flash(parts, color, duration)
	for _, part in ipairs(parts) do
		local tween = TweenColor(part, duration, color)
		tween:Play()
	end
end

local function RunRapid(groups)
	Flash(groups.Light1, LightColors[1], 0.1)
	Flash(groups.Light2, OffColor, 0.04)
	task.wait(0.16)
	for _, part in ipairs(groups.Light1) do part.Color = OffColor end
	Flash(groups.Light1, LightColors[2], 0.1)
	Flash(groups.Light2, LightColors[1], 0.1)
	task.wait(0.16)
	for _, part in ipairs(groups.Light1) do part.Color = OffColor end
end

local function RunInterlude(groups)
	Flash(groups.Light1, LightColors[1], 0.35)
	Flash(groups.Light2, OffColor, 0.1)
	task.wait(0.5)
	Flash(groups.Light2, LightColors[1], 0.35)
	Flash(groups.Light1, OffColor, 0.1)
	task.wait(0.5)
	Flash(groups.Light1, LightColors[2], 0.35)
	Flash(groups.Light2, OffColor, 0.1)
	task.wait(0.5)
	Flash(groups.Light2, LightColors[2], 0.35)
	Flash(groups.Light1, OffColor, 0.1)
	task.wait(0.5)
	Flash(groups.Light1, OffColor, 0.12)
	Flash(groups.Light2, OffColor, 0.12)
	task.wait(0.3)
end

function LightsModule.StartLightShow(cart, delayTime)
	task.spawn(function()
		if delayTime and delayTime > 0 then
			task.wait(delayTime)
		end
		local groups = BuildLightGroups(cart)
		while true do
			RunRapid(groups)
			RunRapid(groups)
			RunInterlude(groups)
		end
	end)
end

local function SetupSound(cart)
	local mainPart = cart:FindFirstChild("Main")
	if not mainPart or not mainPart:IsA("BasePart") then return nil end
	local sound = mainPart:FindFirstChild("CoasterLoop")
	if not sound then
		sound = Instance.new("Sound")
		sound.Name = "CoasterLoop"
		sound.SoundId = "rbxassetid://129348271333576"
		sound.Looped = true
		sound.Volume = 1
		sound.PlayOnRemove = false
		sound.Parent = mainPart
	end
	return sound
end

local function WheelSpin(cart)
	local wheels = {}
	for _, descendant in ipairs(cart:GetDescendants()) do
		if descendant:IsA("Motor6D") and descendant.Name:find("Wheel") then
			table.insert(wheels, {
				Motor = descendant,
				BaseC1 = descendant.C1,
				Angle = 0,
				Speed = math.rad(34.90658503988659)
			})
		end
	end

	RunService.Heartbeat:Connect(function(deltaTime)
		if not cart:GetAttribute("Idle") then
			for _, wheel in ipairs(wheels) do
				if wheel.Motor.Parent then
					wheel.Angle = (wheel.Angle + wheel.Speed * deltaTime) % (2 * math.pi)
					wheel.Motor.C1 = wheel.BaseC1 * CFrame.Angles(wheel.Angle, 0, 0)
				end
			end
		end
	end)
end




local ridingPlayers = {}
local occupiedSeats = {}

local SittingAnimationId = "rbxassetid://2506281703"

local function getFreeSeat(cart)
	for i = 1, 6 do
		local seat = cart.Seats:FindFirstChild("Seat"..i)
		if seat and not occupiedSeats[seat] then
			return seat
		end
	end
	return nil
end

local function weldPlayerToSeat(player, seatPart)
	local char = player.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not root or not humanoid then return end

	humanoid.PlatformStand = true

	root.CFrame = seatPart.CFrame * CFrame.new(0, 2, 0)
	root.CFrame = CFrame.new(root.Position, root.Position + seatPart.CFrame.LookVector)

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = root
	weld.Part1 = seatPart
	weld.Parent = root

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end
	local sitAnim = Instance.new("Animation")
	sitAnim.AnimationId = SittingAnimationId
	local track = animator:LoadAnimation(sitAnim)
	track.Priority = Enum.AnimationPriority.Action
	track:Play()

	occupiedSeats[seatPart] = player
	ridingPlayers[player] = {weld = weld, humanoid = humanoid, seat = seatPart, animationTrack = track}
end

local function releasePlayerFromRide(player)
	local data = ridingPlayers[player]
	if data then
		if data.weld then data.weld:Destroy() end
		if data.animationTrack then data.animationTrack:Stop() end
		if data.humanoid then
			data.humanoid.PlatformStand = false
			data.humanoid.Sit = false
		end
		if data.seat then
			occupiedSeats[data.seat] = nil
		end
		ridingPlayers[player] = nil
	end
end

local function onPromptTriggered(cartPrompt, cart)
	return function(player)
		if not cart:GetAttribute("Idle") then
			local seat = getFreeSeat(cart)
			if seat then
				weldPlayerToSeat(player, seat)
			else
			end
		else
		end
	end
end










local function SetupCart(cart, delayTime, startTime)
	local defaultPivot = cart:GetAttribute("DefaultPivot")
	if not defaultPivot then
		defaultPivot = cart:GetPivot()
		cart:SetAttribute("DefaultPivot", defaultPivot)
	end

	RunService.PostSimulation:Connect(function()
		if (cart:GetPivot().Position - defaultPivot.Position).Magnitude > 2 then
			cart:PivotTo(defaultPivot)
		end
	end)

	local animator = cart:FindFirstChildOfClass("AnimationController"):FindFirstChildOfClass("Animator")
	for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
		track:Stop(0)
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://119337994401490"
	local animationTrack = animator:LoadAnimation(animation)
	animationTrack.Priority = Enum.AnimationPriority.Action4
	animationTrack.Looped = true
	animationTrack:Play(0, 1, 0)
	animationTrack:AdjustSpeed(0)

	local cartSound = SetupSound(cart)

	while animationTrack.Length == 0 and cart:IsDescendantOf(workspace) do
		task.wait()
	end

	if cart:IsDescendantOf(workspace) then
		if delayTime and delayTime > 0 then
			task.wait(delayTime)
		end

		animationTrack.TimePosition = startTime or 0
		cart:SetAttribute("Idle", false)
		VFX.disable(cart)

		animationTrack:AdjustSpeed(0.5)
		cart:SetAttribute("Idle", false)
		VFX.enable(cart)
		if cartSound then cartSound:Play() end

		local prompt = cart.Parent:WaitForChild("Prompt"):WaitForChild("ProximityPrompt")
		prompt.Enabled = true
		prompt.Triggered:Connect(onPromptTriggered(prompt, cart))

		local canTrigger = true
		animationTrack:GetMarkerReachedSignal("Origin"):Connect(function()
			if canTrigger then
				animationTrack.TimePosition = 0.141666
				animationTrack:AdjustSpeed(0)
				if cartSound then cartSound:Pause() end
				cart:SetAttribute("Idle", true)
				VFX.disable(cart)
				for player, _ in pairs(ridingPlayers) do
					releasePlayerFromRide(player)
				end
				task.wait(5)
				canTrigger = false
				task.delay(0.5, function()
					canTrigger = true
				end)
				animationTrack:AdjustSpeed(0.5)
				if cartSound then cartSound:Resume() end
				cart:SetAttribute("Idle", false)
				VFX.enable(cart)
			end
		end)
	end
end

function LightsModule.Start()
	local parent = script.Parent
	local cart1 = parent:FindFirstChild("Cart1")

	if cart1 then
		LightsModule.StartLightShow(cart1, 0)
		WheelSpin(cart1)
		task.spawn(SetupCart, cart1, 0, 0)
	end
end

return LightsModule
