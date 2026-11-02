-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script:FindFirstAncestor("Products").Types.Interface)

return {
	ProductId = 3611613592,
	DisplayName = "Grow All Eggs",
	Desc = "Finish growing all placed eggs.",
	LockWhileProcessing = true,
	DisableNotification = true,
	ServerTest = function(p1) --[[ ServerTest | Line: 18 | Upvalues: Asserts (copy), ServerScriptService (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.Eggs).CanPurchaseGrowAll(p1)
	end,
	ClientTest = function() --[[ ClientTest | Line: 25 | Upvalues: ReplicatedStorage (copy) ]]
		return require(ReplicatedStorage.Library.Client.EggCmds).CanPurchaseGrowAll()
	end,
	Callback = function(p1) --[[ Callback | Line: 30 | Upvalues: Asserts (copy), ServerScriptService (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.Eggs).PurchaseGrowAll(p1)
	end
}