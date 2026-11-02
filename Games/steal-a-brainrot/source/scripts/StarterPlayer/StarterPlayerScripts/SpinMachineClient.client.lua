local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ===== BRAINROT LIST (loaded dynamically from game data - all Secret rarity) =====
local brainrots = {}
local SECRET_COLOR = Color3.fromRGB(44, 44, 44)

-- ===== HELPERS =====
local function ensureLayout(scrollFrame)
	local layout = scrollFrame:FindFirstChildOfClass("UIListLayout")
	if not layout then
		layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 6)
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Parent = scrollFrame
	end
	return layout
end

local function clearLabels(scrollFrame)
	for _, child in ipairs(scrollFrame:GetChildren()) do
		if child:IsA("TextLabel") or child:IsA("Frame") then
			child:Destroy()
		end
	end
end

local function makeLabel(text, color, parent)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -12, 0, 36)
	label.BackgroundColor3 = color
	label.BackgroundTransparency = 0.25
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.Font = Enum.Font.FredokaOne
	label.Parent = parent

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.new(0, 0, 0)
	stroke.Parent = label

	return label
end

local function formatTime(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = math.floor(seconds % 60)
	if hours > 0 then
		return string.format("%dh %dm", hours, minutes)
	elseif minutes > 0 then
		return string.format("%dm %ds", minutes, secs)
	else
		return string.format("%ds", secs)
	end
end

-- ===== MAIN SETUP (deferred so we don't block) =====
task.spawn(function()
	-- Wait for PlayerGui
	local playerGui = player:WaitForChild("PlayerGui")
	local gui = playerGui:WaitForChild("SpinMachineGui", 30)
	if not gui then
		warn("[SpinMachine] SpinMachineGui not found in PlayerGui")
		return
	end

	local mainFrame = gui:WaitForChild("SpinMachine")
	local header = mainFrame:WaitForChild("Header")
	local closeButton = header:WaitForChild("Close")
	local content = mainFrame:WaitForChild("Content")
	local chanceFrame = content:WaitForChild("Chance")
	local chanceScroll = chanceFrame:WaitForChild("ViewportFrame")
	local contentFrame = content:WaitForChild("Content")
	local contentScroll = contentFrame:WaitForChild("ViewportFrame")
	local rollButton = contentFrame:WaitForChild("RollButton")

	-- Ensure GUI is hidden by default
	mainFrame.Visible = false

	-- Wait for SpinMachine in workspace
	local spinMachine = workspace:WaitForChild("SpinMachine", 30)
	if not spinMachine then
		warn("[SpinMachine] SpinMachine model not found in workspace")
		return
	end
	local promptPart = spinMachine:WaitForChild("Prompt")
	local proximityPrompt = promptPart:WaitForChild("ProximityPrompt")

	-- RemoteEvent
	local spinEvent = ReplicatedStorage:WaitForChild("SpinMachineEvent")

	-- ===== LOAD ALL SECRET BRAINROTS FROM GAME DATA =====
	local AnimalsData = nil
	pcall(function()
		AnimalsData = require(ReplicatedStorage:WaitForChild("Datas").Animals)
	end)
	if AnimalsData then
		for name, data in pairs(AnimalsData) do
			if data.Rarity == "Secret" and not data.LuckyBlock then
				table.insert(brainrots, {
					name = name,
					chance = 0,
					color = SECRET_COLOR
				})
			end
		end
	end
	if #brainrots == 0 then
		warn("[SpinMachineClient] No Secret brainrots found!")
		table.insert(brainrots, { name = "Strawberry Elephant", chance = 100, color = SECRET_COLOR })
	end
	-- Equal chance for each Secret brainrot
	local equalChance = math.floor((100000 / #brainrots) + 0.5) / 1000
	for _, b in ipairs(brainrots) do
		b.chance = equalChance
	end

	-- ===== LOAD MUTATION NAMES (for reel variety & anti-duplicate based on mutation) =====
	local mutationNames = {}
	pcall(function()
		local MutationsData = require(ReplicatedStorage:WaitForChild("Datas").Mutations)
		for mname, _ in pairs(MutationsData) do
			table.insert(mutationNames, mname)
		end
	end)

	-- ===== POPULATE CHANCE ViewportFrame =====
	local function populateChances()
		ensureLayout(chanceScroll)
		clearLabels(chanceScroll)

		local sorted = {}
		for _, b in ipairs(brainrots) do
			table.insert(sorted, b)
		end
		table.sort(sorted, function(a, b) return a.chance > b.chance end)

		for i, brainrot in ipairs(sorted) do
			local label = makeLabel(brainrot.name .. "  -  " .. brainrot.chance .. "%", brainrot.color, chanceScroll)
			label.LayoutOrder = i
		end

		chanceScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	end

	-- Require SharedAnimals for 3D models (load once)
	local SharedAnimals = nil
	pcall(function()
		SharedAnimals = require(ReplicatedStorage.Shared.Animals)
	end)

	-- ===== IDLE SCROLL (slow continuous scroll before roll) =====
	local idleConn = nil

	local function clearcontent()
		for _, child in ipairs(contentScroll:GetChildren()) do
			child:Destroy()
		end
		contentScroll.AutomaticCanvasSize = Enum.AutomaticSize.None
		contentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	end

	local function stopIdleScroll()
		if idleConn then
			idleConn:Disconnect()
			idleConn = nil
		end
	end

	local function makeIdentity(name, mutation)
		return name .. "|" .. (mutation or "none")
	end

	-- ===== VIEWPORT CACHE (pre-warm brainrot models for instant loading) =====
	local viewportCache = {}
	local prewarmStarted = false

	-- Hidden container so cached frames don't get destroyed by clearcontent()
	local cacheHolder = Instance.new("Frame")
	cacheHolder.Name = "ViewportCache"
	cacheHolder.Visible = false
	cacheHolder.BackgroundTransparency = 1
	cacheHolder.Parent = mainFrame

	local function prewarmViewports()
		if prewarmStarted then return end
		prewarmStarted = true
		task.spawn(function()
			-- Pre-warm each brainrot without mutation (most common in reel)
			for _, b in ipairs(brainrots) do
				local key = makeIdentity(b.name, nil)
				if not viewportCache[key] then
					local vp = Instance.new("ViewportFrame")
					vp.BackgroundTransparency = 1
					vp.Visible = false
					vp.Parent = cacheHolder
					if SharedAnimals then
						pcall(function()
							SharedAnimals:AttachOnViewport(b.name, vp, nil, nil)
						end)
					end
					viewportCache[key] = vp
				end
				task.wait() -- yield between each to not block the main thread
			end
		end)
	end

	local function getViewportFor(name, mutation)
		local key = makeIdentity(name, mutation)
		if viewportCache[key] then
			-- Clone from cache (instant - model already loaded)
			local clone = viewportCache[key]:Clone()
			clone.Visible = true
			return clone
		end
		-- Not in cache (e.g. with mutation), create fresh
		local vp = Instance.new("ViewportFrame")
		vp.BackgroundTransparency = 1
		if SharedAnimals then
			pcall(function()
				SharedAnimals:AttachOnViewport(name, vp, nil, mutation)
			end)
		end
		return vp
	end

	local function pickRandomReelItem(excludeKey)
		local item = nil
		local key = excludeKey
		local attempts = 0
		repeat
			local b = brainrots[math.random(1, #brainrots)]
			local mutation = nil
			if #mutationNames > 0 and math.random() < 0.6 then
				mutation = mutationNames[math.random(1, #mutationNames)]
			end
			key = makeIdentity(b.name, mutation)
			item = { name = b.name, mutation = mutation, key = key }
			attempts = attempts + 1
		until key ~= excludeKey or attempts > 20 or #brainrots <= 1
		return item
	end

	local function startIdleScroll()
		stopIdleScroll()
		clearcontent()

		local reelWindow = Instance.new("Frame")
		reelWindow.Size = UDim2.new(1, 0, 1, 0)
		reelWindow.Position = UDim2.new(0, 0, 0, 0)
		reelWindow.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
		reelWindow.BackgroundTransparency = 0.3
		reelWindow.ClipsDescendants = true
		reelWindow.Parent = contentScroll

		local reelStroke = Instance.new("UIStroke")
		reelStroke.Thickness = 3
		reelStroke.Color = Color3.new(0, 0, 0)
		reelStroke.Parent = reelWindow

		task.wait()
		local windowHeight = reelWindow.AbsoluteSize.Y
		local windowWidth = reelWindow.AbsoluteSize.X
		local ITEM_WIDTH = math.max(80, math.floor(windowHeight * 0.65))
		local ITEM_PAD = 25
		local ITEM_PITCH = ITEM_WIDTH + ITEM_PAD

		-- Generate enough items for seamless wrap (2 sets of the same items)
		local visibleCount = math.ceil(windowWidth / ITEM_PITCH) + 2
		local reelItems = {}
		local lastKey = nil
		for i = 1, visibleCount do
			local ri = pickRandomReelItem(lastKey)
			reelItems[i] = ri
			lastKey = ri.key
		end
		-- Duplicate for seamless looping
		local totalItems = visibleCount * 2
		local reelWidth = totalItems * ITEM_PITCH

		local reelContent = Instance.new("Frame")
		reelContent.Size = UDim2.new(0, reelWidth, 1, 0)
		reelContent.BackgroundTransparency = 1
		reelContent.Parent = reelWindow

		local reelLayout = Instance.new("UIListLayout")
		reelLayout.FillDirection = Enum.FillDirection.Horizontal
		reelLayout.Padding = UDim.new(0, ITEM_PAD)
		reelLayout.Parent = reelContent

		for i = 1, totalItems do
			local idx = ((i - 1) % visibleCount) + 1
			local ri = reelItems[idx]
			local item = getViewportFor(ri.name, ri.mutation)
			item.Size = UDim2.new(0, ITEM_WIDTH, 1, 0)
			item.Parent = reelContent
		end

		-- Continuous slow scroll with seamless wrap
		local scrollSpeed = 22 -- pixels per second (slow)
		local oneSetWidth = visibleCount * ITEM_PITCH
		local startTime = tick()

		idleConn = RunService.RenderStepped:Connect(function()
			local elapsed = tick() - startTime
			local offset = (elapsed * scrollSpeed) % oneSetWidth
			reelContent.Position = UDim2.new(0, -offset, 0, 0)
		end)
	end

	-- ===== ROLL STATE =====
	local rolling = false

	-- ===== ROLL ANIMATION =====
	local function playRollAnimation(brainrotName, color)
		stopIdleScroll()
		clearcontent()

		local reelWindow = Instance.new("Frame")
		reelWindow.Size = UDim2.new(1, 0, 1, 0)
		reelWindow.Position = UDim2.new(0, 0, 0, 0)
		reelWindow.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
		reelWindow.BackgroundTransparency = 0.3
		reelWindow.ClipsDescendants = true
		reelWindow.Parent = contentScroll

		local reelStroke = Instance.new("UIStroke")
		reelStroke.Thickness = 3
		reelStroke.Color = Color3.new(0, 0, 0)
		reelStroke.Parent = reelWindow

		task.wait()
		local windowHeight = reelWindow.AbsoluteSize.Y
		local windowWidth = reelWindow.AbsoluteSize.X
		local ITEM_WIDTH = math.max(80, math.floor(windowHeight * 0.65))
		local ITEM_PAD = 25
		local ITEM_PITCH = ITEM_WIDTH + ITEM_PAD

		-- Center highlight
		local highlight = Instance.new("Frame")
		highlight.Size = UDim2.new(0, ITEM_WIDTH, 1, 0)
		highlight.Position = UDim2.new(0.5, -ITEM_WIDTH / 2, 0, 0)
		highlight.BackgroundColor3 = color
		highlight.BackgroundTransparency = 0.75
		highlight.BorderSizePixel = 0
		highlight.ZIndex = 5
		highlight.Parent = reelWindow

		-- Left fade
		local leftFade = Instance.new("Frame")
		leftFade.Size = UDim2.new(0, 40, 1, 0)
		leftFade.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
		leftFade.BorderSizePixel = 0
		leftFade.ZIndex = 10
		leftFade.Parent = reelWindow

		-- Right fade
		local rightFade = Instance.new("Frame")
		rightFade.Size = UDim2.new(0, 40, 1, 0)
		rightFade.Position = UDim2.new(1, -40, 0, 0)
		rightFade.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
		rightFade.BorderSizePixel = 0
		rightFade.ZIndex = 10
		rightFade.Parent = reelWindow

		-- Slot machine reel (more items = longer spin = more suspense)
		local TOTAL_ITEMS = 20
		local STOP_INDEX = TOTAL_ITEMS - 3 -- winning item lands here

		local reelContent = Instance.new("Frame")
		reelContent.Size = UDim2.new(0, TOTAL_ITEMS * ITEM_PITCH, 1, 0)
		reelContent.BackgroundTransparency = 1
		reelContent.Parent = reelWindow

		local reelLayout = Instance.new("UIListLayout")
		reelLayout.FillDirection = Enum.FillDirection.Horizontal
		reelLayout.Padding = UDim.new(0, ITEM_PAD)
		reelLayout.Parent = reelContent

		-- Populate reel items (no adjacent duplicates) - staggered for smooth loading
		local lastKey = nil
		for i = 1, TOTAL_ITEMS do
			local ri
			if i == STOP_INDEX then
				ri = { name = brainrotName, mutation = nil, key = makeIdentity(brainrotName, nil) }
			elseif i > STOP_INDEX then
				ri = pickRandomReelItem(makeIdentity(brainrotName, nil))
			else
				ri = pickRandomReelItem(lastKey)
			end
			lastKey = ri.key

			local item = getViewportFor(ri.name, ri.mutation)
			item.Size = UDim2.new(0, ITEM_WIDTH, 1, 0)
			item.Parent = reelContent

			-- Stagger every 4 items so the engine can render without frame drops
			if i % 4 == 0 and i < TOTAL_ITEMS then
				task.wait()
			end
		end

		-- Animate: 9 seconds with dramatic suspense easing
		local itemCenter = (STOP_INDEX - 1) * ITEM_PITCH + ITEM_WIDTH / 2
		local targetX = -(itemCenter - windowWidth / 2)
		local startX = windowWidth
		local duration = 9 -- longer for more suspense
		local startTime = tick()

		local conn
		conn = RunService.RenderStepped:Connect(function()
			local elapsed = tick() - startTime
			local t = math.clamp(elapsed / duration, 0, 1)

			-- Multi-phase easing for maximum suspense:
			-- Phase 1 (0-70%): Fast spin with ease-out quintic
			-- Phase 2 (70-90%): Dramatic slow-down
			-- Phase 3 (90-100%): Tiny overshoot then settle (bounce)
			local eased
			if t < 0.7 then
				-- Fast spin phase: ease-out quintic
				local phaseT = t / 0.7
				eased = 1 - math.pow(1 - phaseT, 5)
				eased = eased * 0.82 -- map to 0-0.82 of total travel
			elseif t < 0.9 then
				-- Slow crawl phase: very gradual
				local phaseT = (t - 0.7) / 0.2
				local phaseEased = 1 - math.pow(1 - phaseT, 2)
				eased = 0.82 + phaseEased * 0.15 -- 0.82 to 0.97
			else
				-- Final settle: tiny overshoot and bounce back
				local phaseT = (t - 0.9) / 0.1
				-- Overshoot by ~8px then settle
				local overshoot = math.sin(phaseT * math.pi) * 0.03
				eased = 0.97 + phaseT * 0.03 + overshoot
				eased = math.clamp(eased, 0, 1)
			end

			local currentX = startX + (targetX - startX) * eased

			reelContent.Position = UDim2.new(0, currentX, 0, 0)

			if t >= 1 then
				conn:Disconnect()

				-- Tell server to spawn the brainrot now that animation is done
				spinEvent:FireServer("Spawn")

				-- Replace reel with result
				reelContent:Destroy()
				highlight:Destroy()
				leftFade:Destroy()
				rightFade:Destroy()

				-- Result text
				local resultLabel = Instance.new("TextLabel")
				resultLabel.Size = UDim2.new(1, 0, 0, 45)
				resultLabel.Position = UDim2.new(0, 0, 0, 5)
				resultLabel.BackgroundTransparency = 1
				resultLabel.Text = "You obtained " .. brainrotName .. "!"
				resultLabel.TextColor3 = Color3.new(1, 1, 1)
				resultLabel.TextScaled = true
				resultLabel.Font = Enum.Font.FredokaOne
				resultLabel.ZIndex = 15
				resultLabel.Parent = reelWindow

				local resultStroke = Instance.new("UIStroke")
				resultStroke.Thickness = 2
				resultStroke.Color = Color3.new(0, 0, 0)
				resultStroke.Parent = resultLabel

				-- Brainrot 3D model (use cache for instant load)
				local resultVP = getViewportFor(brainrotName, nil)
				resultVP.Size = UDim2.new(1, 0, 1, -55)
				resultVP.Position = UDim2.new(0, 0, 0, 52)
				resultVP.Parent = reelWindow

				rollButton.Text = "ROLL"
				rolling = false

				-- After 4 seconds, restart idle scroll
				task.delay(4, function()
					if not rolling and mainFrame.Visible then
						startIdleScroll()
					end
				end)
			end
		end)
	end

	-- ===== EVENTS =====
	proximityPrompt.Triggered:Connect(function()
		mainFrame.Visible = true
		startIdleScroll()
	end)

	closeButton.MouseButton1Click:Connect(function()
		mainFrame.Visible = false
		stopIdleScroll()
	end)

	-- Roll button
	rollButton.MouseButton1Click:Connect(function()
		if rolling then return end
		rolling = true
		rollButton.Text = "..."
		stopIdleScroll()
		spinEvent:FireServer("Roll")
	end)

	-- ===== SERVER RESPONSE =====
	spinEvent.OnClientEvent:Connect(function(data)
		if not data then return end

		if data.action == "skipTimers" then
			rollButton.Text = "ROLL"
			rolling = false
			if mainFrame.Visible then startIdleScroll() end
			return
		end

		if not data.success then
			if data.remaining then
				rollButton.Text = "Wait " .. formatTime(data.remaining)
			else
				rollButton.Text = "ERROR"
			end
			rolling = false
			if mainFrame.Visible then startIdleScroll() end
			return
		end

		-- Success: play roll animation
		local brainrotName = data.brainrot
		local color = Color3.fromRGB(150, 150, 150)
		for _, b in ipairs(brainrots) do
			if b.name == brainrotName then
				color = b.color
				break
			end
		end

		playRollAnimation(brainrotName, color)
	end)

	-- ===== INIT =====
	prewarmViewports()
	populateChances()
	rollButton.Text = "ROLL"
end)