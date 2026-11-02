-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function Safe_Index(p1, p2, p3) --[[ Safe_Index | Line: 1 ]]
	if typeof(p1) == "Instance" then
		return p1[if p3 then "WaitForChild" else "FindFirstChild"](p1, p2)
	end

	if typeof(p1) == "table" then
		return p1[p2]
	end
end

return function(p1, p2, p3, p4, p5, p6, p7) --[[ Exe_GS | Line: 9 ]]
	local v1 = typeof(p1)

	if v1 ~= "Instance" and v1 ~= "table" then
		warn("Failled to execute due to: (Base must be a table or Instance)")

		return nil
	end

	local v2 = typeof(p2)

	if v2 == "string" then
		p2 = p2:split("|")
	elseif v2 ~= "table" then
		warn("Failled to execute due to: (Path must be a string or a table)")

		return nil
	end

	local v4 = if typeof(p3) == "number" and p3 then p3 else 1
	local v5 = if typeof(p6) == "function" then true else false
	local v6 = p1

	for i = v4, #p2 do
		local v7
		local v8 = p2[i]

		if v5 then
			p6(v6, p2, i)
		end

		if if i == #p2 then true else false then
			if p4 then
				v6[v8] = p5
			end

			v7 = if typeof(v6) == "Instance" then v6[if p7 then "WaitForChild" else "FindFirstChild"](v6, v8) elseif typeof(v6) == "table" then v6[v8] else nil

			return v7, v8
		end

		if typeof(v6) == "Instance" then
			v6 = v6[if p7 then "WaitForChild" else "FindFirstChild"](v6, v8)
		else
			v6 = if typeof(v6) == "table" then v6[v8] else nil
		end

		if not v6 then
			return warn(("Path not found at step \'%s\', trace: \'%s\'"):format(tostring(v8), debug.traceback()))
		end
	end
end