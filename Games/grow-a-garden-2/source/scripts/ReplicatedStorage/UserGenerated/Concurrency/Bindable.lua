--credit to leon games studio
local function ErrorHandler(p1) --[[ ErrorHandler | Line: 107 ]]
	warn((("%*\nStack Begin\n%*Stack End"):format(tostring(p1), (debug.traceback(nil, 3)))))
end

local function WCall(p1, ...) --[[ WCall | Line: 111 | Upvalues: ErrorHandler (copy) ]]
	return xpcall(p1, ErrorHandler, ...)
end

local function FindRight(p1, p2) --[[ FindRight | Line: 122 ]]
	local v1 = 1
	local v2 = #p1
	local v3 = false

	while v1 <= v2 do
		local v4 = v1 + (v2 - v1) // 2
		local v5 = p1[v4].Pr - p2.Pr

		if v5 > 0 then
			v2 = v4 - 1
		else
			if v5 < 0 then
				v1 = v4 + 1

				continue
			end

			v1 = v4 + 1
			v3 = true
		end
	end

	return if v3 and v1 then v1 else -v1
end

local function FindLeft(p1, p2) --[[ FindLeft | Line: 149 ]]
	local v1 = 1
	local v2 = #p1
	local v3 = false

	while v1 <= v2 do
		local v4 = v1 + (v2 - v1) // 2
		local v5 = p1[v4].Pr - p2.Pr

		v2 = v4 - 1

		if not (v5 > 0) then
			if v5 < 0 then
				v1 = v4 + 1

				continue
			end

			v3 = true
		end
	end

	return if v3 and v1 then v1 else -v1
end

local function InsertRight(p1, p2) --[[ InsertRight | Line: 175 | Upvalues: FindRight (copy) ]]
	local v2 = math.abs((FindRight(p1, p2)))

	table.insert(p1, v2, p2)

	return v2
end

local function Remove(p1, p2) --[[ Remove | Line: 188 | Upvalues: FindLeft (copy) ]]
	local v1 = FindLeft(p1, p2)

	if not (v1 > 0) then
		return false
	end

	for i = v1, #p1 do
		if p1[i] == p2 then
			table.remove(p1, i)

			return true
		end
	end

	return false
end

local function Connection_IsConnected(p1) --[[ Connection_IsConnected | Line: 205 ]]
	return p1.Ow ~= nil
end

local function Connection_Disconnect(p1) --[[ Connection_Disconnect | Line: 209 | Upvalues: Remove (copy) ]]
	local Ow = p1.Ow

	if Ow == nil then
		return
	end

	p1.Ow = nil

	if not Remove(Ow.Cs, p1) then
		warn("BindableConnectionDisconnect")
	end

	for i, v in ipairs(p1.Wt) do
		task.spawn(v)
	end

	table.clear(p1.Wt)
end

local function Connection_GetPriority(p1) --[[ Connection_GetPriority | Line: 223 ]]
	return p1.Pr
end

local v2 = table.freeze({
	__index = table.freeze({
		IsConnected = Connection_IsConnected,
		Disconnect = Connection_Disconnect,
		GetPriority = Connection_GetPriority
	})
})

local function Connection_new(p1, p2, p3) --[[ Connection_new | Line: 235 | Upvalues: v2 (copy) ]]
	return setmetatable({
		Ow = p1,
		Cb = p2,
		Pr = p3,
		Wt = {}
	}, v2)
end

