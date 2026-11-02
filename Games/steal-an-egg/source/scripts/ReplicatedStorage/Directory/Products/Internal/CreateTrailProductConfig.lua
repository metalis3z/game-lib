-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)
require(script:FindFirstAncestor("Products").Types.Interface)

local Trails = require(ReplicatedStorage.Directory.Trails)

return function(p1, p2, p3) --[[ Line: 14 | Upvalues: Asserts (copy), Trails (copy), ServerScriptService (copy), ReplicatedStorage (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)
	Asserts.number(p3)

	local v1, v2 = Trails.Types.TrailNameExists(p2)

	assert(v1, if v2 then v2 else ("Trail \"%*\" does not exist"):format(p2))

	local v4 = Trails.Directory[p2]

	local function validateData(p1) --[[ validateData | Line: 24 | Upvalues: p2 (copy) ]]
		if not p1 then
			return false, "Player data not found"
		end

		if p1.TrailInventory[p2] then
			return false, "You already own this trail"
		end

		return true
	end

	local function ServerTest(p1) --[[ ServerTest | Line: 35 | Upvalues: Asserts (ref), ServerScriptService (ref), validateData (copy) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

		if v1 and v2 then
			return validateData(v2)
		end

		return false, "Player profile not found"
	end

	local function ClientTest() --[[ ClientTest | Line: 47 | Upvalues: ReplicatedStorage (ref), validateData (copy) ]]
		local v1 = require(ReplicatedStorage.Library.Client.Save).Get()

		if v1 then
			return validateData(v1)
		end

		return false, "Data not loaded"
	end

	local function Callback(p1) --[[ Callback | Line: 57 | Upvalues: Asserts (ref), ServerScriptService (ref), p2 (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.TrailShop).GrantOwnedTrail(p1, p2, true)
	end

	return {
		SinglePurchase = true,
		LockWhileProcessing = true,
		ProductId = p3,
		DisplayName = v4.DisplayName,
		Icon = v4.Icon,
		Desc = ("Unlock the %* trail."):format(v4.DisplayName),
		ServerTest = ServerTest,
		ClientTest = ClientTest,
		Callback = Callback
	}
end