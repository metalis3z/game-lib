local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local ServerLuck = Synchronizer:Get("ServerLuck")

local function color3ToHex(c)
	local r = math.clamp(math.floor(c.R * 255 + 0.5), 0, 255)
	local g = math.clamp(math.floor(c.G * 255 + 0.5), 0, 255)
	local b = math.clamp(math.floor(c.B * 255 + 0.5), 0, 255)
	return string.format("%02x%02x%02x", r, g, b)
end

local luckMap = {
	["2x"] = { index = 2, tag = nil, color = Color3.fromRGB(70, 255, 70), icon = "rbxassetid://92074411396710" },
	["4x"] = { index = 4, tag = nil, color = Color3.fromRGB(255, 230, 90), icon = "rbxassetid://90033075589118" },
	["6x"] = { index = 6, tag = nil, color = Color3.fromRGB(180, 90, 255), icon = "rbxassetid://94933198053674" },
	["8x"] = { index = 8, tag = "rainbow", color = nil, icon = "rbxassetid://124799036749678" },
	["10x"] = { index = 10, tag = "zebra", color = nil, icon = "rbxassetid://137888841783656" },
	["12x"] = { index = 12, tag = "og", color = nil, icon = "rbxassetid://136587115794841" },
}

local function formatDisplay(label)
	local cfg = luckMap[label]
	if not cfg then return label end

	if cfg.tag then
		return string.format("<%s>%s Luck</%s>", cfg.tag, label, cfg.tag)
	elseif cfg.color then
		return string.format("<font color=\"#%s\">%s Luck</font>", color3ToHex(cfg.color), label)
	else
		return label .. " Luck"
	end
end

local lastNotified = nil
local function notifyAll(label)
	if not label or label == lastNotified then return end
	lastNotified = label

	local cfg = luckMap[label]
	local msg = ("Sammy activated %s!"):format(formatDisplay(label))
	local icon = cfg and cfg.icon or ""

	for _, plr in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			NotificationService.Notify(plr, msg, 5, "Sounds.Sfx.Success", icon)
		end)
	end
end

-- MAIN COMMAND LOGIC
return function(context, multiplier, duration)
	multiplier = string.lower(multiplier)
	duration = duration or 900

	local cfg = luckMap[multiplier]
	if not cfg then
		return string.format("❌ Unknown luck multiplier '%s'. Options: 2x, 4x, 6x, 8x, 10x, 12x", multiplier)
	end

	local now = workspace:GetServerTimeNow()
	local endTime = now + duration

	-- Apply luck to synchronizer
	ServerLuck:Set("Index", cfg.index)
	ServerLuck:Set("EndTime", endTime)

	-- Add event to ActiveEvents
	local Events = Synchronizer:Get("Events")
	if Events then
		Events:InsertOnArray("ActiveEvents", {
			eventName = ("%s Server Luck"):format(multiplier),
			startedAt = now,
			endsAt = endTime,
		})
	end

	notifyAll(multiplier)

	return string.format("✅ Activated %s server luck for %d seconds!", multiplier, duration)
end
