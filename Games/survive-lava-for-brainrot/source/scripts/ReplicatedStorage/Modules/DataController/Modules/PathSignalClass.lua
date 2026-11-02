-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("ReplicatedStorage")
game:GetService("HttpService")
local v1 = script.Parent
local v_u_2 = require(v1:WaitForChild("Signal"))
local v_u_3 = {}
v_u_3.__index = v_u_3
function v_u_3.new(p4)
	-- upvalues: (copy) v_u_3
	local v5 = v_u_3
	return setmetatable({
		["Table"] = p4,
		["PathRegistry"] = {}
	}, v5)
end
function v_u_3.Destroy(p6)
	for _, v7 in p6.PathRegistry do
		v7:Destroy()
	end
end
function v_u_3.GetTable(p8)
	return p8.Table
end
function v_u_3.FindPathSignal(p9, p10)
	local v11 = p9.PathRegistry
	if v11[p10] then
		return v11[p10]
	end
end
function v_u_3.FreePathSignal(p12, p13)
	p12.PathRegistry[p13] = nil
end
function v_u_3.GetPathSignal(p14, p15)
	-- upvalues: (copy) v_u_2
	local v16 = p14:FindPathSignal(p15)
	if v16 then
		return v16
	end
	local v17 = p14.PathRegistry
	local v18 = v_u_2.new()
	v17[("%*"):format(p15)] = v18
	return v18
end
return v_u_3
