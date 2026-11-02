--credit to quartz games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedABTests = require(ReplicatedStorage.UserGenerated.ABTests.SharedABTests)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local LocalPlayer = Players.LocalPlayer
local v1 = false
local v2 = Bindable.new()

local function IsLoaded() --[[ IsLoaded | Line: 31 | Upvalues: v1 (ref) ]]
	return v1
end

local v3 = nil

local function GetAssignmentsAsync(p1, p2) --[[ GetAssignmentsAsync | Line: 36 | Upvalues: LocalPlayer (copy), v3 (ref) ]]
	assert(if typeof(p1) == "Instance" then p1:IsA("Player") else false)
	assert(if type(p2) == "boolean" then true else false)

	if p1 ~= LocalPlayer then
		return nil
	end

	local v32

	while true do
		v32 = v3

		if v3 then
			break
		end

		if not p2 then
			return nil
		end

		if not p1.Parent then
			return nil
		end

		task.wait()
	end

	return v32
end

local v4 = nil

local function GetAttributes(p1) --[[ GetAttributes | Line: 61 | Upvalues: LocalPlayer (copy), v4 (ref) ]]
	if p1 == LocalPlayer then
		return v4
	end

	assert(if typeof(p1) == "Instance" then p1:IsA("Player") else false)

	return nil
end

local function GetAttribute(p1, p2, p3) --[[ GetAttribute | Line: 68 | Upvalues: LocalPlayer (copy), v4 (ref) ]]
	assert(if type(p2) == "string" then true else false)

	local v2

	if p1 == LocalPlayer then
		v2 = v4
	else
		assert(if typeof(p1) == "Instance" then p1:IsA("Player") else false)
		v2 = nil
	end

	local v42 = if v2 then v2[p2] else v2

	if v42 == nil then
		return p3, false
	end

	return v42, true
end

local function GetAttributeAsync(p1, p2, p3) --[[ GetAttributeAsync | Line: 81 | Upvalues: GetAssignmentsAsync (copy), GetAttribute (copy) ]]
	assert(if type(p2) == "string" then true else false)

	if GetAssignmentsAsync(p1, true) then
		return GetAttribute(p1, p2, p3)
	end

	return p3, false
end

local function GetJobAttributes() --[[ GetJobAttributes | Line: 93 | Upvalues: LocalPlayer (copy), v4 (ref) ]]
	local v1 = LocalPlayer

	if v1 == LocalPlayer then
		return v4
	end

	assert(if typeof(v1) == "Instance" then v1:IsA("Player") else false)

	return nil
end

local function GetJobAttribute(p1, p2) --[[ GetJobAttribute | Line: 96 | Upvalues: GetAttribute (copy), LocalPlayer (copy) ]]
	return GetAttribute(LocalPlayer, p1, p2)
end

local function GetJobAttributeAsync(p1, p2) --[[ GetJobAttributeAsync | Line: 102 | Upvalues: GetAttributeAsync (copy), LocalPlayer (copy) ]]
	return GetAttributeAsync(LocalPlayer, p1, p2)
end

local function GetJobAssignments() --[[ GetJobAssignments | Line: 108 | Upvalues: v3 (ref) ]]
	return v3
end

local function GetJobAssignmentsAsync(p1) --[[ GetJobAssignmentsAsync | Line: 111 | Upvalues: GetAssignmentsAsync (copy), LocalPlayer (copy) ]]
	return GetAssignmentsAsync(LocalPlayer, p1)
end

local v5 = Bindable.new()
local v6 = Bindable.new()

SharedABTests.UpdateRemote.OnClientEvent:Connect(function(p1, p2) --[[ Line: 120 | Upvalues: DeepFreezeUnsafe (copy), v4 (ref), v3 (ref), v1 (ref), v2 (copy), v5 (copy), LocalPlayer (copy), v6 (copy) ]]
	DeepFreezeUnsafe(p1)
	DeepFreezeUnsafe(p2)
	v4 = p1
	v3 = p2
	v1 = true
	v2:Fire()
	v5:Fire(LocalPlayer)
	v6:Fire()
end)

return table.freeze({
	GetAttributes = GetAttributes,
	GetAttribute = GetAttribute,
	GetAttributeAsync = GetAttributeAsync,
	GetAssignmentsAsync = GetAssignmentsAsync,
	GetJobAttributes = GetJobAttributes,
	GetJobAttribute = GetJobAttribute,
	GetJobAttributeAsync = GetJobAttributeAsync,
	GetJobAssignments = GetJobAssignments,
	GetJobAssignmentsAsync = GetJobAssignmentsAsync,
	IsLoaded = IsLoaded,
	Loaded = v2,
	PlayerUpdated = v5,
	JobUpdated = v6
})