-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: indexes, time of decompilation: Sun May  3 10:09:42 2026 ]]
require("./flags")

local branch = require("./branch")
local source = require("./source")
local effect = require("./effect")
local v4 = require("./timeout")()

return function(p1: ((...any) -> ...any), p2: ((...any) -> ...any)) --[[ indexes ]] -- line: 11
	-- upvalues: source (copy), effect (copy), branch (copy), v4 (copy)
	local n1 = 0
	local t1 = {}
	local v9 = source({})

	effect(function() -- line: 38
		-- upvalues: p1 (copy), n1 (ref), t1 (copy), source (copy), branch (copy), p2 (copy), v4 (copy), v9 (copy)
		local v13 = p1()
		local v14 = n1

		n1 += 1

		local v15 = false

		for v16, v17 in v13 do
			local v18 = t1[v16]

			if v18 == nil then
				local v19 = source(v17)
				local v20 = source(false)
				local u21 = nil
				local v22, v23 = branch(function() -- line: 55
					-- upvalues: p2 (copy), v19 (copy), v16 (copy), v20 (copy), u21 (ref)
					local v29, v30 = p2(v19, v16, v20)

					u21 = v30

					return v29
				end)

				v20(true)
				v15 = true
				t1[v16] = {
					timeout = nil,
					destroy = v22,
					object = v23,
					value = v17,
					value_source = v19,
					count = v14,
					delay = u21 or 0,
					present = v20
				}
			else
				v18.count = v14

				if v17 ~= v18.value then
					if v18.timeout then
						v18.timeout.cancel = true
						v18.timeout = nil
						v18.present(true)
					end

					v18.value = v17
					v18.value_source(v17)
				end
			end
		end

		for v24, v25 in t1 do
			if v14 > v25.count then
				v25.present(false)

				if v25.delay == 0 then
					v25.destroy()
					t1[v24] = nil
					v15 = true
				else
					v25.value = nil

					if v25.timeout == nil then
						v25.timeout = v4(v25.delay, function() -- line: 103
							-- upvalues: v25 (copy), t1 (copy), v24 (copy), v9 (copy)
							v25.destroy()
							t1[v24] = nil

							local t2 = table.create(4)

							for _, v33 in t1 do
								table.insert(t2, v33.object)
							end

							v9(t2)
						end)
					end
				end
			end
		end

		if v15 then
			local t3 = table.create(4)

			for _, v28 in t1 do
				table.insert(t3, v28.object)
			end

			v9(t3)
		end
	end)

	return v9
end
