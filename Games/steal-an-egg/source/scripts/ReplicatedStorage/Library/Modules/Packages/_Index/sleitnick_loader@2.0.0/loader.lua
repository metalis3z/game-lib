-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	LoadChildren = function(p1, p2) --[[ LoadChildren | Line: 44 ]]
		local t = {}

		for v1, v2 in p1:GetChildren() do
			if v2:IsA("ModuleScript") and (not p2 or p2(v2)) then
				t[v2.Name] = require(v2)
			end
		end

		return t
	end,
	LoadDescendants = function(p1, p2) --[[ LoadDescendants | Line: 74 ]]
		local t = {}

		for v1, v2 in p1:GetDescendants() do
			if v2:IsA("ModuleScript") and (not p2 or p2(v2)) then
				t[v2.Name] = require(v2)
			end
		end

		return t
	end,
	MatchesName = function(p1) --[[ MatchesName | Line: 97 ]]
		return function(p12) --[[ Line: 98 | Upvalues: p1 (copy) ]]
			return p12.Name:match(p1) ~= nil
		end
	end,
	SpawnAll = function(p1, p2) --[[ SpawnAll | Line: 125 ]]
		for v1, v2 in p1 do
			local v3 = v2[p2]

			if type(v3) == "function" then
				task.spawn(function() --[[ Line: 129 | Upvalues: v1 (copy), v3 (copy), v2 (copy) ]]
					debug.setmemorycategory(v1)
					v3(v2)
				end)
			end
		end
	end
}