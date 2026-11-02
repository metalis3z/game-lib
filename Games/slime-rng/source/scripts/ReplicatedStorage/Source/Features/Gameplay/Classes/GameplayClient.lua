-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GameplayClient, time of decompilation: Sun May  3 10:11:20 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoinPickupClient = require(ReplicatedStorage.Source.Features.Gameplay.Classes.CoinPickupClient)
local EnemyClient = require(ReplicatedStorage.Source.Features.Gameplay.Classes.EnemyClient)
local GameplayFormationUtils = require(ReplicatedStorage.Source.Features.Gameplay.Classes.GameplayFormationUtils)
local GameplayServiceUtils = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceUtils)
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local Networker = require(ReplicatedStorage.Packages.Networker)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local SlimeClient = require(ReplicatedStorage.Source.Features.Gameplay.Classes.SlimeClient)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local t1 = {}

t1.__index = t1

function t1.new(p1) -- line: 71
	-- upvalues: Workspace (copy), Janitor (copy), t1 (copy), Networker (copy), RunService (copy)
	local Folder = Instance.new("Folder")

	Folder.Name = "Gameplay" .. p1.id
	Folder.Parent = Workspace

	local Folder2 = Instance.new("Folder")

	Folder2.Name = "Slimes"
	Folder2.Parent = Folder

	local Folder3 = Instance.new("Folder")

	Folder3.Name = "Enemies"
	Folder3.Parent = Folder

	local v25 = setmetatable({
		nextCurrencyPickupId = 0,
		followForward = Vector3.new(0, 0, 1),
		lastEnemyAttack = nil,
		lastSlimeAttack = nil,
		id = p1.id,
		janitor = Janitor.new(),
		root = Folder,
		slimeRoot = Folder2,
		enemyRoot = Folder3,
		enemies = {},
		slimes = {},
		currencyPickups = {}
	}, t1)

	v25.networker = Networker.client.new("Gameplay" .. v25.id, v25)

	for _, v27 in p1.slimes do
		v25:addSlime(v27)
	end

	for _, v29 in p1.enemies do
		v25:addEnemy(v29)
	end

	v25.janitor:Add(RunService.Heartbeat:Connect(function(dt: number) -- line: 109
		-- upvalues: v25 (copy)
		v25:update(dt)
	end))

	return v25
end
function t1.addSlime(p2, p3) -- line: 116
	-- upvalues: SlimeClient (copy)
	local v32 = p2.slimes[p3.uniqueId]

	if v32 then
		v32:destroy()
	end

	p2.slimes[p3.uniqueId] = SlimeClient.new(p3, p2.slimeRoot)
end
function t1.removeSlime(p4, s1: string) -- line: 125
	local v35 = p4.slimes[s1]

	if not v35 then
		return
	end

	v35:destroy()
	p4.slimes[s1] = nil
end
function t1.addEnemy(p5, p6) -- line: 135
	-- upvalues: TutorialServiceClient (copy), EnemyClient (copy)
	local v38 = p5.enemies[p6.uniqueId]

	if v38 then
		TutorialServiceClient:onEnemyRemoving(p6.uniqueId)
		v38:destroy()
	end

	p5.enemies[p6.uniqueId] = EnemyClient.new(p6, p5.enemyRoot)
	TutorialServiceClient:onEnemyAdded(p5.enemies[p6.uniqueId])
end
function t1.removeEnemy(p7, n1: number) -- line: 146
	-- upvalues: TutorialServiceClient (copy)
	local v41 = p7.enemies[n1]

	if not v41 then
		return
	end

	TutorialServiceClient:onEnemyRemoving(n1)

	if v41.health <= 0 then
		v41:playDeathVfx()
	end

	v41:destroy()
	p7.enemies[n1] = nil
end
function t1.update(p8, n2: number) -- line: 160
	-- upvalues: Players (copy), GameplayFormationUtils (copy), GameplayServiceUtils (copy)
	local Character = Players.LocalPlayer.Character
	local v45, v46

	if not Character then
		v45 = nil
		v46 = nil
	else
		local Pivot = Character:GetPivot()

		v45 = Vector3.new(Pivot.Position.X, 0, Pivot.Position.Z)
		v46 = Vector3.new(Pivot.LookVector.X, 0, Pivot.LookVector.Z)
	end

	local v48, v49, v50 = GameplayFormationUtils.getFormationBasis(p8.followForward, v45, v46, n2)

	p8.followForward = v49

	local v51 = GameplayFormationUtils.getSortedSlimes(p8.slimes)
	local t2 = {}
	local slimeStates = GameplayServiceUtils.enums.slimeStates

	for _, v55 in v51 do
		if v55.state == slimeStates.following then
			table.insert(t2, v55)
		end
	end

	local v56 = GameplayFormationUtils.getFollowFormationSlots(t2, v48, v49, v50)
	local v57 = GameplayFormationUtils.getAttackFormationSlots(p8.slimes, p8.enemies, v49)

	for _, v59 in v51 do
		local v60 = v57[v59.uniqueId] or v56[v59.uniqueId]
		local v61 = v60

		if v59.targetUniqueId and p8.enemies[v59.targetUniqueId] then
			v61 = p8.enemies[v59.targetUniqueId].pos
		elseif v59.state == slimeStates.following then
			v61 = v48
		end

		v59:update(n2, v45 and v48 or nil, v60, v61)
	end

	for _, v63 in p8.enemies do
		v63:update(n2, v48, p8.slimes)
	end

	for v64, v65 in p8.currencyPickups do
		if v65:update(n2) then
			v65:destroy()
			p8.currencyPickups[v64] = nil
		end
	end
