local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local templates = ServerStorage:WaitForChild("ToolTemplates")
local toolTemplate = templates:WaitForChild("Jetpack")
local wearableTemplate = templates:WaitForChild("JetpackWearable")

local signals = ReplicatedStorage:FindFirstChild("Signals")

if not signals then
	signals = Instance.new("Folder")
	signals.Name = "Signals"
	signals.Parent = ReplicatedStorage
end

local remoteEvents = signals:FindFirstChild("RemoteEvents")

if not remoteEvents then
	remoteEvents = Instance.new("Folder")
	remoteEvents.Name = "RemoteEvents"
	remoteEvents.Parent = signals
end

local remote = remoteEvents:FindFirstChild("JetpackControl")

if not remote then
	remote = Instance.new("RemoteEvent")
	remote.Name = "JetpackControl"
	remote.Parent = remoteEvents
end

local horizontalspeed = 44
local upspeed = 54
local lookupspeed = 18
local force = 90000
local particlerate = 40

local activeBoosts = {}

local function ownsJetpack(player)
	local products = player:FindFirstChild("Products")
	local value = products and products:FindFirstChild("Jetpack")

	return value and value.Value == true
end

local function getTool(container)
	if not container then
		return nil
	end

	local tool = container:FindFirstChild("Jetpack")

	if tool and tool:IsA("Tool") then
		return tool
	end

	return nil
end

local function getEquippedTool(player)
	local character = player.Character

	if not character then
		return nil
	end

	return getTool(character)
end

local function getHumanoid(player)
	local character = player.Character

	if not character then
		return nil
	end

	return character:FindFirstChildOfClass("Humanoid")
end

local function getRoot(player)
	local character = player.Character

	if not character then
		return nil
	end

	return character:FindFirstChild("HumanoidRootPart")
end

local function getTorso(character)
	if not character then
		return nil
	end

	return character:FindFirstChild("UpperTorso")
		or character:FindFirstChild("Torso")
end

local function getWorn(player)
	local character = player.Character

	if not character then
		return nil
	end

	return character:FindFirstChild("EquippedJetpackVisual")
end

local function setEffects(root, enabled)
	if not root then
		return
	end

	for _, inst in ipairs(root:GetDescendants()) do
		if inst:IsA("ParticleEmitter") then
			if enabled and inst.Rate <= 0 then
				local customRate = inst:GetAttribute("JetpackRate")

				if typeof(customRate) == "number" and customRate > 0 then
					inst.Rate = customRate
				else
					inst.Rate = particlerate
				end
			end

			inst.Enabled = enabled

		elseif inst:IsA("PointLight")
			or inst:IsA("SpotLight")
			or inst:IsA("SurfaceLight") then

			inst.Enabled = enabled

		elseif inst:IsA("Beam")
			or inst:IsA("Trail")
			or inst:IsA("Fire")
			or inst:IsA("Smoke")
			or inst:IsA("Sparkles") then

			inst.Enabled = enabled

		elseif inst:IsA("Sound") and inst.Name == "Loop" then
			inst.Looped = true

			if enabled then
				if not inst.IsPlaying then
					inst:Play()
				end
			else
				inst:Stop()
			end
		end
	end
end

local function prepareTool(tool)
	if not tool then
		return
	end

	tool.CanBeDropped = false
	setEffects(tool, false)
end

local function ensureTool(container)
	if not container or getTool(container) then
		return
	end

	local tool = toolTemplate:Clone()

	prepareTool(tool)

	tool.Parent = container
end

local function removeTool(container)
	local tool = getTool(container)

	if tool then
		tool:Destroy()
	end
end

local function syncTool(player)
	if ownsJetpack(player) then
		ensureTool(player:FindFirstChildOfClass("Backpack"))
		ensureTool(player:FindFirstChild("StarterGear"))
	else
		removeTool(player:FindFirstChildOfClass("Backpack"))
		removeTool(player:FindFirstChild("StarterGear"))
		removeTool(player.Character)
	end
end

