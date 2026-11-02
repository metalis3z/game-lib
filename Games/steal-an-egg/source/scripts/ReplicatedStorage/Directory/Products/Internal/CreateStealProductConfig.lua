-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script:FindFirstAncestor("Products").Types.Interface)

local Rarity = require(ReplicatedStorage.Directory.Rarity)

return function(p1, p2, p3) --[[ Line: 17 | Upvalues: Asserts (copy), Rarity (copy), ServerScriptService (copy) ]]
	Asserts.string(p1)
	Asserts.string(p2)
	Asserts.number(p3)

	local v1, v2 = Rarity.Types.RarityNameExists(p2)

	assert(v1, if v2 then v2 else ("Rarity \"%*\" does not exist"):format(p2))

	local DisplayName = Rarity.Rarities[p2].DisplayName

	local function ClientTest() --[[ ClientTest | Line: 28 | Upvalues: p3 (copy) ]]
		if p3 <= 0 then
			return false, "This DNA steal product is not configured yet."
		end

		return true
	end

	local function ServerTest(p1, p2) --[[ ServerTest | Line: 36 | Upvalues: Asserts (ref), p3 (copy), ServerScriptService (ref) ]]
		Asserts.Player(p1)

		if p3 <= 0 then
			return false, "This DNA steal product is not configured yet."
		end

		local AssetDnaStealService = require(ServerScriptService.Controllers.AssetDnaStealService)
		local v1, v2

		if p2 == nil then
			local v3, v4 = AssetDnaStealService.CanPromptProduct(p1, p3)

			v1 = v3
			v2 = v4
		else
			local v5, v6 = AssetDnaStealService.CanRedeemProduct(p1, p3)

			v1 = v5
			v2 = v6
		end

		if v1 then
			return true
		end

		return false, v2 or "Choose a valid pet to steal DNA from first."
	end

	local function ReservePrompt(p1) --[[ ReservePrompt | Line: 58 | Upvalues: Asserts (ref), ServerScriptService (ref), p3 (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.AssetDnaStealService).ReservePrompt(p1, p3)
	end

	local function CancelPrompt(p1) --[[ CancelPrompt | Line: 65 | Upvalues: Asserts (ref), ServerScriptService (ref), p3 (copy) ]]
		Asserts.Player(p1)
		require(ServerScriptService.Controllers.AssetDnaStealService).CancelPrompt(p1, p3)
	end

	local function Callback(p1) --[[ Callback | Line: 72 | Upvalues: Asserts (ref), ServerScriptService (ref), p3 (copy) ]]
		Asserts.Player(p1)

		local v1, v2 = require(ServerScriptService.Controllers.AssetDnaStealService).RedeemProduct(p1, p3)

		if v1 then
			return true
		end

		return false, v2 or "Failed to pet asset DNA"
	end

	return {
		LockWhileProcessing = true,
		ProductId = p3,
		DisplayName = ("Steal DNA %*"):format(DisplayName),
		Desc = ("Create an exact egg from another player\'s %* asset DNA."):format(DisplayName),
		ReservePrompt = ReservePrompt,
		CancelPrompt = CancelPrompt,
		ClientTest = ClientTest,
		ServerTest = ServerTest,
		Callback = Callback,
		StealRarity = p2
	}
end