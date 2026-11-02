local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local TreeController = {}

local SPAWN_YIELD_EVERY = 25

local treesRootRef = nil
local mapRef = nil

local function pickTemplate(treesRoot, treeType)
	local folder = treesRoot:FindFirstChild(treeType)
	local children = folder and folder:GetChildren() or {}
	if #children == 0 then
		return nil
	end
	return children[math.random(1, #children)]
end

local function spawnTree(template, levelPart, localX, localZ, levelIndex, row, col, cfg)
	local clone = template:Clone()

	local bbCF, bbSize = clone:GetBoundingBox()
	clone.WorldPivot = CFrame.new(bbCF.Position.X, bbCF.Position.Y - bbSize.Y / 2, bbCF.Position.Z)

	local topLocal = CFrame.new(localX, levelPart.Size.Y / 2, localZ)
	local topWorld = levelPart.CFrame * topLocal

	local rotY = math.rad(math.random(0, 359))
	clone:PivotTo(CFrame.new(topWorld.Position) * CFrame.Angles(0, rotY, 0))

	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = true
		end
	end

	local hp = math.random(cfg.HealthMin, cfg.HealthMax)
	clone:SetAttribute("MaxHealth", hp)
	clone:SetAttribute("Health", hp)
	clone:SetAttribute("Level", levelIndex)
	clone:SetAttribute("Row", row)
	clone:SetAttribute("Col", col)

	return clone
end

-- Fast, smooth grow from the model's center (used on respawn only).
local function animateZoomIn(model)
	local bbCF = model:GetBoundingBox()
	model.WorldPivot = bbCF
	model:ScaleTo(0.05)
	local proxy = Instance.new("NumberValue")
	proxy.Value = 0.05
	local conn
	conn = proxy:GetPropertyChangedSignal("Value"):Connect(function()
		if model.Parent then
			model:ScaleTo(proxy.Value)
		end
	end)
	local tw = TweenService:Create(proxy, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Value = 1 })
	tw:Play()
	tw.Completed:Once(function()
		conn:Disconnect()
		proxy:Destroy()
		if model.Parent then
			model:ScaleTo(1)
		end
	end)
end

local function spawnSingle(levelIndex, row, col, animateIn)
	if not treesRootRef or not mapRef then
		return nil
	end
	local cfg = GameConfig.Trees and GameConfig.Trees[levelIndex]
	if not cfg then
		return nil
	end
	-- Recursive lookup: TreeLevel parts are nested inside Persistent Model
	-- wrappers (TreeLevel<n>_Persistent) to prevent streaming-induced delete /
	-- restore flicker on camera shake. See PodiumService.Init for the wrap.
	local levelPart = mapRef:FindFirstChild("TreeLevel" .. levelIndex, true)
	if not levelPart then
		return nil
	end
	local container = levelPart:FindFirstChild("Trees")
	if not container then
		return nil
	end

	local template = pickTemplate(treesRootRef, cfg.TreeType)
	if not template then
		return nil
	end

	local longSize = levelPart.Size.X
	local narrowSize = levelPart.Size.Z
	local rowStep = longSize / cfg.Rows
	local colStep = narrowSize / cfg.Cols
	local localX = -longSize / 2 + (row - 0.5) * rowStep
	local localZ = -narrowSize / 2 + (col - 0.5) * colStep

	local clone = spawnTree(template, levelPart, localX, localZ, levelIndex, row, col, cfg)
	clone.Parent = container
	if animateIn then
		animateZoomIn(clone)
	end
	return clone
end

function TreeController.RespawnSlot(levelIndex, row, col, delay)
	task.delay(delay or 0, function()
		spawnSingle(levelIndex, row, col, true)
	end)
end

local function populateLevel(levelIndex, treesRoot, map)
	local cfg = GameConfig.Trees and GameConfig.Trees[levelIndex]
	if not cfg then
		return
	end

	-- WaitForChild has no recursive flag, so poll FindFirstChild instead. The
	-- TreeLevel parts are nested inside Persistent Model wrappers (see
	-- PodiumService.Init) so a non-recursive lookup misses them.
	local levelPart
	local deadline = os.clock() + 30
	while os.clock() < deadline do
		levelPart = map:FindFirstChild("TreeLevel" .. levelIndex, true)
		if levelPart then break end
		task.wait(0.1)
	end
	if not levelPart then
		warn(string.format("[TreeController] TreeLevel%d missing after 30s wait", levelIndex))
		return
	end

	local existing = levelPart:FindFirstChild("Trees")
	if existing then
		existing:Destroy()
	end

	local container = Instance.new("Folder")
	container.Name = "Trees"
	container.Parent = levelPart

	local longSize = levelPart.Size.X
	local narrowSize = levelPart.Size.Z
	local rowStep = longSize / cfg.Rows
	local colStep = narrowSize / cfg.Cols

	local spawned = 0
	for r = 1, cfg.Rows do
		for c = 1, cfg.Cols do
			local template = pickTemplate(treesRoot, cfg.TreeType)
			if not template then
				warn(string.format("[TreeController] No template available for %s", cfg.TreeType))
				return
			end

			local localX = -longSize / 2 + (r - 0.5) * rowStep
			local localZ = -narrowSize / 2 + (c - 0.5) * colStep
			local clone = spawnTree(template, levelPart, localX, localZ, levelIndex, r, c, cfg)
			clone.Parent = container

			spawned = spawned + 1
			if spawned % SPAWN_YIELD_EVERY == 0 then
				task.wait()
			end
		end
	end
end

function TreeController.Init()
	-- Trees removed from the game; spawning disabled (old wood/bridge loop retired).
	do return end
	local treesRoot = ReplicatedStorage:WaitForChild("Trees")
	local map = Workspace:WaitForChild("Assets"):WaitForChild("Map")

	treesRootRef = treesRoot
	mapRef = map

	if not GameConfig.Trees then
		return
	end

	for levelIndex in pairs(GameConfig.Trees) do
		task.spawn(populateLevel, levelIndex, treesRoot, map)
	end
end

return TreeController
