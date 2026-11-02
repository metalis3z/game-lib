local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local Signal = require(script.Parent.Parent.Signal)
local v5 = RunService:IsServer()
local RequestData = script.Parent:WaitForChild("RequestData")
local t1 = {}

t1.__index = t1

local function ReadPath(p1, t2: {[any]: any})
	local v13 = typeof(p1) == "table"
	local v14 = if not v13 then string.split(p1, ".") else p1
	local v15 = nil
	local v16 = nil

	for i = 1, #v14 do
		local v18 = v14[i]

		v16 = if not v13 then tonumber(v18) or v18 else v18
		v15 = t2
		if typeof(t2) ~= "table" then
			return nil, v15, v16
		end
		t2 = t2[v16]

		if t2 == nil then
			return nil, v15, v16
		end
	end

	return t2, v15, v16
end
local function DispatchQueuedActions(t3: {[any]: any})
	if #t3.Queue == 0 then
		return
	end

	for i = 1, #t3.Queue do
		local v26 = t3.Queue[i]
		local v27 = v26[1]

		if typeof(v27) == "table" then
			v27 = table.concat(v27, ".")
		end

		local v28 = v26[2]

		if v27 ~= "" then
			local v29 = t3.Signals[v28][v27]

			if v29 then
				v29:Fire(v26[3], v26[4], v26[5])
			end
		end
	end

	if v5 then
		for _, v31 in t3.Listeners do
			t3.CommunicationRoute:FireClient(v31, t3.Queue)
		end
	end

	table.clear(t3.Queue)
end
local function InsertOnQueue(t4: {[any]: any}, p2)
	local v34 = p2[1]
	local v35 = p2[2]

	if typeof(v34) == "table" then
		v34 = table.concat(v34, ".")
	end

	if v35 ~= "ArrayInsert" and v35 ~= "ArrayRemoved" and v35 ~= "DictionaryInsert" and v35 ~= "DictionaryRemoved" then
		for i = #t4.Queue, 1, -1 do
			if v34 == t4.Queue[i][1] and v35 == t4.Queue[i][2] then
				table.remove(t4.Queue, i)

				break
			end
		end
	end

	table.insert(t4.Queue, p2)
end

function t1.new(p3, t5: {[any]: any}?, p4)
	local v40 = setmetatable({}, t1)

	v40.Index = p3
	v40.Queue = {}
	v40.Synchronizer = p4
	v40.Connections = {}
	v40.SavedConnections = {}
	v40.OnDestroyed = Signal.new()
	v40.Listeners = {}
	v40.Signals = {
		Changed = {},
		ArrayInsert = {},
		ArrayRemoved = {},
		DictionaryInsert = {},
		DictionaryRemoved = {}
	}

	if v5 then
		v40.ReferenceTable = t5
	end

	if v5 then
		local RemoteEvent = Instance.new("RemoteEvent")

		RemoteEvent.Name = tostring(p3)
		RemoteEvent.Parent = script
		v40.CommunicationRoute = RemoteEvent
	else
		v40.CommunicationRoute = script:WaitForChild((tostring(p3)))
	end

	if not v5 then
		local u42 = false
		local connection = v40.CommunicationRoute.OnClientEvent:Connect(function(p5)
			if not u42 then
				return
			end

			for i = 1, #p5 do
				local v133 = p5[i]
				local v134 = v133[1]
				local v135, v136, v137 = ReadPath(v134, v40:GetTable())

				if v133[2] == "Changed" then
					local v138 = v133[3]
					local _ = v133[4]

					v133[4] = v135
					if typeof(v136) == "table" then
						v136[v137] = v138
					end
				elseif v133[2] == "ArrayInsert" then
					if typeof(v135) == "table" then
						table.insert(v135, v133[4], v133[3])
					end
				elseif v133[2] == "ArrayRemoved" then
					if typeof(v135) == "table" then
						table.remove(v135, v133[4])
					end
				elseif v133[2] == "DictionaryInsert" then
					if typeof(v135) == "table" then
						v135[v133[4]] = v133[3]
					end
				elseif v133[2] == "DictionaryRemoved" then
					if typeof(v135) == "table" then
						v135[v133[4]] = nil
					end
				end

				local v140 = v40
				local v141 = v133[1]

				if typeof(v141) == "table" then
					v141 = table.concat(v141, ".")
				end

				local v142 = v133[2]

				if v141 ~= "" then
					local v143 = v140.Signals[v142][v141]

					if v143 then
						v143:Fire(v133[3], v133[4], v133[5])
					end
				end
			end
		end)

		v40.CacheTable = RequestData:InvokeServer(v40:GetIndex())
		u42 = true
		table.insert(v40.Connections, connection)
	end

	if v5 then
		table.insert(v40.Connections, RunService.Stepped:Connect(function()
			debug.profilebegin("Synchronizer:DispatchQueuedActions")
			DispatchQueuedActions(v40)
			debug.profileend()
		end))
	end

	return v40
