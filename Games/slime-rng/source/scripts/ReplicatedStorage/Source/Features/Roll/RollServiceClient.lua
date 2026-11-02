-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RollServiceClient, time of decompilation: Sun May  3 10:11:44 2026 ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local client = require(ReplicatedStorage.Packages.DataService).client
local BoostServiceClient = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceClient)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local AdminLuckServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminLuckServiceClient)
local FriendsServiceClient = require(ReplicatedStorage.Source.Features.Friends.FriendsServiceClient)
local FriendsServiceUtils = require(ReplicatedStorage.Source.Features.Friends.FriendsServiceUtils)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local LikeGroupServiceClient = require(ReplicatedStorage.Source.Features.LikeGroup.LikeGroupServiceClient)
local LuckLadderServiceClient = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceClient)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local RebirthServiceUtils = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceUtils)
local RollSlice = require(script.Parent.RollSlice)
local Networker = require(ReplicatedStorage.Packages.Networker)
local SettingsServiceClient = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceClient)
local SettingsServiceUtils = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceUtils)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local Vide = require(ReplicatedStorage.Packages.Vide)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local RareRollCutsceneVisuals = require(ReplicatedStorage.Source.Features.Roll.RareRollCutsceneVisuals)
local RareRollCutsceneUtils = require(ReplicatedStorage.Source.Features.Roll.RareRollCutsceneUtils)
local RollStatResolver = require(ReplicatedStorage.Source.Features.Roll.RollStatResolver)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local t1 = {}
local v30 = "Global " .. utf8.char(127757)

local function getResolvedArmedSpecialDiceQueue() -- line: 44
	-- upvalues: SpecialDiceServiceUtils (copy), client (copy)
	return SpecialDiceServiceUtils.migrateQueue(client:get("armedSpecialDice"), client:get("armedJackpotSpins"))
end
local function armRareRollCutscene(p1, p2) -- line: 55
	-- upvalues: RareRollCutsceneUtils (copy), client (copy), Products (copy), MonetizationServiceClient (copy), SettingsServiceUtils (copy), SettingsState (copy), RollSlice (copy)
	local v38 = p1.furthestZone()
	local v39 = RareRollCutsceneUtils.getFixedRequiredRarityDenominator(v38)
	local v40 = RareRollCutsceneUtils.getPermanentLuck({
		upgradesOwned = p1.ownedUpgrades(),
		furthestZone = v38,
		indexData = client:get("index"),
		ownsProductKey = function(p3) -- line: 49
			-- upvalues: Products (copy), MonetizationServiceClient (copy)
			local v99 = Products[p3]

			return v99 ~= nil and MonetizationServiceClient:ownsGamepass(v99)
		end,
		rebirths = p1.rebirths()
	})
	local v41 = if v39 == nil then nil else RareRollCutsceneUtils.getRarestQualifiedSlime(p2, v38, v40)

	if v39 == nil then
		local v42 = SettingsServiceUtils.getRareRollCutsceneThreshold(SettingsState.get("rareRollCutscenes"))

		if v42 == nil then
			RollSlice.actions.clearPendingRareRollCutscene()

			return
		end

		v41 = RareRollCutsceneUtils.getRarestQualifiedSlimeByThreshold(p2, v40, v42)
	end

	if not v41 then
		RollSlice.actions.clearPendingRareRollCutscene()

		return
	end

	RollSlice.actions.armRareRollCutscene(v41)
end
local function getGlobalsTextChannel() -- line: 97
	-- upvalues: TextChatService (copy), v30 (copy)
	local TextChannels = TextChatService:WaitForChild("TextChannels", 10)

	if not TextChannels then
		return nil
	end

	local v45 = TextChannels:FindFirstChild(v30)

	if v45 == nil then
		v45 = TextChannels:WaitForChild(v30, 5)
	end

	if v45 and v45:IsA("TextChannel") then
		return v45
	end

	local RBXGeneral = TextChannels:FindFirstChild("RBXGeneral")

	if RBXGeneral and RBXGeneral:IsA("TextChannel") then
		return RBXGeneral
	end

	return nil
