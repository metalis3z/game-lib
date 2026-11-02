local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local NotificationService = require(ServerScriptService.Services.NotificationService)

-- Tag gradient rainbow
local GRADIENT_TAG = "font"

-- Fonction rainbow anime
local function RainbowText(text)
	return string.format(
		'<%s color="#ff0000">R</%s><%s color="#ff7f00">A</%s><%s color="#ffff00">I</%s><%s color="#00ff00">N</%s><%s color="#00ffff">B</%s><%s color="#0000ff">O</%s><%s color="#8b00ff">W</%s> %s',
		GRADIENT_TAG, GRADIENT_TAG,
		GRADIENT_TAG, GRADIENT_TAG,
		GRADIENT_TAG, GRADIENT_TAG,
		GRADIENT_TAG, GRADIENT_TAG,
		GRADIENT_TAG, GRADIENT_TAG,
		GRADIENT_TAG, GRADIENT_TAG,
		GRADIENT_TAG, GRADIENT_TAG,
		text
	)
end

-- Messages speciaux
local SPECIAL_PLAYERS = {
	["omaramgad2009"] = {
		message = ("👑 OWNER CORN JOINED YOUR SERVER 👑"),
		sound = "Sounds.Sfx.Success"
	},

	["Randomcharacter1211"] = {
		message = RainbowText("⚡ YELLOWBLOX CO OWNER JOINED YOUR SERVER 👑"),
		sound = "Sounds.Sfx.Success"
	}, 
	
	["iDont_hackbro2"] = {
		message = RainbowText("⚡  ADMIN LEON  JOINED YOUR SERVER ⚡"),
		sound = "Sounds.Sfx.Success"
	}
}

-- Quand un joueur rejoint
local function onPlayerAdded(player)
	local playerName = player.Name

	local specialData = SPECIAL_PLAYERS[playerName]

	if specialData then
		for _, p in ipairs(Players:GetPlayers()) do
			NotificationService.Notify(
				p,
				specialData.message,
				8,
				specialData.sound
			)
		end
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
	task.wait(0.1)
	onPlayerAdded(player)
end