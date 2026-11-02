local Signal = require(script.Parent.Parent.Parent.Signal)

local RemoteSignal = {}
RemoteSignal.__index = RemoteSignal

function RemoteSignal.new(parent, name, unreliable, inbound, outbound)
	local self = setmetatable({}, RemoteSignal)
	
	if unreliable == true then
		self._re = Instance.new("UnreliableRemoteEvent")
	else
		self._re = Instance.new("RemoteEvent")
	end
	self._re.Name = name
	self._re.Parent = parent
	
	-- Outbound middleware
	if type(outbound) == "table" and #outbound > 0 then
		self._hasOutbound = true
		self._outbound = outbound
	else
		self._hasOutbound = false
	end
	
	-- Inbound middleware
	if type(inbound) == "table" and #inbound > 0 then
		self._directConnect = false
		self._signal = Signal.new()
		self._re.OnServerEvent:Connect(function(player, ...)
			local args = table.pack(...)
			for _, mwFn in inbound do
				if not table.pack(mwFn(player, args))[1] then return end
				args.n = #args
			end
			self._signal:Fire(player, table.unpack(args, 1, args.n))
		end)
	else
		self._directConnect = true
	end
	
	return self
end

function RemoteSignal:IsUnreliable()
	return self._re:IsA("UnreliableRemoteEvent")
end

function RemoteSignal:Connect(fn)
	if self._directConnect then
		return self._re.OnServerEvent:Connect(fn)
	end
	return self._signal:Connect(fn)
end

function RemoteSignal:_processOutboundMiddleware(player, ...)
	if not self._hasOutbound then
		return ...
	end
	local args = table.pack(...)
	for _, mwFn in self._outbound do
		local result = table.pack(mwFn(player, args))
		if not result[1] then
			return table.unpack(result, 2, result.n)
		end
		args.n = #args
	end
	return table.unpack(args, 1, args.n)
end

function RemoteSignal:Fire(player, ...)
	self._re:FireClient(player, self:_processOutboundMiddleware(player, ...))
end

function RemoteSignal:FireAll(...)
	self._re:FireAllClients(self:_processOutboundMiddleware(nil, ...))
end

function RemoteSignal:FireExcept(player, ...)
	self:FireFilter(function(p) return p ~= player end, ...)
end

function RemoteSignal:FireFilter(predicate, ...)
	for _, player in game:GetService("Players"):GetPlayers() do
		if predicate(player, ...) then
			self._re:FireClient(player, self:_processOutboundMiddleware(nil, ...))
		end
	end
end

function RemoteSignal:FireFor(players, ...)
	for _, player in players do
		self._re:FireClient(player, self:_processOutboundMiddleware(nil, ...))
	end
end

function RemoteSignal:Destroy()
	self._re:Destroy()
	if self._signal then
		self._signal:Destroy()
	end
end

return RemoteSignal
