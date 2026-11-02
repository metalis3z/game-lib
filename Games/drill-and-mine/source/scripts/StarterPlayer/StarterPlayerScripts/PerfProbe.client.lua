-- PerfProbe: press F8 during a playtest to run a ~21s automated A/B scan.
-- Measures average FPS with each render subsystem briefly disabled, prints
-- a report to the output console, then restores EVERYTHING exactly.
-- Diagnostic only -- does nothing until F8 is pressed.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local PHASE_SECONDS = 3
local running = false

local function measure(seconds)
	local frames = 0
	local t0 = os.clock()
	local conn = RunService.RenderStepped:Connect(function()
		frames += 1
	end)
	task.wait(seconds)
	conn:Disconnect()
	local elapsed = math.max(os.clock() - t0, 1e-3)
	return frames / elapsed
end

-- collectors return {{inst, prop, prev, off}} lists of currently-ON things
local function collectViewports()
	local list = {}
	for _, d in ipairs(playerGui:GetDescendants()) do
		if d:IsA("ViewportFrame") and d.Visible then
			table.insert(list, { inst = d, prop = "Visible", prev = true, off = false })
		end
	end
	return list
end

local function collectWorkspaceClass(className)
	local list = {}
	for _, d in ipairs(workspace:GetDescendants()) do
		if d:IsA(className) and d.Enabled then
			table.insert(list, { inst = d, prop = "Enabled", prev = true, off = false })
		end
	end
	return list
end

local function apply(list, on)
	for _, e in ipairs(list) do
		if e.inst.Parent then
			e.inst[e.prop] = on and e.prev or e.off
		end
	end
end

local function runScan()
	if running then return end
	running = true
	print("[PerfScan] starting -- ~21s, visuals will flicker off in groups, everything restores after")

	local phases = {
		{ name = "viewports", list = collectViewports() },
		{ name = "particles", list = collectWorkspaceClass("ParticleEmitter") },
		{ name = "beams", list = collectWorkspaceClass("Beam") },
		{ name = "lights", list = collectWorkspaceClass("Light") },
		{ name = "surface+billboard guis", list = collectWorkspaceClass("SurfaceGui") },
	}
	-- fold billboards into the last phase
	for _, e in ipairs(collectWorkspaceClass("BillboardGui")) do
		table.insert(phases[#phases].list, e)
	end

	local baseline = measure(PHASE_SECONDS)
	local results = {}

	for _, phase in ipairs(phases) do
		apply(phase.list, false)
		local fps = measure(PHASE_SECONDS)
		apply(phase.list, true)
		table.insert(results, { name = phase.name, fps = fps, n = #phase.list })
	end

	-- everything off at once = the total recoverable headroom
	for _, phase in ipairs(phases) do apply(phase.list, false) end
	local allOff = measure(PHASE_SECONDS)
	for _, phase in ipairs(phases) do apply(phase.list, true) end

	local lines = {}
	table.insert(lines, ("BASELINE: %.0f fps (%.2f ms)"):format(baseline, 1000 / baseline))
	for _, r in ipairs(results) do
		table.insert(lines, ("%s OFF (%d instances): %.0f fps (%+.0f vs baseline)"):format(r.name, r.n, r.fps, r.fps - baseline))
	end
	table.insert(lines, ("EVERYTHING OFF: %.0f fps (%+.0f vs baseline)"):format(allOff, allOff - baseline))
	for _, l in ipairs(lines) do
		print("[PerfScan] " .. l)
	end
	print("[PerfScan] done -- all visuals restored")
	-- ALSO store the report on a StringValue: Studio's captured console does
	-- not include play-session prints, so this is read live via the MCP
	-- bridge while the playtest is still running
	local holder = game:GetService("ReplicatedStorage"):FindFirstChild("PerfScanResults")
	if not holder then
		holder = Instance.new("StringValue")
		holder.Name = "PerfScanResults"
		holder.Parent = game:GetService("ReplicatedStorage")
	end
	holder.Value = table.concat(lines, " | ")
	running = false
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F8 then
		task.spawn(runScan)
	end
end)

-- Auto-run REMOVED (user 2026-07-17: the scan's grouped blink-off read as
-- "all my UI disappears out of nowhere"). F8 stays as the manual trigger.

-- ===== passive sampler =====
-- Zero visual effect: every 5s publish a rolling report (real FPS + engine
-- stat split) to ReplicatedStorage.PerfScanResults so the MCP bridge can
-- read it live during any playtest. High HeartbeatTimeMs = script-bound;
-- low script/physics time with low FPS = render-bound (world/UI/Studio).
local StatsService = game:GetService("Stats")
task.spawn(function()
	local RS = game:GetService("ReplicatedStorage")
	local holder = RS:FindFirstChild("PerfScanResults")
	if not holder then
		holder = Instance.new("StringValue")
		holder.Name = "PerfScanResults"
		holder.Parent = RS
	end
	while true do
		local frames = 0
		local conn = RunService.RenderStepped:Connect(function()
			frames += 1
		end)
		task.wait(5)
		conn:Disconnect()
		local fps = frames / 5
		local parts = { string.format("FPS %.0f (%.1f ms/frame)", fps, 1000 / math.max(fps, 1)) }
		for _, statName in ipairs({ "HeartbeatTimeMs", "PhysicsStepTimeMs", "InstanceCount", "MovingPrimitivesCount", "ContactsCount", "DataReceiveKbps" }) do
			local ok, v = pcall(function()
				return StatsService[statName]
			end)
			if ok and typeof(v) == "number" then
				table.insert(parts, string.format("%s %.2f", statName, v))
			end
		end
		local okMem, mem = pcall(function()
			return StatsService:GetTotalMemoryUsageMb()
		end)
		if okMem then
			table.insert(parts, string.format("MemMB %.0f", mem))
		end
		holder.Value = table.concat(parts, " | ")
	end
end)
