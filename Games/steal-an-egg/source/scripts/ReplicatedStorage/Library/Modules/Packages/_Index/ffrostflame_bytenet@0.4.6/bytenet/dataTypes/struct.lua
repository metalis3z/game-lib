-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local namespacesDependencies = require(script.Parent.Parent.namespaces.namespacesDependencies)
local values = require(script.Parent.Parent.replicated.values)

require(script.Parent.Parent.types)

local v1 = if RunService:IsServer() then "server" else "client"

return function(p1) --[[ Line: 13 | Upvalues: v1 (copy), namespacesDependencies (copy), values (copy) ]]
	local t = {}
	local t2 = {}

	if v1 == "server" then
		local count = 0
		local t3 = {}

		for v12 in p1 do
			count = count + 1
			t3[v12] = count
			t[count] = p1[v12]
			t2[count] = v12
		end

		namespacesDependencies.add(t3)
	elseif v1 == "client" then
		namespacesDependencies.add(p1)
		values.access((namespacesDependencies.currentName())):read()

		for v3, v4 in structData do
			t[v4] = p1[v3]
			t2[v4] = v3
		end
	end

	return {
		read = function(p12, p2) --[[ read | Line: 74 | Upvalues: p1 (copy), t (copy), t2 (copy) ]]
			local v1 = table.clone(p1)
			local sum = p2

			for v2, v3 in t do
				local v4, v5 = v3.read(p12, sum)

				v1[t2[v2]] = v4
				sum = sum + v5
			end

			return v1, sum - p2
		end,
		write = function(p1) --[[ write | Line: 89 | Upvalues: t (copy), t2 (copy) ]]
			for v1, v2 in t do
				v2.write(p1[t2[v1]])
			end
		end
	}
end