end
function t1.slimeAdded(p9, p10) -- line: 203
	p9:addSlime(p10)
end
function t1.slimeRemoving(p11, s2: string) -- line: 207
	p11:removeSlime(s2)
end
function t1.enemyStateChanged(p12, n3: number, n4: number, s3: string?) -- line: 211
	local v74 = p12.enemies[n3]

	if v74 then
		v74:setState(n4, s3)
	end
end
function t1.enemyHealthChanged(p13, n5: number, n6: number, n7: number) -- line: 223
	local v79 = p13.enemies[n5]

	if v79 then
		v79:setHealth(n6, n7)
	end
end
function t1.enemyAttack(p14, n8: number, s4: string, n9: number) -- line: 235
	p14.lastEnemyAttack = {
		attackerUniqueId = n8,
		targetUniqueId = s4,
		damage = n9
	}

	local v84 = p14.enemies[n8]

	if v84 then
		local v85 = p14.slimes[s4]

		v84:onAttack(if not v85 then nil else v85.pos, n9)

		if v85 then
			v85:onDamaged(v84.pos, n9, v85.maxHealth)
		end
	end
end
function t1.enemyAdded(p15, p16) -- line: 258
	p15:addEnemy(p16)
end
function t1.enemyRemoving(p17, n10: number) -- line: 262
	p17:removeEnemy(n10)
end
function t1.currencyRewarded(p18, p19, p20) -- line: 266
	-- upvalues: SettingsState (copy), CoinPickupClient (copy)
	if type(p20.amount) ~= "number" then
		return
	end

	if p20.amount <= 0 then
		return
	end

	if not SettingsState.get("coinGoopCollectionVfx") then
		CoinPickupClient.collectImmediately(p19, p20.amount)

		return
	end

	local enemyUniqueId = p20.enemyUniqueId
	local g94 = nil
	local v95 = nil
	local v96 = nil

	repeat
		if g94 or type(enemyUniqueId) == "number" then
			if not g94 then
				v95 = p18.enemies[enemyUniqueId]
			end

			if g94 or v95 then
				if not g94 then
					v96 = v95.model:GetPivot().Position + Vector3.new(0, 2.5, 0)
				end

				g94 = false

				if not v96 then
					CoinPickupClient.collectImmediately(p19, p20.amount)

					return
				end

				p18.nextCurrencyPickupId = p18.nextCurrencyPickupId + 1
				p18.currencyPickups[p18.nextCurrencyPickupId] = CoinPickupClient.new(p19, p20.amount, v96, p18.root)

				return
			end
		end

		v96 = if typeof(p20.worldPosition) ~= "Vector3" then nil else p20.worldPosition
		g94 = true
	until not g94
end
function t1.coinRewarded(p21, p22) -- line: 295
	p21:currencyRewarded("coins", p22)
end
function t1.goopRewarded(p23, p24) -- line: 299
	p23:currencyRewarded("goop", p24)
end
function t1.slimeStateChanged(p25, s5: string, n11: number, n12: number?) -- line: 303
	local v105 = p25.slimes[s5]

	if v105 then
		v105:setState(n11, n12)
	end
end
function t1.slimeHealthChanged(p26, s6: string, n13: number, n14: number) -- line: 315
	local v110 = p26.slimes[s6]

	if v110 then
		v110:setHealth(n13, n14)
	end
end
function t1.slimeAttack(p27, s7: string, n15: number?, n16: number) -- line: 327
	p27.lastSlimeAttack = {
		attackerUniqueId = s7,
		targetUniqueId = n15,
		damage = n16
	}

	local v115 = p27.slimes[s7]

	if v115 then
		local v116 = if not n15 then nil else p27.enemies[n15]

		v115:onAttack(if not v116 then nil else v116.pos, n16)

		if v116 then
			v116:onDamaged(v115.pos, n16, v116.maxHealth)
		end
	end
end
function t1.destroy(p28) -- line: 350
	for _, v119 in p28.slimes do
		v119:destroy()
	end

	for _, v121 in p28.enemies do
		v121:destroy()
	end

	for _, v123 in p28.currencyPickups do
		v123:destroy()
	end

	p28.janitor:Destroy()
	p28.root:Destroy()
end

return t1
