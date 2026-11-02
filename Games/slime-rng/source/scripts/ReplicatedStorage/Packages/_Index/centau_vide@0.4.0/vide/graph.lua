-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: graph, time of decompilation: Sun May  3 10:09:41 2026 ]]
local flags = require("./flags")
local t1 = {
	n = 0
}

local function efn(s1: string) -- line: 24
	local trace = debug.traceback(s1, 2)

	if string.find(s1, "^effect error stacktrace") then
		trace = string.gsub("    " .. trace, "\n", function() -- line: 28
			return "\n    "
		end)
	end

	return trace .. "\nsource update stacktrace:"
end
local function ycall(p1: ((...any) -> ...any), p2) -- line: 37
	-- upvalues: efn (copy)
	local co = coroutine.create(xpcall)
	local ok, result, v16 = coroutine.resume(co, p1, efn, p2)

	assert(ok)

	if coroutine.status(co) ~= "dead" then
		return false, debug.traceback(co, "attempt to yield in reactive scope")
	end

	return result, v16
end
local function flush_cleanups(t2: {[any]: any}) -- line: 94
	if t2.cleanups then
		for _, v28 in t2.cleanups do
			local ok, result = xpcall(v28, debug.traceback)

			if not ok then
				error(`cleanup error: { result }`, 0)
			end
		end

		table.clear(t2.cleanups)
	end
end
local function destroy(t3: {[any]: any}) -- line: 121
	-- upvalues: flags (copy), t1 (copy), flush_cleanups (copy), destroy (copy)
	if flags.strict and table.find(t1, t3) then
		error("attempt to destroy an active scope", 0)
	end

	flush_cleanups(t3)

	local parents = t3.parents

	for v43, v44 in parents do
		local v45 = table.find(v44, t3)
		local v46 = #v44

		v44[v45] = v44[v46]
		v44[v46] = nil
		parents[v43] = nil
	end

	if t3.owner then
		local owned = t3.owner.owned
		local v48 = table.find(owned, t3)
		local v49 = #owned

		owned[v48] = owned[v49]
		owned[v49] = nil
		t3.owner = false
	end

	if t3.owned then
		local owned = t3.owned

		while owned[1] do
			destroy(owned[1])
		end
	end
end

local t4 = {
	n = 0
}

local function evaluate_node(t5: {[any]: any}) -- line: 149
	-- upvalues: flags (copy), t1 (copy), flush_cleanups (copy), destroy (copy), ycall (copy), t4 (copy)
	if flags.strict then
		if table.find(t1, t5) then
			error("a scope, that should rerun due to the update of a source, is already active", 0)
		end

		local cache = t5.cache

		for _ = 1, 2 do
			local cache2 = t5.cache

			flush_cleanups(t5)

			if t5.owned then
				local owned = t5.owned

				while owned[1] do
					destroy(owned[1])
				end
			end

			local v58 = t1.n + 1

			t1.n = v58
			t1[v58] = t5

			local v59, v60 = ycall(t5.effect, cache2)
			local n = t1.n

			t1.n = n - 1
			t1[n] = nil

			if not v59 then
				table.clear(t4)
				t4.n = 0
				error(`effect error stacktrace\n{ v60 }`, 0)
			end

			t5.cache = v60
		end

		return cache ~= t5.cache
	end

	local cache = t5.cache

	flush_cleanups(t5)

	if t5.owned then
		local owned = t5.owned

		while owned[1] do
			destroy(owned[1])
		end
	end

	local v64 = t1.n + 1

	t1.n = v64
	t1[v64] = t5

	local ok, result = pcall(t5.effect, t5.cache)
	local n = t1.n

	t1.n = n - 1
	t1[n] = nil

	if not ok then
		table.clear(t4)
		t4.n = 0
		error(`effect error:\n{ result }\n`, 0)
	end

	t5.cache = result

	return cache ~= result
end

