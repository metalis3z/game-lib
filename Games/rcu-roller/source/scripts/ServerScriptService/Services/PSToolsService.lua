local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)

local ALLOWED_USERS = {108167759}

local PSToolsService = Knit.CreateService({
	Name = "PSToolsService",
	Client = {
		call = Knit.CreateSignal(),
	},
	_ds = nil,
})

local COMMANDS = {
	giveGems = function(self, player, data, params)
		local amount = tonumber(params.amount) or 0
		self._ds:Set(player, {"gems"}, (data.gems or 0) + amount)
		return "gave " .. amount .. " gems"
	end,
	giveClicks = function(self, player, data, params)
		local amount = tonumber(params.amount) or 0
		self._ds:Set(player, {"clicks"}, (data.clicks or 0) + amount)
		return "gave " .. amount .. " clicks"
	end,
	setRebirths = function(self, player, data, params)
		local amount = tonumber(params.amount) or 0
		self._ds:Set(player, {"rebirths"}, amount)
		return "set rebirths to " .. amount
	end,
	resetData = function(self, player, data, params)
		return "resetData not implemented for safety"
	end,
}

function PSToolsService:KnitInit()
	self._ds = Knit.GetService("DataService")

	self.Client.call:Connect(function(player, commandName, params)
		if not table.find(ALLOWED_USERS, player.UserId) then
			warn("[PSToolsService] Unauthorized:", player.Name)
			return
		end
		if type(commandName) ~= "string" then return end
		local handler = COMMANDS[commandName]
		if not handler then
			warn("[PSToolsService] Unknown command:", commandName)
			return
		end
		local data = self._ds:GetData(player)
		if not data then return end
		local result = handler(self, player, data, params or {})
		print("[PSToolsService]", player.Name, commandName, result or "done")
	end)
end

function PSToolsService:KnitStart()
	print("[PSToolsService] Started")
end

return PSToolsService