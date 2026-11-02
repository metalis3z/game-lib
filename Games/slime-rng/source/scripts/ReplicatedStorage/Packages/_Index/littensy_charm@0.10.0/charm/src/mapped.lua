-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: mapped, time of decompilation: Sun May  3 10:10:42 2026 ]]
local atom = require(script.Parent.atom)
local store = require(script.Parent.store)
local subscribe = require(script.Parent.subscribe)

require(script.Parent.types)

return function(p1, p2: ((...any) -> ...any)) --[[ mapped ]] -- line: 23
	-- upvalues: atom (copy), subscribe (copy), store (copy)
	local v6 = atom({})
	local v7 = setmetatable({
		current = v6
	}, {
		__mode = "v"
	})
	local t1 = {}
	local u9 = nil

	local function listener(t2: {[any]: any}) -- line: 29
		-- upvalues: v7 (copy), u9 (ref), p2 (copy), t1 (ref)
		local current = v7.current

		if not current then
			return u9()
		end

		local v13 = table.clone(current())
		local t3 = {}

		for k, v in next, t2 do
			local v17, v18 = p2(v, k)

			if v18 == nil then
				v18 = k
			end

			if v17 ~= v13[v18] then
				v13[v18] = v17
			else
				t3[v18] = k
			end
		end

		for k in next, t1 do
			if t3[k] == nil and v13[k] == t1[k] then
				v13[k] = nil
			end
		end

		t1 = v13
		current(v13)
	end

	u9 = subscribe(p1, listener)
	store.peek(function() -- line: 64
		-- upvalues: listener (copy), p1 (copy)
		listener(p1())
	end)

	return v6
end
