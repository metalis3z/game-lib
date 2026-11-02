local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)
local LuckService = require(script.Parent.Parent.Parent.LuckService)

local module = function(Conch, Config)
	Conch.register("ServerLuck", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "ServerLuck",
					name = "ServerLuck",
				},
			{
				kind = "argument",
				type = "number",
				name = "Duration",

			}
		end,
		callback = function(amount, Duration)
			LuckService:StartLuck(amount, Duration)
		end
	})
end

return module
