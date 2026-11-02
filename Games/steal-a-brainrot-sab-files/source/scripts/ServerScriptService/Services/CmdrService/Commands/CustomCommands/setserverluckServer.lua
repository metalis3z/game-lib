local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local net = require(ReplicatedStorage.Packages.Net)
local LuckIcons = require(ReplicatedStorage.Datas.LuckIcons)
local LuckService = require(ServerScriptService.Services.LuckService)
local EventService = require(ServerScriptService.Services.EventService)
local setluck = net:RemoteFunction("AdminService/SetLuck")
local setluckbindable = script.SetLuck
local luckMap = {
	["2x"]  = { index = 1,  tag = nil,       color = Color3.fromRGB(70, 255, 70) },
	["4x"]  = { index = 2,  tag = nil,       color = Color3.fromRGB(255, 230, 90) },
	["6x"]  = { index = 6,  tag = nil,       color = Color3.fromRGB(180, 90, 255) },
	["8x"]  = { index = 3,  tag = "rainbow", color = nil },
	["10x"] = { index = 10, tag = "zebra",   color = nil },
	["12x"] = { index = 12, tag = "og",      color = nil },
	["15x"] = { index = 15, tag = nil,       color = Color3.fromRGB(0, 255, 0) },
	["20x"] = { index = 20, tag = "pink",    color = Color3.fromRGB(255, 115, 223) },
	["25x"] = { index = 25, tag = nil,       color = Color3.fromRGB(142, 227, 63) },
	["30x"] = { index = 30, tag = nil,       color = Color3.fromRGB(255, 230, 90) }
}
for label, iconId in pairs(LuckIcons) do
	if luckMap[label] then
		luckMap[label].icon = iconId
	end
end

local function color3ToHex(c)
	return string.format("%02x%02x%02x", math.floor(c.R * 255), math.floor(c.G * 255), math.floor(c.B * 255))
end

local function formatDisplay(label)
	local cfg = luckMap[label]
	if not cfg then return label end
	if cfg.tag then return string.format("<%s>%s Luck</%s>", cfg.tag, label, cfg.tag) end
	if cfg.color then return string.format("<font color=\"#%s\">%s Luck</font>", color3ToHex(cfg.color), label) end
	return label .. " Luck"
end

local function notifyAll(label)
	local allowedToNotify = {["2x"] = true, ["4x"] = true, ["8x"] = true}

	if allowedToNotify[label] then
		local cfg = luckMap[label]
		local msg = ("Sammy Activated %s!"):format(formatDisplay(label))
		local icon = cfg and cfg.icon or ""

		for _, plr in ipairs(Players:GetPlayers()) do
			task.spawn(function()
				NotificationService.Notify(plr, msg, 5, "Sounds.Sfx.Success", icon)
			end)
		end
	end
end

local function applyLuck(player, multiplier, duration, isreset)
	local Events = Synchronizer:Wait("Events")
	local ServerLuck = Synchronizer:Wait("ServerLuck")

	if isreset then
		LuckService:ResetLuck()
		ServerLuck:Set("Index", 1) 
		ServerLuck:Set("EndTime", 0)

		for eventName, _ in pairs(EventService.ActiveEvents) do
			if string.find(eventName, "Luck") then
				EventService:CancelEvent(eventName)
			end
		end

		return true, "Luck Reset!"
	end

	if not multiplier then 
		return false, "Multiplier is missing!" 
	end

	multiplier = tostring(multiplier)
	if not string.find(multiplier, "x") then multiplier = multiplier .. "x" end
	multiplier = string.lower(multiplier)
	duration = tonumber(duration) or 900

	local cfg = luckMap[multiplier]
	if not cfg then return false, "Unknown multiplier" end

	local now = workspace:GetServerTimeNow()
	local endTime = now + duration

	LuckService:ResetLuck()
	ServerLuck:Set("Index", cfg.index)
	ServerLuck:Set("EndTime", endTime)

	local eventName = ("%s Server Luck"):format(multiplier)

	if not EventService.EventConfigs[eventName] then
		EventService:RegisterEvent(eventName, {
			Duration = duration,
			Icon = cfg.icon or "rbxassetid://17451423471"
		})
	end

	EventService:ExecuteEvent(eventName, duration)

	notifyAll(multiplier)
	return true, "Activated!"
end

setluck.OnServerInvoke = applyLuck

return function(context, multiplier, duration)
	local success, err = applyLuck(context.Executor, multiplier, duration)
	if success then
		return string.format("✅ Activated %s luck!", multiplier)
	else
		return "❌ Error: " .. tostring(err)
	end
end