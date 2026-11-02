--!native
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local EventsDataFolder = ServerScriptService.Services.EventService.Events 
local AnimalsData = require(ReplicatedStorage.Datas.Animals) 
local LuckData = require(ReplicatedStorage.Datas.Luck) 

local LUCK_ORDER = {"30x Server Luck","20x Server Luck","15x Server Luck", "12x Server Luck", "10x Server Luck", "8x Server Luck", "6x Server Luck", "4x Server Luck", "2x Server Luck" }
local ListCycleRemote = Net:RemoteFunction("AdminboardService/ListCycle")

local DEFAULT_ICON = "rbxassetid://17451423471"

local FIXED_EVENT_ORDER = {
	"Ay Mi Gatito",
	"UFO",
	"Rainbow",
	"Candy",
	"Sammy's Base",
	"Bubblegum",
	"Cyber",
	"Mexico",
	"Glitch",
	"Skip Craft",
	"Nyan Cats",
	"Rap Concert",
}

local function getEventIcon(eventName)
	local replicatedgui = ReplicatedStorage:WaitForChild("ReplicatedGui")
	local activevents = replicatedgui:WaitForChild("ActiveEvents"):WaitForChild("ActiveEvents")
	local event = activevents:FindFirstChild(eventName)
	if event and event:FindFirstChildOfClass("ImageLabel") then
		return event:FindFirstChildOfClass("ImageLabel").Image
	end
	if eventName == "Skip Craft" then
		return "rbxassetid://94959630028141"
	end
	return DEFAULT_ICON
end

local function getLuckIcon(luckName)
	local data = LuckData[luckName]
	if data and data.Icon then
		return data.Icon
	end
	return DEFAULT_ICON
end

local function buildList()
	local Events = {}
	local Luck = {}
	local Items = { 
		{Name = "Admin Lucky Block", Icon = DEFAULT_ICON}, 
		{Name = "Los Lucky Blocks", Icon = DEFAULT_ICON}, 
		{Name = "Taco Lucky Block", Icon = DEFAULT_ICON}, 
		{Name = "Los Taco Blocks", Icon = DEFAULT_ICON}, 
		{Name = "Secret Lucky Block", Icon = DEFAULT_ICON} 
	}

	for _, eventName in ipairs(FIXED_EVENT_ORDER) do
		table.insert(Events, {
			Name = eventName,
			Icon = getEventIcon(eventName)
		})
	end

	for _, luckName in ipairs(LUCK_ORDER) do
		table.insert(Luck, {
			Name = luckName,
			Icon = getLuckIcon(luckName)
		})
	end

	return {
		Events = Events,
		Luck = Luck,
		Items = Items,
	}
end

local ListCycleService = {
	buildList = buildList,
}

function ListCycleService:Start()
	task.spawn(function()
		ListCycleRemote.OnServerInvoke = buildList
	end)
end

return ListCycleService