end
local function syncResolvedRollStats(p4) -- line: 133
	-- upvalues: FriendsServiceUtils (copy), FriendsServiceClient (copy), LikeGroupServiceClient (copy), BoostServiceClient (copy), RebirthServiceUtils (copy), IndexServiceUtils (copy), client (copy), LuckLadderServiceClient (copy), AdminLuckServiceClient (copy), RollStatResolver (copy), Products (copy), MonetizationServiceClient (copy), SettingsState (copy), RollSlice (copy)
	local v50 = p4.ownedUpgrades() or {}
	local v51 = FriendsServiceUtils.getFriendLuckBonus(FriendsServiceClient:getFriendCount(), v50)
	local v52 = LikeGroupServiceClient:getLuckBonus()
	local v53 = BoostServiceClient:getRollStatModifiers()

	if v51 > 0 then
		table.insert(v53, {
			id = "friends.luck",
			stat = "luck",
			mode = "add",
			value = v51
		})
	end

	if v52 > 0 then
		table.insert(v53, {
			id = "likeGroup.luck",
			stat = "luck",
			mode = "add",
			value = v52
		})
	end

	RebirthServiceUtils.addLuckModifier(v53, p4.rebirths())

	for _, v55 in IndexServiceUtils.getLuckModifiers(client:get("index")) do
		table.insert(v53, v55)
	end

	local v56 = LuckLadderServiceClient:getRollStatModifier()

	if v56 then
		table.insert(v53, v56)
	end

	local v57 = AdminLuckServiceClient:getRollStatModifier()

	if v57 then
		table.insert(v53, v57)
	end

	local v58 = RollStatResolver.resolve({
		upgradesOwned = v50,
		zoneLuckBonus = math.max((p4.furthestZone() or 1) - 1, 0),
		modifiers = v53,
		ownsProductKey = function(p5) -- line: 49
			-- upvalues: Products (copy), MonetizationServiceClient (copy)
			local v101 = Products[p5]

			return v101 ~= nil and MonetizationServiceClient:ownsGamepass(v101)
		end,
		luckOverrideEnabled = SettingsState.get("luckOverrideEnabled") == true,
		luckOverrideValue = SettingsState.get("luckOverrideValue")
	})

	RollSlice.actions.setResolvedRollStats(v58)
end
local function tryResumeAutoRoll(p6) -- line: 182
	-- upvalues: RollSlice (copy), client (copy), UpgradeServiceUtils (copy), TutorialServiceClient (copy)
	if not RollSlice.autoRoll() then
		return
	end

	local v61 = p6.ownedUpgrades and p6.ownedUpgrades() or client:get("upgrades")

	if not UpgradeServiceUtils.ownsUpgrade("autoRoll", v61 or {}) then
		return
	end

	if not TutorialServiceClient:canRoll() then
		return
	end

	if RollSlice.rollResults()[1] ~= nil or RollSlice.jackpotScreenShown() or RollSlice.rareRollCutsceneShown() then
		return
	end

	task.defer(function() -- line: 199
		-- upvalues: RollSlice (copy), p6 (copy)
		if RollSlice.autoRoll() and RollSlice.rollResults()[1] == nil then
			p6:roll()
		end
	end)
end