local function removeWorn(player)
	local worn = getWorn(player)

	if worn then
		setEffects(worn, false)
		worn:Destroy()
	end
end

local function prepareWearable(worn)
	local base =
		worn.PrimaryPart
		or worn:FindFirstChild("Base", true)
		or worn:FindFirstChildWhichIsA("BasePart", true)

	if not base then
		warn("[Jetpack] JetpackWearable has no BasePart")
		return nil
	end

	worn.PrimaryPart = base

	for _, inst in ipairs(worn:GetDescendants()) do
		if inst:IsA("BasePart") then
			inst.Anchored = false
			inst.CanCollide = false
			inst.CanTouch = false
			inst.CanQuery = false
			inst.Massless = true
		end
	end

	for _, inst in ipairs(worn:GetDescendants()) do
		if inst:IsA("BasePart") and inst ~= base then
			local connected = false

			for _, existing in ipairs(inst:GetChildren()) do
				if existing:IsA("WeldConstraint") then
					if existing.Part0 == base or existing.Part1 == base then
						connected = true
						break
					end
				end
			end

			if not connected then
				local weld = Instance.new("WeldConstraint")

				weld.Name = "JetpackInternalWeld"
				weld.Part0 = base
				weld.Part1 = inst
				weld.Parent = inst
			end
		end
	end

	setEffects(worn, false)

	return base
end

local function syncWorn(player)
	local character = player.Character
	local torso = getTorso(character)
	local equipped = getEquippedTool(player)

	if not ownsJetpack(player)
		or not character
		or not torso
		or not equipped then

		removeWorn(player)
		return nil
	end

	local existing = getWorn(player)

	if existing then
		return existing
	end

	local worn = wearableTemplate:Clone()

	worn.Name = "EquippedJetpackVisual"
	worn.Parent = character

	local base = prepareWearable(worn)

	if not base then
		worn:Destroy()
		return nil
	end

	worn:PivotTo(
		torso.CFrame
			* CFrame.new(0, 0.02, 0.42)
			* CFrame.Angles(0, math.rad(180), 0)
	)

	local weld = Instance.new("WeldConstraint")

	weld.Name = "BackWeld"
	weld.Part0 = torso
	weld.Part1 = base
	weld.Parent = base

	return worn
end

local function setJetpackEffects(player, enabled)
	local worn = getWorn(player)

	if worn then
		setEffects(worn, enabled)
	end

	local equipped = getEquippedTool(player)

	if equipped then
		setEffects(equipped, false)
	end
end

local function stopBoost(player)
	local state = activeBoosts[player]

	activeBoosts[player] = nil

	if state then
		if state.linearVelocity then
			state.linearVelocity:Destroy()
		end

		if state.attachment then
			state.attachment:Destroy()
		end
	end

	setJetpackEffects(player, false)
end

local function getBoostState(player)
	local root = getRoot(player)

	if not root then
		return nil
	end

	local state = activeBoosts[player]

	if state then
		if state.root == root
			and state.root.Parent
			and state.linearVelocity
			and state.linearVelocity.Parent then

			return state
		end

		stopBoost(player)
	end

	local attachment = Instance.new("Attachment")

	attachment.Name = "JetpackBoostAttachment"
	attachment.Parent = root

	local linearVelocity = Instance.new("LinearVelocity")

	linearVelocity.Name = "JetpackBoostVelocity"
	linearVelocity.Attachment0 = attachment
	linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
	linearVelocity.MaxForce = force
	linearVelocity.VectorVelocity = Vector3.zero
	linearVelocity.Parent = root

	state = {
		root = root,
		attachment = attachment,
		linearVelocity = linearVelocity,
	}

	activeBoosts[player] = state

	return state
end

local function sanitizeLookVector(player, lookVector)
	if typeof(lookVector) ~= "Vector3"
		or lookVector.Magnitude <= 0 then

		local root = getRoot(player)

		return root
			and root.CFrame.LookVector
			or Vector3.new(0, 0, -1)
	end

	if lookVector.Magnitude > 1.25 then
		return lookVector.Unit
	end

	return lookVector
end

