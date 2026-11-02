local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)
local Variables = require(RS.Shared.Variables)

local AXES = {
	{name = "woodenAxe", damage = 1, cost = 0},
	{name = "stoneAxe", damage = 2, cost = 500},
	{name = "ironAxe", damage = 5, cost = 2500},
	{name = "goldenAxe", damage = 10, cost = 10000},
	{name = "diamondAxe", damage = 25, cost = 50000},
	{name = "mythicalAxe", damage = 50, cost = 250000},
}

local function getAxeIndex(axeName)
	for i, axe in AXES do
		if axe.name == axeName then return i end
	end
	return 1
end

local AxeService = Knit.CreateService({
	Name = "AxeService",
	Client = {},
	_ds = nil,
})

function AxeService.Client:upgradeAxe(player)
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	local currentAxe = data.axe or Variables.startingAxe
	local currentIdx = getAxeIndex(currentAxe)
	local nextAxe = AXES[currentIdx + 1]
	if not nextAxe then return "maxLevel" end
	if (data.wood or 0) < nextAxe.cost then return "notEnoughWood" end
	self.Server._ds:Set(player, {"wood"}, (data.wood or 0) - nextAxe.cost)
	self.Server._ds:Set(player, {"axe"}, nextAxe.name)
	return "success"
end

function AxeService:GetAxeDamage(data)
	local currentAxe = data.axe or Variables.startingAxe
	local idx = getAxeIndex(currentAxe)
	return AXES[idx] and AXES[idx].damage or 1
end

function AxeService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function AxeService:KnitStart()
	print("[AxeService] Started")
end

return AxeService