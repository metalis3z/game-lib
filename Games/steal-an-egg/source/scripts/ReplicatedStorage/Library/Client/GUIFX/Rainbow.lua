-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local RainbowStep = require(script.Parent.RainbowStep)

function RainbowEffect(p1, p2, p3, p4) --[[ RainbowEffect | Line: 13 | Upvalues: RainbowStep (copy), RunService (copy) ]]
	local v1 = RainbowStep(p3, p4)
	local v2 = nil

	v2 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 17 | Upvalues: p1 (copy), p2 (copy), v1 (copy), v2 (ref) ]]
		if p1.Parent then
			p1[p2] = v1(p12)
		else
			v2:Disconnect()
		end
	end)

	return function() --[[ Line: 25 | Upvalues: v2 (ref) ]]
		v2:Disconnect()
	end
end

return RainbowEffect