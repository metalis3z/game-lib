local SteakSnap = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local isActive = false
local snapTask = nil
local Variants = {
	["Raining Burgers"] = {
		"Rainbow",
		"Bubblegum",
		"Bombardiro Crocodilo",
		"Mexico",
		"Solar Flare",
		"Raining Tacos",
		"Crab Rave",
		"Nyan Cats",
	},

	Concert = {
		"Rainbow",
		"Bubblegum",
		"Bombardiro Crocodilo",
		"Mexico",
		"Solar Flare",
		"Concert",
		"Raining Tacos",
		"Crab Rave",
		"Nyan Cats",
	},

	Brazil = {
		"Rainbow",
		"Bubblegum",
		"Bombardiro Crocodilo",
		"Brazil",
		"Mexico",
		"Solar Flare",
		"Raining Tacos",
		"Crab Rave",
		"Nyan Cats",
	},

	["Rap Concert"] = {
		"Rainbow",
		"Bubblegum",
		"Bombardiro Crocodilo",
		"Mexico",
		"Solar Flare",
		"Rap Concert",
		"Raining Tacos",
		"Crab Rave",
		"Nyan Cats",
	},

	Mexico = {
		"Rainbow",
		"Bubblegum",
		"Bombardiro Crocodilo",
		"Ay Mi Gatito",
		"Solar Flare",
		"Mexico",
		"Raining Tacos",
		"Crab Rave",
		"Nyan Cats",
	},

	Indonesia = {
		"Rainbow",
		"Bubblegum",
		"Bombardiro Crocodilo",
		"Easter",
		"Solar Flare",
		"Indonesia",
		"Raining Tacos",
		"Crab Rave",
		"Nyan Cats",
	},

	["Ay Mi Gatito"] = {
		"Rainbow",
		"Bubblegum",
		"Bombardiro Crocodilo",
		"Mexico",
		"Solar Flare",
		"Ay Mi Gatito",
		"Raining Tacos",
		"Crab Rave",
		"Nyan Cats",
	},
}

function SteakSnap.OnStart(eventData)
	if isActive then return end
	isActive = true
	local variant = ServerScriptService:GetAttribute("SteakSnapMusic")
	if not variant then
		local variantKeys = {}
		for key, _ in pairs(Variants) do
			table.insert(variantKeys, key)
		end
		variant = variantKeys[math.random(1, #variantKeys)]
	end
	ReplicatedStorage:SetAttribute("SteakSnapEvent", true)
	ReplicatedStorage:SetAttribute("SteakSnapMusic", variant)
	local EventService = require(ServerScriptService.Services.EventService)
	snapTask = task.delay(6.4, function()
		if not isActive then return end

		local events = Variants[variant]
		if not events then
			print("steak snap problem")
			return
		end
		for _, eventName in ipairs(events) do
			local eventModule = script.Parent:FindFirstChild(eventName)
			if eventModule and eventModule:IsA("ModuleScript") then
				local event = require(eventModule)
				if event.OnStart then
					EventService:ExecuteEvent(eventName)
				else
					warn("Steak Snap " .. eventName .. " does not have an OnStart function!")
				end
			else
				warn("Steak Snap " .. eventName .. " not found or not a ModuleScript")
			end
		end
	end)
end
function SteakSnap.OnStop(eventData)
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("SteakSnapEvent", false)

	if snapTask then
		task.cancel(snapTask)
		snapTask = nil
	end
end
return SteakSnap