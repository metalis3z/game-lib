-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("RunService")
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("StarterPlayer")
local v3 = require(v2.StarterPlayerScripts.Controllers.ScopeController)
require(v1.Registries.PermissionRegistries.PermissionNodesEnumsType)
require(v1.Registries.PermissionRegistries.PermissionGroupEnumsType)
local v4 = require(v1.Registries.PermissionRegistries.PermissionGroups)
local v5 = require(v1.Registries.PermissionRegistries.PermissionMap)
local v_u_6 = {}
local v7 = v3:GetScope()
local v8 = v5[v7]
local v_u_9 = v8.Roles
local v_u_10 = v8.Users
local v_u_11 = v4[v7]
local v_u_12 = {
	[327423121] = nil
}
function v_u_6.GetPermissionGroup(_, p_u_13)
	-- upvalues: (copy) v_u_12, (copy) v_u_10, (copy) v_u_9, (copy) v_u_11
	local v14 = v_u_12[p_u_13.UserId]
	if v14 ~= nil then
		return v14
	end
	local v15 = {}
	local v16, v17 = pcall(function()
		-- upvalues: (copy) p_u_13
		return p_u_13:GetRankInGroup(876852426)
	end)
	local v18 = not v16 and 1 or v17
	local v19 = v_u_10
	local v20 = p_u_13.UserId
	local v21 = v19[tostring(v20)] or v_u_10[p_u_13.UserId]
	local v22 = v_u_9[tostring(v18)] or v_u_9[v18]
	if v22 then
		table.insert(v15, v22)
	end
	if v21 then
		table.insert(v15, v21)
	end
	table.sort(v15, function(p23, p24)
		-- upvalues: (ref) v_u_11
		local v25 = v_u_11[p23]
		local v26 = v_u_11[p24]
		return v25.Priority > v26.Priority
	end)
	return v15[1]
end
function v_u_6.HasPermissionNode(_, p27, p28)
	-- upvalues: (copy) v_u_6, (copy) v_u_11
	local v29 = v_u_6:GetPermissionGroup(p27)
	if v29 then
		local v30 = v_u_11[v29]
		if v30 then
			return table.find(v30.PermissionNodes, p28) ~= nil
		else
			return false
		end
	else
		return false
	end
end
return v_u_6
