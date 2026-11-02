-- Reference copy for study. Game: Aura Ascension (UPD 3) (aura-ascension)
-- Original: ServerScriptService/GameServer/Core/RemoteBinder.lua  (88 lines)
-- What it does: Creates RF/RE folders per service on demand (Knit-style layout) and binds functions / fires events by service + name.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteBinder = {}
RemoteBinder.__index = RemoteBinder

function RemoteBinder.new()
	local servicesRoot = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
	return setmetatable({
		ServicesRoot = servicesRoot,
		Cache = {},
	}, RemoteBinder)
end

function RemoteBinder:_getOrCreateServiceFolder(serviceName)
	local folder = self.ServicesRoot:FindFirstChild(serviceName)
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = serviceName
		folder.Parent = self.ServicesRoot
	end

	local rfFolder = folder:FindFirstChild("RF")
	if not rfFolder then
		rfFolder = Instance.new("Folder")
		rfFolder.Name = "RF"
		rfFolder.Parent = folder
	end

	local reFolder = folder:FindFirstChild("RE")
	if not reFolder then
		reFolder = Instance.new("Folder")
		reFolder.Name = "RE"
		reFolder.Parent = folder
	end

	return {
		Folder = folder,
		RF = rfFolder,
		RE = reFolder,
	}
end

function RemoteBinder:_getServiceFolder(serviceName)
	local cached = self.Cache[serviceName]
	if cached then
		return cached
	end

	local serviceFolder = self:_getOrCreateServiceFolder(serviceName)
	self.Cache[serviceName] = serviceFolder
	return serviceFolder
end

function RemoteBinder:GetFunction(serviceName, functionName)
	local serviceFolder = self:_getServiceFolder(serviceName)
	local remote = serviceFolder.RF:FindFirstChild(functionName)
	if not remote then
		remote = Instance.new("RemoteFunction")
		remote.Name = functionName
		remote.Parent = serviceFolder.RF
	end
	return remote
end

function RemoteBinder:GetEvent(serviceName, eventName)
	local serviceFolder = self:_getServiceFolder(serviceName)
	local remote = serviceFolder.RE:FindFirstChild(eventName)
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = eventName
		remote.Parent = serviceFolder.RE
	end
	return remote
end

function RemoteBinder:BindFunction(serviceName, functionName, callback)
	self:GetFunction(serviceName, functionName).OnServerInvoke = callback
end

function RemoteBinder:FireClient(serviceName, eventName, player, ...)
	self:GetEvent(serviceName, eventName):FireClient(player, ...)
end

function RemoteBinder:FireAll(serviceName, eventName, ...)
	self:GetEvent(serviceName, eventName):FireAllClients(...)
end

return RemoteBinder
