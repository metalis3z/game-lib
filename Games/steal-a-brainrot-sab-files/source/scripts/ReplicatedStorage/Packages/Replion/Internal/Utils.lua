

local RunService = game:GetService("RunService")
local Freeze = require(script.Parent.Parent.Parent.Freeze)

require(script.Parent.Types)

return table.freeze({
	SerializedNone = "\000",
	ShouldMock = RunService:IsStudio() and not RunService:IsRunning() or _G.NOCOLOR,
	getValue = function(p1)
		if p1 == Freeze.None or p1 == "\000" then
			return nil
		end

		return p1
	end,
	getPathTable = function(p2)
		if type(p2) == "table" then
			return p2
		end

		if type(p2) == "string" then
			return string.split(p2, ".")
		end

		return { p2 }
	end,
	getPathString = function(p3)
		if type(p3) == "string" then
			return p3
		end

		if type(p3) == "table" then
			return table.concat(p3, ".")
		end

		return (tostring(p3))
	end,
	safeCancelThread = function(p4: thread)
		if coroutine.status(p4) ~= "dead" then
			task.cancel(p4)
		end
	end,
	trimString = function(s1: string)
		return string.gsub(s1, "^%s*(.-)%s*$", "%1")
	end,
	checkForTrimmedString = function(s2: string)
		return s2 ~= string.gsub(s2, "^%s*(.-)%s*$", "%1")
	end
})
