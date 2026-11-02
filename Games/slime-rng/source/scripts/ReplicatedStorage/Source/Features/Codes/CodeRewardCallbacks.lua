-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CodeRewardCallbacks, time of decompilation: Sun May  3 10:12:10 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local server = require(ReplicatedStorage.Packages.DataService).server
local BoostServiceUtils = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceUtils)
local GoopRewardUtils = require(ReplicatedStorage.Source.Features.Currency.GoopRewardUtils)
local InventoryItemUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryItemUtils)
local JackpotSpinServiceUtils = require(ReplicatedStorage.Source.Features.JackpotSpins.JackpotSpinServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local Food = require(ReplicatedStorage.Source.Game.Items.Food)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local Zones = require(ReplicatedStorage.Source.Game.Items.Zones)
local Enemies = require(ReplicatedStorage.Source.Game.Items.Enemies)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local BoostServiceServer = require(ServerScriptService.Features.Boosts.BoostServiceServer)
local InventoryServiceServer = require(ServerScriptService.Features.Inventory.InventoryServiceServer)
local NotificationServiceServer = require(ServerScriptService.Features.Notifications.NotificationServiceServer)
local t1 = {}

local function getSafeZoneId(p1, p2) -- line: 43
	-- upvalues: Zones (copy), server (copy)
	local v35 = Zones.getMaxZone()

	if type(p2) == "number" then
		return (math.clamp(math.floor(p2 + 0.5), 1, v35))
	end

	return (math.clamp(math.floor((server:get(p1, "maxZone") or 1) + 0.5), 1, v35))
end
local function getAverageEnemyCoinReward(n1: number) -- line: 53
	-- upvalues: Zones (copy), Enemies (copy)
	local n2 = 0
	local n3 = 0

	for _, v40 in Zones.getZone(n1).enemies do
		local v41 = Enemies.getEnemyInfo(v40)

		if v41 then
			n2 += v41.reward
			n3 += 1
		end
	end

	if n3 <= 0 then
		return 0
	end

	return n2 / n3
end
local function grantCoins(p3, p4) -- line: 79
	-- upvalues: server (copy), ImageIds (copy), NotificationServiceServer (copy)
	local v47 = if type(p4) == "number" and p4 == p4 then math.max(math.floor(p4 + 0.5), 0) else 0

	if v47 <= 0 then
		return false
	end

	server:update(p3, "coins", function(n4: number?) -- line: 85
		-- upvalues: v47 (copy)
		return (n4 or 0) + v47
	end)
	server:update(p3, {
		"stats",
		"totalCoins"
	}, function(n5: number?) -- line: 88
		-- upvalues: v47 (copy)
		return (n5 or 0) + v47
	end)

	local coin = ImageIds.coin

	if coin and coin ~= "" and v47 > 0 then
		NotificationServiceServer:sendNotification(p3, coin, v47)
	end

	return true
end
local function grantGoop(p5, p6) -- line: 96
	-- upvalues: server (copy), ImageIds (copy), NotificationServiceServer (copy)
	local v51 = if type(p6) == "number" and p6 == p6 then math.max(math.floor(p6 + 0.5), 0) else 0

	if v51 <= 0 then
		return false
	end

	server:update(p5, "goop", function(n6: number?) -- line: 102
		-- upvalues: v51 (copy)
		return (n6 or 0) + v51
	end)

	local goop = ImageIds.goop

	if goop and goop ~= "" and v51 > 0 then
		NotificationServiceServer:sendNotification(p5, goop, v51)
	end

	return true
end
local function grantBoost(p7, p8, p9) -- line: 110
	-- upvalues: BoostServiceUtils (copy), BoostServiceServer (copy), ImageIds (copy), NotificationServiceServer (copy)
	if type(p8) ~= "string" or not BoostServiceUtils.getConfig(p8) then
		return false
	end

	local v56 = if type(p9) == "number" and p9 == p9 then math.max(math.floor(p9 + 0.5), 1) else 1
	local v57 = BoostServiceServer:addBoost(p7, p8, v56)

	if v57 then
		local v58 = ImageIds.boosts[p8]

		if v58 and v58 ~= "" and v56 > 0 then
			NotificationServiceServer:sendNotification(p7, v58, v56)
		end
	end

	return v57
end
local function grantBoostTime(p10, p11, p12) -- line: 124
	-- upvalues: BoostServiceUtils (copy), BoostServiceServer (copy)
	if type(p11) ~= "string" or not BoostServiceUtils.getConfig(p11) then
		return false
	end

	local v62 = math.max(math.floor(BoostServiceUtils.getDuration(p11) or 1), 1)
	local v63 = if type(p12) == "number" and p12 == p12 then math.max(math.floor(p12 + 0.5), 1) else v62

	return BoostServiceServer:addTimeToBoost(p10, p11, v63)
end
local function grantInventoryItem(p13, p14, p15, p16) -- line: 133
	-- upvalues: InventoryItemUtils (copy), InventoryServiceServer (copy), NotificationServiceServer (copy)
	if type(p14) ~= "string" then
		return false
	end

	local v68 = InventoryItemUtils.getDefinition(p14)

	if not v68 then
		return false
	end

	if p16 and p16 ~= v68.kind then
		return false
	end

	if v68.kind == "boost" then
		return false
	end

	local v69 = if type(p15) == "number" and p15 == p15 then math.max(math.floor(p15 + 0.5), 1) else 1
	local v70 = InventoryServiceServer:addItem(p13, p14, v69)

	if v70 then
		local icon = v68.icon

		if icon and icon ~= "" and v69 > 0 then
			NotificationServiceServer:sendNotification(p13, icon, v69)
		end
	end

	return v70
end
local function normalizeMutations(p17) -- line: 163
	-- upvalues: Mutations (copy)
	if p17 == nil then
		return nil
	end

	local t2 = {}
	local v74 = false

	if type(p17) == "string" then
		for match in string.gmatch(string.lower(p17), "[%a]+") do
			if Mutations.mutations[match] then
				t2[match] = true
				v74 = true
			end
		end
	elseif type(p17) == "table" then
		for v76, v77 in p17 do
			if type(v76) == "number" and type(v77) == "string" then
				local v78 = string.lower(v77)

				if Mutations.mutations[v78] then
					t2[v78] = true
					v74 = true
				end
			elseif v77 == true and type(v76) == "string" then
				local v79 = string.lower(v76)

				if Mutations.mutations[v79] then
					t2[v79] = true
					v74 = true
				end
			end
		end
	end

	if v74 then
		return t2
	end

	return nil
end
local function grantSlime(p18, p19, p20, p21, p22, p23) -- line: 199
	-- upvalues: Slimes (copy), normalizeMutations (copy), InventoryServiceServer (copy), NotificationServiceServer (copy)
	if type(p19) ~= "string" then
		return false
	end

	local ok, _ = pcall(Slimes.getSlime, p19)

	if not ok then
		return false
	end

	local v88 = if type(p20) == "number" and p20 == p20 then math.max(math.floor(p20 + 0.5), 1) else 1
	local v89 = if p21 ~= nil then if type(p21) == "number" and p21 == p21 then math.max(math.floor(p21 + 0.5), 1) else 1 else nil
	local v90 = if type(p22) == "number" and p22 == p22 then math.max(math.floor(p22 + 0.5), 0) else 0
	local v91 = normalizeMutations(p23)
	local v92 = v89 ~= nil or v90 > 0

	for _ = 1, v88 do
		if v92 then
			InventoryServiceServer:addSlime(p18, {
				id = p19,
				level = v89 or 1,
				xp = v90,
				mutations = v91
			})
		else
			InventoryServiceServer:addSlime(p18, {
				id = p19,
				mutations = v91
			})
		end
	end

	local v94 = Slimes.getImage(p19, v91)

	if v94 and v94 ~= "" and v88 > 0 then
		NotificationServiceServer:sendNotification(p18, v94, v88)
	end

	return true
end

function t1.coins(p24, n7: number) -- line: 239
	-- upvalues: grantCoins (copy)
	return (grantCoins(p24, n7))
end
function t1.goop(p25, n8: number) -- line: 243
	-- upvalues: grantGoop (copy)
	return (grantGoop(p25, n8))
end
function t1.zoneCoins(p26, n9: number, n10: number?) -- line: 247
	-- upvalues: getSafeZoneId (copy), getAverageEnemyCoinReward (copy), grantCoins (copy)
	local v102 = getSafeZoneId(p26, n10)
	local v103 = if type(n9) == "number" and n9 == n9 then math.max(math.floor(n9 + 0.5), 1) else 1
	local v104 = math.max(math.round(getAverageEnemyCoinReward(v102) * v103), 0)

	return (grantCoins(p26, v104))
end
function t1.zoneGoop(p27, n11: number, n12: number?) -- line: 254
	-- upvalues: getSafeZoneId (copy), GoopRewardUtils (copy), grantGoop (copy)
	local v108 = getSafeZoneId(p27, n12)
	local v109 = if type(n11) == "number" and n11 == n11 then math.max(math.floor(n11 + 0.5), 1) else 1
	local v110 = GoopRewardUtils.getBaseEnemyGoopReward(v108) * v109

	return (grantGoop(p27, v110))
end
function t1.boost(p28, s1: string, n13: number?) -- line: 261
	-- upvalues: grantBoost (copy)
	return (grantBoost(p28, s1, n13))
end
function t1.boostTime(p29, s2: string, n14: number?) -- line: 265
	-- upvalues: grantBoostTime (copy)
	return grantBoostTime(p29, s2, n14)
end
function t1.food(p30, s3: string, n15: number?) -- line: 269
	-- upvalues: Food (copy), grantInventoryItem (copy)
	if not Food.getFood(s3) then
		return false
	end

	return (grantInventoryItem(p30, s3, n15, "food"))
end
function t1.item(p31, s4: string, n16: number?) -- line: 277
	-- upvalues: grantInventoryItem (copy)
	return (grantInventoryItem(p31, s4, n16, nil))
end
function t1.consumable(p32, s5: string, n17: number?) -- line: 281
	-- upvalues: InventoryItemUtils (copy), grantBoost (copy), grantInventoryItem (copy)
	if type(s5) ~= "string" then
		return false
	end

	local v126 = InventoryItemUtils.getDefinition(s5)

	if not v126 then
		return false
	end

	if v126.kind == "boost" then
		return (grantBoost(p32, v126.boostKind or s5, n17))
	end

	return (grantInventoryItem(p32, s5, n17, nil))
end
function t1.jackpotSpin(p33, n18: number?) -- line: 298
	-- upvalues: grantInventoryItem (copy), JackpotSpinServiceUtils (copy)
	return (grantInventoryItem(p33, JackpotSpinServiceUtils.ITEM_ID, n18, "specialDice"))
end
function t1.jackpotSpins(p34, n19: number?) -- line: 302
	-- upvalues: t1 (copy)
	return t1.jackpotSpin(p34, n19)
end
function t1.bigDice(p35, n20: number?) -- line: 306
	-- upvalues: InventoryItemUtils (copy), InventoryServiceServer (copy), NotificationServiceServer (copy)
	local v133 = InventoryItemUtils.getDefinition("bigDice")

	if not v133 then
		return false
	end

	if v133.kind ~= "specialDice" then
		return false
	end

	if v133.kind == "boost" then
		return false
	end

	local v134 = if type(n20) == "number" and n20 == n20 then math.max(math.floor(n20 + 0.5), 1) else 1
	local v135 = InventoryServiceServer:addItem(p35, "bigDice", v134)

	if v135 then
		local icon = v133.icon

		if icon and icon ~= "" and v134 > 0 then
			NotificationServiceServer:sendNotification(p35, icon, v134)
		end
	end

	return v135
end
function t1.hugeDice(p36, n21: number?) -- line: 310
	-- upvalues: InventoryItemUtils (copy), InventoryServiceServer (copy), NotificationServiceServer (copy)
	local v139 = InventoryItemUtils.getDefinition("hugeDice")

	if not v139 then
		return false
	end

	if v139.kind ~= "specialDice" then
		return false
	end

	if v139.kind == "boost" then
		return false
	end

	local v140 = if type(n21) == "number" and n21 == n21 then math.max(math.floor(n21 + 0.5), 1) else 1
	local v141 = InventoryServiceServer:addItem(p36, "hugeDice", v140)

	if v141 then
		local icon = v139.icon

		if icon and icon ~= "" and v140 > 0 then
			NotificationServiceServer:sendNotification(p36, icon, v140)
		end
	end

	return v141
end
function t1.shinyDice(p37, n22: number?) -- line: 314
	-- upvalues: InventoryItemUtils (copy), InventoryServiceServer (copy), NotificationServiceServer (copy)
	local v145 = InventoryItemUtils.getDefinition("shinyDice")

	if not v145 then
		return false
	end

	if v145.kind ~= "specialDice" then
		return false
	end

	if v145.kind == "boost" then
		return false
	end

	local v146 = if type(n22) == "number" and n22 == n22 then math.max(math.floor(n22 + 0.5), 1) else 1
	local v147 = InventoryServiceServer:addItem(p37, "shinyDice", v146)

	if v147 then
		local icon = v145.icon

		if icon and icon ~= "" and v146 > 0 then
			NotificationServiceServer:sendNotification(p37, icon, v146)
		end
	end

	return v147
end
function t1.invertedDice(p38, n23: number?) -- line: 318
	-- upvalues: InventoryItemUtils (copy), InventoryServiceServer (copy), NotificationServiceServer (copy)
	local v151 = InventoryItemUtils.getDefinition("invertedDice")

	if not v151 then
		return false
	end

	if v151.kind ~= "specialDice" then
		return false
	end

	if v151.kind == "boost" then
		return false
	end

	local v152 = if type(n23) == "number" and n23 == n23 then math.max(math.floor(n23 + 0.5), 1) else 1
	local v153 = InventoryServiceServer:addItem(p38, "invertedDice", v152)

	if v153 then
		local icon = v151.icon

		if icon and icon ~= "" and v152 > 0 then
			NotificationServiceServer:sendNotification(p38, icon, v152)
		end
	end

	return v153
end
function t1.slime(p39, s6: string, n24: number?, n25: number?, n26: number?, p40) -- line: 322
	-- upvalues: grantSlime (copy)
	return (grantSlime(p39, s6, n24, n25, n26, p40))
end

t1.coin = t1.coins
t1.boosts = t1.boost
t1.activeBoost = t1.boostTime
t1.scaledCoins = t1.zoneCoins
t1.zoneScaledCoins = t1.zoneCoins
t1.zoneScaledGoop = t1.zoneGoop

return t1
