-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: cleanup, time of decompilation: Sun May  3 10:09:38 2026 ]]
local v1 = game and typeof or require("../test/mock").typeof
local graph = require("./graph")
local get_scope = graph.get_scope
local push_cleanup = graph.push_cleanup

local function helper(p1) -- line: 7
	-- upvalues: v1 (copy)
	if v1(p1) == "RBXScriptConnection" then
		return function() -- line: 9
			-- upvalues: p1 (copy)
			p1:Disconnect()
		end
	end

	if type(p1) == "thread" then
		return function() -- line: 10
			-- upvalues: p1 (copy)
			task.cancel(p1)
		end
	end

	if v1(p1) == "Instance" then
		return function() -- line: 11
			-- upvalues: p1 (copy)
			p1:Destroy()
		end
	end

	if p1.destroy then
		return function() -- line: 12
			-- upvalues: p1 (copy)
			p1:destroy()
		end
	end

	if p1.disconnect then
		return function() -- line: 13
			-- upvalues: p1 (copy)
			p1:disconnect()
		end
	end

	if p1.Destroy then
		return function() -- line: 14
			-- upvalues: p1 (copy)
			p1:Destroy()
		end
	end

	if p1.Disconnect then
		return function() -- line: 15
			-- upvalues: p1 (copy)
			p1:Disconnect()
		end
	end

	return (error("cannot cleanup given object"))
end

return function(p2) --[[ cleanup ]] -- line: 19
	-- upvalues: get_scope (copy), push_cleanup (copy), helper (copy)
	local v8 = get_scope()

	if not v8 then
		error("cannot cleanup outside a stable or reactive scope")
	end

	assert(v8)

	if type(p2) == "function" then
		push_cleanup(v8, p2)

		return
	end

	push_cleanup(v8, (helper(p2)))
end