end
function t1.InsertOnDictionary(t6: {[any]: any}, p6, p7, p8)
	assert(p6 and (typeof(p6) == "string" or typeof(p6) == "table"), "Invalid path required!")
	assert(p8, "Value is nil!")
	assert(p7, "Index is nil!")

	local v48, _, _ = ReadPath(p6, t6:GetTable())

	if not v48 then
		return
	end

	v48[p7] = p8
	InsertOnQueue(t6, {
		p6,
		"DictionaryInsert",
		p8,
		p7
	})
end
function t1.RemoveFromDictionary(t7: {[any]: any}, p9, p10)
	assert(p9 and (typeof(p9) == "string" or typeof(p9) == "table"), "Invalid path required!")
	assert(p10, "Index is nil!")

	local v54, _, _ = ReadPath(p9, t7:GetTable())

	if not v54 then
		return
	end

	local v57 = v54[p10]

	v54[p10] = nil
	InsertOnQueue(t7, {
		p9,
		"DictionaryRemoved",
		v57,
		p10
	})

	return v57
end
function t1.InsertOnArray(t8: {[any]: any}, p11, p12, n1: number?)
	assert(p11 and (typeof(p11) == "string" or typeof(p11) == "table"), "Invalid path required!")
	assert(p12, "Value is nil!")

	if n1 then
		assert(n1 and typeof(n1) == "number", "Invalid target index!")
	end

	local v62, _, _ = ReadPath(p11, t8:GetTable())

	if not v62 then
		return
	end

	if n1 then
		table.insert(v62, n1, p12)
	else
		table.insert(v62, p12)
		n1 = #v62
	end

	InsertOnQueue(t8, {
		p11,
		"ArrayInsert",
		p12,
		n1
	})

	return n1
end
function t1.RemoveFromArray(t9: {[any]: any}, p13, n2: number)
	assert(p13 and (typeof(p13) == "string" or typeof(p13) == "table"), "Invalid path required!")
	assert(n2, "Target index is invalid!")

	local v68, _, _ = ReadPath(p13, t9:GetTable())

	if not v68 then
		return
	end

	local v71 = table.remove(v68, n2)

	InsertOnQueue(t9, {
		p13,
		"ArrayRemoved",
		v71,
		n2
	})

	return v71
end
function t1.Set(t10: {[any]: any}, p14, p15)
	assert(p14 and (typeof(p14) == "string" or typeof(p14) == "table"), "Invalid path required!")

	local v75, v76, v77 = ReadPath(p14, t10:GetTable())

	if not v76 then
		return t10
	end

	v76[v77] = p15
	InsertOnQueue(t10, {
		p14,
		"Changed",
		p15,
		v75
	})

	return t10
end
function t1.Increase(t11: {[any]: any}, p16, n3: number)
	assert(p16 and (typeof(p16) == "string" or typeof(p16) == "table"), "Invalid path required!")
	assert(n3 and typeof(n3) == "number", "Invalid value number required!")

	local v81, v82, v83 = ReadPath(p16, t11:GetTable())

	if not v82 or not v83 then
		return t11
	end

	v82[v83] = v81 + n3
	InsertOnQueue(t11, {
		p16,
		"Changed",
		v81 + n3,
		v81
	})

	return t11
end
function t1.OnChanged(t12: {[any]: any}, p17, p18: ((...any) -> ...any), b1: boolean?)
	assert(p17 and (typeof(p17) == "string" or typeof(p17) == "table"), "Invalid path required!")

	local v88 = if typeof(p17) ~= "table" then p17 else table.concat(p17, ".")
	local v89 = t12.Signals.Changed[v88]

	if not v89 then
		v89 = Signal.new()
		t12.Signals.Changed[v88] = v89
	end

	if b1 == true then
		p18(t12:Get(v88), nil)
	end

	return (v89:Connect(p18))
