-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: switch, time of decompilation: Sun May  3 10:09:46 2026 ]]
local branch = require("./branch")
local source = require("./source")
local effect = require("./effect")
local v4 = require("./timeout")()

local function switch_map(p1: ((...any) -> ...any), t1: {[any]: any}) -- line: 11
	-- upvalues: source (copy), effect (copy), v4 (copy), branch (copy)
	local t2 = {}
	local v9 = source(nil)

	local function update_output() -- line: 24
		-- upvalues: t2 (copy), v9 (copy)
		local t3 = {}

		for _, v14 in t2 do
			table.insert(t3, v14.object)
		end

		v9(if not t3[2] then if not t3[1] then nil else t3[1] else t3)
	end

	effect(function() -- line: 38
		-- upvalues: p1 (copy), t2 (copy), v4 (copy), update_output (copy), t1 (copy), source (copy), branch (copy)
		local v15 = p1()

		for v16, v17 in t2 do
			if v16 ~= v15 then
				v17.present(false)

				if v17.delay == 0 then
					v17.destroy()
					t2[v16] = nil
				elseif v17.timeout == nil then
					v17.timeout = v4(v17.delay, function() -- line: 52
						-- upvalues: v17 (copy), t2 (copy), v16 (copy), update_output (copy)
						v17.destroy()
						t2[v16] = nil
						update_output()
					end)
				end
			end
		end

		if v15 ~= nil then
			local v18 = t2[v15]

			if v18 then
				v18.present(true)

				if v18.timeout then
					v18.timeout.cancel = true
					v18.timeout = nil
				end
			else
				local v19 = t1[v15]

				if v19 ~= nil then
					if type(v19) ~= "function" then
						error("map must map a value to a function", 0)
					end

					local v20 = source(false)
					local u21 = nil
					local v22, v23 = branch(function() -- line: 83
						-- upvalues: v19 (copy), v20 (copy), u21 (ref)
						local v25, v26 = v19(v20)

						u21 = v26

						return v25
					end)

					v20(true)
					t2[v15] = {
						timeout = nil,
						destroy = v22,
						object = v23,
						delay = u21 or 0,
						present = v20
					}
				end
			end
		end

		update_output()
	end)

	return v9
end

return function(p2: ((...any) -> ...any)) --[[ switch ]] -- line: 108
	-- upvalues: switch_map (copy)
	return function(p3) -- line: 109
		-- upvalues: switch_map (copy), p2 (copy)
		return (switch_map(p2, p3))
	end
end
