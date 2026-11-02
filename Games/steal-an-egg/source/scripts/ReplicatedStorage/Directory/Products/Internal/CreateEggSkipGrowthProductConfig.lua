-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script:FindFirstAncestor("Products").Types.Interface)

local FormatDuration = require(ReplicatedStorage.Library.Functions.FormatDuration)

return {
	Create = function(p1, p2, p3) --[[ Create | Line: 19 | Upvalues: Asserts (copy), ServerScriptService (copy), ReplicatedStorage (copy), FormatDuration (copy) ]]
		Asserts.string(p1)
		Asserts.number(p2)
		Asserts.positiveInteger(p3)

		local function ServerTest(p12, p2) --[[ ServerTest | Line: 28 | Upvalues: Asserts (ref), ServerScriptService (ref), p1 (copy) ]]
			Asserts.Player(p12)

			local Eggs = require(ServerScriptService.Controllers.Eggs)

			if p2 == nil then
				return Eggs.CanPurchaseSkipGrowth(p12, p1)
			end

			return Eggs.CanRedeemSkipGrowth(p12, p1)
		end

		local function ReservePrompt(p12) --[[ ReservePrompt | Line: 38 | Upvalues: Asserts (ref), ServerScriptService (ref), p1 (copy) ]]
			Asserts.Player(p12)

			return require(ServerScriptService.Controllers.Eggs).ReserveSkipGrowthPrompt(p12, p1)
		end

		local function CancelPrompt(p12) --[[ CancelPrompt | Line: 45 | Upvalues: Asserts (ref), ServerScriptService (ref), p1 (copy) ]]
			Asserts.Player(p12)
			require(ServerScriptService.Controllers.Eggs).CancelSkipGrowthPrompt(p12, p1)
		end

		local function ClientTest() --[[ ClientTest | Line: 52 | Upvalues: ReplicatedStorage (ref) ]]
			return require(ReplicatedStorage.Library.Client.EggCmds).CanPurchaseSelectedSkipGrowth()
		end

		local function Callback(p12) --[[ Callback | Line: 57 | Upvalues: Asserts (ref), ServerScriptService (ref), p1 (copy) ]]
			Asserts.Player(p12)

			return require(ServerScriptService.Controllers.Eggs).PurchaseSkipGrowth(p12, p1)
		end

		return {
			LockWhileProcessing = true,
			DisableNotification = true,
			ProductId = p2,
			DisplayName = p1,
			Desc = ("Skip the growth of your egg by %*!"):format((FormatDuration(p3))),
			EggSkipGrowthMaxRemainingSeconds = p3,
			ReservePrompt = ReservePrompt,
			CancelPrompt = CancelPrompt,
			ServerTest = ServerTest,
			ClientTest = ClientTest,
			Callback = Callback
		}
	end
}