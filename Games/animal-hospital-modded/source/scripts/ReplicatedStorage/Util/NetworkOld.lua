local t = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t2 = {}
local t3 = {}
local v1 = RunService:IsStudio()
local v2 = RunService:IsServer()
local v3 = nil
local v4 = Instance.new("BindableEvent")

local function Spawn(p1, ...) --[[ Spawn | Line: 52 | Upvalues: v4 (copy) ]]
	coroutine.wrap(function(...) --[[ Line: 53 | Upvalues: v4 (ref), p1 (copy) ]]
		v4.Event:Wait()
		p1(...)
	end)(...)
	v4:Fire()
end

local Events, Functions

if v2 then
	print("Server Network Folder SetUp Started!")

	local Communication = Instance.new("Folder")

	Communication.Name = "Communication"
	Communication.Parent = ReplicatedStorage
	Events = Instance.new("Folder")
	Events.Name = "Events"
	Events.Parent = Communication
	Functions = Instance.new("Folder")
	Functions.Name = "Functions"
	Functions.Parent = Communication
	print("Server Network Folder SetUp Done!")
else
	local Communication = ReplicatedStorage:WaitForChild("Communication")

	Events = Communication:WaitForChild("Events")
	Functions = Communication:WaitForChild("Functions")
end

local function GetEventHandler(p1) --[[ GetEventHandler | Line: 83 | Upvalues: t2 (copy), Events (ref), v2 (copy) ]]
	local v1 = t2[p1]

	if v1 then
		return v1
	end

	local t = {
		Name = p1,
		Folder = Events
	}

	t2[p1] = t

	if v2 then
		local v22 = Instance.new("RemoteEvent")

		v22.Name = t.Name
		v22.Parent = t.Folder
		t.Remote = v22

		return t
	end

	t.Remote = t.Folder:FindFirstChild(p1)

	if t.Remote then
		t.Remote.Name = ""
	else
		t.Queue = {}

		local v3 = nil

		v3 = t.Folder.ChildAdded:Connect(function(p12) --[[ Line: 109 | Upvalues: p1 (copy), v3 (ref), t (copy) ]]
			if p12.Name ~= p1 then
				return
			end

			v3:Disconnect()
			t.Remote = p12
			p12.Name = ""

			for k, v in pairs(t.Queue) do
				v()
			end

			t.Queue = nil
		end)
	end

	return t
end

function GetFunctionHandler(p1) --[[ GetFunctionHandler | Line: 133 | Upvalues: t3 (copy), Functions (ref), v2 (copy) ]]
	local v1 = t3[p1]

	if v1 then
		return v1
	end

	local t = {
		Name = p1,
		Folder = Functions
	}

	t3[p1] = t

	if v2 then
		local v22 = Instance.new("RemoteEvent")

		v22.Name = t.Name
		v22.Parent = t.Folder

		local Response = Instance.new("RemoteEvent")

		Response.Name = "Response"
		Response.Parent = v22
		t.Remote = v22
		t.ResponseRemote = Response

		return t
	end

	t.Queue = {}
	t.Folder:WaitForChild(p1):WaitForChild("Response")
	t.Remote = t.Folder:FindFirstChild(p1)
	t.ResponseRemote = t.Remote and t.Remote:FindFirstChild("Response")
	t.Remote.Name = ""

	for k, v in pairs(t.Queue) do
		v()
	end

	t.Queue = nil

	return t
