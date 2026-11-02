-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = { "__index", "__newindex" }
local t2 = {
	__proxy = {
		new = function(p1) --[[ new | Line: 7 | Upvalues: t (copy) ]]
			if typeof(p1) ~= "table" then
				return
			end

			local v1 = newproxy(true)

			for v2, v3 in t do
				getmetatable(v1)[v3] = p1
			end

			return v1
		end
	}
}

t2.__index = t2

local function v1(p1, p2) --[[ Is_Structure_Valid | Line: 24 | Upvalues: v1 (copy) ]]
	if typeof(p1) == "table" and typeof(p2) == "table" then
		local v12 = table.find({ "string", "table" }, (typeof(p1.__generic))) and p1.__generic

		for v7, v8 in if v12 and p2 then p2 else p1 do
			local v3, v4, v5, v6
			local v9 = v12 or v8

			v3 = if v12 and v8 then v8 else p2[v7]

			local v10 = if typeof(v9) == "string" then { v9:gsub(";", "") } else false
			local v11 = if v10 then v9:split(";")[1]:split("|") else v10
			local v122 = if v10 then if v10[2] > 0 and #v9:split(";")[2] > 0 then v9:split(";")[2]:split("|") else false else v10

			v4 = if v12 or not v8 then if typeof(v12) == "table" and v12 then v12 else p1[v7] else v8

			if typeof(v4) == "table" then
				if v12 then
					v5 = {}
					v6 = if typeof(v12) == "table" and v12 then v12 else p1[v7]
					v5[1] = v6
					v5[2] = v8

					if not v5 then
						v5 = { v8, p2[v7] }
					end
				else
					v5 = { v8, p2[v7] }
				end

				if not v1(unpack(v5)) then
					return
				end

				continue
			end

			if not table.find(v11, (typeof(v3))) then
				return
			end

			if #v11 >= 2 and (v10[2] > 0 and (not v3:IsA(v11[2]) or v122 and not table.find(v122, v3.ClassName))) then
				return
			end
		end

		return p2
	end

	return warn("Invalid STRF structure params. Structure must be a table, got:", p1, ", object must be a table got:", p2)
end

function t2.new(p1) --[[ new | Line: 63 | Upvalues: t2 (copy) ]]
	return setmetatable(p1, t2)
end
function t2.Request_Proxy(p1, p2, ...) --[[ Request_Proxy | Line: 67 | Upvalues: v1 (copy) ]]
	local v12 = v1(p1["Strct_" .. p2], { ... })

	return if typeof(v12) == "table" then v12 else false
end

return t2