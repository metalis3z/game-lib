-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script:FindFirstAncestor("Products").Types.Interface)

return function(p1, p2) --[[ Line: 16 | Upvalues: Asserts (copy), ServerScriptService (copy), ReplicatedStorage (copy) ]]
	Asserts.string(p1)
	Asserts.number(p2)

	local v2 = tonumber((p1:gsub("Money_", ""):gsub("%D", "")))

	assert(v2 ~= nil, "Money product name must include a numeric reward amount")
	assert(if v2 > 0 then true else false, "Money reward must be positive")

	local function ensureDataLoaded(p1) --[[ ensureDataLoaded | Line: 25 ]]
		if p1 then
			return true
		end

		return false, "Player data is not loaded yet."
	end

	return {
		Desc = "Purchase bonus money!",
		LockWhileProcessing = true,
		ProductId = p2,
		DisplayName = p1,
		ServerTest = function(p1) --[[ ServerTest | Line: 33 | Upvalues: ServerScriptService (ref), ensureDataLoaded (copy) ]]
			local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

			if v1 then
				return ensureDataLoaded(v2)
			end

			return false, "Failed to retrieve player data."
		end,
		ClientTest = function() --[[ ClientTest | Line: 43 | Upvalues: ReplicatedStorage (ref), ensureDataLoaded (copy) ]]
			return ensureDataLoaded((require(ReplicatedStorage.Library.Client.Save).Get()))
		end,
		Callback = function(p1) --[[ Callback | Line: 50 | Upvalues: ServerScriptService (ref), v2 (copy) ]]
			require(ServerScriptService.Controllers.MoneyService).AddMoney(p1, v2)

			return true
		end
	}
end