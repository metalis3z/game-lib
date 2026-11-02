-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	["\""] = "\\\"",
	["\\"] = "\\\\",
	["\8"] = "\\b",
	["\f"] = "\\f",
	["\n"] = "\\n",
	["\r"] = "\\r",
	["\t"] = "\\t"
}

setmetatable(t, {
	__index = function(p1, p2) --[[ Line: 12 ]]
		return string.format("\\u00%02X", p2:byte())
	end
})
function newencoder() --[[ newencoder | Line: 17 | Upvalues: t (copy) ]]
	local v1 = 1
	local t2 = {}
	local v2 = nil
	local t3 = {
		boolean = function(p1) --[[ Line: 25 | Upvalues: t2 (ref), v1 (ref) ]]
			t2[v1] = tostring(p1)
			v1 = v1 + 1
		end,
		number = function(p1) --[[ Line: 30 | Upvalues: t2 (ref), v1 (ref) ]]
			t2[v1] = string.format("%.17g", p1)
			v1 = v1 + 1
		end,
		string = function(p1) --[[ Line: 35 | Upvalues: t2 (ref), v1 (ref), t (ref) ]]
			t2[v1] = "\""

			if p1:find("[\0-\31\"\\]") then
				p1 = p1:gsub("[\0-\31\"\\]", t)
			end

			t2[v1 + 1] = p1
			t2[v1 + 2] = "\""
			v1 = v1 + 3
		end,
		table = function(p1) --[[ Line: 47 | Upvalues: t2 (ref), v1 (ref), v2 (ref), t (ref) ]]
			local v12 = #p1

			if v12 > 0 then
				t2[v1] = "["
				v1 = v1 + 1

				for i = 1, v12 do
					v2(p1[i])
					t2[v1] = ","
					v1 = v1 + 1
				end

				v1 = v1 - 1
				t2[v1] = "]"
			else
				t2[v1] = "{"
				v1 = v1 + 1

				local v22 = v1
				local list = {}

				for k, v in pairs(p1) do
					table.insert(list, k)
				end

				table.sort(list)

				for i, v in ipairs(list) do
					local v3 = tostring(v)

					t2[v1] = "\""

					if v3:find("[\0-\31\"\\]") then
						v3 = v3:gsub("[\0-\31\"\\]", t)
					end

					t2[v1 + 1] = v3
					t2[v1 + 2] = "\""
					v1 = v1 + 3
					t2[v1] = ":"
					v1 = v1 + 1
					v2(p1[v])
					t2[v1] = ","
					v1 = v1 + 1
				end

				if v22 < v1 then
					v1 = v1 - 1
				end

				t2[v1] = "}"
			end

			v1 = v1 + 1
		end
	}

	v2 = function(p1) --[[ Line: 107 | Upvalues: t3 (copy) ]]
		(t3[type(p1)] or t3.string)(p1)
	end

	return function(p1) --[[ Line: 118 | Upvalues: v1 (ref), t2 (ref), v2 (ref) ]]
		v1 = 1
		t2 = {}
		v2(p1)

		return table.concat(t2)
	end
end

return newencoder