return table.freeze({
	push_scope = function(t6: {[any]: any}) --[[ push_scope ]] -- line: 74
		-- upvalues: t1 (copy)
		local v22 = t1.n + 1

		t1.n = v22
		t1[v22] = t6
	end,
	pop_scope = function() --[[ pop_scope ]] -- line: 80
		-- upvalues: t1 (copy)
		local n = t1.n

		t1.n = n - 1
		t1[n] = nil
	end,
	evaluate_node = evaluate_node,
	get_scope = function() --[[ get_scope ]] -- line: 52
		-- upvalues: t1 (copy)
		return t1[t1.n]
	end,
	assert_stable_scope = function() --[[ assert_stable_scope ]] -- line: 56
		-- upvalues: t1 (copy)
		local v17 = t1[t1.n]

		if not v17 then
			local v18 = debug.info(2, "n")

			return error(`cannot use { v18 }() outside a stable or reactive scope`, 0)
		end

		if v17.effect then
			error("cannot create a new reactive scope inside another reactive scope", 0)
		end

		return v17
	end,
	push_cleanup = function(t7: {[any]: any}, p3: ((...any) -> ...any)) --[[ push_cleanup ]] -- line: 86
		if t7.cleanups then
			table.insert(t7.cleanups, p3)

			return
		end

		t7.cleanups = { p3 }
	end,
	destroy = destroy,
	flush_cleanups = flush_cleanups,
	push_scope_as_child_of = function(t8: {[any]: any}) --[[ push_scope_as_child_of ]] -- line: 252
		-- upvalues: t1 (copy)
		local v105 = t1[t1.n]

		if v105 and v105.effect then
			table.insert(t8, v105)
			table.insert(v105.parents, t8)
		end
	end,
	update_descendants = function(t9: {[any]: any}) --[[ update_descendants ]] -- line: 229
		-- upvalues: t4 (copy), flags (copy), evaluate_node (copy)
		local n = t4.n
		local n2 = t4.n

		while t9[1] do
			n2 += 1
			t4[n2] = t9[1]

			local v89 = t9[1]
			local parents = v89.parents

			for v91, v92 in parents do
				local v93 = table.find(v92, v89)
				local v94 = #v92

				v92[v93] = v92[v94]
				v92[v94] = nil
				parents[v91] = nil
			end
		end

		t4.n = n2

		if flags.batch then
			return
		end

		local v95 = n + 1

		while v95 <= t4.n do
			local v96 = t4[v95]

			if v96.owner and evaluate_node(v96) then
				local n3 = t4.n

				while v96[1] do
					n3 += 1
					t4[n3] = v96[1]

					local v98 = v96[1]
					local parents = v98.parents

					for v100, v101 in parents do
						local v102 = table.find(v101, v98)
						local v103 = #v101

						v101[v102] = v101[v103]
						v101[v103] = nil
						parents[v100] = nil
					end
				end

				t4.n = n3
			end

			t4[v95] = false
			v95 += 1
		end

		t4.n = n
	end,
	push_child = function(t10: {[any]: any}, t11: {[any]: any}) --[[ push_child ]] -- line: 69
		table.insert(t10, t11)
		table.insert(t11.parents, t10)
	end,
	create_node = function(p4, p5, p6) --[[ create_node ]] -- line: 259
		local t12 = {
			cleanups = false,
			context = false,
			owned = false,
			cache = p6,
			effect = p5,
			owner = p4,
			parents = {}
		}

		if p4 then
			if p4.owned then
				table.insert(p4.owned, t12)

				return t12
			end

			p4.owned = { t12 }
		end

		return t12
	end,
	create_source_node = function(p7) --[[ create_source_node ]] -- line: 284
		return {
			cache = p7
		}
	end,
	get_children = function(t13: {[any]: any}) --[[ get_children ]] -- line: 288
		return { unpack(t13) }
	end,
	flush_update_queue = function(n1: number) --[[ flush_update_queue ]] -- line: 212
		-- upvalues: t4 (copy), evaluate_node (copy)
		local v77 = n1 + 1

		while v77 <= t4.n do
			local v78 = t4[v77]

			if v78.owner and evaluate_node(v78) then
				local n = t4.n

				while v78[1] do
					n += 1
					t4[n] = v78[1]

					local v80 = v78[1]
					local parents = v80.parents

					for v82, v83 in parents do
						local v84 = table.find(v83, v80)
						local v85 = #v83

						v83[v84] = v83[v85]
						v83[v85] = nil
						parents[v82] = nil
					end
				end

				t4.n = n
			end

			t4[v77] = false
			v77 += 1
		end

		t4.n = n1
	end,
	get_update_queue_length = function() --[[ get_update_queue_length ]] -- line: 208
		-- upvalues: t4 (copy)
		return t4.n
	end,
	set_context = function(t14: {[any]: any}, n2: number, p8) --[[ set_context ]] -- line: 292
		if t14.context then
			t14.context[n2] = p8

			return
		end

		t14.context = {
			[n2] = p8
		}
	end,
	scopes = t1,
	q = t4
})
