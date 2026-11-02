-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Types.Eggs)

local LimitedEgg = require(ReplicatedStorage.Directory.LimitedEgg)
local LotteryCustom = require(ReplicatedStorage.Library.Functions.LotteryCustom)

require(script.Parent.Parent.Types.Interface)

local GenerateUID = require(ReplicatedStorage.Library.Functions.GenerateUID)

local function buildReceiptGrants(p1) --[[ buildReceiptGrants | Line: 19 | Upvalues: ReplicatedStorage (copy), LotteryCustom (copy), LimitedEgg (copy), Asserts (copy), GenerateUID (copy) ]]
	local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
	local t = {}

	for i = 1, p1 do
		local v1 = LotteryCustom(nil, LimitedEgg.DropTable)

		Asserts.string(v1)
		table.insert(t, {
			Uid = GenerateUID(),
			Record = EggItemUtil.BuildSavedEgg(v1)
		})
	end

	return t
end

return function(p1, p2) --[[ Line: 36 | Upvalues: Asserts (copy), ServerScriptService (copy), ReplicatedStorage (copy), buildReceiptGrants (copy) ]]
	Asserts.number(p1)
	Asserts.positiveInteger(p2)
	assert(p1 > 0, "Limited egg product id must be positive")

	local function ServerTest(p1) --[[ ServerTest | Line: 41 | Upvalues: Asserts (ref), ServerScriptService (ref) ]]
		Asserts.Player(p1)

		if require(ServerScriptService.Library.Database).IsPlayerLoaded(p1) then
			return true
		end

		return false, "Data not loaded"
	end

	local function ClientTest() --[[ ClientTest | Line: 52 | Upvalues: ReplicatedStorage (ref) ]]
		if require(ReplicatedStorage.Library.Client.Save).Get() == nil then
			return false, "Data not loaded"
		end

		return true
	end

	local function Callback(p1) --[[ Callback | Line: 61 | Upvalues: Asserts (ref), ServerScriptService (ref), buildReceiptGrants (ref), p2 (copy) ]]
		Asserts.Player(p1)

		local Eggs = require(ServerScriptService.Controllers.Eggs)

		return Eggs.GrantPaidEggBatch(p1, (buildReceiptGrants(p2)))
	end

	local t = {
		Icon = "",
		LockWhileProcessing = true,
		DisableNotification = true,
		ProductId = p1,
		DisplayName = ("Limited Egg x%*"):format(p2)
	}

	t.Desc = if p2 == 1 then "A limited pet egg." else ("%* limited pet eggs."):format(p2)
	t.ServerTest = ServerTest
	t.ClientTest = ClientTest
	t.Callback = Callback

	return t
end