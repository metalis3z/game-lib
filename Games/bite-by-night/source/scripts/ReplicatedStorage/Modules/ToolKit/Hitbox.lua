-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("Players")
local v1 = {}

local v_u_2 = workspace:WaitForChild("PLAYERS"):WaitForChild("ALIVE")
local v_u_3 = table.find

function v1.QueryAliveInRadius(_, p4, p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v6 = OverlapParams.new()
	v6.FilterDescendantsInstances = { v_u_2 }
	v6.FilterType = Enum.RaycastFilterType.Include
	
	local v7 = workspace:GetPartBoundsInRadius(p4, p5, v6)
	local v8 = {}
	
	for _, v9 in next, v7 do
		local v10 = v9:FindFirstAncestorWhichIsA("Model")
		if v10 and (v_u_2:IsAncestorOf(v10) and not v_u_3(v8, v10)) then
			v8[#v8 + 1] = v10
		end
	end
	
	return v8
end

return v1