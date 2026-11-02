-- Signal module (sleitnick-compatible)
-- Clean implementation with free thread pool pattern
-- API: Signal.new(), Signal.Wrap(), Signal.Is()

local Signal = {}
Signal.__index = Signal

local Connection = {}
Connection.__index = Connection

-- Free thread pool for coroutine reuse
local freeThreads = {}

local function runCallback(thread, fn, ...)
	fn(...)
	table.insert(freeThreads, thread)
end

local function acquireThread()
	if #freeThreads > 0 then
		return table.remove(freeThreads)
	end
	local thread
	thread = coroutine.create(function(fn, ...)
		runCallback(thread, fn, ...)
		while true do
			runCallback(coroutine.yield())
		end
	end)
	return thread
end

local function fireInThread(fn, ...)
	local thread = acquireThread()
	coroutine.resume(thread, fn, ...)
end

-- Connection implementation

function Connection.new(signal, fn)
	local self = setmetatable({}, Connection)
	self._signal = signal
	self._fn = fn
	self.Connected = true
	return self
end

function Connection:Disconnect()
	if not self.Connected then return end
	self.Connected = false
	local signal = self._signal
	local node = signal._head
	local prev = nil
	while node do
		if node == self then
			if prev then
				prev._next = node._next
			else
				signal._head = node._next
			end
			break
		end
		prev = node
		node = node._next
	end
	self._signal = nil
	self._fn = nil
end

function Connection:Destroy()
	self:Disconnect()
end

-- Signal implementation

function Signal.new()
	local self = setmetatable({}, Signal)
	self._head = nil
	return self
end

function Signal.Is(obj)
	return type(obj) == "table" and getmetatable(obj) == Signal
end

function Signal.Wrap(rbxSignal)
	local sig = Signal.new()
	rbxSignal:Connect(function(...)
		sig:Fire(...)
	end)
	return sig
end

function Signal:Connect(fn)
	local conn = Connection.new(self, fn)
	conn._next = self._head
	self._head = conn
	return conn
end

function Signal:Once(fn)
	local conn
	conn = self:Connect(function(...)
		if conn.Connected then
			conn:Disconnect()
		end
		fn(...)
	end)
	return conn
end

-- Alias
Signal.ConnectOnce = Signal.Once

function Signal:Fire(...)
	local node = self._head
	while node do
		local next = node._next
		if node.Connected then
			fireInThread(node._fn, ...)
		end
		node = next
	end
end

function Signal:FireDeferred(...)
	local args = {...}
	task.defer(function()
		self:Fire(table.unpack(args))
	end)
end

function Signal:Wait()
	local thread = coroutine.running()
	local conn
	conn = self:Once(function(...)
		task.spawn(thread, ...)
	end)
	return coroutine.yield()
end

function Signal:GetConnections()
	local result = {}
	local node = self._head
	while node do
		if node.Connected then
			table.insert(result, node)
		end
		node = node._next
	end
	return result
end

function Signal:DisconnectAll()
	local node = self._head
	while node do
		node.Connected = false
		node._signal = nil
		node._fn = nil
		node = node._next
	end
	self._head = nil
end

function Signal:Destroy()
	self:DisconnectAll()
end

return table.freeze({
	new = function(...) return Signal.new(...) end,
	Wrap = function(...) return Signal.Wrap(...) end,
	Is = function(...) return Signal.Is(...) end,
})
