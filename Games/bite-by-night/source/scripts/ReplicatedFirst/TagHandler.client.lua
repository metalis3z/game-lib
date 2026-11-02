-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("CollectionService")
game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = {}
local v_u_4 = {}
for _, v5 in script:GetDescendants() do
	if v5:IsA("ModuleScript") then
		v_u_3[v5.Name] = require(v5)
	end
end
local function v_u_7(p6, ...)
	if p6 then
		p6(...)
	end
end
for v_u_8, v_u_9 in v_u_3 do
	for _, v10 in v1:GetTagged(v_u_8) do
		v_u_7(v_u_9.OnInit, v10)
		if v_u_9.OnFrame then
			table.insert(v_u_4, { v_u_8, v10 })
		end
	end
	v1:GetInstanceAddedSignal(v_u_8):Connect(function(p11)
		-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_7, (copy) v_u_4
		local v12 = v_u_9
		local v13 = v_u_8
		v_u_7(v12.OnInit, p11)
		if v12.OnFrame then
			local v14 = v_u_4
			table.insert(v14, { v13, p11 })
		end
	end)
end
v2.RenderStepped:Connect(function(p15)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	for _, v16 in v_u_4 do
		v_u_3[v16[1]].OnFrame(v16[2], p15)
	end
end)