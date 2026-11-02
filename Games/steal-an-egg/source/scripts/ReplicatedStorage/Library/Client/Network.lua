-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")

assert(RunService:IsClient())

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = ReplicatedStorage:WaitForChild("Network", 99999999)
local NETWORK_MAP = require(ReplicatedStorage.Library.Globals.Constants).NETWORK_MAP
local t = {}
local t2 = {
	{},
	{},
	{},
	{},
	{},
	{}
}
local t3 = { "BindableEvent", "BindableFunction", "BindableEvent", "BindableEvent", "BindableFunction", "BindableEvent" }
local t4 = {
	{},
	{},
	{}
}
local t5 = { "RemoteEvent", "RemoteFunction", "UnreliableRemoteEvent" }

for i, v in ipairs({ "ProfileFunction: Reset", "ProfileFunction: Print" }) do
	t[v] = true
end

local t6 = { function(p1, p2) --[[ Line: 23 ]]
		local v1 = _bindable(1, p1, false)

		if v1 then
			p2.OnClientEvent:Connect(function(...) --[[ Line: 27 | Upvalues: v1 (copy) ]]
				v1:Fire(...)
			end)
		end

		local v2 = _bindable(4, p1, false)

		if not v2 then
			return
		end

		v2.Event:Connect(function(...) --[[ Line: 33 | Upvalues: p2 (copy) ]]
			p2:FireServer(...)
		end)
	end, function(p1, p2) --[[ Line: 39 ]]
		local v1 = _bindable(2, p1, false)

		if v1 then
			function p2.OnClientInvoke(...) --[[ OnClientInvoke | Line: 43 | Upvalues: v1 (copy) ]]
				return v1:Invoke(...)
			end
		end

		local v2 = _bindable(5, p1, false)

		if not v2 then
			return
		end

		function v2.OnInvoke(...) --[[ OnInvoke | Line: 49 | Upvalues: p2 (copy) ]]
			return p2:InvokeServer(...)
		end
	end, function(p1, p2) --[[ Line: 55 ]]
		local v1 = _bindable(3, p1, false)

		if v1 then
			p2.OnClientEvent:Connect(function(...) --[[ Line: 59 | Upvalues: v1 (copy) ]]
				v1:Fire(...)
			end)
		end

		local v2 = _bindable(6, p1, false)

		if not v2 then
			return
		end

		v2.Event:Connect(function(...) --[[ Line: 65 | Upvalues: p2 (copy) ]]
			p2:FireServer(...)
		end)
	end }

local function getName(p1, p2) --[[ getName | Line: 72 ]]
	return p2
end

function _bindable(p1, p2, p3) --[[ _bindable | Line: 76 | Upvalues: t2 (copy), t3 (copy) ]]
	local v1 = t2[p1]
	local v2 = v1[p2]

	if not v2 and p3 then
		local v3 = Instance.new(t3[p1])

		v3.Name = p2
		v3.Parent = script
		v1[p2] = v3
		v2 = v3
	end

	return v2
end
function _bindableEventRx(p1) --[[ _bindableEventRx | Line: 88 ]]
	return _bindable(1, p1, true)
end
function _bindableEventTx(p1) --[[ _bindableEventTx | Line: 92 ]]
	return _bindable(4, p1, true)
end
function _bindableFunctionRx(p1) --[[ _bindableFunctionRx | Line: 96 ]]
	return _bindable(2, p1, true)
end
function _bindableFunctionTx(p1) --[[ _bindableFunctionTx | Line: 100 ]]
	return _bindable(5, p1, true)
end
function _bindableUnreliableEventRx(p1) --[[ _bindableUnreliableEventRx | Line: 104 ]]
	return _bindable(3, p1, true)
end
function _bindableUnreliableEventTx(p1) --[[ _bindableUnreliableEventTx | Line: 108 ]]
	return _bindable(6, p1, true)
