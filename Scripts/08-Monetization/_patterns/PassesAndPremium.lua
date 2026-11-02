--[[
	PassesAndPremium  (ModuleScript, server only)

	Game pass ownership and Roblox Premium perks in one place.
	  * checks every configured pass once on join (in parallel, pcall'd)
	  * mirrors ownership to player attributes ("Pass_VIP" = true) so any script, server or
	    client, can read it without a remote call
	  * picks up in-game purchases instantly (PromptGamePassPurchaseFinished)
	  * OnOwned(name, callback) runs a perk for every owner: now, on join and on purchase
	  * Premium: "Premium" attribute kept in sync with PlayerMembershipChanged

	Credit: drill-and-mine GamepassService (OwnsGamepass_<key> attributes, re-query only when
	unknown) and RobloxPlusService (premium boost + PlayerMembershipChanged), punching-simulator
	Purchases (pass callbacks), BIG Paintball Gamepasses (owned list saved with the player).

	Usage (server):
		local Passes = require(game.ServerScriptService.PassesAndPremium)
		Passes.Init({
			VIP = 12345678,
			DoubleCoins = 23456789,
		})

		Passes.OnOwned("VIP", function(player)
			player:SetAttribute("ChatTag", "VIP")
		end)

		Passes.OnPremium(function(player, isPremium)
			player:SetAttribute("PremiumBonus", if isPremium then 0.1 else 0)
		end)

		local multiplier = if Passes.Owns(player, "DoubleCoins") then 2 else 1

	Client read (no remote needed):
		if localPlayer:GetAttribute("Pass_VIP") then ... end
]]

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local PassesAndPremium = {}

local ATTRIBUTE_PREFIX = "Pass_"

local passIds = {} -- [name] = id
local passNames = {} -- [id] = name
local ownedCallbacks = {} -- [name] = { callback, ... }
local premiumCallbacks = {}

local function runOwned(player, name)
	for _, callback in ipairs(ownedCallbacks[name] or {}) do
		task.spawn(callback, player)
	end
end

local function grant(player, name)
	if player:GetAttribute(ATTRIBUTE_PREFIX .. name) == true then
		return
	end
	player:SetAttribute(ATTRIBUTE_PREFIX .. name, true)
	runOwned(player, name)
end

local function checkPlayer(player)
	for name, id in pairs(passIds) do
		task.spawn(function()
			local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, id)
			if not ok then
				warn(("[Passes] Ownership check failed for %s / %s: %s"):format(player.Name, name, tostring(owns)))
				return -- leave the attribute unset; Refresh() can try again later
			end
			if player.Parent ~= Players then
				return
			end
			if owns then
				grant(player, name)
			elseif player:GetAttribute(ATTRIBUTE_PREFIX .. name) == nil then
				player:SetAttribute(ATTRIBUTE_PREFIX .. name, false)
			end
		end)
	end
end

local function refreshPremium(player)
	local isPremium = player.MembershipType == Enum.MembershipType.Premium
	if player:GetAttribute("Premium") == isPremium then
		return
	end
	player:SetAttribute("Premium", isPremium)
	for _, callback in ipairs(premiumCallbacks) do
		task.spawn(callback, player, isPremium)
	end
end

function PassesAndPremium.Init(passes)
	for name, id in pairs(passes) do
		passIds[name] = id
		passNames[id] = name
	end

	local function onJoin(player)
		refreshPremium(player)
		checkPlayer(player)
	end
	Players.PlayerAdded:Connect(onJoin)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(onJoin, player)
	end

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, purchased)
		local name = passNames[passId]
		if purchased and name then
			grant(player, name)
		end
	end)

	Players.PlayerMembershipChanged:Connect(refreshPremium)
	MarketplaceService.PromptPremiumPurchaseFinished:Connect(function(player)
		task.delay(1, refreshPremium, player)
	end)
end

function PassesAndPremium.Owns(player, name)
	return player:GetAttribute(ATTRIBUTE_PREFIX .. name) == true
end

function PassesAndPremium.IsPremium(player)
	return player.MembershipType == Enum.MembershipType.Premium
end

-- callback(player) runs for current owners, future joiners who own it, and new buyers.
function PassesAndPremium.OnOwned(name, callback)
	assert(passIds[name], "Unknown pass: " .. tostring(name))
	ownedCallbacks[name] = ownedCallbacks[name] or {}
	table.insert(ownedCallbacks[name], callback)
	for _, player in ipairs(Players:GetPlayers()) do
		if PassesAndPremium.Owns(player, name) then
			task.spawn(callback, player)
		end
	end
end

-- callback(player, isPremium) runs on join and whenever membership changes.
function PassesAndPremium.OnPremium(callback)
	table.insert(premiumCallbacks, callback)
	for _, player in ipairs(Players:GetPlayers()) do
		if player:GetAttribute("Premium") ~= nil then
			task.spawn(callback, player, player:GetAttribute("Premium"))
		end
	end
end

function PassesAndPremium.Prompt(player, name)
	local id = passIds[name]
	if not id or PassesAndPremium.Owns(player, name) then
		return false
	end
	return (pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, player, id))
end

-- Re-check passes whose first check failed (for example after a web outage).
function PassesAndPremium.Refresh(player)
	checkPlayer(player)
end

return PassesAndPremium
