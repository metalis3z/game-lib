-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LootServiceClient, time of decompilation: Sun May  3 10:12:02 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local client = require(ReplicatedStorage.Packages.DataService).client
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Networker = require(ReplicatedStorage.Packages.Networker)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local LootPickupClient = require(ReplicatedStorage.Source.Features.Loot.Classes.LootPickupClient)

require(ReplicatedStorage.Source.Features.Loot.LootServiceUtils)

local PlayerUpgradeUtils = require(ReplicatedStorage.Source.Features.Upgrades.PlayerUpgradeUtils)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

return {
	refreshUpgradeState = function(p1) --[[ refreshUpgradeState ]] -- line: 18
		-- upvalues: PlayerUpgradeUtils (copy)
		local v12 = p1.ownedUpgrades or {}

		p1.magnetRadius = PlayerUpgradeUtils.getMagnetRadius(v12)
	end,
	init = function(p2) --[[ init ]] -- line: 23
		-- upvalues: Networker (copy), Janitor (copy), Workspace (copy), client (copy), RunService (copy)
		p2.networker = Networker.client.new("LootService", p2)
		p2.janitor = Janitor.new()
		p2.lootRoot = Instance.new("Folder")
		p2.lootRoot.Name = "Loot"
		p2.lootRoot.Parent = Workspace
		p2.lootById = {}
		p2.ownedUpgrades = client:get("upgrades") or {}
		p2:refreshUpgradeState()
		p2.janitor:Add(RunService.Heartbeat:Connect(function(dt: number) -- line: 33
			-- upvalues: p2 (copy)
			p2:update(dt)
		end))
		p2.janitor:Add(client:getChangedSignal("upgrades"):Connect(function(p3) -- line: 36
			-- upvalues: p2 (copy)
			p2.ownedUpgrades = p3 or {}
			p2:refreshUpgradeState()
		end))
		task.spawn(function() -- line: 41
			-- upvalues: p2 (copy)
			for _, v32 in p2.networker:fetch("getLootData") or {} do
				p2:lootAdded(v32, true)
			end
		end)
	end,
	update = function(p4, n1: number) --[[ update ]] -- line: 49
		for _, v17 in p4.lootById do
			v17:update(n1, p4.magnetRadius)
		end
	end,
	requestCollect = function(p5, s1: string) --[[ requestCollect ]] -- line: 55
		-- upvalues: SoundController (copy), Sounds (copy)
		local v20, v21 = p5.networker:fetch("requestCollect", s1)

		if v20 then
			SoundController:Play(Sounds.misc.itemPickup)
			p5:lootRemoved(s1)

			return true
		end

		if v21 == "Loot not found" or v21 == "Loot expired" then
			p5:lootRemoved(s1)

			return true
		end

		warn("Failed to collect loot:", v21)

		return false
	end,
	lootAdded = function(p6, p7, b1: boolean?) --[[ lootAdded ]] -- line: 72
		-- upvalues: SoundController (copy), Sounds (copy), LootPickupClient (copy)
		local v25 = p6.lootById[p7.uniqueId]

		if v25 then
			v25:destroy()
		end

		if not b1 then
			SoundController:Play(Sounds.misc.itemDrop)
		end

		p6.lootById[p7.uniqueId] = LootPickupClient.new(p7, p6.lootRoot, function(s2: string) -- line: 82
			-- upvalues: p6 (copy)
			return p6:requestCollect(s2)
		end)
	end,
	lootRemoved = function(p8, s3: string) --[[ lootRemoved ]] -- line: 87
		local v28 = p8.lootById[s3]

		if not v28 then
			return
		end

		v28:destroy()
		p8.lootById[s3] = nil
	end
}
