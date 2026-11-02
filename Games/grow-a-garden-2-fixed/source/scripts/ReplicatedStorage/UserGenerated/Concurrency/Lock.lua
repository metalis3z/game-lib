--credit to prince games studio
local Finally = require(game.ReplicatedStorage.UserGenerated.Lang.Finally)
local t2 = {}
local v1 = table.freeze({
	__index = table.freeze({
		Call = function(p1, p2, ...) --[[ Call | Line: 42 | Upvalues: Finally (copy) ]]
			assert(if type(p2) == "function" then true else false)

			while p1.Count > 0 do
				task.wait()
			end

			p1.Count = p1.Count + 1

			return Finally(p2, function() --[[ Line: 52 | Upvalues: p1 (copy) ]]
				local v1 = p1

				v1.Count = v1.Count - 1
			end, ...)
		end,
		Try = function(p1, p2, ...) --[[ Try | Line: 57 | Upvalues: Finally (copy) ]]
			assert(if type(p2) == "function" then true else false)

			if p1.Count > 0 then
				return false
			end

			p1.Count = p1.Count + 1

			return true, Finally(p2, function() --[[ Line: 67 | Upvalues: p1 (copy) ]]
				local v1 = p1

				v1.Count = v1.Count - 1
			end, ...)
		end,
		IsLocked = function(p1) --[[ IsLocked | Line: 72 ]]
			return p1.Count > 0
		end
	})
})

function t2.new() --[[ new | Line: 82 | Upvalues: v1 (copy) ]]
	return setmetatable({
		Count = 0
	}, v1)
end

return table.freeze(t2)