end
function AddToQueue(p1, p2, p3) --[[ AddToQueue | Line: 180 ]]
	if p1.Remote then
		return p2()
	end

	p1.Queue[#p1.Queue + 1] = p2

	if not p3 then
		return
	end

	delay(5, function() --[[ Line: 188 | Upvalues: p1 (copy) ]]
		if p1.Remote then
			return
		end

		warn(debug.traceback(("Infinite yield possible on \'%s:WaitForChild(\"%s\")\'"):format(p1.Folder:GetFullName(), p1.Name)))
	end)
end

local function checkParams(p1, p2) --[[ checkParams | Line: 197 | Upvalues: v2 (copy), v1 (copy) ]]
	local tbl = { unpack(p2) }
	local v12 = 1

	for k, v in pairs(tbl) do
		local t = {}
		local v22 = type(v) == "string" and { v } or v

		t._string = table.concat(v22, " or ")

		for k2, v3 in pairs(v22) do
			t[v3] = true
		end

		tbl[k] = t
	end

	if v2 then
		table.insert(tbl, 1, false)
		v12 = 2
	end

	return function(p12, ...) --[[ Line: 219 | Upvalues: tbl (ref), v1 (ref), p1 (copy), v12 (ref) ]]
		local t = {
			n = select("#", ...),
			...
		}

		if #tbl < t.n then
			if not v1 then
				return
			end

			warn(("[Network] Invalid number of parameters to %s (%d expected, got %d)"):format(p1, #tbl, t.n))

			return
		end

		for i = v12, #tbl do
			local v2 = typeof(t[i])
			local v3 = tbl[i]

			if not (v3[v2] or v3.any) then
				if not v1 then
					return
				end

				warn(("[Network] Invalid parameter %d to %s (%s expected, got %s)"):format(i, p1, v3._string, v2))

				return
			end
		end

		return p12(...)
	end
end

local function combineFn(p1, p2, p3) --[[ combineFn | Line: 245 | Upvalues: checkParams (copy), v3 (ref) ]]
	local t = { p3 }

	if typeof(p2) == "table" then
		p2 = p2[1]

		if p2.MatchParams then
			table.insert(t, (checkParams(p1.Name, p2.MatchParams)))
		end
	end

	table.insert(t, p2)

	return function(...) --[[ NetworkHandler | Line: 259 | Upvalues: v3 (ref), p1 (copy), t (copy) ]]
		local v1, v2

		if not v3 then
			v1 = 0
			v2 = function(...) --[[ runMiddleware | Line: 266 | Upvalues: v1 (ref), t (ref), v2 (copy) ]]
				v1 = v1 + 1

				if v1 < #t then
					return t[v1](v2, ...)
				end

				return t[v1](...)
			end

			return v2(...)
		end

		v3[#v3 + 1] = { true, p1.Remote, ... }
		v1 = 0
		v2 = function(...) --[[ runMiddleware | Line: 266 | Upvalues: v1 (ref), t (ref), v2 (copy) ]]
			v1 = v1 + 1

			if v1 < #t then
				return t[v1](v2, ...)
			end

			return t[v1](...)
		end

		return v2(...)
	end
end

function BindEvent(p1, p2, p3) --[[ BindEvent | Line: 282 | Upvalues: GetEventHandler (copy), combineFn (copy), RunService (copy) ]]
	local v1 = GetEventHandler(p1)

	if not v1 then
		error(("Tried to bind callback to non-existing RemoteEvent %q"):format(p1))
	end

	local v2 = combineFn(v1, p2, p3)

	if RunService:IsServer() then
		v1.Remote.OnServerEvent:Connect(v2)
	elseif v1.Remote then
		v1.Remote.OnClientEvent:Connect(v2)
	else
		AddToQueue(v1, function() --[[ Line: 296 | Upvalues: v1 (copy), v2 (ref) ]]
			v1.Remote.OnClientEvent:Connect(v2)
		end)
	end
end
function BindFunction(p1, p2, p3) --[[ BindFunction | Line: 303 | Upvalues: v2 (copy), combineFn (copy), Spawn (copy) ]]
	assert(v2)

	local v22 = GetFunctionHandler(p1)

	if not v22 then
		error(("Tried to bind callback to non-existing RemoteFunction %q"):format(p1))
	end

	if v22.IsSet then
		error(("Tried to bind multiple callbacks to the same RemoteFunction (%s)"):format(v22.Remote:GetFullName()))
	end

	v22.IsSet = true

	local v3 = combineFn(v22, p2, p3)

	v22.Remote.OnServerEvent:Connect(function(p1, p2, ...) --[[ Line: 318 | Upvalues: Spawn (ref), v22 (copy), v3 (ref) ]]
		local v1 = false
		local v2 = nil

		Spawn(function(...) --[[ Line: 322 | Upvalues: v2 (ref), v22 (ref), p1 (copy), p2 (copy), v3 (ref), v1 (ref) ]]
			v2 = coroutine.running()
			pcall(function(...) --[[ Line: 324 | Upvalues: v22 (ref), p1 (ref), p2 (ref) ]]
				v22.ResponseRemote:FireClient(p1, p2, true, ...)
			end, v3(p1, ...))
			v1 = true
		end, ...)

		while not v1 and p1:IsDescendantOf(game) do
			wait(0.5)
		end

		if not v1 and p1:IsDescendantOf(game) then
			v22.ResponseRemote:FireClient(p1, p2, false)
		end
	end)
end
function t.BindEvents(p1, p2, p3) --[[ BindEvents | Line: 342 ]]
	if typeof(p2) == "table" then
		p3, p2 = p2, nil
	end

	for k, v in pairs(p3) do
		BindEvent(k, v, p2)
	end
end

local tbl = {
	Character = {},
	CharacterPart = {}
}
local t4 = {}
local t5 = {}

for k, v in pairs(tbl) do
	t4[k] = {}
	t5[k] = {}
end

function t.AddReference(p1, p2, p3, ...) --[[ AddReference | Line: 367 | Upvalues: tbl (copy), t4 (copy), t5 (copy) ]]
	assert(tbl[p3], "Invalid Reference Type")

	local t = {
		Type = p3,
		Reference = p2,
		Objects = { ... },
		Aliases = {}
	}

	t4[p3][t.Reference] = t

	local v2 = t5[p3]

	for i, v in ipairs(t.Objects) do
		local v3 = v2[v] or {}

		v2[v] = v3
		v2 = v3
	end

	v2.__Data = t
end
function t.AddReferenceAlias(p1, p2, p3, ...) --[[ AddReferenceAlias | Line: 390 | Upvalues: tbl (copy), t4 (copy), t5 (copy) ]]
	assert(tbl[p3], "Invalid Reference Type")

	local v2 = t4[p3][p2]

	if not v2 then
		warn("Tried to add an alias to a non-existing reference")

		return
	end

	local list = { ... }

	v2.Aliases[#v2.Aliases + 1] = list

	local v3 = t5[p3]

	for i, v in ipairs(list) do
		local v4 = v3[v] or {}

		v3[v] = v4
		v3 = v4
	end

	v3.__Data = v2
end
function t.RemoveReference(p1, p2, p3) --[[ RemoveReference | Line: 413 | Upvalues: tbl (copy), t4 (copy), t5 (copy) ]]
	assert(tbl[p3], "Invalid Reference Type")

	local v2 = t4[p3][p2]

	if not v2 then
		warn("Tried to remove a non-existing reference")

		return
	end

	t4[p3][v2.Reference] = nil

	local function v3(p1, p2, p3) --[[ rem | Line: 425 | Upvalues: v3 (copy), v2 (copy) ]]
		if p3 <= #p2 then
			local v1 = p2[p3]
			local v22 = p1[v1]

			v3(v22, p2, p3 + 1)

			if next(v22) == nil then
				p1[v1] = nil
			end
		else
			if p1.__Data ~= v2 then
				return
			end

			p1.__Data = nil
		end
	end

	local v4 = t5[v2.Type]
	local Objects = v2.Objects

	if #Objects >= 1 then
		local v5 = Objects[1]
		local v6 = v4[v5]

		v3(v6, Objects, 2)

		if next(v6) == nil then
			v4[v5] = nil
		end
	elseif v4.__Data == v2 then
		v4.__Data = nil
	end

	for i, v in ipairs(v2.Aliases) do
		if #v >= 1 then
			local v7 = v[1]
			local v8 = v4[v7]

			v3(v8, v, 2)

			if next(v8) == nil then
				v4[v7] = nil
			end

			continue
		end

		if v4.__Data == v2 then
			v4.__Data = nil
		end
	end
end
function t.GetObject(p1, p2, p3) --[[ GetObject | Line: 448 | Upvalues: tbl (copy), t4 (copy) ]]
	assert(tbl[p3], "Invalid Reference Type")

	local v2 = t4[p3][p2]

	if v2 then
		return unpack(v2.Objects)
	end

	return nil
end
function t.GetReference(p1, ...) --[[ GetReference | Line: 459 | Upvalues: tbl (copy), t5 (copy) ]]
	local list = { ... }
	local v1 = table.remove(list)

	assert(tbl[v1], "Invalid Reference Type")

	local v3 = t5[v1]

	for i, v in ipairs(list) do
		v3 = v3[v]

		if not v3 then
			break
		end
	end

	local v4 = if v3 then v3.__Data else v3

	return if v4 then v4.Reference or nil else nil
end

if RunService:IsServer() then
	function t.BindFunctions(p1, p2, p3) --[[ BindFunctions | Line: 481 ]]
		if typeof(p2) == "table" then
			p3, p2 = p2, nil
		end

		for k, v in pairs(p3) do
			BindFunction(k, v, p2)
		end
	end
	function t.GetPlayers(p1) --[[ GetPlayers | Line: 491 | Upvalues: Players (copy) ]]
		return Players:GetPlayers()
	end
	function t.FireClient(p1, p2, p3, ...) --[[ FireClient | Line: 495 | Upvalues: GetEventHandler (copy), v3 (ref) ]]
		local v1 = GetEventHandler(p3)

		if not v1 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p3))
		end

		if v3 then
			v3[#v3 + 1] = {
				false,
				v1.Remote,
				p2,
				...
			}
		end

		return v1.Remote:FireClient(p2, ...)
	end
	function t.FireAllClients(p1, p2, ...) --[[ FireAllClients | Line: 507 | Upvalues: GetEventHandler (copy), v3 (ref) ]]
		local v1 = GetEventHandler(p2)

		if not v1 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p2))
		end

		for k, v in pairs(p1:GetPlayers()) do
			if v3 then
				v3[#v3 + 1] = {
					false,
					v1.Remote,
					v,
					...
				}
			end

			v1.Remote:FireClient(v, ...)
		end
	end
	function t.FireAllClientsInArray(p1, p2, p3, ...) --[[ FireAllClientsInArray | Line: 521 | Upvalues: GetEventHandler (copy), v3 (ref) ]]
		local v1 = GetEventHandler(p3)

		if not v1 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p3))
		end

		for k, v in pairs(p2) do
			if v3 then
				v3[#v3 + 1] = {
					false,
					v1.Remote,
					v,
					...
				}
			end

			v1.Remote:FireClient(v, ...)
		end
	end
	function t.FireOtherClients(p1, p2, p3, ...) --[[ FireOtherClients | Line: 535 | Upvalues: GetEventHandler (copy), v3 (ref) ]]
		local v1 = GetEventHandler(p3)

		if not v1 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p3))
		end

		for k, v in pairs(p1:GetPlayers()) do
			if v ~= p2 then
				if v3 then
					v3[#v3 + 1] = {
						false,
						v1.Remote,
						v,
						...
					}
				end

				v1.Remote:FireClient(v, ...)
			end
		end
	end
	function t.FireOtherClientsWithinDistance(p1, p2, p3, p4, ...) --[[ FireOtherClientsWithinDistance | Line: 553 ]]
		local Character = p2.Character

		if not Character then
			return
		end

		local PrimaryPart = Character.PrimaryPart

		if not PrimaryPart then
			return
		end

		local Position = PrimaryPart.Position

		for k, v in pairs(p1:GetPlayers()) do
			if v ~= p2 then
				local Character2 = v.Character

				if Character2 and (Character2.PrimaryPart and (Character2.PrimaryPart.Position - Position).Magnitude <= p4) then
					p1:FireClient(v, p3, ...)
				end
			end
		end
	end
	function t.FireAllClientsWithinDistance(p1, p2, p3, p4, ...) --[[ FireAllClientsWithinDistance | Line: 581 ]]
		for k, v in pairs(p1:GetPlayers()) do
			local Character = v.Character

			if Character and (Character.PrimaryPart and (Character.PrimaryPart.Position - p4).Magnitude <= p3) then
				p1:FireClient(v, p2, ...)
			end
		end
	end
