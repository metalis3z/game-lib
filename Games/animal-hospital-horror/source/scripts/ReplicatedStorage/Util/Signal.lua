local t = {}

t.__index = t
t.ClassName = "Signal"
function t.new() --[[ new | Line: 17 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2._bindableEvent = Instance.new("BindableEvent")
	v2._argData = nil
	v2._argCount = nil
	v2._source = ""

	return v2
end
function t.Fire(p1, ...) --[[ Fire | Line: 33 ]]
	if p1._bindableEvent then
		p1._argData = { ... }
		p1._argCount = select("#", ...)
		p1._bindableEvent:Fire()
	else
		warn(("Signal is already destroyed. %s"):format(p1._source))
	end
end
function t.Connect(p1, p2) --[[ Connect | Line: 49 ]]
	if type(p2) ~= "function" then
		error(("connect(%s)"):format((typeof(p2))), 2)
	end

	return p1._bindableEvent.Event:Connect(function() --[[ Line: 54 | Upvalues: p2 (copy), p1 (copy) ]]
		p2(unpack(p1._argData, 1, p1._argCount))
	end)
end
function t.Wait(p1) --[[ Wait | Line: 61 ]]
	p1._bindableEvent.Event:Wait()
	assert(p1._argData, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")

	return unpack(p1._argData, 1, p1._argCount)
end
function t.Destroy(p1) --[[ Destroy | Line: 69 ]]
	if p1._bindableEvent then
		p1._bindableEvent:Destroy()
		p1._bindableEvent = nil
	end

	p1._argData = nil
	p1._argCount = nil
	setmetatable(p1, nil)
end

return t