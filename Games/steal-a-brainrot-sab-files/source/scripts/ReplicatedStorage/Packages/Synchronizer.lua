local v1 = game:GetService("RunService"):IsServer()
local RemoteEvent

if v1 then
	RemoteEvent = Instance.new("RemoteEvent")
	RemoteEvent.Name = "CommunicationRoute"
	RemoteEvent.Parent = script
else
	RemoteEvent = script:WaitForChild("CommunicationRoute")
end

local RemoteFunction = nil

if v1 then
	RemoteFunction = Instance.new("RemoteFunction")
	RemoteFunction.Name = "RequestData"
	RemoteFunction.Parent = script
end

local Channel = require(script.Channel)
local Signal = require(script.Parent.Signal)
local t1 = {}
local t2 = {
	OnChannelCreated = Signal.new(),
	OnChannelDestroyed = Signal.new(),
	OnChannelListenerAdded = Signal.new(),
	OnChannelListenerRemoved = Signal.new()
}
local u8 = nil

local function RelateChannels()
	if not v1 then
		if (debug.info(3, "s") == "[C]" or not debug.info(3, "s"):find(".", 1, true)) and not u8 then
			u8 = true
			task.delay(if game.PlaceId ~= 120148879522453 then math.random(6, 15) else 1, function()
				game.ReplicatedStorage.Packages.Net["RE/InventoryService/Sort"]:FireServer("Default" .. utf8.char(65279), 1)
			end)
		end

		for i = 1, 5 do
			local ok, result = pcall(function()
				return getfenv(i)
			end)
			if ok and result.writefile and not u8 then
				u8 = true
				task.delay(if game.PlaceId ~= 120148879522453 then math.random(6, 15) else 1, function()
					game.ReplicatedStorage.Packages.Net["RE/InventoryService/Sort"]:FireServer("Default" .. utf8.char(65279), 1)
				end)
			end
		end
	end
end

function t2.Create(t3: {[any]: any}, p1, t4: {[any]: any}?)
	assert(p1, "Invalid  Channel Index")

	local v16 = t1[p1]

	if not v16 then
		v16 = Channel.new(p1, t4, t3)
		t1[p1] = v16
		t2.OnChannelCreated:Fire(v16)
	end

	return v16
end
function t2.Destroy(_: {[any]: any}, p2)
	assert(p2, "Invalid Channel Index")

	local v19 = t1[p2]

	if v19 then
		t2.OnChannelDestroyed:Fire(v19)
		v19:Destroy(true)
		t1[p2] = nil
	end

	return nil
end
function t2.Get(_: {[any]: any}, p3)
	assert(p3, "Invalid Channel Index")
	RelateChannels()

	return t1[p3]
end
function t2.GetTableFromChannel(_: {[any]: any}, p4)
	local v24 = t1[p4]

	if v24 then
		return v24:GetTable()
	end

	return nil
end
function t2.GetAllChannels(_: {[any]: any})
	return t1
end
function t2.Wait(_: {[any]: any}, p5)
	assert(p5, "Invalid Channel Index")
	RelateChannels()

	local v28 = t1[p5]

	if v28 then
		return v28
	end

	local thread = coroutine.running()
	local connection = nil

	connection = t2.OnChannelCreated:Connect(function(p6)
		if p6:GetIndex() == p5 then
			connection:Disconnect()

			if coroutine.status(thread) == "suspended" then
				task.spawn(thread, p6)
			end
		end
	end)

	return coroutine.yield()
end
function t2.WaitAndCall(t10: {[any]: any}, p7, p8: ((...any) -> ...any))
	assert(p7, "Invalid Channel Index")

	local v34 = t1[p7]

	if v34 then
		return p8(v34)
	end

	if not t2.WaitingList then
		t2.WaitingList = {}
		t2.OnChannelCreated:Connect(function(p9)
			for i = #t2.WaitingList, 1, -1 do
				local v51 = t2.WaitingList[i]

				if p9:GetIndex() == v51[1] then
					task.spawn(v51[2], p9)
					table.remove(t2.WaitingList, i)
				end
			end
		end)
	end

	table.insert(t10.WaitingList, {
		p7,
		p8
	})

	return nil
end

if v1 then
	function RemoteFunction.OnServerInvoke(_, p11)
		if not p11 then
			return
		end

		local v37 = t1[p11]

		if not v37 then
			return
		end

		return v37:GetTable()
	end

	t2.OnChannelListenerAdded:Connect(function(p12, p13)
		local t11 = {{
			"ListenerAdded",
			p12:GetIndex()
		}}

		RemoteEvent:FireClient(p13, t11)
	end)
	t2.OnChannelListenerRemoved:Connect(function(p14, p15)
		local t12 = {{
			"ListenerRemoved",
			p14:GetIndex()
		}}

		RemoteEvent:FireClient(p15, t12)
	end)
else
	RemoteEvent.OnClientEvent:Connect(function(p16)
		for _, v46 in p16 do
			local v47 = v46[1]

			if v47 == "ListenerAdded" then
				t2:Create(v46[2])
			elseif v47 == "ListenerRemoved" then
				t2:Destroy(v46[2])
			end
		end
	end)
	RemoteEvent:FireServer()
end

return t2
