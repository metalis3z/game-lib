--credit to quartz games studio
local Signal = require(script.Signal)
local Task = require(script.Task)
local Types = require(script.Types)
local t = {
	UseBuffers = true,
	DebugOutgoing = false,
	DebugOutgoingInterval = 5,
	DebugOutgoingTop = 10
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Reads = Types.Reads
local Writes = Types.Writes
local Import = Types.Import
local Export = Types.Export
local Truncate = Types.Truncate
local Ended = Types.Ended
local NumberU8 = Reads.NumberU8
local NumberU82 = Writes.NumberU8
local NumberU16 = Reads.NumberU16
local NumberU162 = Writes.NumberU16
local t2 = {}
local t3 = {}
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local t4 = {
	BufferLength = 128,
	BufferOffset = 0,
	InstancesOffset = 0,
	Buffer = buffer.create(128),
	Instances = {}
}
local v11 = nil
local v12 = 0

local function debugOutgoingIncrement(p1) --[[ debugOutgoingIncrement | Line: 52 | Upvalues: t (copy), RunService (copy), v11 (ref), v12 (ref) ]]
	if t.DebugOutgoing ~= true or RunService:IsServer() ~= true then
		return
	end

	local v1 = v11

	if v1 == nil then
		v1 = {}
		v11 = v1
		v12 = os.clock()
	end

	v1[p1] = (v1[p1] or 0) + 1

	local v2 = os.clock()

	if v2 - v12 < (t.DebugOutgoingInterval or 5) then
		return
	end

	v12 = v2

	local t2 = {}

	for v3, v4 in v1 do
		t2[#t2 + 1] = { v3, v4 }
	end

	table.sort(t2, function(p1, p2) --[[ Line: 77 ]]
		return p1[2] > p2[2]
	end)

	local t3 = {}

	for i = 1, math.min(t.DebugOutgoingTop or 10, #t2) do
		local v6 = t2[i]

		t3[#t3 + 1] = v6[1] .. "=" .. tostring(v6[2])
	end

	table.clear(v1)
end

local function Constructor(p1, p2, ...) --[[ Constructor | Line: 93 | Upvalues: t3 (copy), t2 (copy), RunService (copy), v10 (ref), Signal (copy), v9 (ref), v1 (ref) ]]
	local v12 = t3[p2]

	if v12 then
		return v12
	end

	local v3 = setmetatable({}, t2)

	v3.Name = p2

	if RunService:IsServer() then
		v3.Id = v10
		v3.OnServerEvent = Signal()
		v9:SetAttribute(p2, v10)
		t3[v10] = v3
		v10 = v10 + 1
	else
		v3.Id = v9:GetAttribute(p2)
		v3.OnClientEvent = Signal()

		if v3.Id then
			t3[v3.Id] = v3
		end
	end

	local v4, v5 = v1(table.pack(...))

	v3.Reads = v4
	v3.Writes = v5
	t3[v3.Name] = v3

	return v3
end

t2.__index = t2
t2.Type = "Packet"
function t2.Response(p1, ...) --[[ Response | Line: 119 | Upvalues: v1 (ref) ]]
	p1.ResponseTimeout = p1.ResponseTimeout or 10

	local v12, v2 = v1(table.pack(...))

	p1.ResponseReads = v12
	p1.ResponseWrites = v2

	return p1
end
function t2.Fire(p1, ...) --[[ Fire | Line: 125 | Upvalues: t (copy), RunService (copy), v8 (ref), Import (copy), t4 (ref), NumberU162 (copy), NumberU82 (copy), Task (copy), v5 (ref), v4 (ref), Export (copy), v9 (ref) ]]
	if t.UseBuffers then
		if not p1.ResponseReads then
			Import(t4)
			NumberU162(p1.Id)
		else
			if RunService:IsServer() then
				error("You must use FireClient(player)", 2)
			end

			local v1 = nil

			for i = 1, 128 do
				v1 = v8[v8.Index]

				if not v1 then
					break
				end

				v8.Index = (v8.Index + 1) % 128
			end

			if not v1 then
				Import(t4)
				NumberU162(p1.Id)
				NumberU82(v8.Index)
				v8[v8.Index] = {
					Yielded = coroutine.running(),
					Timeout = Task:Delay(p1.ResponseTimeout, v5, v8, v8.Index, p1.ResponseTimeoutValue)
				}
				v8.Index = (v8.Index + 1) % 128
				v4(p1.Writes, { ... })
				t4 = Export()

				return coroutine.yield()
			end

			error("Cannot have more than 128 yielded threads", 2)
		end

		v4(p1.Writes, { ... })
		t4 = Export()
	else
		if not p1.ResponseReads then
			v9:FireServer(p1.Id, ...)

			return
		end

		if RunService:IsServer() then
			error("You must use FireClient(player)", 2)
		end

		local v2 = nil

		for j = 1, 128 do
			v2 = v8[v8.Index]

			if not v2 then
				break
			end

			v8.Index = (v8.Index + 1) % 128
		end

		if not v2 then
			v8[v8.Index] = {
				Yielded = coroutine.running(),
				Timeout = Task:Delay(p1.ResponseTimeout, v5, v8, v8.Index, p1.ResponseTimeoutValue)
			}
			v9:FireServer(p1.Id, v8.Index, ...)
			v8.Index = (v8.Index + 1) % 128

			return coroutine.yield()
		end

		error("Cannot have more than 128 yielded threads", 2)
	end

	-- FIX: un packet SIN Response (fire-and-forget) no debe ceder el hilo. Con
	-- UseBuffers=true el flujo caía aquí y colgaba al llamador para siempre
	-- (rompía cualquier patrón que dependiera de que :Fire retornara, p.ej. el
	-- flag de "compra en curso" de RestockStoreController). Solo se cede si hay
	-- respuesta esperada.
	if not p1.ResponseReads then
		return
	end
	return coroutine.yield()
end
function t2.FireClient(p1, p2, ...) --[[ FireClient | Line: 171 | Upvalues: t (copy), debugOutgoingIncrement (copy), v7 (ref), Import (copy), v6 (ref), NumberU162 (copy), NumberU82 (copy), Task (copy), v5 (ref), v4 (ref), Export (copy), v9 (ref) ]]
	if p2.Parent == nil then
		return
	end

	if t.UseBuffers then
		if p1.ResponseReads then
			debugOutgoingIncrement(p1.Name)

			local v1 = v7[p2]

			if v1 == nil then
				local t2 = {
					Index = 0
				}

				v7[p2] = t2
				v1 = t2
			end

			local v2 = nil

			for i = 1, 128 do
				v2 = v1[v1.Index]

				if not v2 then
					break
				end

				v1.Index = (v1.Index + 1) % 128
			end

			if v2 then
				error("Cannot have more than 128 yielded threads", 2)
			end

			Import(v6[p2] or {
				BufferLength = 128,
				BufferOffset = 0,
				InstancesOffset = 0,
				Buffer = buffer.create(128),
				Instances = {}
			})
			NumberU162(p1.Id)
			NumberU82(v1.Index)
			v1[v1.Index] = {
				Yielded = coroutine.running(),
				Timeout = Task:Delay(p1.ResponseTimeout, v5, v1, v1.Index, p1.ResponseTimeoutValue)
			}
			v1.Index = (v1.Index + 1) % 128
			v4(p1.Writes, { ... })
			v6[p2] = Export()

			return coroutine.yield()
		end

		debugOutgoingIncrement(p1.Name)
		Import(v6[p2] or {
			BufferLength = 128,
			BufferOffset = 0,
			InstancesOffset = 0,
			Buffer = buffer.create(128),
			Instances = {}
		})
		NumberU162(p1.Id)
		v4(p1.Writes, { ... })
		v6[p2] = Export()

		return
	end

	if not p1.ResponseReads then
		debugOutgoingIncrement(p1.Name)
		v9:FireClient(p2, p1.Id, ...)

		return
	end

	debugOutgoingIncrement(p1.Name)

	local v72 = v7[p2]

	if v72 == nil then
		local t2 = {
			Index = 0
		}

		v7[p2] = t2
		v72 = t2
	end

	local v8 = nil

	for j = 1, 128 do
		v8 = v72[v72.Index]

		if not v8 then
			break
		end

		v72.Index = (v72.Index + 1) % 128
	end

	if v8 then
		error("Cannot have more than 128 yielded threads", 2)
	end

	v72[v72.Index] = {
		Yielded = coroutine.running(),
		Timeout = Task:Delay(p1.ResponseTimeout, v5, v72, v72.Index, p1.ResponseTimeoutValue)
	}
	v9:FireClient(p2, p1.Id, v72.Index, ...)
	v72.Index = (v72.Index + 1) % 128

	return coroutine.yield()
end
function t2.FireAllClients(p1, ...) --[[ FireAllClients | Line: 221 | Upvalues: RunService (copy), t (copy), debugOutgoingIncrement (copy), Import (copy), t4 (ref), NumberU162 (copy), v4 (ref), Export (copy), v9 (ref) ]]
	if not RunService:IsServer() then
		error("FireAllClients can only be called from the server", 2)
	end

	if p1.ResponseReads then
		error("Cannot use FireAllClients with packets that expect a response", 2)
	end

	if t.UseBuffers then
		debugOutgoingIncrement(p1.Name)
		Import(t4)
		NumberU162(p1.Id)
		v4(p1.Writes, { ... })
		t4 = Export()
	else
		debugOutgoingIncrement(p1.Name)
		v9:FireAllClients(p1.Id, ...)
	end
end
function t2.Serialize(p1, ...) --[[ Serialize | Line: 236 | Upvalues: Import (copy), v4 (ref), Truncate (copy) ]]
	Import({
		BufferLength = 128,
		BufferOffset = 0,
		InstancesOffset = 0,
		Buffer = buffer.create(128),
		Instances = {}
	})
	v4(p1.Writes, { ... })

	return Truncate()
end
function t2.Deserialize(p1, p2, p3) --[[ Deserialize | Line: 242 | Upvalues: Import (copy), v3 (ref) ]]
	local t = {
		BufferOffset = 0,
		InstancesOffset = 0,
		Buffer = p2,
		BufferLength = buffer.len(p2)
	}

	t.Instances = if p3 then p3 else {}
	Import(t)

	return v3(p1.Reads)
end
v1 = function(p1) --[[ ParametersToFunctions | Line: 249 | Upvalues: v2 (ref), Reads (copy), Writes (copy) ]]
	local v1 = table.create(#p1)
	local v22 = table.create(#p1)
	local v3 = v1

	for i, v in ipairs(p1) do
		if type(v) == "table" then
			local v4, v5 = v2(v)

			v3[i] = v4
			v22[i] = v5

			continue
		end

		v3[i] = Reads[v]
		v22[i] = Writes[v]
	end

	return v3, v22
end
v2 = function(p1) --[[ TableToFunctions | Line: 261 | Upvalues: v2 (ref), Reads (copy), Writes (copy), NumberU16 (copy), NumberU162 (copy) ]]
	if #p1 == 1 then
		local v1 = p1[1]
		local v22, v3

		if type(v1) == "table" then
			local v4, v5 = v2(v1)

			v22 = v5
			v3 = v4
		else
			v3 = Reads[v1]
			v22 = Writes[v1]
		end

		return function() --[[ Line: 270 | Upvalues: NumberU16 (ref), v3 (ref) ]]
			local v1 = NumberU16()
			local v2 = table.create(v1)

			for i = 1, v1 do
				v2[i] = v3()
			end

			return v2
		end, function(p1) --[[ Line: 276 | Upvalues: NumberU162 (ref), v22 (ref) ]]
			NumberU162(#p1)

			for v1, v2 in p1 do
				v22(v2)
			end
		end
	end

	local t = {}

	for v6, v7 in p1 do
		table.insert(t, v6)
	end

	table.sort(t)

	local v8 = table.create(#t)
	local v9 = table.create(#t)

	for v10, v11 in t do
		local v12 = p1[v11]

		if type(v12) == "table" then
			local v13, v14 = v2(v12)

			v8[v10] = v13
			v9[v10] = v14

			continue
		end

		v8[v10] = Reads[v12]
		v9[v10] = Writes[v12]
	end

	return function() --[[ Line: 292 | Upvalues: v8 (copy), t (copy) ]]
		local t2 = {}

		for v1, v2 in v8 do
			t2[t[v1]] = v2()
		end

		return t2
	end, function(p1) --[[ Line: 297 | Upvalues: v9 (copy), t (copy) ]]
		for v1, v2 in v9 do
			v2(p1[t[v1]])
		end
	end
end
v3 = function(p1) --[[ ReadParameters | Line: 304 ]]
	local v1 = table.create(#p1)

	for v2, v3 in p1 do
		v1[v2] = v3()
	end

	return table.unpack(v1)
end
v4 = function(p1, p2) --[[ WriteParameters | Line: 310 ]]
	for v1, v2 in p1 do
		v2(p2[v1])
	end
end
v5 = function(p1, p2, p3) --[[ Timeout | Line: 314 ]]
	local v1 = p1[p2]

	if v1 then
		pcall(task.defer, v1.Yielded, p3)
		p1[p2] = nil
	end
end

if RunService:IsServer() then
	v6 = {}
	v7 = {}
	v10 = 0
	v9 = Instance.new("RemoteEvent", script)

	local t5 = {}
	local v13 = task.spawn(function() --[[ Line: 340 | Upvalues: t4 (ref), v9 (ref), v6 (ref), t5 (copy) ]]
		while true do
			coroutine.yield()

			if t4.BufferOffset > 0 then
				local v1 = buffer.create(t4.BufferOffset)

				buffer.copy(v1, 0, t4.Buffer, 0, t4.BufferOffset)

				if t4.InstancesOffset == 0 then
					v9:FireAllClients(v1)
				else
					v9:FireAllClients(v1, t4.Instances)
					t4.InstancesOffset = 0
					table.clear(t4.Instances)
				end

				t4.BufferOffset = 0
			end

			for v2, v3 in v6 do
				local v4 = buffer.create(v3.BufferOffset)

				buffer.copy(v4, 0, v3.Buffer, 0, v3.BufferOffset)

				if v3.InstancesOffset == 0 then
					v9:FireClient(v2, v4)

					continue
				end

				v9:FireClient(v2, v4, v3.Instances)
			end

			table.clear(v6)
			table.clear(t5)
		end
	end)

	local function f14(p1, p2, p3, ...) --[[ Line: 369 | Upvalues: RunService (copy), Import (copy), v6 (ref), NumberU162 (copy), NumberU82 (copy), v4 (ref), Export (copy) ]]
		if p1.OnServerInvoke == nil then
			RunService:IsStudio()

			return
		end

		local t = { p1.OnServerInvoke(p2, ...) }

		if p2.Parent == nil then
			return
		end

		Import(v6[p2] or {
			BufferLength = 128,
			BufferOffset = 0,
			InstancesOffset = 0,
			Buffer = buffer.create(128),
			Instances = {}
		})
		NumberU162(p1.Id)
		NumberU82(p3 + 128)
		v4(p1.ResponseWrites, t)
		v6[p2] = Export()
	end

	local function f15(p1, p2, p3) --[[ Line: 380 | Upvalues: t5 (copy), RunService (copy), Import (copy), Ended (copy), NumberU16 (copy), t3 (copy), NumberU8 (copy), Task (copy), f14 (copy), v3 (ref), v7 (ref) ]]
		local v32 = (t5[p1] or 0) + math.max(buffer.len(p2), 800)

		if v32 > 8000 then
			RunService:IsStudio()

			return
		end

		t5[p1] = v32

		local t = {
			BufferOffset = 0,
			InstancesOffset = 0,
			Buffer = p2,
			BufferLength = buffer.len(p2)
		}

		t.Instances = if p3 then p3 else {}
		Import(t)

		while Ended() == false do
			local v6 = t3[NumberU16()]

			if not v6 then
				break
			end

			if v6.ResponseReads then
				local v72 = NumberU8()

				if v72 < 128 then
					Task:Defer(f14, v6, p1, v72, v3(v6.Reads))

					continue
				end

				local v8 = v72 - 128
				local v9 = v7[p1][v8]

				if v9 then
					task.cancel(v9.Timeout)
					task.defer(v9.Yielded, v3(v6.ResponseReads))
					v7[p1][v8] = nil

					continue
				end

				if RunService:IsStudio() then
					continue
				end

				v3(v6.ResponseReads)
			else
				v6.OnServerEvent:Fire(p1, v3(v6.Reads))
			end
		end
	end

	local function f16(p1, p2, p3, ...) --[[ Line: 413 | Upvalues: RunService (copy), v9 (ref) ]]
		if p1.OnServerInvoke == nil then
			RunService:IsStudio()

			return
		end

		local t = { p1.OnServerInvoke(p2, ...) }

		if p2.Parent ~= nil then
			v9:FireClient(p2, p1.Id, p3 + 128, table.unpack(t))
		end
	end

	local function f17(p1, p2, ...) --[[ Line: 420 | Upvalues: t3 (copy), Task (copy), f16 (copy) ]]
		local v1 = t3[p2]

		if not v1 then
			return
		end

		if v1.ResponseReads then
			local t = { ... }

			Task:Defer(f16, v1, p1, table.remove(t, 1), table.unpack(t))
		else
			v1.OnServerEvent:Fire(p1, ...)
		end
	end

	v9.OnServerEvent:Connect(function(p1, p2, ...) --[[ Line: 432 | Upvalues: f15 (copy), f17 (copy) ]]
		local v1, v2

		if typeof(p2) == "buffer" then
			local ok, result = pcall(f15, p1, p2, ...)

			v1 = ok
			v2 = result
		else
			local ok, result = pcall(f17, p1, p2, ...)

			v1 = ok
			v2 = result
		end

		if v1 then
			return
		end

		warn((("[Packet] Server event handler errored for %*: %*"):format(p1.Name, v2)))
	end)
	Players.PlayerRemoving:Connect(function(p1) --[[ Line: 444 | Upvalues: v6 (ref), v7 (ref), t5 (copy) ]]
		v6[p1] = nil
		v7[p1] = nil
		t5[p1] = nil
	end)

	if t.UseBuffers then
		RunService.Heartbeat:Connect(function(p1) --[[ Line: 451 | Upvalues: v13 (copy) ]]
			task.defer(v13)
		end)
	end
else
	v8 = {
		Index = 0
	}
	v9 = script:WaitForChild("RemoteEvent")

	local v18 = 0
	local v19 = task.spawn(function() --[[ Line: 458 | Upvalues: t4 (ref), v9 (ref) ]]
		while true do
			repeat
				coroutine.yield()
			until t4.BufferOffset > 0

			local v1 = buffer.create(t4.BufferOffset)

			buffer.copy(v1, 0, t4.Buffer, 0, t4.BufferOffset)

			if t4.InstancesOffset == 0 then
				v9:FireServer(v1)
			else
				v9:FireServer(v1, t4.Instances)
				t4.InstancesOffset = 0
				table.clear(t4.Instances)
			end

			t4.BufferOffset = 0
		end
	end)

	local function f20(p1, p2, ...) --[[ Line: 476 | Upvalues: Import (copy), t4 (ref), NumberU162 (copy), NumberU82 (copy), v4 (ref), Export (copy) ]]
		if p1.OnClientInvoke ~= nil then
			local t = { p1.OnClientInvoke(...) }

			Import(t4)
			NumberU162(p1.Id)
			NumberU82(p2 + 128)
			v4(p1.ResponseWrites, t)
			t4 = Export()
		end
	end

	local function f21(p1, p2, ...) --[[ Line: 486 | Upvalues: v9 (ref) ]]
		if p1.OnClientInvoke ~= nil then
			v9:FireServer(p1.Id, p2 + 128, table.unpack({ p1.OnClientInvoke(...) }))
		end
	end

	local function f22(p1, ...) --[[ Line: 492 | Upvalues: t3 (copy), Task (copy), f21 (copy), v8 (ref) ]]
		local v1 = t3[p1]

		if not v1 then
			return
		end

		if v1.ResponseReads then
			local t = { ... }
			local v2 = table.remove(t, 1)

			if v2 < 128 then
				Task:Defer(f21, v1, v2, table.unpack(t))

				return
			end

			local v3 = v2 - 128
			local v4 = v8[v3]

			if v4 then
				task.cancel(v4.Timeout)
				pcall(task.defer, v4.Yielded, table.unpack(t))
				v8[v3] = nil
			end
		else
			v1.OnClientEvent:Fire(...)
		end
	end

	v9.OnClientEvent:Connect(function(p1, ...) --[[ Line: 519 | Upvalues: Import (copy), Ended (copy), t3 (copy), NumberU16 (copy), NumberU8 (copy), Task (copy), f20 (copy), v3 (ref), v8 (ref), f22 (copy) ]]
		if typeof(p1) == "buffer" then
			local v1 = select(1, ...)
			local t = {
				BufferOffset = 0,
				InstancesOffset = 0,
				Buffer = p1,
				BufferLength = buffer.len(p1)
			}

			t.Instances = if v1 then v1 else {}
			Import(t)

			while Ended() == false do
				local v4 = t3[NumberU16()]

				if v4.ResponseReads then
					local v5 = NumberU8()

					if v5 < 128 then
						Task:Defer(f20, v4, v5, v3(v4.Reads))

						continue
					end

					local v6 = v5 - 128
					local v7 = v8[v6]

					if v7 then
						task.cancel(v7.Timeout)
						pcall(task.defer, v7.Yielded, v3(v4.ResponseReads))
						v8[v6] = nil
					end

					continue
				end

				v4.OnClientEvent:Fire(v3(v4.Reads))
			end
		else
			f22(p1, ...)
		end
	end)
	v9.AttributeChanged:Connect(function(p1) --[[ Line: 556 | Upvalues: t3 (copy), v9 (ref) ]]
		local v1 = t3[p1]

		if not v1 then
			return
		end

		if v1.Id then
			t3[v1.Id] = nil
		end

		v1.Id = v9:GetAttribute(p1)

		if not v1.Id then
			return
		end

		t3[v1.Id] = v1
	end)

	if t.UseBuffers then
		RunService.Heartbeat:Connect(function(p1) --[[ Line: 566 | Upvalues: v18 (ref), v19 (copy) ]]
			v18 = v18 + p1

			if not (v18 > 1 / 60) then
				return
			end

			v18 = v18 % 1 / 60
			task.defer(v19)
		end)
	end
end

local v23 = setmetatable(Types.Types, {
	__call = Constructor
})

v23.Settings = t

return v23