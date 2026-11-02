-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CodeServiceClient, time of decompilation: Sun May  3 10:12:11 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networker = require(ReplicatedStorage.Packages.Networker)
local CodeServiceUtils = require(script.Parent.CodeServiceUtils)

return {
	init = function(p1) --[[ init ]] -- line: 8
		-- upvalues: Networker (copy)
		p1.networker = Networker.client.new("CodeService", p1)
	end,
	redeem = function(p2, s1: string) --[[ redeem ]] -- line: 12
		-- upvalues: CodeServiceUtils (copy)
		local v7 = p2.networker:fetch("redeem", s1)

		return v7 == CodeServiceUtils.REDEEM_ENUMS.success, CodeServiceUtils.ERROR_CODES[v7] or "Unknown Error!"
	end
}
