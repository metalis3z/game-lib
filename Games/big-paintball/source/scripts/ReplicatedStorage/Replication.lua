
local ReplicateModule = {}

local fastSignal = require(script.FastSignal)

local function CheckServer()
	if game:GetService("RunService"):IsServer() == false then
		error("You can only use this function on the server!")
	end
end

local function CheckClient()
	if game:GetService("RunService"):IsClient() == false then
		error("You can only use this function on the client!")
	end
end

local function deepCopy(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = deepCopy(v)
		end
		copy[k] = v
	end
	return copy
end

local replications = {}
local playersOnline = {}

local function Check(tbl,LastChecked,result)
	for index,value in pairs(tbl) do
		if result[1] == true then
			if type(value) == "table" then
				pcall(function()
					Check(tbl[index],LastChecked[index],result)
				end)
			else
				if LastChecked ~= nil and LastChecked[index] == value then

				else
					result[1] = false
				end
			end
		end
	end
end

local function Replicate(Key)
	local tbl = replications[Key]
	local perm = tbl["Perm"]
	local data = tbl["Data"]
	if perm == "all" then
		script.ReplicaChanged:FireAllClients(Key,data)
	elseif type(perm) == "table" then
		for _,plr in pairs(perm) do
			pcall(function()
				script.ReplicaChanged:FireClient(plr,Key,data)
			end)
		end
	else
		warn("No replication target found!")
	end
end

spawn(function()
	while wait() do
		for _,detail in pairs(replications) do
			spawn(function()
				local perm = detail["Perm"]
				local data = detail["Data"]
				local key = detail["Key"]
				local LastChecked = detail["LastChecked"]
				local result = {true}
				if data ~= nil then
					Check(data,LastChecked,result)
				end
				if result[1] == false then
					detail["LastChecked"] = deepCopy(data)
					Replicate(key)
				end
			end)
		end
	end
end)

function ReplicateModule:CreateNewReplication(Key:string,Perm:string|{Player},Data:{any})
	CheckServer()
	local tbl = {
		Key = Key,
		Perm = Perm,
		Data = Data,
		LastChecked = deepCopy(Data)
	}
	replications[Key] = tbl
	Replicate(Key)
end

local replicas = {}

function ReplicateModule:GetLocalReplica()
	CheckClient()
	return ReplicateModule:GetReplica("PlayerData_"..game:GetService("Players").LocalPlayer.UserId)
end

function ReplicateModule:GetReplica(Key:string)
	CheckClient()
	if replicas[Key] ~= nil then
		return replicas[Key]
	end
	local Replica = {
		Changed = fastSignal.new()
	}
	replicas[Key] = Replica
	function Replica:GetData()
		if replications[Key] == nil then
			repeat wait() until replications[Key] ~= nil
		end
		return replications[Key]
	end
	return Replica
end

function ReplicateModule:DestroyReplica(Key:string)
	replicas[Key] = nil
end

if game:GetService("RunService"):IsClient() then
	script.ReplicaChanged.OnClientEvent:Connect(function(Key,Data)
		local oldData = replications[Key]
		if not replications[Key] then
			replications[Key] = Data
		else
			for i,_ in pairs(replications[Key]) do
				replications[Key][i] = nil
			end
			for i,v in pairs(Data) do
				replications[Key][i] = v
			end
		end
		ReplicateModule:GetReplica(Key).Changed:Fire(oldData,Data)
	end)
end

return ReplicateModule