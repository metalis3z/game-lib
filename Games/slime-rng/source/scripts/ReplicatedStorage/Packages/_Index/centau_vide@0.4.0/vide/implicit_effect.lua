-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: implicit_effect, time of decompilation: Sun May  3 10:09:41 2026 ]]
local graph = require("./graph")
local create_node = graph.create_node
local assert_stable_scope = graph.assert_stable_scope
local get_scope = graph.get_scope
local evaluate_node = graph.evaluate_node
local push_cleanup = graph.push_cleanup

local function update_property_effect(t1: {[any]: any}) -- line: 9
	t1.instance[t1.property] = t1.source()

	return t1
end
local function update_parent_effect(t2: {[any]: any}) -- line: 18
	t2.instance.Parent = t2.source()

	return t2
end
local function update_children_effect(t3: {[any]: any}) -- line: 27
	-- upvalues: create_node (copy), get_scope (copy), update_children_effect (copy), evaluate_node (copy), push_cleanup (copy)
	local cur_children_set = t3.cur_children_set
	local new_children_set = t3.new_children_set

	local function process_child(p1) -- line: 38
		-- upvalues: new_children_set (copy), cur_children_set (copy), t3 (copy), process_child (copy), create_node (copy), get_scope (copy), update_children_effect (copy), evaluate_node (copy), push_cleanup (copy)
		if type(p1) == "userdata" then
			if new_children_set[p1] then
				return
			end

			new_children_set[p1] = true

			if not cur_children_set[p1] then
				p1.Parent = t3.instance

				return
			end

			cur_children_set[p1] = nil

			return
		end

		if type(p1) == "table" then
			for _, v29 in p1 do
				process_child(v29)
			end

			return
		end

		if type(p1) == "function" then
			local v30 = create_node(assert(get_scope()), update_children_effect, {
				instance = t3.instance,
				cur_children_set = {},
				new_children_set = {},
				source = p1
			})

			evaluate_node(v30)
			push_cleanup(assert(get_scope()), function() -- line: 63
				-- upvalues: v30 (copy)
				for v32 in v30.cache.cur_children_set do
					v32.Parent = nil
				end
			end)
		end
	end

	process_child((t3.source()))

	for v16 in cur_children_set do
		v16.Parent = nil
	end

	table.clear(cur_children_set)
	t3.cur_children_set = new_children_set
	t3.new_children_set = cur_children_set

	return t3
end

return {
	property = function(p2, p3, p4) --[[ property ]] -- line: 84
		-- upvalues: create_node (copy), assert_stable_scope (copy), update_property_effect (copy), evaluate_node (copy)
		local v20 = create_node(assert_stable_scope(), update_property_effect, {
			instance = p2,
			property = p3,
			source = p4
		})

		evaluate_node(v20)

		return v20
	end,
	parent = function(p5, p6) --[[ parent ]] -- line: 96
		-- upvalues: create_node (copy), assert_stable_scope (copy), update_parent_effect (copy), evaluate_node (copy)
		local v23 = create_node(assert_stable_scope(), update_parent_effect, {
			instance = p5,
			source = p6
		})

		evaluate_node(v23)

		return v23
	end,
	children = function(p7, p8) --[[ children ]] -- line: 107
		-- upvalues: create_node (copy), assert_stable_scope (copy), update_children_effect (copy), evaluate_node (copy), push_cleanup (copy)
		local v26 = create_node(assert_stable_scope(), update_children_effect, {
			instance = p7,
			cur_children_set = {},
			new_children_set = {},
			source = p8
		})

		evaluate_node(v26)
		push_cleanup(assert_stable_scope(), function() -- line: 117
			-- upvalues: v26 (copy)
			for v31 in v26.cache.cur_children_set do
				v31.Parent = nil
			end
		end)

		return v26
	end
}
