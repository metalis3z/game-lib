-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

return function(p1, p2, p3) --[[ Line: 3 | Upvalues: RunService (copy) ]]
	local v1 = p1:FindFirstChild(p2, true)

	if v1 then
		return v1
	end

	local v2 = p3 or (1 / 0)
	local sum = 0
	local v3 = false
	local v4

	repeat
		v4 = p1:FindFirstChild(p2, true)

		if v2 <= sum then
			break
		end

		if sum >= 5 and not v3 then
			warn((("Infinite yield possible on \'game.%s:WaitForDescendant(\"%s\")\' %s"):format(p1:GetFullName(), p2, debug.traceback())))
			v3 = true
		end

		sum = sum + RunService.PreSimulation:Wait()
	until v4

	return v4
end