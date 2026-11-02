--!strict
-- LOCATION: ReplicatedStorage/Eventos/Aquatic/Aquatic
-- Evento Aquatic: bolhas de agua sobem e aplicam mutacao Aquatic nos brainrots

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local EventConfig = require(ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("EventConfig"))
local scriptParent = script.Parent

-- State
local isActive = false
local loopThread = nil
local activeBubbles = {}

-- Helper: find mutation module
local function getMutationModule()
	local events = ReplicatedStorage:FindFirstChild("Events")
	if not events then return nil end
	local mutations = events:FindFirstChild("Mutations")
	if not mutations then return nil end
	local aquatic = mutations:FindFirstChild("Aquatic")
	if aquatic then return aquatic:FindFirstChild("Aquatic") end
	return nil
end

-- Helper: find all brainrots in workspace
local function findAllBrainrots()
	local t = {}
	for _, v in ipairs(Workspace:GetChildren()) do
		if v:IsA("Model") and v:GetAttribute("BrainrotName") then
			table.insert(t, v)
		end
	end
	return t
end

-- Helper: sync attribute to parent slot
local function syncToSlot(model, attr, value)
	model:SetAttribute(attr, value)
	local parent = model.Parent
	if parent and parent:GetAttribute("Earn") then
		parent:SetAttribute(attr, value)
	end
end

-- Helper: apply Aquatic mutation to a brainrot
local function applyAquaticMutation(model)
	if not model or not model.Parent then return end

	local list = {}
	for ev in string.gmatch(model:GetAttribute("ActiveEvent") or "", "[^,]+") do
		table.insert(list, ev)
		if ev == "Aquatic" then return end
	end

	local config = EventConfig.Events.Aquatic
	if not config then return end

	local earn = tonumber(model:GetAttribute("Earn")) or 0
	if not model:GetAttribute("BaseEarn") then
		syncToSlot(model, "BaseEarn", earn)
	end

	table.insert(list, "Aquatic")
	local activeStr = table.concat(list, ",")
	syncToSlot(model, "ActiveEvent", activeStr)

	local sum = 0
	for _, ev in ipairs(list) do
		local evConfig = EventConfig.Events[ev]
		if evConfig and evConfig.Multiplier then
			sum = sum + (evConfig.Multiplier - 1)
		end
	end
	syncToSlot(model, "EventMultiplier", sum + 1)

	if (model:GetAttribute("Mutation") or "Normal") == "Normal" then
		syncToSlot(model, "Mutation", "Aquatic")
	end

	-- Show mutation icon in Brainrot_UI
	local brainrotUI = model:FindFirstChild("Brainrot_UI")
	if brainrotUI then
		local uiFrame = brainrotUI:FindFirstChild("Frame")
		if uiFrame then
			local mutationsFolder = uiFrame:FindFirstChild("Mutations")
			if mutationsFolder then
				local icon = mutationsFolder:FindFirstChild("Aquatic")
				if icon then
					icon.Visible = true
				end
			end
			local lblType = uiFrame:FindFirstChild("Type")
			if lblType then
				lblType.Text = "Aquatic"
			end
		end
	end

	-- Apply VFX via mutation module
	local mutModule = getMutationModule()
	if mutModule then
		local ok, result = pcall(require, mutModule)
		if ok and result and result.ApplyVFX then
			result.ApplyVFX(model)
		end
	end

	-- Highlight
	local hl = model:FindFirstChild("EventHighlight")
	if not hl then
		hl = Instance.new("Highlight")
		hl.Name = "EventHighlight"
		hl.FillTransparency = 0.5
		hl.OutlineTransparency = 0.3
		hl.Parent = model
	end
	hl.FillColor = config.Color
	hl.OutlineColor = config.OutlineColor

	-- Burst effect
	local pos = model:GetPivot().Position
	local attachment = Instance.new("Attachment")
	attachment.Position = pos
	attachment.Parent = Workspace.Terrain

	local particles = Instance.new("ParticleEmitter")
	particles.Color = ColorSequence.new(config.Color)
	particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.8), NumberSequenceKeypoint.new(1, 0) })
	particles.Lifetime = NumberRange.new(0.5, 1.2)
	particles.Rate = 100
	particles.Speed = NumberRange.new(8, 15)
	particles.SpreadAngle = Vector2.new(180, 180)
	particles.Parent = attachment
	particles:Emit(40)
	task.delay(2, function()
		particles.Enabled = false
		task.wait(1)
		if attachment and attachment.Parent then attachment:Destroy() end
	end)

	print("[Aquatic] Applied Aquatic mutation to " .. model.Name)
