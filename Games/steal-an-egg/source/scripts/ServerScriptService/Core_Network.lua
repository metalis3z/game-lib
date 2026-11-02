--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = {}
local folder = ReplicatedStorage:FindFirstChild("Network")
if not folder then
	folder = Instance.new("Folder")
	folder.Name = "Network"
	folder.Parent = ReplicatedStorage
end

local function getRemote(name: string, className: string): Instance
	local remote = folder:FindFirstChild(name)
	if remote then
		assert(remote.ClassName == className, ("Remote %q is %s, expected %s"):format(name, remote.ClassName, className))
		return remote
	end

	remote = Instance.new(className)
	remote.Name = name
	remote.Parent = folder
	return remote
end

function Network.GetEvent(name: string): RemoteEvent
	return getRemote(name, "RemoteEvent") :: RemoteEvent
end

function Network.GetFunction(name: string): RemoteFunction
	return getRemote(name, "RemoteFunction") :: RemoteFunction
end

function Network.BindEvent(name: string, handler: (Player, ...any) -> ())
	local remote = Network.GetEvent(name)
	return remote.OnServerEvent:Connect(function(player, ...)
		local args = table.pack(...)
		local ok, err = xpcall(function()
			handler(player, table.unpack(args, 1, args.n))
		end, debug.traceback)
		if not ok then
			warn(("[Server:%s] %s"):format(name, tostring(err)))
		end
	end)
end

function Network.BindFunction(name: string, handler: (Player, ...any) -> ...any)
	local remote = Network.GetFunction(name)
	remote.OnServerInvoke = function(player, ...)
		local args = table.pack(...)
		local result = table.pack(xpcall(function()
			return handler(player, table.unpack(args, 1, args.n))
		end, debug.traceback))
		if not result[1] then
			warn(("[Server:%s] %s"):format(name, tostring(result[2])))
			return false, "The server could not complete that request."
		end
		return table.unpack(result, 2, result.n)
	end
	return remote
end

function Network.FireClient(name: string, player: Player, ...: any)
	Network.GetEvent(name):FireClient(player, ...)
end

function Network.FireAll(name: string, ...: any)
	Network.GetEvent(name):FireAllClients(...)
end

return Network
