-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("RunService")
return {
	["UnreliableRemoteEvent"] = function(_, p2)
		-- upvalues: (copy) v_u_1
		local v3 = "URE/" .. p2
		if v_u_1:IsServer() then
			local v4 = script:FindFirstChild(v3)
			if not v4 then
				v4 = Instance.new("UnreliableRemoteEvent")
				v4.Name = v3
				v4.Parent = script
			end
			return v4
		else
			local v5 = script:WaitForChild(v3, 10)
			if not v5 then
				error("Failed to find UnreliableRemoteEvent: " .. v3, 2)
			end
			return v5
		end
	end,
	["RemoteEvent"] = function(_, p6)
		-- upvalues: (copy) v_u_1
		local v7 = "RE/" .. p6
		if v_u_1:IsServer() then
			local v8 = script:FindFirstChild(v7)
			if not v8 then
				v8 = Instance.new("RemoteEvent")
				v8.Name = v7
				v8.Parent = script
			end
			return v8
		else
			local v9 = script:WaitForChild(v7, 10)
			if not v9 then
				error("Failed to find RemoteEvent: " .. v7, 2)
			end
			return v9
		end
	end,
	["ConnectUnreliable"] = function(p10, p11, p12)
		-- upvalues: (copy) v_u_1
		if v_u_1:IsServer() then
			return p10:UnreliableRemoteEvent(p11).OnServerEvent:Connect(p12)
		else
			return p10:UnreliableRemoteEvent(p11).OnClientEvent:Connect(p12)
		end
	end,
	["Connect"] = function(p13, p14, p15)
		-- upvalues: (copy) v_u_1
		if v_u_1:IsServer() then
			return p13:RemoteEvent(p14).OnServerEvent:Connect(p15)
		else
			return p13:RemoteEvent(p14).OnClientEvent:Connect(p15)
		end
	end,
	["RemoteFunction"] = function(_, p16)
		-- upvalues: (copy) v_u_1
		local v17 = "RF/" .. p16
		if v_u_1:IsServer() then
			local v18 = script:FindFirstChild(v17)
			if not v18 then
				v18 = Instance.new("RemoteFunction")
				v18.Name = v17
				v18.Parent = script
			end
			return v18
		else
			local v19 = script:WaitForChild(v17, 10)
			if not v19 then
				error("Failed to find RemoteFunction: " .. v17, 2)
			end
			return v19
		end
	end,
	["Handle"] = function(p20, p21, p22)
		p20:RemoteFunction(p21).OnServerInvoke = p22
	end,
	["Invoke"] = function(p23, p24, ...)
		return p23:RemoteFunction(p24):InvokeServer(...)
	end,
	["Clean"] = function(_)
		script:ClearAllChildren()
	end
}
