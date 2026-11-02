local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService   = game:GetService("CollectionService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")

local Eventservice    = require(ServerScriptService.Services.EventService)
local animalservice   = require(ServerScriptService.Services.AnimalService)
local animals         = require(ReplicatedStorage.Datas.Animals)
local Timer           = require(ReplicatedStorage.Packages.Timer)
local TimeUtils       = require(ReplicatedStorage.Utils.TimeUtils)
local AdminboardData  = require(script.Parent:WaitForChild("ListCycleService"))

local BOARD_PART_NAME       = "Adminboard"
local TOTAL_CYCLE           = 3600
local CYCLE_OFFSET          = 0
local DEFAULT_SPIN_DURATION = 300

local boardPart
local countdownTimer


local function getResultsForTimestamp(timestamp)
	local dataLists = AdminboardData.buildList()

	local overrideEvent = boardPart:GetAttribute("OverrideEvent")
	local overrideLuck  = boardPart:GetAttribute("OverrideLuck")
	local overrideItem  = boardPart:GetAttribute("OverrideItem")

	if overrideEvent and overrideLuck and overrideItem then
		boardPart:SetAttribute("OverrideEvent", nil)
		boardPart:SetAttribute("OverrideLuck",  nil)
		boardPart:SetAttribute("OverrideItem",  nil)

		return {
			Event   = dataLists.Events[overrideEvent],
			Luck    = dataLists.Luck[overrideLuck],
			Item    = dataLists.Items[overrideItem],
			Indices = {Event = overrideEvent, Luck = overrideLuck, Item = overrideItem}
		}
	end

	local hourSeed = math.floor(timestamp / TOTAL_CYCLE)
	local rng      = Random.new(hourSeed)

	local eventIdx = rng:NextInteger(1, #dataLists.Events)
	local luckIdx  = rng:NextInteger(1, #dataLists.Luck)
	local itemIdx  = rng:NextInteger(1, #dataLists.Items)

	return {
		Event   = dataLists.Events[eventIdx],
		Luck    = dataLists.Luck[luckIdx],
		Item    = dataLists.Items[itemIdx],
		Indices = {Event = eventIdx, Luck = luckIdx, Item = itemIdx}
	}
end

local function applyRewards(data)
	if not data then return end

	Eventservice:ExecuteEvent(data.Event.Name, Eventservice.EventDurations[data.Event.Name])

	local animal = animals[data.Item.Name]
	if animal then
		animalservice.spawnAnimalCustom(animal)
	else
		warn("Adminboard: Animal not found in data - " .. tostring(data.Item.Name))
	end

	local success, message = Eventservice:ExecuteEvent(data.Luck.Name, Eventservice.EventDurations[data.Luck.Name])
	if not success then
		warn("Adminboard Luck Error: " .. tostring(message))
	end
end

local function getSpinDuration(data)
	if data and data.Event and data.Event.Name then
		local dur = Eventservice.EventDurations[data.Event.Name]
		if dur and dur > 0 then
			return dur
		end
	end
	return DEFAULT_SPIN_DURATION
end

local function startSpinPhase(spinEndTime, nextFlipTime)
	boardPart:SetAttribute("SpinningIn", true)
	boardPart:SetAttribute("SpinStartTime", os.time())
	boardPart:SetAttribute("SpinEndTime", spinEndTime)
	boardPart:SetAttribute("NextFlipTime", nextFlipTime)
end

local function revealResults(data)
	boardPart:SetAttribute("SpinningIn", false)
	boardPart:SetAttribute("Event", data.Indices.Event)
	boardPart:SetAttribute("Luck", data.Indices.Luck)
	boardPart:SetAttribute("Item", data.Indices.Item)
end

local hasInitialized = false
local currentData = nil

local adminboardservice = {}

function adminboardservice.SetCustomPattern(eventIndex, luckIndex, itemIndex)
	boardPart:SetAttribute("OverrideEvent", eventIndex)
	boardPart:SetAttribute("OverrideLuck",  luckIndex)
	boardPart:SetAttribute("OverrideItem",  itemIndex)
end

function adminboardservice:Start()
	task.spawn(function()
		boardPart = workspace:FindFirstChild("AdminBoard") or workspace:FindFirstChild(BOARD_PART_NAME)
		if not boardPart then
			boardPart = Instance.new("Part")
			boardPart.Name = BOARD_PART_NAME
			boardPart.Anchored = true
			boardPart.Parent = workspace
		end
		CollectionService:AddTag(boardPart, "Adminboard")

		countdownTimer = Timer.new(1)
		countdownTimer.Tick:Connect(function()
			local now = os.time()
			local spinningIn = boardPart:GetAttribute("SpinningIn")

			if spinningIn then
				local spinEndTime = boardPart:GetAttribute("SpinEndTime")
				if spinEndTime then
					local remaining = math.max(0, spinEndTime - now)
					boardPart:SetAttribute("TimerDisplay", remaining)
				end
			else
				local nextFlip = boardPart:GetAttribute("NextFlipTime")
				if nextFlip then
					local remaining = math.max(0, nextFlip - now)
					boardPart:SetAttribute("TimerDisplay", remaining)
				end
			end
		end)
		countdownTimer:Start()

		task.spawn(function()
			while true do
				local now = os.time()

				local shiftedNow        = now - CYCLE_OFFSET
				local posInCycle        = shiftedNow % TOTAL_CYCLE
				local currentCycleStart = shiftedNow - posInCycle
				local nextCycleStart    = currentCycleStart + TOTAL_CYCLE

				local realCurrentStart = currentCycleStart + CYCLE_OFFSET
				local realNextStart    = nextCycleStart + CYCLE_OFFSET

				if not hasInitialized then
					hasInitialized = true

					currentData = getResultsForTimestamp(realCurrentStart)

					local spinDuration = getSpinDuration(currentData)
					local spinEndTime  = realCurrentStart + spinDuration
					local inSpinPhase  = posInCycle < spinDuration

					if inSpinPhase then
						startSpinPhase(spinEndTime, realNextStart)

						local spinRemaining = spinDuration - posInCycle
						task.wait(math.max(0, spinRemaining))

						revealResults(currentData)

						local timeUntilNextCycle = realNextStart - os.time()
						if timeUntilNextCycle > 0 then
							task.wait(timeUntilNextCycle)
						end
					else
						boardPart:SetAttribute("NextFlipTime", realNextStart)
						revealResults(currentData)

						local timeUntilNextCycle = realNextStart - os.time()
						if timeUntilNextCycle > 0 then
							task.wait(timeUntilNextCycle)
						end
					end
				else

					if currentData then
						applyRewards(currentData)
					end

					currentData = getResultsForTimestamp(realCurrentStart)

					local spinDuration = getSpinDuration(currentData)
					local spinEndTime  = realCurrentStart + spinDuration

					startSpinPhase(spinEndTime, realNextStart)

					task.wait(spinDuration)

					revealResults(currentData)

					local timeUntilNextCycle = realNextStart - os.time()
					if timeUntilNextCycle > 0 then
						task.wait(timeUntilNextCycle)
					end
				end
			end
		end)
	end)
end

return adminboardservice