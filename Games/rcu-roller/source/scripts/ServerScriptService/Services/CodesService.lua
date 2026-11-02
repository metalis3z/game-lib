local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)

local CODES = {
	release = {
		rewards = {
			{type = "gems", amount = 1000},
		},
	},
	update1 = {
		rewards = {
			{type = "gems", amount = 2500},
		},
	},
}

local CodesService = Knit.CreateService({
	Name = "CodesService",
	Client = {},
	_ds = nil,
	_inv = nil,
})

function CodesService.Client:redeem(player, code)
	if type(code) ~= "string" then return "invalid" end
	code = string.lower(code)
	local codeData = CODES[code]
	if not codeData then return "invalidCode" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	if data.redeemedCodes and data.redeemedCodes[code] then return "alreadyRedeemed" end
	for _, reward in codeData.rewards do
		if reward.type == "gems" then
			self.Server._ds:Set(player, {"gems"}, (data.gems or 0) + reward.amount)
		elseif reward.type == "clicks" then
			self.Server._ds:Set(player, {"clicks"}, (data.clicks or 0) + reward.amount)
		end
	end
	self.Server._ds:Set(player, {"redeemedCodes", code}, true)
	return "success"
end

function CodesService:KnitInit()
	self._ds = Knit.GetService("DataService")
	self._inv = Knit.GetService("InventoryService")
end

function CodesService:KnitStart()
	print("[CodesService] Started")
end

return CodesService