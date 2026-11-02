--!native
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local EventsDataFolder = ServerScriptService.Services.EventService.Events 
local AnimalsData = require(ReplicatedStorage.Datas.Animals) 

local LUCK_LIST = { "12x Server Luck","10x Server Luck", "8x Server Luck", "6x Server Luck" }
local ListCycleRemote = Net:RemoteFunction("AdminboardService/ListCycle")

local function getEventIcon(eventName)
	local eventModule = EventsDataFolder:FindFirstChild(eventName)
	if eventModule and eventModule:IsA("ModuleScript") then
		local data = require(eventModule)
		return data.IconAssetId or "rbxassetid://17451423471"
	end
	return "rbxassetid://17451423471"
end

local function buildList()
	local Events = {}
	local Luck = {}
	local Items = {}
	for _, eventModule in pairs(EventsDataFolder:GetChildren()) do
		if eventModule.Name ~= "Template" and eventModule.Name ~= "TemplateModule" and eventModule:IsA("ModuleScript") then
			local iconId = getEventIcon(eventModule.Name)

			local entry = {
				Name = eventModule.Name,
				Icon = iconId,
			}

			if table.find(LUCK_LIST, eventModule.Name) then
				table.insert(Luck, entry)
			else
				table.insert(Events, entry)
			end
		end
	end
	for _, data in pairs(AnimalsData) do
		if data.DisplayName and data.Price and data.Name then
			table.insert(Items, {
				Name = data.Name,
				DisplayName = data.DisplayName,
			})
		end
	end

	return {
		Events = Events,
		Luck = Luck,
		Items = Items,
	}
end

ListCycleRemote.OnServerInvoke = buildList

return {
	ListCycle = buildList,
}