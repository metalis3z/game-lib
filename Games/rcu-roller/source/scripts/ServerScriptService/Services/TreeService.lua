local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Knit = require(RS.Packages.Knit)
local Variables = require(RS.Shared.Variables)

local TREE_RESPAWN_TIME = 10
local TREE_BASE_HP = 100

local TreeService = Knit.CreateService({
	Name = "TreeService",
	Client = {
		damage2 = Knit.CreateSignal(),
		treeFelled = Knit.CreateSignal(),
		treeRespawned = Knit.CreateSignal(),
	},
	_ds = nil,
	_axeService = nil,
	_treeHP = {},
	_respawnTimers = {},
})

function TreeService:_getTreeKey(groupId, treeId)
	return groupId .. "_" .. treeId
end

function TreeService:_damageTree(player, groupId, treeId)
	local data = self._ds:GetData(player)
	if not data then return end
	if not data.isAxeEquipped then return end

	local key = self:_getTreeKey(groupId, treeId)
	if not self._treeHP[key] then
		self._treeHP[key] = TREE_BASE_HP
	end

	local damage = self._axeService:GetAxeDamage(data)
	self._treeHP[key] -= damage

	if self._treeHP[key] <= 0 then
		self._treeHP[key] = nil
		local woodReward = damage * 2
		self._ds:Set(player, {"wood"}, (data.wood or 0) + woodReward)
		self.Client.treeFelled:Fire(player, groupId, treeId, woodReward)
		local QuestService = Knit.GetService("QuestService")
		QuestService:IncrementQuest(player, "destroyTree", 1, groupId)
		local replica = self._ds:GetReplica(player)
		if replica then
			local newCount = (data.stats and data.stats.treesDestroyed or 0) + 1
			replica:Set({"stats", "treesDestroyed"}, newCount)
		end

		self._respawnTimers[key] = task.delay(TREE_RESPAWN_TIME, function()
			self._respawnTimers[key] = nil
			self._treeHP[key] = TREE_BASE_HP
			for _, p in Players:GetPlayers() do
				self.Client.treeRespawned:Fire(p, groupId, treeId)
			end
		end)
	end
end

function TreeService:KnitInit()
	self._ds = Knit.GetService("DataService")
	self._axeService = Knit.GetService("AxeService")

	self.Client.damage2:Connect(function(player, groupId, treeId)
		if type(groupId) ~= "string" and type(groupId) ~= "number" then return end
		if type(treeId) ~= "string" and type(treeId) ~= "number" then return end
		self:_damageTree(player, tostring(groupId), tostring(treeId))
	end)
end

function TreeService:KnitStart()
	Players.PlayerRemoving:Connect(function(_player)
	end)
	print("[TreeService] Started")
end

return TreeService