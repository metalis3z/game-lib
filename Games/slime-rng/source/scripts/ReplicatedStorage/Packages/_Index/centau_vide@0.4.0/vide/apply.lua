-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: apply, time of decompilation: Sun May  3 10:09:37 2026 ]]
local v1 = game and typeof or require("../test/mock").typeof
local flags = require("./flags")
local implicit_effect = require("./implicit_effect")
local _, v5 = require("./action")()

require("./graph")

local u6 = nil

local function borrow_cache() -- line: 42
	-- upvalues: u6 (ref)
	if u6 then
		local v9 = u6

		u6 = nil

		return v9
	end

	return {
		parent = nil,
		events = {},
		actions = setmetatable({}, {
			__index = function(p1, p2) --[[ __index ]] -- line: 51
				p1[p2] = {}

				return p1[p2]
			end
		}),
		nested_debug = setmetatable({}, {
			__index = function(p3, n1: number) --[[ __index ]] -- line: 55
				p3[n1] = {}

				return p3[n1]
			end
		}),
		nested_stack = {}
	}
end
local function process_properties(t1: {[any]: any}, p4, t2: {[any]: any}, n2: number) -- line: 66
	-- upvalues: flags (copy), v1 (copy), implicit_effect (copy), v5 (copy), process_properties (copy)
	for v15, v16 in t1 do
		if type(v15) == "string" then
			if flags.strict then
				if t2.nested_debug[n2][v15] then
					error(`duplicate property { v15 } at depth { n2 }`, 0)
				end

				t2.nested_debug[n2][v15] = true
			end

			if v15 == "Parent" then
				t2.parent = v16
			elseif type(v16) == "function" then
				if v1(p4[v15]) == "RBXScriptSignal" then
					table.insert(t2.events, v15)
					table.insert(t2.events, v16)
				else
					implicit_effect.property(p4, v15, v16)
				end
			else
				p4[v15] = v16
			end
		elseif type(v15) == "number" then
			if type(v16) == "function" then
				implicit_effect.children(p4, v16)
			elseif type(v16) == "table" then
				if v5(v16) then
					table.insert(t2.actions[v16.priority], v16.callback)
				elseif flags.defer_nested_properties then
					table.insert(t2.nested_stack, v16)
					table.insert(t2.nested_stack, n2 + 1)
				else
					process_properties(v16, p4, t2, n2 + 1)
				end
			elseif type(v16) == "userdata" then
				v16.Parent = p4
			end
		end
	end
end

return function(p5, t3: {[any]: any}) --[[ apply ]] -- line: 111
	-- upvalues: borrow_cache (copy), process_properties (copy), implicit_effect (copy), flags (copy), u6 (ref)
	if not t3 then
		error("attempt to call a constructor returned by create() with no properties")
	end

	local v19 = borrow_cache()
	local events = v19.events
	local actions = v19.actions
	local nested_debug = v19.nested_debug
	local nested_stack = v19.nested_stack
	local n3 = 1

	repeat
		process_properties(t3, p5, v19, n3)
		n3 = table.remove(nested_stack)
		t3 = table.remove(nested_stack)
	until not t3

	for i = 1, #events, 2 do
		local v26 = events[i]
		local v27 = events[i + 1]

		p5[v26]:Connect(v27)
	end

	for _, v29 in actions do
		for _, v31 in v29 do
			v31(p5)
		end
	end

	local parent = v19.parent

	if parent then
		if type(parent) == "function" then
			implicit_effect.parent(p5, parent)
		else
			p5.Parent = parent
		end
	end

	table.clear(events)

	for _, v34 in actions do
		table.clear(v34)
	end

	v19.parent = nil

	if flags.strict then
		table.clear(nested_debug)
	end

	table.clear(nested_stack)
	u6 = v19

	return p5
end
