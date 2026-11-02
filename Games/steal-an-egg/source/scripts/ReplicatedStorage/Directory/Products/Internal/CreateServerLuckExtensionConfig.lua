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

	return {
		LockWhileProcessing = true,
		DisableNotification = true,
		ProductId = p2,
		DisplayName = p1,
		ServerTest = function(p1) --[[ ServerTest | Line: 14 | Upvalues: ServerScriptService (ref) ]]
			return require(ServerScriptService.Controllers.ServerLuck).GetState().Multiplier > 1
		end,
		Callback = function(p1) --[[ Callback | Line: 20 | Upvalues: ServerScriptService (ref), p3 (copy) ]]
			return require(ServerScriptService.Controllers.ServerLuck).AddTime(p3 * 60, p1)
		end
	}
end