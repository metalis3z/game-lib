--credit to quartz games studio
local function ErrorHandler(p1) --[[ ErrorHandler | Line: 20 ]]
	warn((("%*\nStack Begin\n%*Stack End"):format(tostring(p1), (debug.traceback(nil, 3)))))
end

return function(p1, ...) --[[ WCall | Line: 24 | Upvalues: ErrorHandler (copy) ]]
	return xpcall(p1, ErrorHandler, ...)
end