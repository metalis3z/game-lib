local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("Types"):WaitForChild("EventType"))
local tbl_1 = {}
local u1 = {}
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Sync_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"))
local Events_upv_1 = ReplicatedStorage_1:WaitForChild("Remotes"):WaitForChild("Events")
local u2 = false
function tbl_1.GetEvents(a1)
	return u1
end
local tbl_upv_2 = {}
function tbl_1.GetMainEvent(a1)
	for _, value_1 in u1 do
		if (not (value_1.EventStartInfo) or value_1.Priority ~= "Main") then
			continue
		end
		return value_1
	end
end
function tbl_1.OnEventStarted(a1, a2)
	while (not (u2)) do
		task.wait()
	end
	for _, value_2 in u1 do
		if (value_2.EventStartInfo) then
			a2(value_2)
		end
	end
	table.insert(tbl_upv_2, a2)
end
local function StartEvent(a1)
	local EventStartInfo_1 = a1.EventStartInfo
	if (EventStartInfo_1) then
		if (EventStartInfo_1.Items) then
			for key_1, value_3 in EventStartInfo_1.Items do
				for key_2, value_4 in value_3 do
					Sync_upv_1[key_1][key_2] = value_4
				end
			end
		end
		if (EventStartInfo_1.ShopData) then
			for key_3, value_5 in EventStartInfo_1.ShopData do
				Sync_upv_1.NewShop[key_3] = value_5
			end
		end
	end
	for _, value_6 in tbl_upv_2 do
		value_6(a1)
	end
end
local function onInitialize()
	u1 = Events_upv_1:WaitForChild("GetEvents"):InvokeServer()
	for _, value_7 in u1 do
		if (value_7.EventStartInfo) then
			StartEvent(value_7)
		end
	end
	Events_upv_1:WaitForChild("EventChanged").OnClientEvent:Connect(
		function(a1, a2)
			local v1 = false
			if (u1[a1] and not (u1[a1].EventStartInfo)) then
				v1 = ((a2.EventStartInfo) and true) or v1
			end
			u1[a1] = a2
			if (not v1) then
				return
			end
			StartEvent(a2)
		end
	)
	u2 = true
	print("Events", u1)
end
onInitialize()
return tbl_1