function t1.init(p7) -- line: 206
	-- upvalues: Networker (copy), Vide (copy), client (copy), getResolvedArmedSpecialDiceQueue (copy), syncResolvedRollStats (copy), SettingsServiceClient (copy), RollSlice (copy), LuckLadderServiceClient (copy), AdminLuckServiceClient (copy), Products (copy), tryResumeAutoRoll (copy)
	p7.networker = Networker.client.new("RollService", p7)
	p7.ownedUpgrades = Vide.source(client:get("upgrades") or {})
	p7.furthestZone = Vide.source((math.max(client:get("furthestZone") or 1, client:get("maxZone") or 1)))
	p7.rebirths = Vide.source(client:get("rebirths") or 0)
	p7.armedSpecialDice = Vide.source(getResolvedArmedSpecialDiceQueue())
	p7.ownedUpgradesChangedConn = client:getChangedSignal("upgrades"):Connect(function(p8) -- line: 212
		-- upvalues: p7 (copy), syncResolvedRollStats (copy)
		p7.ownedUpgrades(p8 or {})
		syncResolvedRollStats(p7)
	end)
	p7.furthestZoneChangedConn = client:getChangedSignal("furthestZone"):Connect(function(p9) -- line: 216
		-- upvalues: p7 (copy), client (copy), syncResolvedRollStats (copy)
		p7.furthestZone((math.max(p9 or 1, client:get("maxZone") or 1)))
		syncResolvedRollStats(p7)
	end)
	p7.rebirthsChangedConn = client:getChangedSignal("rebirths"):Connect(function(p10) -- line: 220
		-- upvalues: p7 (copy), syncResolvedRollStats (copy)
		p7.rebirths(p10 or 0)
		syncResolvedRollStats(p7)
	end)
	p7.armedSpecialDiceChangedConn = client:getChangedSignal("armedSpecialDice"):Connect(function() -- line: 224
		-- upvalues: p7 (copy), getResolvedArmedSpecialDiceQueue (copy)
		p7.armedSpecialDice(getResolvedArmedSpecialDiceQueue())
	end)
	p7.armedJackpotSpinsChangedConn = client:getChangedSignal("armedJackpotSpins"):Connect(function() -- line: 227
		-- upvalues: p7 (copy), getResolvedArmedSpecialDiceQueue (copy)
		p7.armedSpecialDice(getResolvedArmedSpecialDiceQueue())
	end)
	p7.boostsChangedConn = client:getChangedSignal("boosts"):Connect(function() -- line: 230
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	p7.indexChangedConn = client:getChangedSignal("index"):Connect(function() -- line: 233
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	p7.friendsInServerChangedConn = client:getChangedSignal("friendsInServer"):Connect(function() -- line: 236
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	p7.likeGroupLuckChangedConn = client:getChangedSignal("likeGroupLuckActive"):Connect(function() -- line: 239
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	SettingsServiceClient:subscribe("hideRoll", function(p11) -- line: 242
		-- upvalues: RollSlice (copy)
		RollSlice.hiddenRoll(p11 == true)
	end)
	SettingsServiceClient:subscribe("autoRoll", function(p12) -- line: 245
		-- upvalues: RollSlice (copy)
		RollSlice.autoRoll(p12 == true)
	end)
	SettingsServiceClient:subscribe("luckOverrideEnabled", function() -- line: 248
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	SettingsServiceClient:subscribe("luckOverrideValue", function() -- line: 251
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	p7.luckLadderChangedConn = LuckLadderServiceClient.stateChanged:Connect(function() -- line: 254
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	p7.adminLuckChangedConn = AdminLuckServiceClient.stateChanged:Connect(function() -- line: 257
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		syncResolvedRollStats(p7)
	end)
	p7.gamepassChangedConns = {
		client:getChangedSignal({
			"__gamepasses",
			(tostring(Products.fastRoll.id))
		}):Connect(function() -- line: 261
			-- upvalues: syncResolvedRollStats (copy), p7 (copy)
			syncResolvedRollStats(p7)
		end),
		client:getChangedSignal({
			"__gamepasses",
			(tostring(Products.luckyRolls.id))
		}):Connect(function() -- line: 264
			-- upvalues: syncResolvedRollStats (copy), p7 (copy)
			syncResolvedRollStats(p7)
		end),
		client:getChangedSignal({
			"__gamepasses",
			(tostring(Products.vip.id))
		}):Connect(function() -- line: 267
			-- upvalues: syncResolvedRollStats (copy), p7 (copy)
			syncResolvedRollStats(p7)
		end)
	}
	syncResolvedRollStats(p7)
	tryResumeAutoRoll(p7)
	task.spawn(function() -- line: 274
		-- upvalues: syncResolvedRollStats (copy), p7 (copy)
		while true do
			task.wait(1)
			syncResolvedRollStats(p7)
		end
	end)
end
function t1.isJackpotSpinActive(p13) -- line: 282
	return p13:getActiveSpecialDiceItemId() == "jackpotSpin"
end
function t1.hasArmedJackpotSpin(p14) -- line: 286
	-- upvalues: SpecialDiceServiceUtils (copy)
	if p14.armedSpecialDice == nil then
		return false
	end

	return SpecialDiceServiceUtils.getJackpotArmedCount(p14.armedSpecialDice()) > 0
end
function t1.getActiveSpecialDiceItemId(p15) -- line: 294
	-- upvalues: SpecialDiceServiceUtils (copy)
	if p15.armedSpecialDice == nil then
		return nil
	end

	return SpecialDiceServiceUtils.getActiveItemId(p15.armedSpecialDice())
end
function t1.getRollButtonImage(p16) -- line: 302
	-- upvalues: SpecialDiceServiceUtils (copy), ImageIds (copy)
	local v67 = p16:getActiveSpecialDiceItemId()
	local v68 = SpecialDiceServiceUtils.getItemIcon(v67)

	if v68 then
		return v68
	end

	return ImageIds.dice
end
function t1.roll(p17)
	if not p17.networker then
		warn("[RollServiceClient] networker is nil — init not complete")
		return false
	end

	local canRoll = TutorialServiceClient:canRoll()
	print("[RollServiceClient] canRoll:", canRoll)

	if not canRoll then
		ErrorMessages.add("You can't roll yet.")
		return false
	end

	print("[RollServiceClient] Fetching roll from server...")
	local v70, v71, v72, v73 = p17.networker:fetch("requestRoll")
	print("[RollServiceClient] Server returned:", v70, v71, v72, v73)

	if not v70 then
		ErrorMessages.add("Roll failed. Try again.")
		warn("[RollServiceClient] Server returned no results for requestRoll")
		return false
	end

	Vide.batch(function()
		RollSlice.actions.resetRollCompletions()
		RollSlice.actions.setInstantRevealRoll(false)
		RollSlice.rollResults(v70)
		RollSlice.actions.setRollTable(v71)
		RollSlice.activeSpecialRolls(v71.activeSpecialRolls or {})
		RollSlice.bonusRollResults({})
		RollSlice.jackpotScreenShown(false)
		RollSlice.actions.setJackpotSpinQueue(v73 or {})
		RollSlice.luckRainBurst(0)
		RollSlice.luckRainMultiplier(2)
		RollSlice.actions.beginNewSlimeRoll()
		RollSlice.actions.setNewSlimeQueue(v72 or {})
		RollSlice.actions.clearPendingRareRollCutscene()
		RollSlice.actions.clearRareRollCutscene()

		if not RollSlice.hiddenRoll() then
			RollSlice.rollScreenShown(true)
		end
	end)

	armRareRollCutscene(p17, v70)
	return true
end
function t1.activateRollButton(p18) -- line: 349
	-- upvalues: RollSlice (copy)
	if RollSlice.hiddenRoll() and RollSlice.rollResults()[1] ~= nil then
		p18:setHiddenRollEnabled(false)
		RollSlice.rollScreenShown(true)
	end

	if not RollSlice.rollResults()[1] then
		return p18:roll()
	end

	return true
end
function t1.setAutoRollEnabled(p19, b1: boolean) -- line: 362
	-- upvalues: SettingsServiceClient (copy), RollSlice (copy), tryResumeAutoRoll (copy)
	local v77 = b1 == true

	SettingsServiceClient:set("autoRoll", v77)

	if not v77 then
		RollSlice.autoRoll(false)
		p19:setHiddenRollEnabled(false)

		return
	end

	RollSlice.autoRoll(true)
	tryResumeAutoRoll(p19)
end
function t1.setHiddenRollEnabled(_, b2: boolean) -- line: 375
	-- upvalues: SettingsServiceClient (copy), RollSlice (copy)
	local v80 = b2 == true

	SettingsServiceClient:set("hideRoll", v80)
	RollSlice.hiddenRoll(v80)
end
function t1.spectatorRareRoll(_, n1: number, vector3: Vector3, p22) -- line: 381
	-- upvalues: Players (copy), SettingsState (copy), RareRollCutsceneVisuals (copy)
	if n1 == Players.LocalPlayer.UserId then
		return
	end

	if typeof(vector3) ~= "Vector3" then
		return
	end

	task.delay(0.5, function() -- line: 394
		-- upvalues: SettingsState (copy), Players (copy), vector3 (copy), RareRollCutsceneVisuals (copy), p22 (copy)
		if not SettingsState.get("otherPlayerRareRollVisuals") then
			return
		end

		local Character = Players.LocalPlayer.Character
		local v108 = if Character then Character:GetPivot().Position else nil

		if v108 == nil then
			return
		end

		if (v108 - vector3).Magnitude > 250 then
			return
		end

		RareRollCutsceneVisuals.playSpectator(vector3, p22)
	end)
end
function t1.rareRollAnnouncement(_, p24, b3: boolean?, b4: boolean?) -- line: 411
	-- upvalues: getGlobalsTextChannel (copy), TextChatService (copy)
	if type(p24) ~= "table" or type(p24.message) ~= "string" then
		return
	end

	local v89 = if b3 ~= false then getGlobalsTextChannel() else nil

	if v89 ~= nil then
		v89:DisplaySystemMessage(p24.message)
	end

	if b4 == true then
		local TextChannels = TextChatService:WaitForChild("TextChannels", 10)
		local v91

		if not TextChannels then
			v91 = nil
		else
			local RBXGeneral = TextChannels:FindFirstChild("RBXGeneral")

			v91 = if not RBXGeneral or not RBXGeneral:IsA("TextChannel") then nil else RBXGeneral
		end

		if v91 and v91 ~= v89 then
			v91:DisplaySystemMessage(p24.message)
		end
	end
end
function t1.setSpecialRollPaused(p25, p26, b5: boolean) -- line: 433
	if not p25.networker:fetch("requestSetSpecialRollPaused", p26, b5) then
		warn("Failed to update special roll pause state")
	end
end

return t1