end

-- Helper: spawn a water bubble that targets a brainrot
local function spawnWaterBubble(targetModel)
	if not targetModel or not targetModel.Parent then return end
	if not isActive then return end

	local rootPart = targetModel:FindFirstChild("HumanoidRootPart") or targetModel.PrimaryPart
	if not rootPart then
		for _, d in ipairs(targetModel:GetDescendants()) do
			if d:IsA("BasePart") then rootPart = d break end
		end
	end
	if not rootPart then return end

	local startPos = rootPart.Position + Vector3.new(math.random(-3, 3), -5, math.random(-3, 3))
	local bubble = Instance.new("Part")
	bubble.Name = "AquaticBubble"
	bubble.Shape = Enum.PartType.Ball
	bubble.Size = Vector3.new(0.8, 0.8, 0.8)
	bubble.Color = Color3.fromRGB(0, 150, 255)
	bubble.Material = Enum.Material.Neon
	bubble.Anchored = true
	bubble.CanCollide = false
	bubble.CastShadow = false
	bubble.CFrame = CFrame.new(startPos)
	bubble.Parent = Workspace

	local particles = Instance.new("ParticleEmitter")
	particles.Color = ColorSequence.new(Color3.fromRGB(0, 150, 255))
	particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) })
	particles.Lifetime = NumberRange.new(0.3, 0.6)
	particles.Rate = 20
	particles.Speed = NumberRange.new(0, 1)
	particles.LightEmission = 0.8
	particles.Parent = bubble

	table.insert(activeBubbles, bubble)

	task.spawn(function()
		local startTime = tick()
		while isActive and bubble and bubble.Parent and targetModel and targetModel.Parent do
			task.wait()
			local target = targetModel:FindFirstChild("HumanoidRootPart") or targetModel.PrimaryPart
			if not target then
				for _, d in ipairs(targetModel:GetDescendants()) do
					if d:IsA("BasePart") then target = d break end
					end
			end
			if not target then break end

			local dir = (target.Position - bubble.Position)
			if dir.Magnitude < 4 then
				applyAquaticMutation(targetModel)
				bubble:Destroy()
				return
			end

			local step = dir.Unit * 50 * 0.03
			bubble.CFrame = CFrame.new(bubble.Position + step, bubble.Position + step + dir.Unit)

			if tick() - startTime > 8 then break end
		end
		if bubble and bubble.Parent then bubble:Destroy() end
	end)
end

-- Module
local Aquatic = {}

function Aquatic.Start()
	Aquatic.Stop()
	isActive = true

	loopThread = task.spawn(function()
		while isActive do
			task.wait(math.random(2, 5))
			if not isActive then break end

			local candidates = {}
			for _, br in ipairs(findAllBrainrots()) do
				local hasEvent = false
				for ev in string.gmatch(br:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if ev == "Aquatic" then hasEvent = true break end
					end
				if not hasEvent then table.insert(candidates, br) end
			end

			if #candidates > 0 then
				spawnWaterBubble(candidates[math.random(1, #candidates)])
			end
		end
	end)

	print("[Aquatic] Event started")
end

function Aquatic.Stop()
	isActive = false
	if loopThread then task.cancel(loopThread) loopThread = nil end

	for _, bubble in ipairs(activeBubbles) do
		if bubble and bubble.Parent then bubble:Destroy() end
	end
	activeBubbles = {}

	for _, v in ipairs(Workspace:GetChildren()) do
		if v.Name == "AquaticBubble" then v:Destroy() end
	end

	print("[Aquatic] Event stopped")
end

function Aquatic.ApplyVFX(model)
	local mutModule = getMutationModule()
	if mutModule then
		local ok, result = pcall(require, mutModule)
		if ok and result and result.ApplyVFX then
			result.ApplyVFX(model)
		end
	end
end

function Aquatic.RemoveVFX(model)
	local mutModule = getMutationModule()
	if mutModule then
		local ok, result = pcall(require, mutModule)
		if ok and result and result.RemoveVFX then
			result.RemoveVFX(model)
		end
	end
end

return Aquatic