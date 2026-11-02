-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RebirthServiceClient, time of decompilation: Sun May  3 10:11:39 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Networker = require(ReplicatedStorage.Packages.Networker)
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local ErrorMessages = require(ReplicatedStorage.Source.Core.UI.Components.ErrorMessages)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local AdminLuckServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminLuckServiceClient)
local BoostServiceClient = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceClient)
local FriendsServiceClient = require(ReplicatedStorage.Source.Features.Friends.FriendsServiceClient)
local FriendsServiceUtils = require(ReplicatedStorage.Source.Features.Friends.FriendsServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local LikeGroupServiceClient = require(ReplicatedStorage.Source.Features.LikeGroup.LikeGroupServiceClient)
local LuckLadderServiceClient = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceClient)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local RebirthSlice = require(ReplicatedStorage.Source.Features.Rebirth.RebirthSlice)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local RollStatResolver = require(ReplicatedStorage.Source.Features.Roll.RollStatResolver)
local RebirthServiceUtils = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceUtils)
local SettingsState = require(ReplicatedStorage.Source.Features.Settings.SettingsState)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local t1 = {}
local t2 = {
	["Not enough goop"] = true,
	["Profile unavailable"] = true
}

local function resolveLuckForRebirthCount(n1: number) -- line: 45
	-- upvalues: client (copy), FriendsServiceUtils (copy), FriendsServiceClient (copy), LikeGroupServiceClient (copy), BoostServiceClient (copy), RebirthServiceUtils (copy), IndexServiceUtils (copy), LuckLadderServiceClient (copy), AdminLuckServiceClient (copy), RollStatResolver (copy), Products (copy), MonetizationServiceClient (copy), SettingsState (copy)
	local v27 = client:get("upgrades") or {}
	local v28 = math.max(client:get("furthestZone") or 1, client:get("maxZone") or 1)
	local v29 = FriendsServiceUtils.getFriendLuckBonus(FriendsServiceClient:getFriendCount(), v27)
	local v30 = LikeGroupServiceClient:getLuckBonus()
	local v31 = BoostServiceClient:getRollStatModifiers()

	if v29 > 0 then
		table.insert(v31, {
			id = "friends.luck",
			stat = "luck",
			mode = "add",
			value = v29
		})
	end

	if v30 > 0 then
		table.insert(v31, {
			id = "likeGroup.luck",
			stat = "luck",
			mode = "add",
			value = v30
		})
	end

	RebirthServiceUtils.addLuckModifier(v31, n1)

	for _, v33 in IndexServiceUtils.getLuckModifiers(client:get("index")) do
		table.insert(v31, v33)
	end

	local v34 = LuckLadderServiceClient:getRollStatModifier()

	if v34 then
		table.insert(v31, v34)
	end

	local v35 = AdminLuckServiceClient:getRollStatModifier()

	if v35 then
		table.insert(v31, v35)
	end

	return RollStatResolver.resolve({
		upgradesOwned = v27,
		zoneLuckBonus = math.max(v28 - 1, 0),
		modifiers = v31,
		ownsProductKey = function(p1) --[[ ownsProductKey ]] -- line: 89
			-- upvalues: Products (copy), MonetizationServiceClient (copy)
			local v47 = Products[p1]

			return v47 ~= nil and MonetizationServiceClient:ownsGamepass(v47)
		end,
		luckOverrideEnabled = SettingsState.get("luckOverrideEnabled") == true,
		luckOverrideValue = SettingsState.get("luckOverrideValue")
	}).luck
end

function t1.init(p2) -- line: 98
	-- upvalues: Networker (copy)
	p2.networker = Networker.client.new("RebirthService", p2)
	p2.pendingLuckSnapshot = nil
end
function t1.attemptRebirth(p3) -- line: 103
	-- upvalues: resolveLuckForRebirthCount (copy), client (copy), RollSlice (copy), ErrorMessages (copy), t2 (copy)
	p3.pendingLuckSnapshot = math.max(resolveLuckForRebirthCount(client:get("rebirths") or 0), RollSlice.luck() or 1, 1)

	local v38, v39 = p3.networker:fetch("requestRebirth")

	if not v38 then
		p3.pendingLuckSnapshot = nil

		if v39 == "Not enough goop" then
			ErrorMessages.add("You need more goop to rebirth.")
		elseif v39 == "Profile unavailable" then
			ErrorMessages.add("Your data is still loading. Try rebirthing again in a moment.")
		else
			ErrorMessages.add(v39 or "Failed to rebirth.")
		end

		if not t2[v39] then
			warn("Failed to rebirth:", v39)
		end
	end

	return v38
end
function t1.rebirthCompleted(p4, n2: number?) -- line: 118
	-- upvalues: client (copy), resolveLuckForRebirthCount (copy), RollSlice (copy), Menu (copy), SoundController (copy), Sounds (copy), RebirthSlice (copy)
	local v42 = math.max(n2 or (client:get("rebirths") or 1), 1)
	local v43 = math.max(v42 - 1, 0)
	local v44 = p4.pendingLuckSnapshot or math.max(resolveLuckForRebirthCount(v43), RollSlice.luck() or 1, 1)
	local v45 = math.max(resolveLuckForRebirthCount(v42), 1)

	p4.pendingLuckSnapshot = nil
	Menu.setOpenedMenu(nil)
	SoundController:Play(Sounds.misc.rebirth)
	RebirthSlice.actions.triggerBurst({
		baseLuck = v44,
		multiplier = v45 / math.max(v44, 1),
		resultLuck = v45
	})
end

return t1
