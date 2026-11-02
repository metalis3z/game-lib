local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CountdownService = require(ServerScriptService.Services.GlobalCountdownService)
local Net = require(ReplicatedStorage.Packages.Net)
local UpdateCountdownRF = Net:RemoteFunction("OwnerCountdown")
local COLOR_MAP = {
	["red"] = "#ff0000",
	["blue"] = "#0000ff",
	["green"] = "#00ff00",
	["yellow"] = "#ffff00",
	["orange"] = "#ffaa00",
	["purple"] = "#aa00ff",
	["white"] = "#ffffff",
	["black"] = "#1a1a1a", 
	["pink"] = "#ff00ff",

	["darkred"] = "#8b0000",
	["darkblue"] = "#00008b",
	["darkgreen"] = "#006400",
	["lightblue"] = "#add8e6",
	["lightgreen"] = "#90ee90",
	["gray"] = "#808080",
	["grey"] = "#808080",
	["darkgray"] = "#a9a9a9",

	["gold"] = "#ffd700",
	["silver"] = "#c0c0c0",
	["cyan"] = "#00ffff",
	["magenta"] = "#ff00ff",
	["lime"] = "#00ff00",
	["crimson"] = "#dc143c",
	["aqua"] = "#00ffff",
	["teal"] = "#008080",
	["maroon"] = "#800000",
	["navy"] = "#000080",
	["olive"] = "#808000",

	["roblox"] = "#de1b1b",
	["admin"] = "#ff4500",
	["neonpink"] = "#ff6ec7",
	["neonblue"] = "#1f51ff",
	["neongreen"] = "#39ff14",
	["cyberpunk"] = "#fcee0a",
	["midnight"] = "#191970",
	["mint"] = "#98ff98",
	["lavender"] = "#e6e6fa",
	["brown"] = "#8b4513",
	["salmon"] = "#fa8072",
	["tan"] = "#d2b48c",
	["violet"] = "#ee82ee",
	["indigo"] = "#4b0082"
}
local function main(player, text, duration, color, IsGlobal, IsUnixTimestamp)
	IsUnixTimestamp = IsUnixTimestamp or false
	local targetTimestamp

	if IsUnixTimestamp then
		targetTimestamp = tonumber(duration) or (os.time() + 60)
	else
		targetTimestamp = os.time() + (tonumber(duration) or 60)
	end

	local title = text or "Event Starting"
	local globalStatus = (IsGlobal == nil) and true or IsGlobal
    
	local inputColor = color and color:lower()
	local hexValue = COLOR_MAP[inputColor] or color or "#FFEA00"
	
	CountdownService.UpdateEvent(
		targetTimestamp, 
		title, 
		hexValue,
		globalStatus, 
		player.UserId
	)

	local modeText = IsUnixTimestamp and " (Unix timestamp: " .. targetTimestamp .. ")" or " for " .. duration .. " seconds"
	return "Global countdown started for " .. title .. " with color " .. hexValue .. modeText
end
UpdateCountdownRF.OnServerInvoke = function(player, action, config)
	if action ~= "Update" or type(config) ~= "table" then
		return false, "Invalid request payload."
	end

	local title = config.title
	local targetTime = config.timestamp
	local colorHex = config.color

	return main(player, title, targetTime, colorHex, true, true)
end

return function(context, text, duration, color, IsGlobal, IsUnixTimestamp)
	return main(context.Executor, text, duration, color, IsGlobal, IsUnixTimestamp)
end
