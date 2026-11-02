local Client = require(script.Parent)
local Util = require(script.Parent.Parent.Util)

local ClientComm = {}
ClientComm.__index = ClientComm

function ClientComm.new(parent, usePromise, namespace)
	assert(not Util.IsServer, "ClientComm must be constructed from the client")
	assert(typeof(parent) == "Instance", "Parent must be of type Instance")
	
	local folderName = namespace or Util.DefaultCommFolderName
	local folder = parent:WaitForChild(folderName, Util.WaitForChildTimeout)
	assert(folder, "Could not find namespace for ClientComm in parent: " .. folderName)
	
	local self = setmetatable({}, ClientComm)
	self._instancesFolder = folder
	self._usePromise = usePromise
	return self
end

function ClientComm:GetFunction(name, inbound, outbound)
	return Client.GetFunction(self._instancesFolder, name, self._usePromise, inbound, outbound)
end

function ClientComm:GetSignal(name, inbound, outbound)
	return Client.GetSignal(self._instancesFolder, name, inbound, outbound)
end

function ClientComm:GetProperty(name, inbound, outbound)
	return Client.GetProperty(self._instancesFolder, name, inbound, outbound)
end

function ClientComm:BuildObject(inbound, outbound)
	local obj = {}
	
	-- Use FindFirstChild (instant) — server creates these folders during Knit.Start()
	-- which completes before any client script runs. No need to wait.
	local rfFolder = self._instancesFolder:FindFirstChild("RF")
	local reFolder = self._instancesFolder:FindFirstChild("RE")
	local rpFolder = self._instancesFolder:FindFirstChild("RP")
	
	if rfFolder then
		for _, rf in rfFolder:GetChildren() do
			if rf:IsA("RemoteFunction") then
				local fn = self:GetFunction(rf.Name, inbound, outbound)
				obj[rf.Name] = function(_self, ...)
					return fn(...)
				end
			end
		end
	end
	
	if reFolder then
		for _, re in reFolder:GetChildren() do
			if re:IsA("RemoteEvent") or re:IsA("UnreliableRemoteEvent") then
				obj[re.Name] = self:GetSignal(re.Name, inbound, outbound)
			end
		end
	end
	
	if rpFolder then
		for _, rp in rpFolder:GetChildren() do
			if rp:IsA("RemoteEvent") then
				obj[rp.Name] = self:GetProperty(rp.Name, inbound, outbound)
			end
		end
	end
	
	return obj
end

function ClientComm:Destroy()
end

return ClientComm
