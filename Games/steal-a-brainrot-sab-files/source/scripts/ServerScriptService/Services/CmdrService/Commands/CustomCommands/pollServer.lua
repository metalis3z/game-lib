local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PollManager = require(game.ServerScriptService.Services.PollService)

local COLOR_OPTIONS = {
	["red"]         = { DisplayName = "Red",         Color = Color3.fromRGB(255, 0,   0),   hex = "#ff0000" },
	["blue"]        = { DisplayName = "Blue",         Color = Color3.fromRGB(0,   0,   255), hex = "#0000ff" },
	["green"]       = { DisplayName = "Green",        Color = Color3.fromRGB(0,   255, 0),   hex = "#00ff00" },
	["yellow"]      = { DisplayName = "Yellow",       Color = Color3.fromRGB(255, 255, 0),   hex = "#ffff00" },
	["orange"]      = { DisplayName = "Orange",       Color = Color3.fromRGB(255, 170, 0),   hex = "#ffaa00" },
	["purple"]      = { DisplayName = "Purple",       Color = Color3.fromRGB(170, 0,   255), hex = "#aa00ff" },
	["white"]       = { DisplayName = "White",        Color = Color3.fromRGB(255, 255, 255), hex = "#ffffff" },
	["black"]       = { DisplayName = "Black",        Color = Color3.fromRGB(26,  26,  26),  hex = "#1a1a1a" },
	["pink"]        = { DisplayName = "Pink",         Color = Color3.fromRGB(255, 0,   255), hex = "#ff00ff" },
	["dark red"]    = { DisplayName = "Dark Red",     Color = Color3.fromRGB(139, 0,   0),   hex = "#8b0000" },
	["dark blue"]   = { DisplayName = "Dark Blue",    Color = Color3.fromRGB(0,   0,   139), hex = "#00008b" },
	["dark green"]  = { DisplayName = "Dark Green",   Color = Color3.fromRGB(0,   100, 0),   hex = "#006400" },
	["light blue"]  = { DisplayName = "Light Blue",   Color = Color3.fromRGB(173, 216, 230), hex = "#add8e6" },
	["light green"] = { DisplayName = "Light Green",  Color = Color3.fromRGB(144, 238, 144), hex = "#90ee90" },
	["gray"]        = { DisplayName = "Gray",         Color = Color3.fromRGB(128, 128, 128), hex = "#808080" },
	["dark gray"]   = { DisplayName = "Dark Gray",    Color = Color3.fromRGB(169, 169, 169), hex = "#a9a9a9" },
	["gold"]        = { DisplayName = "Gold",         Color = Color3.fromRGB(255, 215, 0),   hex = "#ffd700" },
	["silver"]      = { DisplayName = "Silver",       Color = Color3.fromRGB(192, 192, 192), hex = "#c0c0c0" },
	["cyan"]        = { DisplayName = "Cyan",         Color = Color3.fromRGB(0,   255, 255), hex = "#00ffff" },
	["magenta"]     = { DisplayName = "Magenta",      Color = Color3.fromRGB(255, 0,   255), hex = "#ff00ff" },
	["crimson"]     = { DisplayName = "Crimson",      Color = Color3.fromRGB(220, 20,  60),  hex = "#dc143c" },
	["aqua"]        = { DisplayName = "Aqua",         Color = Color3.fromRGB(0,   255, 255), hex = "#00ffff" },
	["teal"]        = { DisplayName = "Teal",         Color = Color3.fromRGB(0,   128, 128), hex = "#008080" },
	["maroon"]      = { DisplayName = "Maroon",       Color = Color3.fromRGB(128, 0,   0),   hex = "#800000" },
	["navy"]        = { DisplayName = "Navy",         Color = Color3.fromRGB(0,   0,   128), hex = "#000080" },
	["olive"]       = { DisplayName = "Olive",        Color = Color3.fromRGB(128, 128, 0),   hex = "#808000" },
	["neon pink"]   = { DisplayName = "Neon Pink",    Color = Color3.fromRGB(255, 110, 199), hex = "#ff6ec7" },
	["neon blue"]   = { DisplayName = "Neon Blue",    Color = Color3.fromRGB(31,  81,  255), hex = "#1f51ff" },
	["neon green"]  = { DisplayName = "Neon Green",   Color = Color3.fromRGB(57,  255, 20),  hex = "#39ff14" },
	["cyberpunk"]   = { DisplayName = "Cyberpunk",    Color = Color3.fromRGB(252, 238, 10),  hex = "#fcee0a" },
	["midnight"]    = { DisplayName = "Midnight",     Color = Color3.fromRGB(25,  25,  112), hex = "#191970" },
	["mint"]        = { DisplayName = "Mint",         Color = Color3.fromRGB(152, 255, 152), hex = "#98ff98" },
	["lavender"]    = { DisplayName = "Lavender",     Color = Color3.fromRGB(230, 230, 250), hex = "#e6e6fa" },
	["brown"]       = { DisplayName = "Brown",        Color = Color3.fromRGB(139, 69,  19),  hex = "#8b4513" },
	["salmon"]      = { DisplayName = "Salmon",       Color = Color3.fromRGB(250, 128, 114), hex = "#fa8072" },
	["tan"]         = { DisplayName = "Tan",          Color = Color3.fromRGB(210, 180, 140), hex = "#d2b48c" },
	["violet"]      = { DisplayName = "Violet",       Color = Color3.fromRGB(238, 130, 238), hex = "#ee82ee" },
	["indigo"]      = { DisplayName = "Indigo",       Color = Color3.fromRGB(75,  0,   130), hex = "#4b0082" },
}

local function getColorNameList()
	local names = {}
	for _, data in pairs(COLOR_OPTIONS) do
		table.insert(names, data.DisplayName)
	end
	table.sort(names)
	return table.concat(names, ", ")
end

local function resolveColorHex(colorName, defaultHex)
	if colorName then
		local lowerName = string.lower(colorName)
		if COLOR_OPTIONS[lowerName] then
			return COLOR_OPTIONS[lowerName].hex
		end
	end
	return defaultHex
end

return function(context, question, option1, option2, color1, color2, duration, isGlobal, isFake, fakeVotesA, fakeVotesB)
	local config = {
		text              = question or "No Question Provided",
		option1           = option1 or "Yes",
		option2           = option2 or "No",
		option1colorHex   = resolveColorHex(color1, "00ff00"),
		option2colorHex   = resolveColorHex(color2, "ff0000"),
		duration          = tonumber(duration) or 60,
		allowSwitch       = true,
		isGlobal          = isGlobal ~= false,
		isFakePoll        = isFake == true,
		startVotesA       = tonumber(fakeVotesA) or 0,
		startVotesB       = tonumber(fakeVotesB) or 0,
	}

	local pollId = PollManager.CreatePoll(config, context.Executor.UserId)

	if pollId then
		return "Poll created!"
	else
		return "Poll creation failed! You may not be authorized to create global polls."
	end
end