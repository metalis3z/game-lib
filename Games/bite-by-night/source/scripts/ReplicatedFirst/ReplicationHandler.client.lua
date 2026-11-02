-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")
require(v1:WaitForChild("Modules"):WaitForChild("Types"))
local v2 = require(v1:WaitForChild("Modules"):WaitForChild("Warp")).Client("ReplicateEvent")
local v_u_3 = {}
local v_u_4 = {}
local v_u_5 = {}
for _, v_u_6 in v1:WaitForChild("ReplicationModules"):GetDescendants() do
	if v_u_6:IsA("ModuleScript") and v_u_6.Name ~= "TEMPLATE" then
		local v7, v8 = xpcall(require, function(_)
			-- upvalues: (copy) v_u_6
			return warn((("failed to require replication module %*/%*"):format(v_u_6.Parent.Name, v_u_6.Name)))
		end, v_u_6)
		v_u_3[v_u_6.Name] = v7 and v8 and v8 or nil
	end
end
function v_u_5.ACTIVATE(p9, p10, p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_4
	local v12 = v_u_3[p10]
	warn(v_u_3)
	if v12 then
		v_u_4[p9] = v12(p11)
	end
end
function v_u_5.DESTROY(p13)
	-- upvalues: (copy) v_u_4
	local v14 = v_u_4[p13]
	if v14 then
		v14:Destroy()
		v_u_4[p13] = nil
	end
end
function v_u_5.UPDATE(p15, p16)
	-- upvalues: (copy) v_u_4
	local v17 = v_u_4[p15]
	if v17 then
		v17.OnUpdate:Fire(p16)
	end
end
v2:Connect(function(p18, ...)
	warn(p18, ...)
	
	-- upvalues: (copy) v_u_5
	v_u_5[p18](...)
end)