--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Events = ReplicatedStorage:WaitForChild("Events")

local WeatherService = {}

local CurrentWeather = nil
local CurrentModule = nil
local WeatherDuration = 70
local WeatherCooldown = 180
local LastWeatherEnd = 0

local WeatherTimer = 0
local WeatherActive = false
local WeatherStatusText = "Idle"
local ForceLockedWeather = nil

local LockedWeather = {
	Tacos = true,
	Gold = true,
	Hacker = true,
	Rainbow = true,
	Candy = true,
	Volcano = true,
	Pyramid = true,
}

-- Prices for buying events (locked events only)
local EventPrices = {
	Rain = 500,
	Galaxy = 1000,
	Tacos = 1500,
	Gold = 2000,
	Hacker = 3000,
	Rainbow = 2500,
	Candy = 3500,
	Volcano = 4000,
	Pyramid = 5000,
}

local function ToClockTime(seconds: number): string
	seconds = math.max(0, math.floor(seconds))
	local minutes = math.floor(seconds / 60)
	local secs = seconds % 60
	return string.format("%02d:%02d", minutes, secs)
end

local function NotifyAll(title: string, message: string, notificationType: string)
	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		for _, p in ipairs(Players:GetPlayers()) do
			notifEvent:FireClient(p, title, notificationType or "Success")
		end
	end
end

local function ReplicateTimer(timeLeft: number, active: boolean, statusText: string)
	local status = statusText
	if active and CurrentWeather then
		status = statusText .. " (" .. tostring(CurrentWeather) .. ")"
	end
	local timerText = status .. " " .. ToClockTime(timeLeft)

	-- Update the physical EventTimer model in workspace
	local eventTimer = workspace:FindFirstChild("EventTimer")
	if eventTimer then
		local front = eventTimer:FindFirstChild("Front")
		if front then
			local surfaceGui = front:FindFirstChild("SurfaceGui")
			if surfaceGui then
				local timerLabel = surfaceGui:FindFirstChild("Timer")
				if timerLabel and timerLabel:IsA("TextLabel") then
					timerLabel.Text = timerText
					-- Color based on active state
					if active then
						timerLabel.TextColor3 = Color3.fromRGB(255, 170, 0) -- Orange when event active
					else
						timerLabel.TextColor3 = Color3.fromRGB(200, 200, 200) -- Gray when waiting
					end
				end
			end
		end
	end

	-- Also update all clients with weather timer info
	local weatherEvent = Events:FindFirstChild("UpdateWeatherTimer")
	if weatherEvent then
		weatherEvent:FireAllClients(timerText, active, CurrentWeather or "")
	end
end

function WeatherService.StartWeather(weatherName: string, duration: number?, bypassCooldown: boolean?)
	if not bypassCooldown then
		local now = os.time()
		if now - LastWeatherEnd < WeatherCooldown then
			warn("[WeatherService] Weather is on cooldown!")
			return
		end
	end

	if CurrentModule then
		CurrentModule.OnEnd()
		CurrentModule = nil
		CurrentWeather = nil
	end

	local moduleScript = script:FindFirstChild(weatherName)
	if not moduleScript then
		warn("[WeatherService] Weather module not found: " .. weatherName)
		return
	end

	local weatherModule = require(moduleScript)
	CurrentModule = weatherModule
	CurrentWeather = weatherName
	ForceLockedWeather = weatherName

	weatherModule.OnStart()
	WeatherActive = true
	WeatherStatusText = "Event ending in"

	NotifyAll(weatherName .. " Event Started!", weatherName .. " weather has begun!", "Success")

	task.delay(duration or WeatherDuration, function()
		if CurrentModule == weatherModule then
			weatherModule.OnEnd()
			CurrentModule = nil
			CurrentWeather = nil
			LastWeatherEnd = os.time()
			WeatherActive = false
			WeatherStatusText = "Event starting in"
			ForceLockedWeather = nil

			NotifyAll(weatherName .. " Event Ended!", weatherName .. " weather has ended!", "Success")
		end
	end)
end