else
	function ToByteArgs(p1) --[[ ToByteArgs | Line: 597 ]]
		if p1 > 255 then
			return math.floor(p1 / 256), p1 % 256
		end

		return p1
	end
	function ToByteString(p1) --[[ ToByteString | Line: 605 ]]
		return string.char(ToByteArgs(p1))
	end
	function GetResponse(p1, p2, p3, p4, ...) --[[ GetResponse | Line: 609 ]]
		if p3 == p1 then
			return ...
		end

		return GetResponse(p1, p2, p2:Wait())
	end

	local v5 = 0

	for k, v in pairs(Events:GetChildren()) do
		GetEventHandler(v.Name)
	end

	for k, v in pairs(Functions:GetChildren()) do
		GetFunctionHandler(v.Name)
	end

	function t.FireServer(p1, p2, ...) --[[ FireServer | Line: 625 | Upvalues: GetEventHandler (copy) ]]
		local v1 = GetEventHandler(p2)

		if not v1 then
			error(("\'%s\' is not a valid RemoteEvent"):format(p2))
		end

		if v1.Remote then
			v1.Remote:FireServer(...)
		else
			local t = {
				n = select("#", ...),
				...
			}

			AddToQueue(v1, function() --[[ Line: 636 | Upvalues: v1 (copy), t (copy) ]]
				v1.Remote:FireServer(unpack(t, 1, t.n))
			end, true)
		end
	end
	function t.InvokeServer(p1, p2, ...) --[[ InvokeServer | Line: 642 | Upvalues: v5 (ref) ]]
		local v1 = GetFunctionHandler(p2)

		if not v1 then
			error(("\'%s\' is not a valid RemoteFunction"):format(p2))
		end

		if not v1.Remote then
			local v2 = Instance.new("BindableEvent")

			AddToQueue(v1, function() --[[ Line: 651 | Upvalues: v2 (copy) ]]
				v2:Fire()
			end, true)
			v2.Event:Wait()
		end

		local v3 = ToByteString(v5)

		v5 = (v5 + 1) % 4294967296
		v1.Remote:FireServer(v3, ...)

		return GetResponse(v3, v1.ResponseRemote.OnClientEvent)
	end
