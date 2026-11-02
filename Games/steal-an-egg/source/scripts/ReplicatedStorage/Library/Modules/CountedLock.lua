-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = require(script.Parent.Event)
local t2 = {
	IsLocked = function(p1) --[[ IsLocked | Line: 7 ]]
		return p1._obtainedCount > 0
	end,
	IsUnlocked = function(p1) --[[ IsUnlocked | Line: 11 ]]
		return p1._obtainedCount <= 0
	end,
	ObtainLock = function(p1) --[[ ObtainLock | Line: 15 ]]
		local v1 = false

		p1._obtainedCount = p1._obtainedCount + 1
		p1.Modified:FireAsync(p1)

		return function() --[[ Line: 20 | Upvalues: v1 (ref), p1 (copy) ]]
			if v1 then
				return
			end

			v1 = true
			p1:ReleaseLock()
		end
	end,
	ReleaseLock = function(p1) --[[ ReleaseLock | Line: 28 ]]
		assert(p1._obtainedCount > 0, "Cannot release a lock that is not obtained")
		p1._obtainedCount = p1._obtainedCount - 1
		p1.Modified:FireAsync(p1)
	end
}

function t.new() --[[ new | Line: 34 | Upvalues: v1 (copy), t2 (copy) ]]
	return setmetatable({
		_obtainedCount = 0,
		Modified = v1.new()
	}, {
		__index = t2
	})
end

return t