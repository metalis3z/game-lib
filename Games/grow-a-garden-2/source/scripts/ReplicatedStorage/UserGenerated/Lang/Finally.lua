--credit to leon games studio
local function ErrorHandler(p1) --[[ ErrorHandler | Line: 20 ]]
	warn((("%*\nStack Begin\n%*Stack End"):format(tostring(p1), (debug.traceback(nil, 3)))))
end

local function Handle(p1, p2, ...) --[[ Handle | Line: 24 | Upvalues: ErrorHandler (copy) ]]
	xpcall(p1, ErrorHandler)

	if p2 then
		return ...
	end

	error((select(1, ...)))
end

return function(p1, p2, ...) --[[ Finally | Line: 36 | Upvalues: Handle (copy), ErrorHandler (copy) ]]
	return Handle(p2, xpcall(p1, ErrorHandler, ...))
end