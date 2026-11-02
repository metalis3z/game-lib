-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Bases = require(ReplicatedStorage.Directory.Bases)

require(script:FindFirstAncestor("Products").Types.Interface)

return function(p1, p2, p3) --[[ Line: 13 | Upvalues: Asserts (copy), Bases (copy), ServerScriptService (copy), ReplicatedStorage (copy) ]]
	Asserts.string(p1)
	Asserts.integerNonNegative(p2)
	Asserts.number(p3)
	assert(p2 > 0, "Base upgrade product target level must be positive")
	assert(if p3 > 0 then true else false, "Base upgrade product id must be positive")

	local v3 = Bases.BASES[p2]

	assert(if v3 == nil then false else true, (("Base upgrade level %* does not exist"):format(p2)))

	local function canBuyNextUpgrade(p1) --[[ canBuyNextUpgrade | Line: 23 | Upvalues: p2 (copy) ]]
		if p1 + 1 == p2 then
			return true
		end

		return false, "This is not your next base upgrade"
	end

	local function ServerTest(p1) --[[ ServerTest | Line: 30 | Upvalues: Asserts (ref), ServerScriptService (ref), canBuyNextUpgrade (copy) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

		if v1 and v2 ~= nil then
			return canBuyNextUpgrade(v2.BaseUpgradeLevel)
		end

		return false, "Player profile not found"
	end

	local function ClientTest() --[[ ClientTest | Line: 41 | Upvalues: ReplicatedStorage (ref), canBuyNextUpgrade (copy) ]]
		local v1 = require(ReplicatedStorage.Library.Client.Save).Get()

		if v1 == nil then
			return false, "Data not loaded"
		end

		return canBuyNextUpgrade(v1.BaseUpgradeLevel)
	end

	local function Callback(p1) --[[ Callback | Line: 50 | Upvalues: Asserts (ref), ServerScriptService (ref), p2 (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.PlotService).UpgradeBase(p1, p2, false)
	end

	return {
		SinglePurchase = true,
		LockWhileProcessing = true,
		ProductId = p3,
		DisplayName = ("Base Upgrade Tier %*"):format(p2),
		Desc = ("Upgrade your base to tier %* and equip %* pets."):format(p2, v3.MaxAssets),
		ServerTest = ServerTest,
		ClientTest = ClientTest,
		Callback = Callback
	}
end