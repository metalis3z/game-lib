local AdminboardService = {}

local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService  = game:GetService("CollectionService")
local Players            = game:GetService("Players")

local Animals = require(ReplicatedStorage.Datas.Animals)

local Net = require(ReplicatedStorage.Packages.Net)
local ListCycle = Net:RemoteFunction("AdminboardService/ListCycle")

local function getEventService()
	return require(ServerScriptService.Services.EventService)
end

local function getLuckService()
	return require(ServerScriptService.Services.LuckService)
end

local function getAnimalService()
	return require(ServerScriptService.Services:WaitForChild("AnimalService"))
end

local ADMINBOARD_TAG = "Adminboard"
local SPIN_INTERVAL  = 30 * 120
local SPIN_DURATION  = 6
local STEP_PERIOD    = 0.35

local cycle = {
	Events = {
		{ Name = "6x Server Luck",   Icon = "rbxassetid://110683846839545" },
		{ Name = "8x Server Luck",   Icon = "rbxassetid://121100427764858" },
		{ Name = "10x Server Luck",  Icon = "rbxassetid://100601425541874" },
		{ Name = "12x Server Luck",  Icon = "rbxassetid://100760966396301" },
		{ Name = "15x Server Luck",  Icon = "rbxassetid://119591742504251" },
		{ Name = "UFO",              Icon = "rbxassetid://110910518481052" },
		{ Name = "Rainbow",          Icon = "rbxassetid://113083327432120" },
		{ Name = "Galaxy",           Icon = "rbxassetid://121332433272976" },
		{ Name = "Candy",            Icon = "rbxassetid://99181785766598"  },
		{ Name = "Bubblegum",        Icon = "rbxassetid://115664804212096" },
		{ Name = "Nyan Cats",          Icon = "rbxassetid://104229924295526" },
		{ Name = "Solar Flare",          Icon = "rbxassetid://117317369032558" },
	},
	Luck = {
		{ LuckIndex = 2,  LuckDuration = 360, Icon = "rbxassetid://92074411396710"  },
		{ LuckIndex = 4,  LuckDuration = 360, Icon = "rbxassetid://90033075589118"  },
		{ LuckIndex = 6,  LuckDuration = 360, Icon = "rbxassetid://94933198053674" },
		{ LuckIndex = 8,  LuckDuration = 300, Icon = "rbxassetid://124799036749678" },
		{ LuckIndex = 10, LuckDuration = 180, Icon = "rbxassetid://137888841783656" },
		{ LuckIndex = 12, LuckDuration = 120,  Icon = "rbxassetid://111270514767194" },
	},
	Items = {
		{ Name = "Admin Lucky Block" },
		{ Name = "Los Lucky Blocks" },
		{ Name = "Los Taco Blocks"},
		{ Name = "Secret Lucky Block" }
	},
}

local function getServerTime(): number
	return workspace:GetServerTimeNow()
end

local function nextSpinDeadline(): number
	local slot = math.floor(getServerTime() / SPIN_INTERVAL)
	return (slot + 1) * SPIN_INTERVAL
end

local function secondsUntilSpin(): number
	return math.max(0, nextSpinDeadline() - getServerTime())
end

local function pickForSlot(count: number, slot: number, salt: number): number
	local s = (slot * 2654435761 + salt * 1000003) % (2 ^ 32)
	s = (s * 1664525 + 1013904223) % (2 ^ 32)
	return (s % count) + 1
end

