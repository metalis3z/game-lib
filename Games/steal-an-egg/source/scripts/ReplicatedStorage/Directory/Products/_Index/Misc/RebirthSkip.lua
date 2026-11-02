-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script:FindFirstAncestor("Products").Types.Interface)

return {
	ProductId = 3597897050,
	DisplayName = "Rebirth Skip",
	Desc = "Rebirth instantly without resetting your speed.",
	LockWhileProcessing = true,
	DisableNotification = true,
	ServerTest = function(p1) --[[ ServerTest | Line: 15 | Upvalues: Asserts (copy), ServerScriptService (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.RebirthService).CanPurchaseSkipRebirth(p1)
	end,
	ClientTest = function() --[[ ClientTest | Line: 22 | Upvalues: ReplicatedStorage (copy) ]]
		local Save = require(ReplicatedStorage.Library.Client.Save)
		local RebirthUtil = require(ReplicatedStorage.Library.Util.RebirthUtil)
		local v1 = Save.Get()

		if not v1 then
			return false, "Data not loaded"
		end

		if (v1.Rebirth or 0) >= RebirthUtil.GetMaxRebirth() then
			return false, "Max rebirth reached"
		end

		return true
	end,
	Callback = function(p1) --[[ Callback | Line: 37 | Upvalues: Asserts (copy), ServerScriptService (copy) ]]
		Asserts.Player(p1)

		return require(ServerScriptService.Controllers.RebirthService).PurchaseSkipRebirth(p1)
	end
}