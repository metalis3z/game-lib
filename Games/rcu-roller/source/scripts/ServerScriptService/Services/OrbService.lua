local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Knit = require(RS.Packages.Knit)

local ORB_GEM_VALUE = 1
local MAX_ORBS_PER_COLLECT = 50

local OrbService = Knit.CreateService({
	Name = "OrbService",
	Client = {
		collectOrbs = Knit.CreateSignal(),
		createOrbs = Knit.CreateSignal(),
	},
	_ds = nil,
	_activeOrbs = {},
})

function OrbService:KnitInit()
	self._ds = Knit.GetService("DataService")

	self.Client.collectOrbs:Connect(function(player, orbIds)
		if typeof(orbIds) ~= "table" then return end
		local data = self._ds:GetData(player)
		if not data then return end

		local count = 0
		for _, orbId in orbIds do
			if count >= MAX_ORBS_PER_COLLECT then break end
			if self._activeOrbs[orbId] then
				self._activeOrbs[orbId] = nil
				count += 1
			end
		end

		if count > 0 then
			local gemsToAdd = count * ORB_GEM_VALUE
			self._ds:Set(player, {"gems"}, (data.gems or 0) + gemsToAdd)
		end
	end)
end

function OrbService:SpawnOrbs(position, count, mapId)
	local orbs = {}
	for i = 1, count do
		local orbId = tostring(os.clock()) .. "_" .. i
		self._activeOrbs[orbId] = {position = position, mapId = mapId}
		orbs[#orbs + 1] = {orbId = orbId, position = position, item = orbId}
	end
	for _, player in Players:GetPlayers() do
		self.Client.createOrbs:Fire(player, orbs)
	end
end

function OrbService:KnitStart()
	print("[OrbService] Started")
end

return OrbService