local function picksAtTime(serverTime: number): (number, number, number)
	local slot = math.floor(serverTime / SPIN_INTERVAL)
	return
		pickForSlot(#cycle.Events, slot, 1),
	pickForSlot(#cycle.Luck , slot, 2),
	pickForSlot(#cycle.Items,  slot, 3)
end

local function executeEvent(eventIdx: number)
	local entry = cycle.Events[eventIdx]
	if not entry then return end

	local ok, err = pcall(function()
		local EventService = getEventService()
		if EventService:IsEventActive(entry.Name) then
			EventService:CancelEvent(entry.Name)
		end
		EventService:ExecuteEvent(entry.Name)
	end)

	if not ok then
		warn("[AdminboardService] executeEvent failed for", entry.Name, "–", err)
	end
end

local function executeLuck(luckIdx: number)
	local entry = cycle.Luck[luckIdx]
	if not entry then return end

	local ok, err = pcall(function()
		local LuckService = getLuckService()
		LuckService:StartLuck(entry.LuckIndex, entry.LuckDuration)
	end)

	if not ok then
		warn("[AdminboardService] executeLuck failed for index", luckIdx, "–", err)
	end
end

local function executeItem(itemIdx: number)
	local entry = cycle.Items[itemIdx]
	if not entry then return end

	local ok, err = pcall(function()
		local AnimalService = getAnimalService()

		local AnimalData = Animals[entry.Name]
		if not AnimalData then
			warn("Lucky Block not found:", entry.Name)
			return
		end

		AnimalService.spawnAnimalCustom(
			AnimalData,
			nil,
			nil,
			nil,
			nil,
			nil
		)
	end)

	if not ok then
		warn("[AdminboardService] executeItem failed for", entry.Name, "–", err)
	end
end

local function clampIndex(i: number, n: number): number
	if n <= 0 then return 1 end
	return math.clamp(math.floor(i), 1, n)
end

local function getBoards(): {Instance}
	return CollectionService:GetTagged(ADMINBOARD_TAG)
end

local function broadcastCountdown(seconds: number)
	local secs = math.max(0, math.floor(seconds))
	for _, board in getBoards() do
		if board and board.Parent then
			board:SetAttribute("Countdown", secs)
		end
	end
end

local function ensureDefaults(board: Instance)
	if board:GetAttribute("Event")      == nil then board:SetAttribute("Event",      1)     end
	if board:GetAttribute("Luck")       == nil then board:SetAttribute("Luck",       1)     end
	if board:GetAttribute("Item")       == nil then board:SetAttribute("Item",       1)     end
	if board:GetAttribute("SpinningIn") == nil then board:SetAttribute("SpinningIn", false) end
	if board:GetAttribute("Countdown")  == nil then board:SetAttribute("Countdown",  0)     end
end

local function runSpinAnimation(boards: {Instance}, finalE: number, finalL: number, finalI: number)
	local startTime = os.clock()

	for _, b in boards do
		if b and b.Parent then b:SetAttribute("SpinningIn", true) end
	end

	while os.clock() - startTime < SPIN_DURATION do
		for _, b in boards do
			if b and b.Parent then
				b:SetAttribute("Event", math.random(1, #cycle.Events))
				b:SetAttribute("Luck",  math.random(1, #cycle.Luck))
				b:SetAttribute("Item",  math.random(1, #cycle.Items))
			end
		end
		task.wait(STEP_PERIOD)
	end

	for _, b in boards do
		if b and b.Parent then
			b:SetAttribute("Event",      finalE)
			b:SetAttribute("Luck",       finalL)
			b:SetAttribute("Item",       finalI)
			b:SetAttribute("SpinningIn", false)
		end
	end

	task.spawn(executeEvent, finalE)
	task.spawn(executeLuck,  finalL)
	task.spawn(executeItem,  finalI)
end

ListCycle.OnServerInvoke = function(_player)
	return cycle
end

function AdminboardService:SetCycle(newCycle: any)
	if type(newCycle) ~= "table" then return end
	if type(newCycle.Events) == "table" then cycle.Events = newCycle.Events end
	if type(newCycle.Luck)   == "table" then cycle.Luck   = newCycle.Luck   end
	if type(newCycle.Items)  == "table" then cycle.Items  = newCycle.Items  end

	for _, board in getBoards() do
		ensureDefaults(board)
		board:SetAttribute("Event", clampIndex(board:GetAttribute("Event") :: number, #cycle.Events))
		board:SetAttribute("Luck",  clampIndex(board:GetAttribute("Luck")  :: number, #cycle.Luck))
		board:SetAttribute("Item",  clampIndex(board:GetAttribute("Item")  :: number, #cycle.Items))
	end
end

function AdminboardService:Start()
	local function initBoard(board: Instance)
		ensureDefaults(board)
		local e, l, i = picksAtTime(getServerTime())
		board:SetAttribute("Event",      e)
		board:SetAttribute("Luck",       l)
		board:SetAttribute("Item",       i)
		board:SetAttribute("SpinningIn", false)
		board:SetAttribute("Countdown",  math.floor(secondsUntilSpin()))
	end

	for _, board in getBoards() do
		initBoard(board)
	end

	CollectionService:GetInstanceAddedSignal(ADMINBOARD_TAG):Connect(function(board)
		initBoard(board)
	end)

	task.spawn(function()
		while true do
			local deadline = nextSpinDeadline()

			while true do
				local remaining = deadline - getServerTime()
				if remaining <= 0 then break end
				broadcastCountdown(remaining)
				task.wait(1)
			end

			broadcastCountdown(0)

			local finalE, finalL, finalI = picksAtTime(getServerTime())
			runSpinAnimation(getBoards(), finalE, finalL, finalI)

			task.wait(2)
		end
	end)
end

return AdminboardService