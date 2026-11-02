local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Packages.DataService)
local client = DataService.client

local function waitForClientData(timeout)
	local t = 0
	while client._data == nil and t < timeout do
		task.wait(0.05)
		t += 0.05
	end
	return client._data ~= nil
end

if client._data == nil then
	local packagesIndex = ReplicatedStorage.Packages._Index
	local remoteFunc = nil
	for _, version in ipairs({"leifstout_networker@0.2.1", "leifstout_networker@0.3.1"}) do
		local nw = packagesIndex:FindFirstChild(version)
		if nw then
			local mod = nw:FindFirstChild("networker")
			if mod then
				local rem = mod:FindFirstChild("_remotes")
				if rem then
					local ds = rem:FindFirstChild("DataService")
					if ds then
						local rf = ds:FindFirstChild("RemoteFunction")
						if rf then
							remoteFunc = rf
							break
						end
					end
				end
			end
		end
	end
	if remoteFunc then
		local ok, result = pcall(function()
			return remoteFunc:InvokeServer("get", nil)
		end)
		if ok and type(result) == "table" and client._data == nil then
			local elapsed = 0
			while client.networker == nil and elapsed < 10 do
				task.wait(0.05)
				elapsed += 0.05
			end
			if client._data == nil then
				client:_initData(result)
			end
		end
	end
end

task.spawn(function()
	local relay = ReplicatedStorage:WaitForChild("DSRelay", 30)
	if not relay then return end
	if not waitForClientData(30) then return end
	relay.OnClientEvent:Connect(function(action, path, value, extra)
		if client._data == nil then return end
		if action == 1 then
			pcall(function() client._data:set(path, value) end)
		elseif action == 2 then
			pcall(function() client._data:arrayInsert(path, value, extra) end)
		elseif action == 3 then
			pcall(function() client._data:arrayRemove(path, value) end)
		elseif action == 0 then
			if client._data == nil then
				pcall(function() client:_initData(path) end)
			end
		end
	end)
end)