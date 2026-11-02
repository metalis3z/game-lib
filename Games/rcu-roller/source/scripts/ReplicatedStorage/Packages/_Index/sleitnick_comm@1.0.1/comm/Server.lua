local Util = require(script.Parent.Util)
local RemoteSignal = require(script.RemoteSignal)
local RemoteProperty = require(script.RemoteProperty)

local Server = {}

local function hasMiddleware(mw)
	return type(mw) == "table" and #mw > 0
end

function Server.BindFunction(parent, name, fn, inbound, outbound)
	assert(Util.IsServer, "BindFunction must be called from the server")
	local folder = Util.GetCommSubFolder(parent, "RF"):Expect("Failed to get Comm RF folder")
	local rf = Instance.new("RemoteFunction")
	rf.Name = name

	local hasIn = hasMiddleware(inbound)
	local hasOut = hasMiddleware(outbound)

	local function processOutbound(player, ...)
		local args = table.pack(...)
		for _, mwFn in ipairs(outbound) do
			local result = table.pack(mwFn(player, args))
			if not result[1] then
				return table.unpack(result, 2, result.n)
			end
			args.n = #args
		end
		return table.unpack(args, 1, args.n)
	end

	if hasIn and hasOut then
		function rf.OnServerInvoke(player, ...)
			local args = table.pack(...)
			for _, mwFn in ipairs(inbound) do
				local result = table.pack(mwFn(player, args))
				if not result[1] then
					return table.unpack(result, 2, result.n)
				end
				args.n = #args
			end
			return processOutbound(player, fn(player, table.unpack(args, 1, args.n)))
		end
	elseif hasIn then
		function rf.OnServerInvoke(player, ...)
			local args = table.pack(...)
			for _, mwFn in ipairs(inbound) do
				local result = table.pack(mwFn(player, args))
				if not result[1] then
					return table.unpack(result, 2, result.n)
				end
				args.n = #args
			end
			return fn(player, table.unpack(args, 1, args.n))
		end
	elseif hasOut then
		function rf.OnServerInvoke(player, ...)
			return processOutbound(player, fn(player, ...))
		end
	else
		rf.OnServerInvoke = fn
	end

	rf.Parent = folder
	return rf
end

function Server.WrapMethod(parent, tbl, name, inbound, outbound)
	assert(Util.IsServer, "WrapMethod must be called from the server")
	local method = tbl[name]
	assert(type(method) == "function", "Value at index " .. name .. " must be a function; got " .. type(method))
	return Server.BindFunction(parent, name, function(...)
		return method(tbl, ...)
	end, inbound, outbound)
end

function Server.CreateSignal(parent, name, unreliable, inbound, outbound)
	assert(Util.IsServer, "CreateSignal must be called from the server")
	return RemoteSignal.new(
		Util.GetCommSubFolder(parent, "RE"):Expect("Failed to get Comm RE folder"),
		name, unreliable, inbound, outbound
	)
end

function Server.CreateProperty(parent, name, initialValue, inbound, outbound)
	assert(Util.IsServer, "CreateProperty must be called from the server")
	return RemoteProperty.new(
		Util.GetCommSubFolder(parent, "RP"):Expect("Failed to get Comm RP folder"),
		name, initialValue, inbound, outbound
	)
end

return Server
