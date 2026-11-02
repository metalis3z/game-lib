-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = require(v1:WaitForChild("Modules"):WaitForChild("ClientReplicationObject"))
return function(p4)
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	if p4[1] ~= nil and p4[2][1] ~= nil then
		local v5 = p4[1]
		local v6 = TweenInfo.new
		local v7 = p4[2][1]
		local v8 = v6(tonumber(v7), p4[2][2], p4[2][3])
		local v9 = p4[3]
		local v10 = v_u_3.new()
		v_u_2:Create(v5, v8, v9):Play()
		return v10
	end
end