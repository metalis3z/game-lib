local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)

local MountService = Knit.CreateService({
	Name = "MountService",
	Client = {
		spawnMount = Knit.CreateSignal(),
		despawnMount = Knit.CreateSignal(),
	},
	_ds = nil,
})

function MountService.Client:toggleMount(player)
	local data = self.Server._ds:GetData(player)
	if not data then return false end
	local newState = not data.isMountEquipped
	self.Server._ds:Set(player, {"isMountEquipped"}, newState)
	if newState then
		self.Server.Client.spawnMount:Fire(player, data.equippedMount)
	else
		self.Server.Client.despawnMount:Fire(player)
	end
	return newState
end

function MountService.Client:equipMount(player, mountName)
	if type(mountName) ~= "string" then return "invalid" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	self.Server._ds:Set(player, {"equippedMount"}, mountName)
	if data.isMountEquipped then
		self.Server.Client.despawnMount:Fire(player)
		self.Server.Client.spawnMount:Fire(player, mountName)
	end
	return "success"
end

function MountService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function MountService:KnitStart()
	print("[MountService] Started")
end

return MountService