end
function t1.OnDictionaryInserted(t13: {[any]: any}, p19, p20: ((...any) -> ...any))
	assert(p19 and (typeof(p19) == "string" or typeof(p19) == "table"), "Invalid path required!")

	local v93 = if typeof(p19) ~= "table" then p19 else table.concat(p19, ".")
	local v94 = t13.Signals.DictionaryInsert[v93]

	if not v94 then
		v94 = Signal.new()
		t13.Signals.DictionaryInsert[v93] = v94
	end

	return (v94:Connect(p20))
end
function t1.OnDictionaryRemoved(t14: {[any]: any}, p21, p22: ((...any) -> ...any))
	assert(p21 and (typeof(p21) == "string" or typeof(p21) == "table"), "Invalid path required!")

	local v98 = if typeof(p21) ~= "table" then p21 else table.concat(p21, ".")
	local v99 = t14.Signals.DictionaryRemoved[v98]

	if not v99 then
		v99 = Signal.new()
		t14.Signals.DictionaryRemoved[v98] = v99
	end

	return (v99:Connect(p22))
end
function t1.OnArrayInserted(t15: {[any]: any}, p23, p24: ((...any) -> ...any))
	assert(p23 and (typeof(p23) == "string" or typeof(p23) == "table"), "Invalid path required!")

	local v103 = if typeof(p23) ~= "table" then p23 else table.concat(p23, ".")
	local v104 = t15.Signals.ArrayInsert[v103]

	if not v104 then
		v104 = Signal.new()
		t15.Signals.ArrayInsert[v103] = v104
	end

	return (v104:Connect(p24))
end
function t1.OnArrayRemoved(t16: {[any]: any}, p25, p26: ((...any) -> ...any))
	assert(p25 and (typeof(p25) == "string" or typeof(p25) == "table"), "Invalid path required!")

	local v108 = if typeof(p25) ~= "table" then p25 else table.concat(p25, ".")
	local v109 = t16.Signals.ArrayRemoved[v108]

	if not v109 then
		v109 = Signal.new()
		t16.Signals.ArrayRemoved[v108] = v109
	end

	return (v109:Connect(p26))
end
function t1.AddListener(t17: {[any]: any}, p27)
	if table.find(t17.Listeners, p27) then
		return t17
	end

	table.insert(t17.Listeners, p27)
	t17.Synchronizer.OnChannelListenerAdded:Fire(t17, p27)

	return t17
end
function t1.RemoveListener(t18: {[any]: any}, p28)
	local v114 = table.find(t18.Listeners, p28)

	if not v114 then
		return t18
	end

	table.remove(t18.Listeners, v114)
	t18.Synchronizer.OnChannelListenerRemoved:Fire(t18, p28)

	return t18
end
function t1.Get(t19: {[any]: any}, p29)
	if not p29 then
		return t19:GetTable()
	end

	return ReadPath(p29, t19:GetTable())
end
function t1.GetIndex(t20: {[any]: any})
	return t20.Index
end
function t1.GetTable(t21: {[any]: any})
	return v5 and t21.ReferenceTable or t21.CacheTable
end
function t1.Destroy(t22: {[any]: any}, b2: boolean?)
	if b2 ~= true then
		return t22.Synchronizer:Destroy(t22:GetIndex())
	end

	if v5 then
		for _, v122 in t22.Listeners do
			t22:RemoveListener(v122)
		end

		t22.CommunicationRoute.Name = HttpService:GenerateGUID(false)
		Debris:AddItem(t22.CommunicationRoute, 5)
	end

	t22.OnDestroyed:Fire(t22)
	t22.OnDestroyed:DisconnectAll()

	for _, v124 in t22.Connections do
		v124:Disconnect()
	end

	for _, v126 in t22.SavedConnections do
		v126:Disconnect()
	end

	t22.OnDestroyed:Destroy()

	for _, v128 in t22.Signals do
		for _, v130 in v128 do
			v130:DisconnectAll()
			v130:Destroy()
		end
	end

	setmetatable(t22, nil)

	return nil
end

return t1
