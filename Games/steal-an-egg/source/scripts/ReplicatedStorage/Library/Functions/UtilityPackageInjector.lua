-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t

local CollectionService = game:GetService("CollectionService")
local t2 = {
	GuidedSearch = "GS",
	LinearSearch = "LS"
}

function t.new(p1, p2) --[[ new | Line: 22 | Upvalues: CollectionService (copy), t2 (copy) ]]
	local v1 = if typeof(p1) == "table" and p1 then p1 else {}
	local v2, v3

	if typeof(p2) == "table" and p2 then
		v2 = p2
		v3 = v1
	else
		v2 = {}
		v3 = v1
	end

	local v4 = v2

	for v5, v6 in CollectionService:GetTagged("(Library):(Functions):[UtilityPackageInjector]:Query") do
		if v6:IsA("ModuleScript") and not table.find(v4, v6.Name) then
			local v7 = t2[v6.Name]

			v3[if v7 then v7 else v6.Name] = require(v6)
		end
	end

	return v3
end

return t