-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local values = require(script.Parent.Parent.replicated.values)

require(script.Parent.Parent.types)

local namespacesDependencies = require(script.Parent.namespacesDependencies)
local packetIDs = require(script.Parent.packetIDs)
local v1 = if RunService:IsServer() then "server" else "client"
local v2 = 0

return function(p1, p2) --[[ Line: 19 | Upvalues: values (copy), namespacesDependencies (copy), v1 (copy), v2 (ref), packetIDs (copy) ]]
	local v12 = values.access(p1)

	namespacesDependencies.start(p1)

	local v22 = p2()
	local v3 = namespacesDependencies.empty()
	local t = {}

	if v1 == "server" then
		local t2 = {
			structs = {},
			packets = {}
		}

		for v4 in v22 do
			v2 = v2 + 1
			t2.packets[v4] = v2
			t[v4] = v22[v4](v2)
			packetIDs.set(v2, t[v4])
		end

		for v5, v6 in v3 do
			t2.structs[v5] = v6
		end

		v12:write(t2)
	elseif v1 == "client" then
		local v7 = v12:read()

		for v8, v9 in v22 do
			t[v8] = v9(v7.packets[v8])
			packetIDs.set(v7.packets[v8], t[v8])
		end
	end

	return t
end