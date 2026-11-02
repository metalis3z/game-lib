local FatSammy = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/FatSammy/PlaySpawnSequence")
local PlayEatAnimation = Net:RemoteEvent("EventService/FatSammy/PlayEatAnimation")
local Delivery = Net:RemoteEvent("EventService/FatSammy/Delivery")
local RemoteNeeded = Net:RemoteEvent("EventService/FatSammy/RemoteNeeded")
local NotificationService = require(game.ServerScriptService.Services.NotificationService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local StealService = require(game.ServerScriptService.Services.StealService)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Model = Workspace.Events.FatSammy.Model
local isActive = false
local slots = 0
local maxSlots = 15
local s = {}
local animals = {"Tipi Topi Taco", "Capi Taco","Bombardini Tortinii", "Nooo My Hotspot"}
local isFired = false
local eventDuration = 900

local function notify(player)
	NotificationService.Notify(
		player,
		'Sammy is here, and he wants <stroke color="#000"><font color="#fff500">tacos</font></stroke>!',
		5,
		"Sounds.Sfx.Success"
	)
end

local function startCountdown()
	local countdownLabel = Model.Overhead.BillboardGui.Countdown
	local startTime = os.time()
	local endTime = startTime + eventDuration
	task.spawn(function()
		while isActive and os.time() <= endTime do
			local remaining = endTime - os.time()
			local minutes = math.floor(remaining / 60)
			local seconds = remaining % 60
			countdownLabel.Text = string.format("%dm %ds", minutes, seconds)
			task.wait(1)
		end
		if isActive then
			countdownLabel.Text = "0m 0s"
		end
	end)
end

local function updateScaleAndDisplay()
	local scaleValue = math.clamp(slots / maxSlots, 0, 1)
	Model.Overhead.BillboardGui.Amount.Text = slots.."/"..maxSlots
	Model.Sammy:SetAttribute("ScaleAlpha", scaleValue)
end

RunService.Heartbeat:Connect(function()
	if isActive then
		updateScaleAndDisplay()
	end
end)

local deliveryConnected = false

local function resetEvent()
	slots = 0
	table.clear(s)
	isFired = false
	Model.Overhead.BillboardGui.Amount.Text = "0/15"
	Model.Sammy:SetAttribute("ScaleAlpha", 0)
end

local function event()
	Model.Overhead.BillboardGui.Amount.Text = slots.."/"..maxSlots
	if not deliveryConnected then
		Delivery.OnServerEvent:Connect(function(plr)
			if not isActive or slots >= maxSlots then return end
			local idx = plr:GetAttribute("StealingIndex")
			local channel = Synchronizer:Get(plr)
			if not channel then return end
			local list = channel:Get("AnimalPodiums")
			if not list then return end
			for podium, info in pairs(list) do
				if typeof(info) == "table" and info.Steal == plr.UserId and info.Index == idx and table.find(info.Traits, "Taco") then
					info.Steal = nil
					PlayEatAnimation:FireAllClients()
					StealService:CancelSteal(plr, podium)
					list[podium] = "Empty"
					plr:SetAttribute("StealingIndex", nil)
					plr:SetAttribute("Stealing", nil)
					plr:SetAttribute("FatSammy", slots + 1)
					slots += 1
					table.insert(s, info)
					channel:Set("AnimalPodiums", list)
					channel:Set("AnimalAddedOrRemoved", true)
					if slots >= maxSlots then
						task.wait(0.5)
						Burst:FireAllClients(Workspace:GetServerTimeNow())
						task.wait(5)
						if not isFired then
							FatSammy.spawnAnimal()
						end
					end
					break
				end
			end
		end)
		deliveryConnected = true
	end
end

function FatSammy.spawnAnimal()
	if isFired then return end
	isFired = true
	local AnimalService = require(game.ServerScriptService.Services.AnimalService)
	local rad = animals[math.random(1, #animals)]
	local ok, err = pcall(function()
		AnimalService.spawnAnimalCustom(Animals[rad])
	end)
	if not ok then warn("Failed to spawn animal:", err) end
	resetEvent()
end

RemoteNeeded.OnServerEvent:Connect(function(plr, tim)
	ReplicatedStorage:SetAttribute("FatSammyEventEndTime", tim)
end)

function FatSammy.OnStart()
	if isActive then return end
	isActive = true
	resetEvent()
	ReplicatedStorage:SetAttribute("FatSammyEvent", true)
	Model:PivotTo(CFrame.new(-441, -5, 17))
	for _, plr in Players:GetPlayers() do notify(plr) end
	startCountdown()
	event()
end

function FatSammy.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("FatSammyEvent", false)
	Model:PivotTo(CFrame.new(0,100000,0))
	resetEvent()
end

function FatSammy:Feed(times)
	times = times or 15
	if not isActive then
		warn("FatSammy event is not active!")
		return
	end
	PlayEatAnimation:FireAllClients()
	slots = maxSlots
	if slots >= maxSlots and not isFired then
		task.wait(0.5)
		Burst:FireAllClients(Workspace:GetServerTimeNow())
		task.wait(5)
		FatSammy.spawnAnimal()
	end
end

return FatSammy