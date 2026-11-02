local SS = game:GetService("ServerScriptService")
local TimerService = require(SS:WaitForChild("Services"):FindFirstChild("TimerService"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)
local MessagingService = game:GetService("MessagingService")
local module = function(_, Config)
	MessagingService:SubscribeAsync("GlobalTimer", function(d)
		local Data = d.Data
		TimerService.CreateTimer(Data[1], Data[2], Data[3])
	end)
	Conch.register("globaltimer", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "duration",
				name = "time (IN SECONDS)",
			},
			{
				kind = "argument",
				type = "string",
				name = "name",
			},
			{
				kind = "argument",
				type = "Color3",
				name = "Color",
			}
		end,
		callback = function(timee, name, color)
			if not timee or timee == "" then
				return "You must provide time to end"
			end

			if not name or name == "" then
				return "You must provide name"
			end

			MessagingService:PublishAsync("GlobalTimer", workspace:GetServerTimeNow() + timee, name, color)
			return "added"
		end,
	})
	Conch.register("localtimer", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "duration",
				name = "time (IN SECONDS)",
			},
			{
				kind = "argument",
				type = "string",
				name = "name",
			},
			{
				kind = "argument",
				type = "Color3",
				name = "Color",
			}
		end,
		callback = function(timee, name, color)
			if not timee or timee == "" then
				return "You must provide time to end"
			end

			if not name or name == "" then
				return "You must provide name"
			end

			TimerService.CreateTimer(workspace:GetServerTimeNow() + timee, name, color)
			return "added"
		end,
	})
end

return module