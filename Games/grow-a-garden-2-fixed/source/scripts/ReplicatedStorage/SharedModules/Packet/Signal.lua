--credit to prince games studio
local Task = require(script.Parent.Task)
local t = {}
local t2 = {}

local function Constructor() --[[ Constructor | Line: 36 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Previous = v2
	v2.Next = v2

	return v2
end

t.__index = t
t.Type = "Signal"
function t.Connect(p1, p2) --[[ Connect | Line: 48 | Upvalues: t2 (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Previous = p1.Previous
	v2.Next = p1
	v2.Once = false
	v2.Function = p2
	p1.Previous.Next = v2
	p1.Previous = v2

	return v2
end
function t.Once(p1, p2) --[[ Once | Line: 59 | Upvalues: t2 (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Previous = p1.Previous
	v2.Next = p1
	v2.Once = true
	v2.Function = p2
	p1.Previous.Next = v2
	p1.Previous = v2

	return v2
end
function t.Wait(p1) --[[ Wait | Line: 70 | Upvalues: t2 (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Previous = p1.Previous
	v2.Next = p1
	v2.Once = true
	v2.Thread = coroutine.running()
	p1.Previous.Next = v2
	p1.Previous = v2

	return coroutine.yield()
end
function t.Fire(p1, ...) --[[ Fire | Line: 81 | Upvalues: Task (copy) ]]
	local Next = p1.Next

	while Next.Type == "Connection" do
		if Next.Function then
			Task:Defer(Next.Function, ...)
		else
			task.defer(Next.Thread, ...)
		end

		if Next.Once then
			Next.Previous.Next = Next.Next
			Next.Next.Previous = Next.Previous
		end

		Next = Next.Next
	end
end
t2.__index = t2
t2.Type = "Connection"
function t2.Disconnect(p1) --[[ Disconnect | Line: 95 ]]
	p1.Previous.Next = p1.Next
	p1.Next.Previous = p1.Previous
end

return Constructor