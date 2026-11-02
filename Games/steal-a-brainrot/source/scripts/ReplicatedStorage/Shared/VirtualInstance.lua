local v_u1 = {
	["__index"] = function(arg1, arg2)
		local v___internals = arg1.__internals
		if v___internals.lastSet[arg2] == nil then
			return v___internals.instance[arg2]
		else
			return v___internals.lastSet[arg2]
		end
	end,
	["__newindex"] = function(arg1, arg2, arg3)
		assert(arg3 ~= nil, "cannot set vinst property to nil")
		local v_u___internals = arg1.__internals
		if v_u___internals.lastSet[arg2] ~= arg3 then
			v_u___internals.bufferedChanges[arg2] = arg3
			v_u___internals.lastSet[arg2] = arg3
			if not v_u___internals.hasBuffered then
				v_u___internals.hasBuffered = true
				task.defer(function()
					local v_instance = v_u___internals.instance
					if v_u___internals.hasBuffered then
						v_u___internals.hasBuffered = false
						for v1, v2 in v_u___internals.bufferedChanges do
							v_instance[v1] = v2
						end
						table.clear(v_u___internals.bufferedChanges)
					end
				end)
			end
		end
	end
}
return {
	["wrap"] = function(arg1)
		local v1 = {
			["__internals"] = {
				["instance"] = arg1,
				["lastSet"] = {},
				["bufferedChanges"] = {},
				["hasBuffered"] = false
			}
		}
		return setmetatable(v1, v_u1)
	end
}