function WeatherService.StartRandomWeather(duration: number?, bypassCooldown: boolean?)
	local children = script:GetChildren()
	local candidates = {}

	for _, child in ipairs(children) do
		if child:IsA("ModuleScript") and not LockedWeather[child.Name] then
			table.insert(candidates, child.Name)
		end
	end

	if #candidates == 0 then
		warn("[WeatherService] No eligible weather modules found!")
		return
	end

	local chosenName = candidates[math.random(1, #candidates)]
	WeatherService.StartWeather(chosenName, duration or WeatherDuration, bypassCooldown)
end

function WeatherService:Init(controllers)
	-- Create BuyEvent RemoteEvent
	if not Events:FindFirstChild("BuyEvent") then
		local e = Instance.new("RemoteEvent")
		e.Name = "BuyEvent"
		e.Parent = Events
	end

	-- Create GetEventShopData RemoteFunction
	if not Events:FindFirstChild("GetEventShopData") then
		local f = Instance.new("RemoteFunction")
		f.Name = "GetEventShopData"
		f.Parent = Events
	end

	-- Create OpenEventShop RemoteEvent for ProximityPrompt
	if not Events:FindFirstChild("OpenEventShop") then
		local o = Instance.new("RemoteEvent")
		o.Name = "OpenEventShop"
		o.Parent = Events
	end

	Events:FindFirstChild("BuyEvent").OnServerEvent:Connect(function(player, weatherName)
		WeatherService.HandleBuyEvent(player, weatherName)
	end)

	Events:FindFirstChild("GetEventShopData").OnServerInvoke = function(player)
		return WeatherService.GetShopData()
	end
end

function WeatherService:Start()
	WeatherService.Setup()
end

function WeatherService.GetShopData()
	local data = {}
	local children = script:GetChildren()
	for _, child in ipairs(children) do
		if child:IsA("ModuleScript") then
			local name = child.Name
			local price = EventPrices[name] or 0
			local isLocked = LockedWeather[name] or false
			table.insert(data, {
				Name = name,
				Price = price,
				Locked = isLocked,
			})
		end
	end
	table.sort(data, function(a, b) return a.Price < b.Price end)
	return data
end

function WeatherService.HandleBuyEvent(player, weatherName)
	if not weatherName or typeof(weatherName) ~= "string" then
		return
	end

	-- Check if weather module exists
	local moduleScript = script:FindFirstChild(weatherName)
	if not moduleScript then
		return
	end

	-- Check price
	local price = EventPrices[weatherName]
	if not price then
		return
	end

	-- Check if event already active
	if WeatherActive then
		local notifEvent = Events:FindFirstChild("ShowNotification")
		if notifEvent then
			notifEvent:FireClient(player, "Event Active!", "An event is already running, wait for it to end.", "Warning")
		end
		return
	end

	-- Check player money
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end
	local money = leaderstats:FindFirstChild("Money")
	if not money then return end
	if money.Value < price then
		local notifEvent = Events:FindFirstChild("ShowNotification")
		if notifEvent then
			notifEvent:FireClient(player, "Not Enough!", "You need $" .. tostring(price) .. " to start this event.", "Warning")
		end
		return
	end

	-- Deduct money and start event
	money.Value -= price
	WeatherService.StartWeather(weatherName, WeatherDuration, true)
end

function WeatherService.StopCurrentWeather()
	if CurrentModule then
		CurrentModule.OnEnd()
		CurrentModule = nil
		CurrentWeather = nil
		LastWeatherEnd = os.time()
		WeatherActive = false
		WeatherStatusText = "Event starting in"
		ForceLockedWeather = nil
		NotifyAll("Event Stopped!", "The current event has been forcefully stopped.", "Success")
	end
end

function WeatherService.Setup()
	-- Create the UpdateWeatherTimer RemoteEvent if it doesn't exist
	if not Events:FindFirstChild("UpdateWeatherTimer") then
		local e = Instance.new("RemoteEvent")
		e.Name = "UpdateWeatherTimer"
		e.Parent = Events
	end

	-- Ensure workspace.Weather folder exists
	if not workspace:FindFirstChild("Weather") then
		local weatherFolder = Instance.new("Folder")
		weatherFolder.Name = "Weather"
		weatherFolder.Parent = workspace
	end

	task.spawn(function()
		while true do
			if WeatherTimer <= 0 and not ForceLockedWeather then
				WeatherService.StartRandomWeather(WeatherDuration, false)
				WeatherTimer = WeatherDuration + WeatherCooldown
			else
				WeatherTimer -= 1
			end

			WeatherStatusText = WeatherActive and "Event ending in" or "Event starting in"
			ReplicateTimer(WeatherTimer, WeatherActive, WeatherStatusText)
			task.wait(1)
		end
	end)
end

return WeatherService