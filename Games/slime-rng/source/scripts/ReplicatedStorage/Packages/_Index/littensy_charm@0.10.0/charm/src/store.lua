-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: store, time of decompilation: Sun May  3 10:10:43 2026 ]]
require(script.Parent.types)

local __DEV__ = _G.__DEV__
local v2 = setmetatable({}, {
	__mode = "k"
})
local t1 = {}
local u4 = false
local t2 = {
	index = 0,
	stack = {}
}

local function try(p1: ((...any) -> ...any), p2: ((...any) -> ...any)?, ...) -- line: 28
	-- upvalues: __DEV__ (copy)
	if __DEV__ then
		local co = coroutine.create(p1)
		local ok, result = coroutine.resume(co, ...)

		if p2 then
			p2()
		end

		if coroutine.status(co) == "suspended" then
			local v13, v14, v15 = debug.info(p1, "sln")

			coroutine.close(co)
			error("Yielding is not allowed in atom functions. Consider wrapping this code in a Promise or task.defer instead." .. `\nFunction defined at: { v13 }:{ v14 }` .. if v15 ~= "" then ` function { v15 }` else "")

			return result
		end

		if not ok then
			local v16, v17, v18 = debug.info(p1, "sln")

			error("An error occurred while running an atom function" .. `\nFunction defined at: { v16 }:{ v17 }` .. ((if v18 ~= "" then ` function { v18 }` else "")) .. `\nError: { result }`)
		end

		return result
	end

	if not p2 then
		return p1(...)
	end

	local ok, result = pcall(p1, ...)

	p2()
	assert(ok, result)

	return result
end
local function peek(p3, ...) -- line: 109
	-- upvalues: t2 (copy), try (copy)
	if type(p3) ~= "function" then
		return p3
	end

	if t2.index == 0 then
		return p3(...)
	end

	local v26 = t2

	v26.index = v26.index + 1
	t2.stack[t2.index] = {}

	return (try(p3, function() -- line: 121
		-- upvalues: t2 (copy)
		t2.stack[t2.index] = nil

		local v39 = t2

		v39.index = v39.index - 1
	end, ...))
end

return {
	listeners = v2,
	capturing = t2,
	isAtom = function(p4) --[[ isAtom ]] -- line: 79
		-- upvalues: v2 (copy)
		return not not (p4 and v2[p4])
	end,
	notify = function(p5) --[[ notify ]] -- line: 88
		-- upvalues: u4 (ref), v2 (copy), t1 (copy), try (copy)
		if u4 then
			for k in next, v2[p5] do
				t1[k] = true
			end

			return
		end

		for k in next, table.clone(v2[p5]) do
			try(k)
		end
	end,
	capture = function(p6: ((...any) -> ...any), ...) --[[ capture ]] -- line: 136
		-- upvalues: v2 (copy), peek (copy), t2 (copy), try (copy)
		if v2[p6] then
			return {
				[p6] = true
			}, peek(p6)
		end

		local t3 = {}
		local v29 = t2

		v29.index = v29.index + 1
		t2.stack[t2.index] = t3

		return t3, (try(p6, function() -- line: 147
			-- upvalues: t2 (copy)
			t2.stack[t2.index] = nil

			local v40 = t2

			v40.index = v40.index - 1
		end, ...))
	end,
	batch = function(p7: ((...any) -> ...any)) --[[ batch ]] -- line: 161
		-- upvalues: u4 (ref), try (copy), t1 (copy)
		if u4 then
			return p7()
		end

		u4 = true
		try(p7, function() -- line: 168
			-- upvalues: u4 (ref)
			u4 = false
		end)

		for k in next, t1 do
			try(k)
		end

		table.clear(t1)
	end,
	peek = peek,
	connect = function(p8, p9: ((...any) -> ...any), p10) --[[ connect ]] -- line: 186
		-- upvalues: v2 (copy)
		for k in next, p8 do
			v2[k][p9] = p10 or true
		end
	end,
	disconnect = function(p11, p12: ((...any) -> ...any)) --[[ disconnect ]] -- line: 198
		-- upvalues: v2 (copy)
		for k in next, p11 do
			v2[k][p12] = nil
		end
	end
}