remote.OnServerEvent:Connect(function(player, boosting, lookVector)
	if boosting ~= true then
		stopBoost(player)
		return
	end

	if not ownsJetpack(player) then
		stopBoost(player)
		return
	end

	local equipped = getEquippedTool(player)
	local humanoid = getHumanoid(player)

	if not equipped
		or not humanoid
		or humanoid.Health <= 0 then

		stopBoost(player)
		return
	end

	local worn = syncWorn(player)

	if not worn then
		stopBoost(player)
		return
	end

	local state = getBoostState(player)

	if not state then
		return
	end

	lookVector = sanitizeLookVector(player, lookVector)

	local horizontal = Vector3.new(
		lookVector.X,
		0,
		lookVector.Z
	)

	if horizontal.Magnitude < 0.05 then
		local rootLook = state.root.CFrame.LookVector

		horizontal = Vector3.new(
			rootLook.X,
			0,
			rootLook.Z
		)
	end

	if horizontal.Magnitude > 0 then
		horizontal = horizontal.Unit
	end

	state.linearVelocity.VectorVelocity =
		horizontal * horizontalspeed
		+ Vector3.yAxis
		* (
			upspeed
			+ math.max(lookVector.Y, 0)
			* lookupspeed
		)

	setJetpackEffects(player, true)

	humanoid:ChangeState(
		Enum.HumanoidStateType.Freefall
	)
end)

RunService.Heartbeat:Connect(function()
	for player, state in pairs(activeBoosts) do
		local humanoid = getHumanoid(player)

		if not player.Parent
			or not ownsJetpack(player)
			or not getEquippedTool(player)
			or not getWorn(player)
			or not state.root
			or not state.root.Parent
			or not state.linearVelocity
			or not state.linearVelocity.Parent
			or not humanoid
			or humanoid.Health <= 0 then

			stopBoost(player)
		else
			setJetpackEffects(player, true)
		end
	end
end)

local function watchCharacter(player, character)
	character.ChildAdded:Connect(function(child)
		if child:IsA("Tool")
			and child.Name == "Jetpack" then

			prepareTool(child)

			task.defer(function()
				if player.Parent
					and player.Character == character then

					syncWorn(player)
				end
			end)
		end
	end)

	character.ChildRemoved:Connect(function(child)
		if child:IsA("Tool")
			and child.Name == "Jetpack" then

			stopBoost(player)
			removeWorn(player)
		end
	end)

	task.spawn(function()
		local humanoid =
			character:FindFirstChildOfClass("Humanoid")
			or character:WaitForChild("Humanoid", 10)

		if humanoid then
			humanoid.Died:Connect(function()
				stopBoost(player)
				removeWorn(player)
			end)
		end
	end)
end

local function watchPlayer(player)
	local productConnection

	local function connectProduct()
		if productConnection then
			productConnection:Disconnect()
			productConnection = nil
		end

		local products =
			player:FindFirstChild("Products")
			or player:WaitForChild("Products", 10)

		if not products then
			return
		end

		local value =
			products:FindFirstChild("Jetpack")
			or products:WaitForChild("Jetpack", 10)

		if not value then
			return
		end

		productConnection =
			value:GetPropertyChangedSignal("Value"):Connect(function()

				syncTool(player)

				if value.Value ~= true then
					stopBoost(player)
					removeWorn(player)
				end
			end)

		syncTool(player)
	end

	player.ChildAdded:Connect(function(child)
		if child.Name == "Products" then
			task.spawn(connectProduct)
		end
	end)

	player.CharacterAdded:Connect(function(character)
		stopBoost(player)
		removeWorn(player)

		watchCharacter(player, character)

		task.defer(function()
			if player.Parent then
				syncTool(player)
			end
		end)
	end)

	if player.Character then
		watchCharacter(player, player.Character)
	end

	task.spawn(connectProduct)
end

Players.PlayerAdded:Connect(watchPlayer)

Players.PlayerRemoving:Connect(function(player)
	stopBoost(player)
	activeBoosts[player] = nil
end)

for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(watchPlayer, player)
end