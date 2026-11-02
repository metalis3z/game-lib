-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(script:FindFirstAncestor("Products").Types.Interface)

return function(p1, p2, p3) --[[ Line: 9 | Upvalues: Asserts (copy), ServerScriptService (copy) ]]
	Asserts.string(p1)
	Asserts.number(p2)
	Asserts.number(p3)

	local function ServerTest(p1) --[[ ServerTest | Line: 14 | Upvalues: ServerScriptService (ref), p3 (copy) ]]
		if p3 <= require(ServerScriptService.Controllers.ServerLuck).GetState().Multiplier then
			return false, "Server already has equal or better luck"
		end

		return true
	end

	return {
		LockWhileProcessing = true,
		DisableNotification = true,
		ProductId = p2,
		DisplayName = p1,
		Callback = function(p1) --[[ Callback | Line: 24 | Upvalues: ServerScriptService (ref), p3 (copy) ]]
			require(ServerScriptService.Controllers.ServerLuck).HandlePurchase(p3, p1)

			return true
		end,
		ServerTest = ServerTest
	}
end