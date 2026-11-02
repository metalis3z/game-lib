local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MSG_TYPE = "GlobalPotReveal"

local function revealPotTimer()
	local resetEvent = ReplicatedStorage:FindFirstChild("ResetRainbowTimer")
	if resetEvent then
		resetEvent:Fire()
	end
end

-- Enregistrer le handler via MessagingHub
local function registerHandler()
	if not _G.MessagingHub then return end
	
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if not data then return end
		if data.FromServer == game.JobId then return end

		if data.Reveal then
			revealPotTimer()
		end
	end)
end

-- Attendre que MessagingHub soit prêt
task.spawn(function()
	while not _G.MessagingHub do
		task.wait(0.5)
	end
	registerHandler()
end)

local module = function(Conch, Config)
	Conch.register("globalpotreveal", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return nil
		end,

		callback = function(context)
			revealPotTimer()

			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					FromServer = game.JobId,
					Reveal = true
				})
			end

			return "pot revealed"
		end,
	})
end

return module