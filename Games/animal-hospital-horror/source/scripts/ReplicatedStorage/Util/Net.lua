local RunService = game:GetService("RunService")
local t = {
	RemoteEvent = function(p1, p2, p3) --[[ RemoteEvent | Line: 25 | Upvalues: RunService (copy) ]]
		local v1 = "RE/" .. p2

		if not RunService:IsServer() then
			task.spawn(function() --[[ Line: 36 | Upvalues: v1 (copy), p2 (copy), p3 (copy) ]]
				if not script:FindFirstChild(v1) then
					script:WaitForChild("RE/RequestRemoteEvent"):FireServer(p2)
				end

				local v12 = script:WaitForChild(v1, 10)

				if not v12 then
					error("Failed to find RemoteEvent: " .. v1, 2)
				end

				if p3 then
					v12.OnClientEvent:Connect(p3)
				end

				return v12
			end)

			return
		end

		local v2 = script:FindFirstChild(v1)

		if not v2 then
			local v3 = Instance.new("RemoteEvent")

			v3.Name = v1
			v3.Parent = script
			v2 = v3
		end

		return v2
	end,
	FindRemoteEvent = function(p1, p2) --[[ FindRemoteEvent | Line: 51 ]]
		return script:FindFirstChild("RE/" .. p2)
	end,
	FireClient = function(p1, p2, p3, ...) --[[ FireClient | Line: 56 ]]
		p1:RemoteEvent(p3):FireClient(p2, ...)
	end,
	FireAllClients = function(p1, p2, ...) --[[ FireAllClients | Line: 64 ]]
		p1:RemoteEvent(p2):FireAllClients(...)
	end,
	FireAllClientsWithinDistance = function(p1, p2, p3, p4, ...) --[[ FireAllClientsWithinDistance | Line: 72 ]]
		for i, v in ipairs(game.Players:GetPlayers()) do
			if v.Character and (v.Character.PrimaryPart and ((v.Character.PrimaryPart.Position - p3) * Vector3.new(1, 0, 1)).Magnitude <= p4) then
				p1:RemoteEvent(p2):FireClient(v, ...)
			end
		end
	end,
	FireServer = function(p1, p2, ...) --[[ FireServer | Line: 86 ]]
		local v1 = nil
		local t = { ... }

		while not v1 do
			local ok, _ = pcall(function() --[[ Line: 94 | Upvalues: p1 (copy), p2 (copy), t (copy) ]]
				p1:FindRemoteEvent(p2):FireServer(table.unpack(t))
			end)

			if ok then
				v1 = ok

				continue
			end

			task.wait()
			v1 = ok
		end
	end,
	UnreliableRemoteEvent = function(p1, p2) --[[ UnreliableRemoteEvent | Line: 116 | Upvalues: RunService (copy) ]]
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
	Connect = function(p1, p2, p3) --[[ Connect | Line: 148 | Upvalues: RunService (copy) ]]
		if RunService:IsServer() then
			return p1:RemoteEvent(p2).OnServerEvent:Connect(p3)
		end

		return p1:RemoteEvent(p2, p3)
	end,
	ConnectUnreliable = function(p1, p2, p3) --[[ ConnectUnreliable | Line: 169 | Upvalues: RunService (copy) ]]
		if RunService:IsServer() then
			return p1:UnreliableRemoteEvent(p2).OnServerEvent:Connect(p3)
		end

		return p1:UnreliableRemoteEvent(p2).OnClientEvent:Connect(p3)
	end,
	RemoteFunction = function(p1, p2) --[[ RemoteFunction | Line: 192 | Upvalues: RunService (copy) ]]
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
	Handle = function(p1, p2, p3) --[[ Handle | Line: 221 ]]
		p1:RemoteFunction(p2).OnServerInvoke = p3
	end,
	Invoke = function(p1, p2, ...) --[[ Invoke | Line: 233 ]]
		return p1:RemoteFunction(p2):InvokeServer(...)
	end,
	InvokeServer = function(p1, p2, ...) --[[ InvokeServer | Line: 237 ]]
		return p1:RemoteFunction(p2):InvokeServer(...)
	end,
	Clean = function(p1) --[[ Clean | Line: 247 ]]
		script:ClearAllChildren()
	end,
	BindFunctions = function(p1, p2) --[[ BindFunctions | Line: 251 ]]
		for k, v in pairs(p2) do
			p1:Handle(k, v)
		end
	end,
	BindEvents = function(p1, p2) --[[ BindEvents | Line: 272 ]]
		for k, v in pairs(p2) do
			p1:Connect(k, v)
		end
	end
}

if RunService:IsServer() then
	t:BindEvents({
		RequestRemoteEvent = function(p1, p2) --[[ RequestRemoteEvent | Line: 295 | Upvalues: t (copy) ]]
			t:RemoteEvent(p2)
		end,
		RequestRemoteFunction = function(p1, p2) --[[ RequestRemoteFunction | Line: 299 | Upvalues: t (copy) ]]
			t:RemoteFunction(p2)
		end
	})
end

return t