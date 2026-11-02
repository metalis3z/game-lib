local EventService: any = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)

local ListEvents = Net:RemoteFunction("EventService/ListEvents")

local Events = {
	"6x Server Luck",
	"8x Server Luck",
	"10x Server Luck",
	"12x Server Luck",
	"15x Server Luck",
	"20x Server Luck",
	"25x Server Luck",
	"500x Server Luck",
	"2000x Server Luck",
	"1x1x1x1",
	"10B Visits",
	"John Pork",
	"Mario",
	"Summer",
	"Mango",
	"Jul",
	"Headless",
	"Indonesia",
	"Italy",
	"Cyber",
	"Elexir",
	"GUIGUI",
	"Raining Burger",
	"Easter",
	"Eid",
	"3 Roads",
	"Steak Snap",
	"Badr Snap",
	"4th of July",
	"STBANCAL",
	"Bloodmoon",
	"Bombardiro Crocodilo",
	"Brazil",
	"Bubblegum",
	"Candy",
	"Chicleteira Bicicleteira",
	"Concert",
	"Crab Rave",
	"Dul Dul Dul",
	"Extinct",
	"FatSammy",
	"Galaxy",
	"Glitch",
	"Graveyard",
	"France",
	"La Vacca Saturno Saturnita",
	"Los Matteos",
	"Matteo",
	"Meowl",
	"Mexico",
	"Molten",
	"Nyan Cats",
	"Sammy's Base",
	"Phase 4: Mygame43",
	"Phase 5: Sammy Snap",
	"Duo Snap Zyna x Badr",
	"Ibrx Snap",
	"Kinoshi",
	"Teykx",
	"Teykx Lazer",
	"Ibrx",
	"Rain",
	"Fishing",
	"Rainbow",
	"Raining Tacos",
	"Rap Concert",
	"Sammyni Spyderini",
	"Snow",
	"Solar Flare",
	"Starfall",
	"Strawberry",
	"Trick or Treat",
	"UFO",
	"Water",
	"Witching Hour",
	"YinYang",
	"Winter Hour",
	"Radioactive",
	"Stock",
	"Skibidi",
	"Gingerbread Town",
	"2026",
	"Cursed",
	"Lance",
	"Ay Mi Gatito",
	"Valentines",
	"Divine",
	"Fuse Machine Luck",
	"Tung Tung Attack",
	"St Patricks",
	"Phase 1: Sleepy",
	"Phase 2: Galaxy Introduction",
	"Werenoi",
	"Backrooms",
	"1 Year",
	"1K Visits",
	"Hacker",
	"3K"
}

EventService.Channels = {}
EventService.EventConfigs = {}
EventService.ActiveEvents = {}
EventService.Events = {}

ListEvents.OnServerInvoke = function()
	return Events
end

function EventService:RegisterEvent(eventName: string, eventConfig: any)
	if type(eventConfig) ~= "table" then
		return
	end

	if not eventConfig.Duration then
		return
	end

	self.EventConfigs[eventName] = eventConfig
end

function EventService:ExecuteEvent(eventName: string, duration: number?)
	local eventConfig = self.EventConfigs[eventName]
	if not eventConfig then
		return
	end

	local eventDuration = eventConfig.Duration

	local eventDuration = duration or eventConfig.Duration

	local eventData: any = {
		eventName = eventName,
		startedAt = workspace:GetServerTimeNow(),
		endsAt = workspace:GetServerTimeNow() + eventDuration,
	}

	self.ActiveEvents[eventName] = eventData

	if self.Channels.Events then
		self.Channels.Events:InsertOnArray("ActiveEvents", eventData)
	end

	if eventConfig.OnStart then
		task.spawn(function()
			local success, err = pcall(eventConfig.OnStart, eventData)
			if not success then
				warn(`[EventService] Error in OnStart for {eventName}:`, err)
			end
		end)
	end

	task.delay(eventDuration, function()
		if self.ActiveEvents[eventName] then
			self:CancelEvent(eventName)
		end
	end)
end

function EventService:CancelEvent(eventName: string)
	local eventData = self.ActiveEvents[eventName]
	if not eventData then
		warn("[EventService] Event not active:", eventName)
		return
	end

	local eventConfig = self.EventConfigs[eventName]
	if eventConfig and eventConfig.OnStop then
		task.spawn(function()
			pcall(eventConfig.OnStop, eventData)
		end)
	end

	if self.Channels.Events then
		local activeEventsArray = self.Channels.Events:Get("ActiveEvents")
		local eventIndex = nil
		for i, data in ipairs(activeEventsArray) do
			if data.eventName == eventName then
				eventIndex = i
				break
			end
		end

		if eventIndex then
			self.Channels.Events:RemoveFromArray("ActiveEvents", eventIndex)
		end
	end

	self.ActiveEvents[eventName] = nil