end

function t.LogTraffic(p1, p2) --[[ LogTraffic | Line: 667 | Upvalues: RunService (copy), v3 (ref) ]]
	if not RunService:IsServer() then
		warn("LogTraffic is server only")

		return
	end

	if not v3 then
		warn("Logging Network Traffic...")
		v3 = {}

		local v1 = tick()

		delay(p2, function() --[[ Line: 679 | Upvalues: v1 (copy), v3 (ref) ]]
			local v12 = tick() - v1
			local v2 = v3

			v3 = nil

			local tbl = {}

			for k, v in pairs(v2) do
				local v32 = v[2]
				local v4 = v[3]
				local v5 = tbl[v4]

				if not v5 then
					local t = {
						total = 0
					}

					tbl[v4] = t
					v5 = t
				end

				local v6 = v5[v32]

				if not v6 then
					local t = {
						dataIn = {},
						dataOut = {}
					}

					v5[v32] = t
					v6 = t
				end

				local v7 = v[1] and v6.dataIn or v6.dataOut

				v7[#v7 + 1] = v
				v5.total = v5.total + 1
			end

			for k, v in pairs(tbl) do
				warn(("Player \'%s\', total received: %d"):format(k.Name, v.total))
				v.total = nil

				for k2, v4 in pairs(v) do
					local dataIn = v4.dataIn

					if #dataIn > 0 then
						warn(("   %s %s: %d (%.2f/s)"):format("Incoming", k2.Name, #dataIn, #dataIn / v12))

						for i = 1, math.min(#dataIn, 3) do
							local v8 = math.random(1, #dataIn)
							local t = {}

							t[1] = unpack(dataIn[v8], 4, 7)

							for j = 1, #t do
								t[j] = tostring(t[j])
							end

							warn(("      %d: %s"):format(v8, table.concat(t, ", ")))
						end
					end

					local dataOut = v4.dataOut

					if #dataOut > 0 then
						warn(("   %s %s: %d (%.2f/s)"):format("Outgoing", k2.Name, #dataOut, #dataOut / v12))

						for k3 = 1, math.min(#dataOut, 3) do
							local v11 = math.random(1, #dataOut)
							local t = {}

							t[1] = unpack(dataOut[v11], 3, 5)

							for n = 1, #t do
								t[n] = tostring(t[n])
							end

							warn(("      %d: %s"):format(v11, table.concat(t, ", ")))
						end
					end
				end
			end
		end)
	end
end

return t