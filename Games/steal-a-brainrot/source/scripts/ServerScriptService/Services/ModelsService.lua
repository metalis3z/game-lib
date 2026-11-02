local ModelsService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local Initialized = false

local function findFrom(root, path)
	local current = root
	for i = 1, #path do
		current = current:FindFirstChild(path[i])
		if not current then
			return nil
		end
	end
	return current
end

local function pivot(model, pos, rot)
	model:PivotTo(
		CFrame.new(pos) *
			CFrame.Angles(
				math.rad(rot.X),
				math.rad(rot.Y),
				math.rad(rot.Z)
			)
	)
end

local function safeModel(obj)
	return obj and obj:IsA("Model") and obj or nil
end

local function hasAnyData()
	for _, player in ipairs(Players:GetPlayers()) do
		if Synchronizer:Get(player) then
			return true
		end
	end
	return false
end

function ModelsService:Init()
	if Initialized then
		return
	end

	if not hasAnyData() then
		return
	end

	Initialized = true

	do
		local src = findFrom(workspace, {"Events", "Dul Dul Dul", "Machine"})
		local dst = findFrom(ReplicatedStorage, {"Controllers", "EventController", "Events", "Dul Dul Dul"})

		if src and dst then
			src.Parent = dst
		end
	end

	do
		local m = safeModel(workspace:FindFirstChild("BrainrotTrader"))
		if m then
			pivot(m, Vector3.new(1000000, 1000000, 0), Vector3.new(0, 0, 0))
		end
	end
	
	do
		local m = safeModel(workspace:FindFirstChild("CupidsMachine"))
		if m then
			pivot(m, Vector3.new(1000000, 1000000, 0), Vector3.new(0, 0, 0))
		end
	end
	
	do
		local m = safeModel(workspace:FindFirstChild("TsunamiLTMMachine"))
		if m then
		end
	end

	do
		local m = safeModel(workspace:FindFirstChild("DuelsMachine"))
		if m then
			pivot(m, Vector3.new(1000000, 1000000, 0), Vector3.new(0, 0, 0))
		end
	end

	do
		local bubblegum = findFrom(workspace, {"Events", "Bubblegum"})
		if bubblegum then
			for _, name in ipairs({"Machine", "Machine2", "Machine3"}) do
				local m = safeModel(bubblegum:FindFirstChild(name))
				if m then
					pivot(m, Vector3.new(0, 100000, 0), Vector3.new(0, 0, 0))
				end
			end
		end
	end

	-- [FIX] CraftingMachine: repositionner à sa vraie place
	do
		local m = safeModel(workspace:FindFirstChild("CraftingMachine"))
		if m then
			pivot(m, Vector3.new(-382.326, -0.432, 73.141), Vector3.new(0, 0, 0))
		end
	end

	do
		local m = safeModel(workspace:FindFirstChild("EventBoard"))
		if m then
			pivot(m, Vector3.new(0, 100000, 0), Vector3.new(0, 0, 0))
		end
	end
	
	do
		local m = safeModel(workspace:FindFirstChild("ValentinesShop"))
		if m then
			pivot(m, Vector3.new(0, 100000, 0), Vector3.new(0, 0, 0))
		end
	end

	do
		local events = workspace:FindFirstChild("Events")
		if events then
			for _, name in ipairs({
				"FatSammy",
				"Fishing",
				"Spooky Lucky Block",
				"Festive Lucky Block",
				"Winter Hour",
				"Witching Hour",
				"Taco Base",
				"Valentines Base"
				}) do
				local m = safeModel(findFrom(events, {name, "Model"}))
				if m then
					pivot(m, Vector3.new(0, 100000, 0), Vector3.new(0, 0, 0))
				end
			end
		end
	end

	do
		local events = workspace:FindFirstChild("Events")
		if events then
			for _, name in ipairs({
				"Extinct"
				}) do
				local m = safeModel(findFrom(events, {name, "Model"}))
				if m then
					pivot(m, Vector3.new(1000000, 1000000, 0), Vector3.new(0, 0, 0))
				end
			end
		end
	end
	
	do
		local events = workspace:FindFirstChild("Events")
		if events then
			for _, name in ipairs({
				"Stock"
				}) do
				local m = safeModel(findFrom(events, {name, "Model"}))
				if m then
					pivot(m, Vector3.new(-380.375, -5, 1.715), Vector3.new(0, 180, 0))
				end
			end
		end
	end
	
	do
		local events = workspace:FindFirstChild("Events")
		if events then
			for _, name in ipairs({
				"Lucky Base"
				}) do
				local m = safeModel(findFrom(events, {name, "Model"}))
				if m then
					pivot(m, Vector3.new(-381.09, -9.5, -14.694), Vector3.new(0, 0, 0))
				end
			end
		end
	end

	do
		local m = safeModel(workspace:FindFirstChild("FuseMachine"))
		if m then
		end
	end

	do
		local m = safeModel(workspace:FindFirstChild("Merchant"))
		if m then
			pivot(m, Vector3.new(1000000, 1000000, 0), Vector3.new(0, 0, 0))
		end
	end

	do
		local m = safeModel(workspace:FindFirstChild("RobuxShop"))
		if m then
		end
	end

	do
		local m = safeModel(workspace:FindFirstChild("Santa Merchant"))
		if m then
			pivot(m, Vector3.new(1000000, 1000000, 0), Vector3.new(0, 0, 0))
		end
	end
	
	do
		local m = safeModel(workspace:FindFirstChild("AdminBoard"))
		if m then
			pivot(m, Vector3.new(0, 100000, 0), Vector3.new(0, 0, 0))
		end
	end
	
	do
		local m = safeModel(workspace:FindFirstChild("TradeMachine"))
		if m then
		end
	end
end

function ModelsService:Start()
	task.delay(2, function()
		self:Init()
	end)

	Players.PlayerAdded:Connect(function(player)
		task.spawn(function()
			Synchronizer:Wait(player)
			task.delay(1, function()
				self:Init()
			end)
		end)
	end)
end

return ModelsService