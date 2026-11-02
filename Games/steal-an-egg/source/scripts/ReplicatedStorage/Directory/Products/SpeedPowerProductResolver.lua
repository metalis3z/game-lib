-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(script.Parent)

require(script.Parent.Types.Interface)

return {
	SmallestSufficient = function(p1) --[[ SmallestSufficient | Line: 18 | Upvalues: Asserts (copy), v1 (copy) ]]
		Asserts.number(p1)
		Asserts.cond(p1 > 0)

		local v2 = nil
		local v3 = nil

		for v4, v5 in v1.Directory do
			local SpeedPowerReward = v5.SpeedPowerReward

			if SpeedPowerReward ~= nil then
				if v2 == nil or v2.SpeedPowerReward < SpeedPowerReward then
					v2 = v5
				end

				if p1 <= SpeedPowerReward and (v3 == nil or SpeedPowerReward < v3.SpeedPowerReward) then
					v3 = v5
				end
			end
		end

		return if v3 then v3 else assert(v2, "Products directory must contain at least one speed-power product")
	end
}