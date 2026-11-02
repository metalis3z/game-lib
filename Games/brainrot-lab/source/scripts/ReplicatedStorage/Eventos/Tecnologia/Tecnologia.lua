--!strict
-- LOCATION: ReplicatedStorage/Eventos/Tecnologia/Tecnologia
-- Evento Tecnologia: particulas de doce caem do ceu e aplicam mutacao Tecnologia nos brainrots

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local EventConfig = require(ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("EventConfig"))

-- State
local isActive = false
local loopThread = nil
local activeDrops = {}

-- Helper: find mutation module
local function getMutationModule()
	local events = ReplicatedStorage:FindFirstChild("Events")
	if not events then return nil end
	local mutations = events:FindFirstChild("Mutations")
	if not mutations then return nil end
	local tecnologia = mutations:FindFirstChild("Tecnologia")
	if tecnologia then return tecnologia:FindFirstChild("Tecnologia") end
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

-- Helper: apply Tecnologia mutation to a brainrot
local function applyTecnologiaMutation(model)
	if not model or not model.Parent then return end

	local list = {}
	for ev in string.gmatch(model:GetAttribute("ActiveEvent") or "", "[^,]+") do
		table.insert(list, ev)
		if ev == "Tecnologia" then return end
	end

	local config = EventConfig.Events.Tecnologia
	if not config then return end

	local earn = tonumber(model:GetAttribute("Earn")) or 0
	if not model:GetAttribute("BaseEarn") then
		syncToSlot(model, "BaseEarn", earn)
	end

	table.insert(list, "Tecnologia")
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
		syncToSlot(model, "Mutation", "Tecnologia")
	end

	-- Show mutation icon in Brainrot_UI
	local brainrotUI = model:FindFirstChild("Brainrot_UI")
	if brainrotUI then
		local uiFrame = brainrotUI:FindFirstChild("Frame")
		if uiFrame then
			local mutationsFolder = uiFrame:FindFirstChild("Mutations")
			if mutationsFolder then
				local icon = mutationsFolder:FindFirstChild("Tecnologia")
				if icon then
					icon.Visible = true
				end
			end
			local lblType = uiFrame:FindFirstChild("Type")
			if lblType then
				lblType.Text = "Tecnologia"
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

	print("[Tecnologia] Applied Tecnologia mutation to " .. model.Name)
end

-- Helper: spawn a tecnologia drop that falls on a brainrot
local function spawnTecnologiaDrop(targetModel)
	if not targetModel or not targetModel.Parent then return end
	if not isActive then return end

	local rootPart = targetModel:FindFirstChild("HumanoidRootPart") or targetModel.PrimaryPart
	if not rootPart then
		for _, d in ipairs(targetModel:GetDescendants()) do
			if d:IsA("BasePart") then rootPart = d break end
		end
	end
	if not rootPart then return end

	local startPos = rootPart.Position + Vector3.new(math.random(-2, 2), 80, math.random(-2, 2))
	local drop = Instance.new("Part")
	drop.Name = "TecnologiaDrop"
	drop.Shape = Enum.PartType.Ball
	drop.Size = Vector3.new(0.6, 0.6, 0.6)
	drop.Color = Color3.fromRGB(255, 100, 200)
	drop.Material = Enum.Material.Neon
	drop.Anchored = true
	drop.CanCollide = false
	drop.CastShadow = false
	drop.CFrame = CFrame.new(startPos)
	drop.Parent = Workspace

	local particles = Instance.new("ParticleEmitter")
	particles.Color = ColorSequence.new(Color3.fromRGB(255, 100, 200))
	particles.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) })
	particles.Lifetime = NumberRange.new(0.3, 0.6)
	particles.Rate = 20
	particles.Speed = NumberRange.new(0, 1)
	particles.LightEmission = 0.8
	particles.Parent = drop

	table.insert(activeDrops, drop)

	task.spawn(function()
		local startTime = tick()
		while isActive and drop and drop.Parent and targetModel and targetModel.Parent do
			task.wait()
			local target = targetModel:FindFirstChild("HumanoidRootPart") or targetModel.PrimaryPart
			if not target then
				for _, d in ipairs(targetModel:GetDescendants()) do
					if d:IsA("BasePart") then target = d break end
					end
			end
			if not target then break end

			local dir = (target.Position - drop.Position)
			if dir.Magnitude < 4 then
				applyTecnologiaMutation(targetModel)
				drop:Destroy()
				return
			end

			local step = dir.Unit * 60 * 0.03
			drop.CFrame = CFrame.new(drop.Position + step, drop.Position + step + dir.Unit)

			if tick() - startTime > 8 then break end
		end
		if drop and drop.Parent then drop:Destroy() end
	end)
end

-- Module
local Tecnologia = {}

function Tecnologia.Start()
	Tecnologia.Stop()
	isActive = true

	loopThread = task.spawn(function()
		while isActive do
			task.wait(math.random(2, 5))
			if not isActive then break end

			local candidates = {}
			for _, br in ipairs(findAllBrainrots()) do
				local hasEvent = false
				for ev in string.gmatch(br:GetAttribute("ActiveEvent") or "", "[^,]+") do
					if ev == "Tecnologia" then hasEvent = true break end
					end
				if not hasEvent then table.insert(candidates, br) end
			end

			if #candidates > 0 then
				spawnTecnologiaDrop(candidates[math.random(1, #candidates)])
			end
		end
	end)

	print("[Tecnologia] Event started")
end

function Tecnologia.Stop()
	isActive = false
	if loopThread then task.cancel(loopThread) loopThread = nil end

	for _, drop in ipairs(activeDrops) do
		if drop and drop.Parent then drop:Destroy() end
	end
	activeDrops = {}

	for _, v in ipairs(Workspace:GetChildren()) do
		if v.Name == "TecnologiaDrop" then v:Destroy() end
	end

	print("[Tecnologia] Event stopped")
end

function Tecnologia.ApplyVFX(model)
	local mutModule = getMutationModule()
	if mutModule then
		local ok, result = pcall(require, mutModule)
		if ok and result and result.ApplyVFX then
			result.ApplyVFX(model)
		end
	end
end

function Tecnologia.RemoveVFX(model)
	local mutModule = getMutationModule()
	if mutModule then
		local ok, result = pcall(require, mutModule)
		if ok and result and result.RemoveVFX then
			result.RemoveVFX(model)
		end
	end
end

return Tecnologia