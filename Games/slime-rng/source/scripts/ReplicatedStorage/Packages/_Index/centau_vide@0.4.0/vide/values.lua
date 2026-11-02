-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: values, time of decompilation: Sun May  3 10:09:47 2026 ]]
local flags = require("./flags")
local branch = require("./branch")
local source = require("./source")
local effect = require("./effect")
local v5 = require("./timeout")()

return function(p1: ((...any) -> ...any), p2: ((...any) -> ...any)) --[[ values ]] -- line: 11
	-- upvalues: source (copy), effect (copy), flags (copy), branch (copy), v5 (copy)
	local n1 = 0
	local t1 = {}
	local v10 = source({})

	effect(function() -- line: 38
		-- upvalues: p1 (copy), n1 (ref), flags (copy), t1 (copy), source (copy), branch (copy), p2 (copy), v5 (copy), v10 (copy)
		local v14 = p1()
		local v15 = n1

		n1 += 1

		local v16 = false

		if flags.strict then
			local t2 = {}

			for _, v19 in v14 do
				if t2[v19] then
					error("table source passed to `values()` contains duplicate values", 0)
				end

				t2[v19] = true
			end
		end

		for v20, v21 in v14 do
			local v22 = t1[v21]

			if v22 == nil then
				local v23 = source(v20)
				local v24 = source(false)
				local u25 = nil
				local v26, v27 = branch(function() -- line: 65
					-- upvalues: p2 (copy), v21 (copy), v23 (copy), v24 (copy), u25 (ref)
					local v33, v34 = p2(v21, v23, v24)

					u25 = v34

					return v33
				end)

				v24(true)
				v16 = true
				t1[v21] = {
					timeout = nil,
					destroy = v26,
					object = v27,
					index = v20,
					index_source = v23,
					count = v15,
					delay = u25 or 0,
					present = v24
				}
			else
				v22.count = v15

				if v20 ~= v22.index then
					if v22.timeout then
						v22.timeout.cancel = true
						v22.timeout = nil
						v22.present(true)
					end

					v22.index = v20
					v22.index_source(v20)
				end
			end
		end

		for v28, v29 in t1 do
			if v15 > v29.count then
				v29.present(false)

				if v29.delay == 0 then
					v29.destroy()
					t1[v28] = nil
					v16 = true
				else
					v29.index = nil

					if v29.timeout == nil then
						v29.timeout = v5(v29.delay, function() -- line: 113
							-- upvalues: v29 (copy), t1 (copy), v28 (copy), v10 (copy)
							v29.destroy()
							t1[v28] = nil

							local t3 = table.create(4)

							for _, v37 in t1 do
								table.insert(t3, v37.object)
							end

							v10(t3)
						end)
					end
				end
			end
		end

		if v16 then
			local t4 = table.create(4)

			for _, v32 in t1 do
				table.insert(t4, v32.object)
			end

			v10(t4)
		end
	end)

	return v10
end
