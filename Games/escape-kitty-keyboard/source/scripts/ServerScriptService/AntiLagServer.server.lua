-- AntiLagServer - Server-side performance optimization
-- Spread work across frames to avoid startup freeze
-- NO full GetDescendants() iteration in a single frame

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local BATCH_SIZE = 500 -- process this many instances per frame, then yield

-- Track what we've already optimized
local optimizedParts = {}
local optimizedGuis = {}

local function optimizeSurfaceGui(gui)
	if optimizedGuis[gui] then return end
	optimizedGuis[gui] = true

	if gui.PixelsPerStud > 10 then
		gui.PixelsPerStud = 10
	end
	gui.AlwaysOnTop = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

local function optimizePart(part)
	if optimizedParts[part] then return end
	optimizedParts[part] = true

	local isKeycap = string.find(string.lower(part.Name), "keycap") ~= nil
	local size = part.Size
	local maxDim = math.max(size.X, size.Y, size.Z)

	-- Disable shadows on small decorative parts
	if maxDim < 5 and not isKeycap then
		part.CastShadow = false
	end

	-- Replace expensive materials
	local material = part.Material
	if material == Enum.Material.Glass or material == Enum.Material.Ice then
		part.Material = Enum.Material.SmoothPlastic
		part.Transparency = part.Transparency * 0.5
	elseif material == Enum.Material.Neon and maxDim < 3 then
		part.Material = Enum.Material.SmoothPlastic
	end
end

-- Lighting optimization (fast, one-time)
local function optimizeLighting()
	pcall(function()
		Lighting.ShadowSoftness = 0.2
	end)
	Lighting.GlobalShadows = true
	if Lighting.Brightness > 2 then
		Lighting.Brightness = 2
	end
	Lighting.ClockTime = 14
	if Lighting.FogEnd > 0 and Lighting.FogEnd < 500 then
		Lighting.FogEnd = 100000
		Lighting.FogStart = 0
	end
	print("[AntiLagServer] Lighting optimized")
end

-- Streaming optimization (fast, one-time)
local function optimizeStreaming()
	pcall(function()
		Workspace.StreamingPauseMode = Enum.StreamingPauseMode.ClientPause
	end)
	print("[AntiLagServer] Streaming optimized")
end

-- Spread optimization across frames to avoid freeze
task.spawn(function()
	print("[AntiLagServer] Starting batched optimization...")
	local startTime = os.clock()
	local totalParts = 0
	local totalGuis = 0
	local batchCount = 0

	-- Get all descendants but process in batches
	local allDescendants = Workspace:GetDescendants()
	local totalCount = #allDescendants

	for i = 1, totalCount, BATCH_SIZE do
		local endIndex = math.min(i + BATCH_SIZE - 1, totalCount)

		for j = i, endIndex do
			local desc = allDescendants[j]
			if desc:IsA("SurfaceGui") then
				optimizeSurfaceGui(desc)
				totalGuis = totalGuis + 1
			elseif desc:IsA("BasePart") then
				optimizePart(desc)
				totalParts = totalParts + 1
			end
		end

		batchCount = batchCount + 1
		-- Yield to let the frame render, preventing freeze
		task.wait()
	end

	-- Clear the big table to free memory
	allDescendants = nil

	local elapsed = os.clock() - startTime
	print(string.format("[AntiLagServer] Optimized %d parts, %d guis in %d batches over %.2fs",
		totalParts, totalGuis, batchCount, elapsed))
end)

-- Handle new instances added during gameplay (lightweight, one at a time)
Workspace.DescendantAdded:Connect(function(descendant)
	if descendant:IsA("SurfaceGui") then
		optimizeSurfaceGui(descendant)
	elseif descendant:IsA("BasePart") then
		optimizePart(descendant)
	end
end)

-- Periodic cleanup of empty models (every 2 minutes)
task.spawn(function()
	task.wait(120) -- Wait 2 min before first cleanup
	while true do
		task.wait(120)
		local cleaned = 0
		for _, descendant in Workspace:GetChildren() do
			if descendant:IsA("Model") and #descendant:GetChildren() == 0 then
				descendant.Parent = nil
				cleaned = cleaned + 1
			end
		end
		if cleaned > 0 then
			print("[AntiLagServer] Cleaned " .. cleaned .. " empty models")
		end
	end
end)

-- Run immediate (non-iterative) optimizations
optimizeLighting()
optimizeStreaming()

print("[AntiLagServer] Initialization complete. Batched optimization running in background.")