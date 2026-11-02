-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

return {
	RemoteEvent = function(p1, p2) --[[ RemoteEvent | Line: 25 | Upvalues: RunService (copy) ]]
		local v1 = "RE/" .. p2

		if RunService:IsServer() then
			local v2 = script:FindFirstChild(v1)

			if not v2 then
				local v3 = Instance.new("RemoteEvent")

				v3.Name = v1
				v3.Parent = script
				v2 = v3
			end

			return v2
		end

		local v4 = script:WaitForChild(v1, 10)

		if v4 then
			return v4
		end

		error("Failed to find RemoteEvent: " .. v1, 2)
	end,
	UnreliableRemoteEvent = function(p1, p2) --[[ UnreliableRemoteEvent | Line: 59 | Upvalues: RunService (copy) ]]
		local v1 = "URE/" .. p2

		if RunService:IsServer() then
			local v2 = script:FindFirstChild(v1)

			if not v2 then
				local UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent")

				UnreliableRemoteEvent.Name = v1
				UnreliableRemoteEvent.Parent = script
				v2 = UnreliableRemoteEvent
			end

			return v2
		end

		local v3 = script:WaitForChild(v1, 10)

		if v3 then
			return v3
		end

		error("Failed to find UnreliableRemoteEvent: " .. v1, 2)
	end,
	Connect = function(p1, p2, p3) --[[ Connect | Line: 91 | Upvalues: RunService (copy) ]]
		if RunService:IsServer() then
			return p1:RemoteEvent(p2).OnServerEvent:Connect(p3)
		end

		return p1:RemoteEvent(p2).OnClientEvent:Connect(p3)
	end,
	ConnectUnreliable = function(p1, p2, p3) --[[ ConnectUnreliable | Line: 112 | Upvalues: RunService (copy) ]]
		if RunService:IsServer() then
			return p1:UnreliableRemoteEvent(p2).OnServerEvent:Connect(p3)
		end

		return p1:UnreliableRemoteEvent(p2).OnClientEvent:Connect(p3)
	end,
	RemoteFunction = function(p1, p2) --[[ RemoteFunction | Line: 135 | Upvalues: RunService (copy) ]]
		local v1 = "RF/" .. p2

		if RunService:IsServer() then
			local v2 = script:FindFirstChild(v1)

			if not v2 then
				local v3 = Instance.new("RemoteFunction")

				v3.Name = v1
				v3.Parent = script
				v2 = v3
			end

			return v2
		end

		local v4 = script:WaitForChild(v1, 10)

		if v4 then
			return v4
		end

		error("Failed to find RemoteFunction: " .. v1, 2)
	end,
	Handle = function(p1, p2, p3) --[[ Handle | Line: 164 ]]
		p1:RemoteFunction(p2).OnServerInvoke = p3
	end,
	Invoke = function(p1, p2, ...) --[[ Invoke | Line: 176 ]]
		return p1:RemoteFunction(p2):InvokeServer(...)
	end,
	Clean = function(p1) --[[ Clean | Line: 186 ]]
		script:ClearAllChildren()
	end
}