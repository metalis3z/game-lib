--give credits kas33214 join my discord to play my game link: https://www.roblox.com/games/119284579517566/Steal-a-Galaxy
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local CHANNEL = "b82db150-528f-4042-a0b5-ad6aaf1a5c33"

MessagingService:SubscribeAsync(CHANNEL, function(message)
	local data = message.Data
	if not data or not data.Text then
		return
	end

	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, data.Text, 5, nil, "Top")
	end
end)

local module = function(_, Config)
	Conch.register("announce", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "string",
				name = "text",
			}
		end,
		callback = function(text)
			if not text or text == "" then
				return "You must provide announcement text"
			end

			-- Configuration des préfixes par UserId (sans le système de rainbow)
			local prefixMap = {
				[7662723911] = { Tag = "Fayzox " },
				[5116730851] = { Tag = "Nova " }, --this code was made by Kas33214 dont leak it without Credits
				[9485277898] = { Tag = "BOT " },  --this code was made by Kas33214 dont leak it without Credits
			}

			local prefix = "Admin" 
			local ctx = Conch.get_command_context()

			if ctx and ctx.executor and ctx.executor.player then
				local player = ctx.executor.player
				local userId = player.UserId
				local preset = prefixMap[userId]

				if preset then
					prefix = preset.Tag
				else
					prefix = player.Name
				end
			end

			-- Structure finale propre : "Nom/Tag : Message"
			local fullText = prefix .. " : " .. text

			MessagingService:PublishAsync(CHANNEL, { Text = fullText })
			require(ReplicatedStorage.Controllers.SoundController):PlaySound(ReplicatedStorage.Sounds.Sfx.Blop)
			return "announced"
		end,
	})
end

return module