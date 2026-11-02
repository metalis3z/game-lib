-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: observe, time of decompilation: Sun May  3 10:10:43 2026 ]]
local store = require(script.Parent.store)
local subscribe = require(script.Parent.subscribe)

require(script.Parent.types)

local function noop() -- line: 6
end

return function(p1, p2: ((...any) -> ...any)) --[[ observe ]] -- line: 17
	-- upvalues: noop (copy), subscribe (copy), store (copy)
	local t1 = {}

	local function listener(t2: {[any]: any}) -- line: 20
		-- upvalues: t1 (copy), p2 (copy), noop (copy)
		for k, v in next, t1 do
			if t2[k] == nil then
				t1[k] = nil
				v()
			end
		end

		for k, v in next, t2 do
			if not t1[k] then
				t1[k] = p2(v, k) or noop
			end
		end
	end

	local v8 = subscribe(p1, listener)

	store.peek(function() -- line: 37
		-- upvalues: listener (copy), p1 (copy)
		listener(p1())
	end)

	return function() -- line: 41
		-- upvalues: v8 (copy), t1 (copy)
		v8()

		for _, v in next, t1 do
			v()
		end

		table.clear(t1)
	end
end
