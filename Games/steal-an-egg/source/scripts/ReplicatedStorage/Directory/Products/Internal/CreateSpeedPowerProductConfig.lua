-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)

require(script:FindFirstAncestor("Products").Types.Interface)

return function(p1, p2) --[[ Line: 17 | Upvalues: Asserts (copy), ServerScriptService (copy), ReplicatedStorage (copy), Simple (copy) ]]
	Asserts.string(p1)
	Asserts.number(p2)

	local v2 = tonumber((p1:gsub("SpeedPower_", ""):gsub("%D", "")))

	assert(v2 ~= nil, "Speed power product name must include a numeric reward amount")
	assert(if v2 > 0 then true else false, "Speed power reward must be positive")

	local function ensureDataLoaded(p1) --[[ ensureDataLoaded | Line: 26 ]]
		if p1 then
			return true
		end

		return false, "Player data is not loaded yet."
	end

	local function ServerTest(p1) --[[ ServerTest | Line: 34 | Upvalues: ServerScriptService (ref), ensureDataLoaded (copy) ]]
		local v1, v2 = require(ServerScriptService.Library.Database).UnsafeGetProfileAwait(p1)

		if v1 then
			return ensureDataLoaded(v2)
		end

		return false, "Failed to retrieve player data."
	end

	local function ClientTest() --[[ ClientTest | Line: 44 | Upvalues: ReplicatedStorage (ref), ensureDataLoaded (copy) ]]
		return ensureDataLoaded((require(ReplicatedStorage.Library.Client.Save).Get()))
	end

	local function Callback(p1) --[[ Callback | Line: 51 | Upvalues: Asserts (ref), ServerScriptService (ref), v2 (copy), ReplicatedStorage (ref) ]]
		Asserts.Player(p1)

		local v1, v22 = require(ServerScriptService.Controllers.SpeedPowerService).AddSpeedPower(p1, v2, "Instant")

		if v1 then
			task.spawn(function() --[[ Line: 59 | Upvalues: ServerScriptService (ref), ReplicatedStorage (ref), p1 (copy), v22 (copy) ]]
				require(ServerScriptService.Library.Functions.NotifyItem)(p1, require(ReplicatedStorage.Library.Items.SpeedPowerItem)():SetAmount(v22))
			end)

			return true, v22
		end

		return false, 0
	end

	return {
		Desc = "Purchase bonus speed!",
		LockWhileProcessing = true,
		ProductId = p2,
		DisplayName = ("+%* Speed"):format((Simple.FormatCompact(v2, ".#"))),
		SpeedPowerReward = v2,
		ServerTest = ServerTest,
		ClientTest = ClientTest,
		Callback = Callback
	}
end