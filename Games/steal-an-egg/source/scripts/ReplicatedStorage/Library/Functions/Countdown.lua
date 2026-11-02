-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

return function(p1, p2, p3) --[[ Line: 2 | Upvalues: RunService (copy) ]]
	local v1 = 0
	local v2 = nil

	v2 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 6 | Upvalues: v1 (ref), p1 (ref), p3 (copy), v2 (ref), p2 (copy) ]]
		v1 = v1 + p12

		if not (v1 > 1) then
			return
		end

		v1 = v1 - 1
		p1 = p1 - 1

		if p1 <= 0 then
			if p3 then
				p3()
			end

			v2:Disconnect()
		else
			if not p2 then
				return
			end

			p2(p1)
		end
	end)

	return function() --[[ Line: 24 | Upvalues: p1 (ref) ]]
		return p1
	end, function() --[[ Line: 26 | Upvalues: v2 (ref) ]]
		v2:Disconnect()
	end
end