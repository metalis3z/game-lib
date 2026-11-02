-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
require(v2:WaitForChild("Modules"):WaitForChild("Types"))
local v_u_3 = require(v2:WaitForChild("Modules"):WaitForChild("Maid"))
local v_u_4 = require(v2:WaitForChild("Modules"):WaitForChild("Signal"))
v_u_1.__index = v_u_1
v_u_1.__ClassName = "ClientReplicationObject"
function v_u_1.new()
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_4
	local v5 = v_u_1
	local v6 = setmetatable({}, v5)
	v6.Maid = v_u_3.new()
	v6.DelayedMaid = v_u_3.new()
	v6.DelayMaidTime = 5
	v6.OnUpdate = v_u_4.new()
	return v6
end
function v_u_1.Destroy(p_u_7)
	p_u_7.Maid:Sweep()
	p_u_7.Maid:Destroy()
	task.delay(p_u_7.DelayMaidTime, function()
		-- upvalues: (ref) p_u_7
		p_u_7.DelayedMaid:Sweep()
		p_u_7.DelayedMaid:Destroy()
		local v8 = p_u_7
		setmetatable(v8, nil)
		p_u_7 = nil
	end)
end
return v_u_1