end

function EventService:GetActiveEvents()
	return self.ActiveEvents
end

function EventService:IsEventActive(eventName: string): boolean
	return self.ActiveEvents[eventName] ~= nil
end

function EventService:Start()
	self.Channels.Events = Synchronizer:Create("Events", { ActiveEvents = {} })

	for _, player in ipairs(Players:GetPlayers()) do
		self.Channels.Events:AddListener(player)
	end

	Players.PlayerAdded:Connect(function(player)
		if self.Channels.Events then
			self.Channels.Events:AddListener(player)
		end
	end)

	for _, v in script.Events:GetChildren() do
		if v:IsA("ModuleScript") then
			pcall(function()
				require(v)
			end)
		end
	end

	self:RegisterEvent("6x Server Luck", {
		Duration = 600,
		OnStart = function()
			require(script.Events:WaitForChild("6x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("6x Server Luck")).OnStop()
		end
	})

	self:RegisterEvent("8x Server Luck", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("8x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("8x Server Luck")).OnStop()
		end
	})

	self:RegisterEvent("10x Server Luck", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("10x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("10x Server Luck")).OnStop()
		end
	})

	self:RegisterEvent("12x Server Luck", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("12x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("12x Server Luck")).OnStop()
		end
	})

	self:RegisterEvent("15x Server Luck", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("15x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("15x Server Luck")).OnStop()
		end
	})
	self:RegisterEvent("Raining Burger", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Raining Burger")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Raining Burger")).OnStop(eventData)
		end
	})
	self:RegisterEvent("20x Server Luck", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("20x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("20x Server Luck")).OnStop()
		end
	})
	
	self:RegisterEvent("25x Server Luck", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("25x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("25x Server Luck")).OnStop()
		end
	})
	
	self:RegisterEvent("30x Server Luck", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("30x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("30x Server Luck")).OnStop()
		end
	})
	
	self:RegisterEvent("2000x Server Luck", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("2000x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("2000x Server Luck")).OnStop()
		end
	})

	self:RegisterEvent("4th of July", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("4th of July")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("4th of July")).OnStop()
		end
	})

	self:RegisterEvent("3 Roads", {
		Duration = 600,
		OnStart = function()
			require(script.Events:WaitForChild("3 Roads")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("3 Roads")).OnStop()
		end
	})
	self:RegisterEvent("STBANCAL", {
		Duration = 190,

		OnStart = function()
			require(script.Events:WaitForChild("STBANCAL")).OnStart()

			local Lighting = game:GetService("Lighting")
			local module = script.Events:WaitForChild("STBANCAL")

			-- SAVE ancien état
			local old = {}
			for _, v in ipairs(Lighting:GetChildren()) do
				if v:IsA("Sky") or v:IsA("Atmosphere") then
					table.insert(old, v:Clone())
				end
			end

			-- stocke pour le stop
			_G.STBANCAL_OLD_LIGHTING = old

			-- CLEAN lighting
			for _, v in ipairs(Lighting:GetChildren()) do
				if v:IsA("Sky") or v:IsA("Atmosphere") then
					v:Destroy()
				end
			end

			-- APPLY TON SKY
			local sky = module:FindFirstChild("CursedSky")
			if sky then
				sky:Clone().Parent = Lighting
			else
				warn("CursedSky introuvable")
			end

			-- APPLY ATMOSPHERE
			local atm = module:FindFirstChild("AtmosphereCursed")
			if atm then
				atm:Clone().Parent = Lighting
			end

			-- AMBIANCE (optionnel mais stylé)
			Lighting.Brightness = 1
			Lighting.ClockTime = 0
			Lighting.FogEnd = 80
			Lighting.FogColor = Color3.fromRGB(20,20,20)
		end,

		OnStop = function()
			require(script.Events:WaitForChild("STBANCAL")).OnStop()

			local Lighting = game:GetService("Lighting")

			-- CLEAN actuel
			for _, v in ipairs(Lighting:GetChildren()) do
				if v:IsA("Sky") or v:IsA("Atmosphere") then
					v:Destroy()
				end
			end

			-- RESTORE ancien
			if _G.STBANCAL_OLD_LIGHTING then
				for _, v in ipairs(_G.STBANCAL_OLD_LIGHTING) do
					v:Clone().Parent = Lighting
				end
			end
		end
	})
	self:RegisterEvent("Steak Snap", {
		Duration = 900,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Steak Snap")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Steak Snap")).OnStop(eventData)

		end,

	})
	
	self:RegisterEvent("Eid", {
		Duration = 130,
		OnStart = function()
			require(script.Events:WaitForChild("Eid")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Eid")).OnStop()
		end
	})
	
	self:RegisterEvent("Easter", {
		Duration = 600,
		OnStart = function()
			require(script.Events:WaitForChild("Easter")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Easter")).OnStop()
		end
	})

	self:RegisterEvent("Winter Hour", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("Winter Hour")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Winter Hour")).OnStop()
		end
	})

	self:RegisterEvent("Bloodmoon", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Bloodmoon")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Bloodmoon")).OnStop()
		end
	})

	self:RegisterEvent("1x1x1x1", {
		Duration = 600,
		OnStart = function()
			require(script.Events:WaitForChild("1x1x1x1")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("1x1x1x1")).OnStop()
		end
	})


	self:RegisterEvent("Bombardiro Crocodilo", {
		Duration = 151,
		OnStart = function()
			require(script.Events:WaitForChild("Bombardiro Crocodilo")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Bombardiro Crocodilo")).OnStop()
		end
	})

	self:RegisterEvent("Brazil", {
		Duration = 85,
		OnStart = function()
			require(script.Events:WaitForChild("Brazil")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Brazil")).OnStop()
		end
	})

	self:RegisterEvent("Bubblegum", {
		Duration = 600,
		OnStart = function()
			require(script.Events:WaitForChild("Bubblegum")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Bubblegum")).OnStop()
		end
	})

	self:RegisterEvent("Candy", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Candy")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Candy")).OnStop()
		end
	})
	
	self:RegisterEvent("Elexir", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Elexir")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Elexir")).OnStop()
		end
	})

	self:RegisterEvent("Chicleteira Bicicleteira", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("Chicleteira Bicicleteira")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Chicleteira Bicicleteira")).OnStop()
		end
	})

	self:RegisterEvent("Concert", {
		Duration = 120,
		OnStart = function()
			require(script.Events:WaitForChild("Concert")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Concert")).OnStop()
		end
	})

	self:RegisterEvent("Crab Rave", {
		Duration = 140,
		OnStart = function()
			require(script.Events:WaitForChild("Crab Rave")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Crab Rave")).OnStop()
		end
	})
	
	self:RegisterEvent("GUIGUI", {
		Duration = 140,
		OnStart = function()
			require(script.Events:WaitForChild("GUIGUI")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("GUIGUI")).OnStop()
		end
	})
	
	self:RegisterEvent("Jul", {
		Duration = 140,
		OnStart = function()
			require(script.Events:WaitForChild("Jul")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Jul")).OnStop()
		end
	})

	self:RegisterEvent("Extinct", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Extinct")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Extinct")).OnStop()
		end
	})

	self:RegisterEvent("Galaxy", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Galaxy")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Galaxy")).OnStop()
		end
	})
	
	self:RegisterEvent("Mario", {
		Duration = 160,
		OnStart = function()
			require(script.Events:WaitForChild("Mario")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Mario")).OnStop()
		end
	})
	self:RegisterEvent("Summer", {
		Duration = 141,
		OnStart = function()
			require(script.Events:WaitForChild("Summer")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Summer")).OnStop()
		end
	})


	self:RegisterEvent("Glitch", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("Glitch")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Glitch")).OnStop()
		end
	})

	self:RegisterEvent("La Vacca Saturno Saturnita", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("La Vacca Saturno Saturnita")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("La Vacca Saturno Saturnita")).OnStop()
		end
	})

	self:RegisterEvent("France", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("France")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("France")).OnStop()
		end
	})
	
	self:RegisterEvent("Indonesia", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("Indonesia")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Indonesia")).OnStop()
		end
	})

	self:RegisterEvent("Meowl", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("Meowl")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Meowl")).OnStop()
		end
	})
	
	self:RegisterEvent("John Pork", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("John Pork")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("John Pork")).OnStop()
		end
	})
	
	self:RegisterEvent("500x Server Luck", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("500x Server Luck")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("500x Server Luck")).OnStop()
		end
	})
	
	self:RegisterEvent("10B Visits", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("10B Visits")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("10B Visits")).OnStop()
		end
	})

	self:RegisterEvent("Los Matteos", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Los Matteos")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Los Matteos")).OnStop()
		end
	})

	self:RegisterEvent("Matteo", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Matteo")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Matteo")).OnStop()
		end
	})
	
	self:RegisterEvent("Cyber", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Cyber")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Cyber")).OnStop()
		end
	})


	self:RegisterEvent("Mexico", {
		Duration = 190,
		OnStart = function()
			require(script.Events:WaitForChild("Mexico")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Mexico")).OnStop()
		end
	})

	self:RegisterEvent("Molten", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Molten")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Molten")).OnStop()
		end
	})

	self:RegisterEvent("Nyan Cats", {
		Duration = 154,
		OnStart = function()
			require(script.Events:WaitForChild("Nyan Cats")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Nyan Cats")).OnStop()
		end
	})

	self:RegisterEvent("Rain", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Rain")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Rain")).OnStop()
		end
	})

	self:RegisterEvent("Rainbow", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Rainbow")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Rainbow")).OnStop()
		end
	})

	self:RegisterEvent("Raining Tacos", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("Raining Tacos")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Raining Tacos")).OnStop()
		end
	})

	self:RegisterEvent("Rap Concert", {
		Duration = 120,
		OnStart = function()
			require(script.Events:WaitForChild("Rap Concert")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Rap Concert")).OnStop()
		end
	})

	self:RegisterEvent("Sammyni Spyderini", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Sammyni Spyderini")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Sammyni Spyderini")).OnStop()
		end
	})

	self:RegisterEvent("Snow", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Snow")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Snow")).OnStop()
		end
	})

	self:RegisterEvent("Solar Flare", {
		Duration = 120,
		OnStart = function()
			require(script.Events:WaitForChild("Solar Flare")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Solar Flare")).OnStop()
		end
	})

	self:RegisterEvent("Water", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Water")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Water")).OnStop()
		end
	})

	self:RegisterEvent("Starfall", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Starfall")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Starfall")).OnStop()
		end
	})

	self:RegisterEvent("Strawberry", {
		Duration = 180	,
		OnStart = function()
			require(script.Events:WaitForChild("Strawberry")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Strawberry")).OnStop()
		end
	})

	self:RegisterEvent("Mango", {
		Duration = 180	,
		OnStart = function()
			require(script.Events:WaitForChild("Mango")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Mango")).OnStop()
		end
	})
	
	self:RegisterEvent("Italy", {
		Duration = 180	,
		OnStart = function()
			require(script.Events:WaitForChild("Italy")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Italy")).OnStop()
		end
	})

	self:RegisterEvent("UFO", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("UFO")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("UFO")).OnStop()
		end
	})

	self:RegisterEvent("Sammy's Base", {
		Duration = 120,
		OnStart = function()
			require(script.Events:WaitForChild("Sammy's Base")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Sammy's Base")).OnStop()
		end
	})

	self:RegisterEvent("Phase 4: Mygame43", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Phase 4: Mygame43")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Phase 4: Mygame43")).OnStop()
		end
	})

	self:RegisterEvent("Phase 5: Sammy Snap", {
		Duration = 20,
		OnStart = function()
			require(script.Events:WaitForChild("Phase 5: Sammy Snap")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Phase 5: Sammy Snap")).OnStop()
		end
	})
	
	self:RegisterEvent("Duo Snap Zyna x Badr", {
		Duration = 20,
		OnStart = function()
			require(script.Events:WaitForChild("Duo Snap Zyna x Badr", 5)).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Duo Snap Zyna x Badr", 5)).OnStop()
		end
	})
	
	self:RegisterEvent("Kinoshi", {
		OnStart = function()
			require(script.Events:WaitForChild("Kinoshi")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Kinoshi")).OnStop()
		end,
	})
	self:RegisterEvent("Teykx", {
		OnStart = function()
			require(script.Events:WaitForChild("Teykx")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Teykx")).OnStop()
		end,
	})
	self:RegisterEvent("Teykx Lazer", {
		Duration = 180,
		OnStart = function()
			require(script.Events:WaitForChild("Teykx Lazer")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Teykx Lazer")).OnStop()
		end,
	})
	self:RegisterEvent("Ibrx", {
		OnStart = function()
			require(script.Events:WaitForChild("Ibrx")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Ibrx")).OnStop()
		end,
	})
	self:RegisterEvent("Ibrx Snap", {
		Duration = 20,
		OnStart = function()
			require(script.Events:WaitForChild("Ibrx Snap")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Ibrx Snap")).OnStop()
		end
	})

	self:RegisterEvent("YinYang", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("YinYang")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("YinYang")).OnStop()
		end
	})

	self:RegisterEvent("Radioactive", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Radioactive")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Radioactive")).OnStop()
		end
	})

	self:RegisterEvent("Dul Dul Dul", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Dul Dul Dul")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Dul Dul Dul")).OnStop()
		end
	})
	
	self:RegisterEvent("Badr Snap", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Badr Snap")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Badr Snap")).OnStop()
		end
	})

	self:RegisterEvent("Karkerkar Kurkur", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Karkerkar Kurkur")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Karkerkar Kurkur")).OnStop()
		end
	})

	self:RegisterEvent("Witching Hour", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Witching Hour")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Witching Hour")).OnStop()
		end
	})

	self:RegisterEvent("Trick or Treat", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Trick or Treat")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Trick or Treat")).OnStop()
		end
	})

	self:RegisterEvent("Graveyard", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Graveyard")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Graveyard")).OnStop()
		end
	})
	self:RegisterEvent("1 Year", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("1 Year")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("1 Year")).OnStop()
		end
	})
	self:RegisterEvent("1K Visits", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("1K Visits")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("1K Visits")).OnStop()
		end
	})
	self:RegisterEvent("Hacker", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Hacker")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Hacker")).OnStop()
		end
	})
	
	self:RegisterEvent("Fishing", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Fishing")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Fishing")).OnStop()
		end
	})
	self:RegisterEvent("Backrooms", {
		Duration = 900,
		OnStart = function()
			require(script.Events:WaitForChild("Backrooms")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Backrooms")).OnStop()
		end
	})

	self:RegisterEvent("FatSammy", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("FatSammy")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("FatSammy")).OnStop()
		end
	})

	self:RegisterEvent("Tung Tung Attack", {
		Duration = 300,
		OnStart = function()
			require(script.Events:WaitForChild("Tung Tung Attack")).OnStart()
		end,
		OnStop = function()
			require(script.Events:WaitForChild("Tung Tung Attack")).OnStop()
		end
	})

	self:RegisterEvent("Stock", {
		Duration = 900,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Stock")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Stock")).OnStop(eventData)
		end
	})

	self:RegisterEvent("Skibidi", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Skibidi")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Skibidi")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Headless", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Headless")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Headless")).OnStop(eventData)
		end
	})

	self:RegisterEvent("Gingerbread Town", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Gingerbread Town")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Gingerbread Town")).OnStop(eventData)
		end
	})

	self:RegisterEvent("2026", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("2026")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("2026")).OnStop(eventData)
		end
	})

	self:RegisterEvent("Cursed", {
		Duration = 900,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Cursed")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Cursed")).OnStop(eventData)
		end
	})

	self:RegisterEvent("Lance", {
		Duration = 452,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Lance")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Lance")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Ay Mi Gatito", {
		Duration = 226,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Ay Mi Gatito")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Ay Mi Gatito")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Valentines", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Valentines")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Valentines")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Divine", {
		Duration = 900,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Divine")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Divine")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Fuse Machine Luck", {
		Duration = 900,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Fuse Machine Luck")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Fuse Machine Luck")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("St Patricks", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("St Patricks")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("St Patricks")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Phase 1: Sleepy", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Phase 1: Sleepy")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Phase 1: Sleepy")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Phase 2: Galaxy Introduction", {
		Duration = 180,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Phase 2: Galaxy Introduction")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Phase 2: Galaxy Introduction")).OnStop(eventData)
		end
	})
	
	self:RegisterEvent("Werenoi", {
		Duration = 200,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("Werenoi")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("Werenoi")).OnStop(eventData)
		end
	})


	self:RegisterEvent("3K", {
		Duration = 300,
		OnStart = function(eventData)
			require(script.Events:WaitForChild("3K")).OnStart(eventData)
		end,
		OnStop = function(eventData)
			require(script.Events:WaitForChild("3K")).OnStop(eventData)
		end
	})

	ReplicatedStorage:SetAttribute("EventsLoaded", true)
end

return EventService