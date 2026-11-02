--credit to leon games studio
local v1 = nil

local function AcquireRunnerThreadAndCallEventHandler(p1, ...) --[[ AcquireRunnerThreadAndCallEventHandler | Line: 42 | Upvalues: v1 (ref) ]]
	local v12 = v1

	v1 = nil
	p1(...)
	v1 = v12
end

local function RunEventHandlerInFreeThread(...) --[[ RunEventHandlerInFreeThread | Line: 50 | Upvalues: AcquireRunnerThreadAndCallEventHandler (copy) ]]
	AcquireRunnerThreadAndCallEventHandler(...)

	while true do
		AcquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local t = {}

t.__index = t

local t2 = {}

t2.__index = t2
function t.Disconnect(p1) --[[ Disconnect | Line: 77 ]]
	if p1.IsConnected == false then
		return
	end

	local signal = p1.signal

	p1.IsConnected = false

	if signal.head == p1 then
		signal.head = p1.next

		return
	end

	local head = signal.head

	while head ~= nil and head.next ~= p1 do
		head = head.next
	end

	if head == nil then
		return
	end

	head.next = p1.next
end
function t2.New() --[[ New | Line: 100 | Upvalues: t2 (copy) ]]
	local t = {
		head = nil
	}

	setmetatable(t, t2)

	return t
end
function t2.Connect(p1, p2) --[[ Connect | Line: 111 | Upvalues: t (copy) ]]
	if type(p2) ~= "function" then
		error((("[%*]: \"listener\" must be a function; Received %*"):format(script.Name, (typeof(p2)))))
	end

	local t2 = {
		IsConnected = true,
		listener = p2,
		signal = p1,
		next = p1.head
	}

	setmetatable(t2, t)
	p1.head = t2

	return t2
end
function t2.Fire(p1, ...) --[[ Fire | Line: 131 | Upvalues: v1 (ref), RunEventHandlerInFreeThread (copy) ]]
	local head = p1.head

	while head ~= nil do
		if head.IsConnected == true then
			if not v1 then
				v1 = coroutine.create(RunEventHandlerInFreeThread)
			end

			task.spawn(v1, head.listener, ...)
		end

		head = head.next
	end
end
function t2.Wait(p1) --[[ Wait | Line: 144 ]]
	local v1 = coroutine.running()
	local v2 = nil

	v2 = p1:Connect(function(...) --[[ Line: 147 | Upvalues: v2 (ref), v1 (copy) ]]
		v2:Disconnect()
		task.spawn(v1, ...)
	end)

	return coroutine.yield()
end
function t2.FireUntil(p1, p2, ...) --[[ FireUntil | Line: 154 ]]
	if type(p2) ~= "function" then
		error((("[%*]: \"continue_callback\" must be a function; Received %*"):format(script.Name, (typeof(p2)))))
	end

	local v1 = table.pack(...)
	local head = p1.head
	local t = {}

	while head ~= nil do
		table.insert(t, head)
		head = head.next
	end

	task.spawn(function() --[[ Line: 169 | Upvalues: t (copy), v1 (copy), p2 (copy) ]]
		for i, v in ipairs(t) do
			if v.IsConnected == true then
				v.listener(table.unpack(v1))

				if p2() ~= true then
					break
				end
			end
		end
	end)
end

return table.freeze({
	New = t2.New
})