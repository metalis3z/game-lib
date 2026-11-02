-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script:FindFirstAncestor("Products").Types.Interface)

local Treadmills = require(ReplicatedStorage.Directory.Treadmills)

return function(p1, p2, p3) --[[ Line: 13 | Upvalues: Asserts (copy), Treadmills (copy), ServerScriptService (copy), ReplicatedStorage (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)
	Asserts.number(p3)

	local v1, v2 = Treadmills.Types.TreadmillNameExists(p2)

	assert(v1, v2 or ("Treadmill \"%*\" does not exist"):format(p2))

	local v4 = Treadmills.Directory[p2]
	local v5 = Treadmills.GetUpgradeLevel(p2)

	assert(if v5 == nil then false else true, (("Treadmill \"%*\" has no upgrade level"):format(p2)))

	local function canBuyNextUpgrade(p1) --[[ canBuyNextUpgrade | Line: 25 | Upvalues: v5 (copy) ]]
		if p1 + 1 == v5 then
			return true
		end

		return false, "This is not your next treadmill upgrade"
	end

	local function ServerTest(p1) --[[ ServerTest | Line: 32 | Upvalues: Asserts (ref), ServerScriptService (ref), canBuyNextUpgrade (copy) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

		if v1 and v2 then
			return canBuyNextUpgrade(v2.TreadmillUpgradeLevel)
		end

		return false, "Player profile not found"
	end

	local function ClientTest() --[[ ClientTest | Line: 44 | Upvalues: ReplicatedStorage (ref), canBuyNextUpgrade (copy) ]]
		local v1 = require(ReplicatedStorage.Library.Client.Save).Get()

		if v1 then
			return canBuyNextUpgrade(v1.TreadmillUpgradeLevel)
		end

		return false, "Data not loaded"
	end

	local function Callback(p1) --[[ Callback | Line: 54 | Upvalues: Asserts (ref), ServerScriptService (ref), p2 (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.TreadmillService).UpgradeTreadmill(p1, p2, false)
	end

	return {
		SinglePurchase = true,
		LockWhileProcessing = true,
		ProductId = p3,
		DisplayName = v4.DisplayName,
		Icon = v4.Icon,
		Desc = ("Upgrade to the %* treadmill."):format(v4.DisplayName),
		ServerTest = ServerTest,
		ClientTest = ClientTest,
		Callback = Callback
	}
end