end
function onChildAdded(p1) --[[ onChildAdded | Line: 112 | Upvalues: t4 (copy), t5 (copy), t6 (copy) ]]
	for k, v in pairs(t4) do
		if p1:IsA(t5[k]) then
			local v1 = p1.Name

			if v[v1] == nil then
				v[v1] = p1
				t6[k](v1, p1)

				return
			end

			break
		end
	end
end
function _remote(p1, p2) --[[ _remote | Line: 127 | Upvalues: t4 (copy), Network (copy), t6 (copy) ]]
	local v1 = t4[p1]
	local v2 = v1[p2]

	if not v2 then
		local v3 = Network:FindFirstChild(p2)

		if not v3 then
			return nil
		end

		v1[p2] = v3
		t6[p1](p2, v3)
		v2 = v3
	end

	return v2
end
function _remoteEvent(p1) --[[ _remoteEvent | Line: 141 ]]
	return _remote(1, p1)
end
function _remoteFunction(p1) --[[ _remoteFunction | Line: 145 ]]
	return _remote(2, p1)
end
function _unreliableRemoteEvent(p1) --[[ _unreliableRemoteEvent | Line: 149 ]]
	return _remote(3, p1)
end

local t7 = {
	NET_MAP = NETWORK_MAP,
	Fire = function(p1, ...) --[[ Fire | Line: 155 ]]
		local v1 = _remoteEvent(p1)

		if v1 then
			task.spawn(function(...) --[[ Line: 158 | Upvalues: v1 (copy) ]]
				v1:FireServer(...)
			end, ...)
		else
			local v2 = _bindableEventTx(p1)

			task.spawn(function(...) --[[ Line: 163 | Upvalues: v2 (copy) ]]
				v2:Fire(...)
			end, ...)
		end
	end,
	Fired = function(p1) --[[ Fired | Line: 169 ]]
		local v1 = _remoteEvent(p1)

		if v1 then
			return v1.OnClientEvent
		end

		return _bindableEventRx(p1).Event
	end,
	UnreliableFire = function(p1, ...) --[[ UnreliableFire | Line: 178 ]]
		local v1 = _unreliableRemoteEvent(p1)

		if v1 then
			task.spawn(function(...) --[[ Line: 181 | Upvalues: v1 (copy) ]]
				v1:FireServer(...)
			end, ...)
		else
			local v2 = _bindableUnreliableEventTx(p1)

			task.spawn(function(...) --[[ Line: 186 | Upvalues: v2 (copy) ]]
				v2:Fire(...)
			end, ...)
		end
	end,
	UnreliableFired = function(p1) --[[ UnreliableFired | Line: 192 ]]
		local v1 = _unreliableRemoteEvent(p1)

		if v1 then
			return v1.OnClientEvent
		end

		return _bindableUnreliableEventRx(p1).Event
	end,
	Invoke = function(p1, ...) --[[ Invoke | Line: 201 ]]
		local v1 = _remoteFunction(p1)

		if v1 then
			return v1:InvokeServer(...)
		end

		return _bindableFunctionTx(p1):Invoke(...)
	end,
	Invoked = function(p1) --[[ Invoked | Line: 215 ]]
		if _bindable(2, p1, false) then
			return _bindableFunctionRx(p1)
		end

		local v1 = _remoteFunction(p1)

		if v1 then
			return setmetatable({}, {
				__newindex = function(p1, p2, p3) --[[ __newindex | Line: 223 | Upvalues: v1 (copy) ]]
					if p2 == "OnInvoke" then
						v1.OnClientInvoke = p3
					else
						error("\'" .. tostring(p2) .. "\' is not a valid member of NetworkFunction")
					end
				end,
				__index = function(p1, p2) --[[ __index | Line: 230 | Upvalues: v1 (copy) ]]
					if p2 == "OnInvoke" then
						return v1.OnClientInvoke
					end

					error("\'" .. tostring(p2) .. "\' is not a valid member of NetworkFunction")
				end
			})
		end

		return _bindableFunctionRx(p1)
	end
}

Network.ChildAdded:Connect(onChildAdded)

for i, v in ipairs(Network:GetChildren()) do
	onChildAdded(v)
end

return t7