local function Connection_IsA(p1) --[[ Connection_IsA | Line: 249 | Upvalues: v2 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == v2 else false
end

local function Connection_Assert(p1) --[[ Connection_Assert | Line: 253 | Upvalues: v2 (copy) ]]
	if if type(p1) == "table" then if getmetatable(p1) == v2 then true else false else false then
		return p1
	end

	error("Connection", 2)
end

local function Bindable_Connect(p1, p2, p3) --[[ Bindable_Connect | Line: 261 | Upvalues: v2 (copy), FindRight (copy) ]]
	assert(if p3 == nil then true elseif type(p3) == "number" then if p3 == p3 then true else false else false)

	local v22 = p3 or (1 / 0)
	local v4 = setmetatable({
		Ow = p1,
		Cb = p2,
		Pr = v22,
		Wt = {}
	}, v2)

	if v22 == (1 / 0) then
		table.insert(p1.Cs, v4)
	else
		local Cs = p1.Cs

		table.insert(Cs, math.abs((FindRight(Cs, v4))), v4)
	end

	return v4
end

local function Bindable_Fire(p1, ...) --[[ Bindable_Fire | Line: 278 ]]
	local Cs = p1.Cs
	local count = 1

	while count <= #Cs do
		local v1 = Cs[count]

		task.spawn(v1.Cb, ...)

		if Cs[count] == v1 then
			count = count + 1
		end
	end
end

local function Bindable_FireAndWait(p1, ...) --[[ Bindable_FireAndWait | Line: 292 | Upvalues: WCall (copy) ]]
	local Cs = p1.Cs

	if #Cs == 0 then
		return
	end

	local count = 1
	local v1 = coroutine.running()

	local function executor(p1, ...) --[[ executor | Line: 299 | Upvalues: WCall (ref), count (ref), v1 (copy) ]]
		WCall(p1, ...)
		count = count - 1

		if count ~= 0 then
			return
		end

		task.spawn(v1)
	end

	local count2 = 1

	while count2 <= #Cs do
		local v2 = Cs[count2]

		count = count + 1
		task.spawn(executor, v2.Cb, ...)

		if Cs[count2] == v2 then
			count2 = count2 + 1
		end
	end

	count = count - 1

	if not (count > 0) then
		return
	end

	coroutine.yield()
end

local function Bindable_FireSync(p1, ...) --[[ Bindable_FireSync | Line: 321 | Upvalues: WCall (copy) ]]
	local Cs = p1.Cs
	local count = 1

	while count <= #Cs do
		local v1 = Cs[count]

		WCall(v1.Cb, ...)

		if Cs[count] == v1 then
			count = count + 1
		end
	end
end

local function Bindable_Invoke(p1, ...) --[[ Bindable_Invoke | Line: 333 ]]
	local Cs = p1.Cs

	if #Cs >= 1 then
		return Cs[1].Cb(...)
	end

	error("Invoke")
end

local function Bindable_Wait(p1) --[[ Bindable_Wait | Line: 344 | Upvalues: Connection_Disconnect (copy), v2 (copy) ]]
	local v1 = coroutine.running()
	local v22 = true
	local v3 = nil

	local function f4(...) --[[ Line: 348 | Upvalues: v3 (ref), v1 (copy), v22 (ref), Connection_Disconnect (ref) ]]
		local v12 = table.find(v3.Wt, v1)

		if not v12 then
			v22 = false
			Connection_Disconnect(v3)
			task.spawn(v1, ...)

			return
		end

		table.remove(v3.Wt, v12)
		v22 = false
		Connection_Disconnect(v3)
		task.spawn(v1, ...)
	end

	assert(true)

	local v6 = setmetatable({
		Pr = (1 / 0),
		Ow = p1,
		Cb = f4,
		Wt = {}
	}, v2)

	table.insert(p1.Cs, v6)
	v3 = v6

	local Wt = v3.Wt

	table.insert(Wt, v1)

	local v7 = table.pack(coroutine.yield())

	if not v22 then
		return table.unpack(v7)
	end

	error("Disconnected")
end

local function Bindable_Once(p1, p2, p3) --[[ Bindable_Once | Line: 365 | Upvalues: Connection_Disconnect (copy), v2 (copy), FindRight (copy) ]]
	local v1 = nil

	local function f2(...) --[[ Line: 371 | Upvalues: Connection_Disconnect (ref), v1 (ref), p2 (copy) ]]
		Connection_Disconnect(v1)

		return p2(...)
	end

	assert(if p3 == nil then true elseif type(p3) == "number" then if p3 == p3 then true else false else false)

	local v4 = p3 or (1 / 0)
	local v6 = setmetatable({
		Ow = p1,
		Cb = f2,
		Pr = v4,
		Wt = {}
	}, v2)

	if v4 == (1 / 0) then
		table.insert(p1.Cs, v6)
	else
		local Cs = p1.Cs

		table.insert(Cs, math.abs((FindRight(Cs, v6))), v6)
	end

	v1 = v6

	return v1
end

local function Bindable_DisconnectAll(p1) --[[ Bindable_DisconnectAll | Line: 378 | Upvalues: Connection_Disconnect (copy) ]]
	local Cs = p1.Cs

	for i = #Cs, 1, -1 do
		Connection_Disconnect(Cs[i])
	end
end

local function Bindable_GetSize(p1) --[[ Bindable_GetSize | Line: 385 ]]
	return #p1.Cs
end

local function Bindable_IsEmpty(p1) --[[ Bindable_IsEmpty | Line: 389 ]]
	return #p1.Cs == 0
end

local v4 = table.freeze({
	__index = table.freeze({
		Fire = Bindable_Fire,
		FireAndWait = Bindable_FireAndWait,
		FireSync = Bindable_FireSync,
		Invoke = Bindable_Invoke,
		Connect = Bindable_Connect,
		Wait = Bindable_Wait,
		Once = Bindable_Once,
		DisconnectAll = Bindable_DisconnectAll,
		GetSize = Bindable_GetSize,
		IsEmpty = Bindable_IsEmpty
	})
})

local function new(p1) --[[ new | Line: 408 | Upvalues: v4 (copy) ]]
	return table.freeze((setmetatable({
		Cs = {}
	}, v4)))
end

local function IsA(p1) --[[ IsA | Line: 421 | Upvalues: v4 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == v4 else false
end

local function Assert(p1) --[[ Assert | Line: 425 | Upvalues: v4 (copy) ]]
	if if type(p1) == "table" then if getmetatable(p1) == v4 then true else false else false then
		return p1
	end

	error("Bindable", 2)
end

return table.freeze({
	new = new,
	IsA = IsA,
	Assert = Assert,
	IsAConnection = Connection_IsA,
	AssertConnection = Connection_Assert
})