-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuardComponent = require(script.GuardComponent)
local GuardEscapeSignController = require(script.GuardEscapeSignController)
local ForestGuardRuntime = require(script.ForestGuardRuntime)
local GuardTutorialController = require(script.GuardTutorialController)
local Network = require(ReplicatedStorage.Library.Client.Network)
local RequiredSpeedSign = require(script.Parent.Parent.GUI.GuardAreas.RequiredSpeedSign)
local Guards = require(ReplicatedStorage.Library.Globals.Constants).NETWORK_MAP.Guards
local t = {}
local t2 = {}
local v1 = GuardTutorialController.new()
local __OBJECTS = Workspace:WaitForChild("__OBJECTS")

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local GuardAreas = Areas.GuardAreas

assert(GuardAreas:IsA("Folder"), "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")

local function setupAreaModel(p1) --[[ setupAreaModel | Line: 46 | Upvalues: t (copy), ForestGuardRuntime (copy), GuardComponent (copy), GuardAreas (copy), t2 (copy), RequiredSpeedSign (copy), GuardEscapeSignController (copy) ]]
	if t[p1] ~= nil then
		return
	end

	local v1 = nil
	local v2

	if p1.Name == "Forest" then
		local v3 = ForestGuardRuntime.new(p1)

		v2 = GuardComponent.new(p1)
		v3:SetWakeHandler(function(p1) --[[ Line: 57 | Upvalues: v2 (ref) ]]
			v2:PlayWakeUp()
		end)
		v1 = v3
	else
		v2 = GuardComponent.new(p1)
	end

	if p1.Parent == GuardAreas then
		local t3 = {
			GuardEscapeSignController = nil,
			RequiredSpeedSign = nil,
			ForestRuntime = v1,
			Guard = v2
		}

		t[p1] = t3
		t2[v2:GetGuardModel()] = v2

		local v4

		if v1 == nil then
			v4 = v2:GetGuardModel().HumanoidRootPart.Position
			task.spawn(function() --[[ Line: 85 | Upvalues: RequiredSpeedSign (ref), p1 (copy), GuardEscapeSignController (ref), v4 (copy), t (ref), t3 (copy), GuardAreas (ref) ]]
				local v1 = RequiredSpeedSign.new(p1)
				local v2 = GuardEscapeSignController.new(p1, v4, v1)

				if t[p1] == t3 and p1.Parent == GuardAreas then
					t3.GuardEscapeSignController = v2
					t3.RequiredSpeedSign = v1
				else
					v2:Destroy()
					v1:Destroy()
				end
			end)

			return
		end

		v1:Start()
		v4 = v2:GetGuardModel().HumanoidRootPart.Position
		task.spawn(function() --[[ Line: 85 | Upvalues: RequiredSpeedSign (ref), p1 (copy), GuardEscapeSignController (ref), v4 (copy), t (ref), t3 (copy), GuardAreas (ref) ]]
			local v1 = RequiredSpeedSign.new(p1)
			local v2 = GuardEscapeSignController.new(p1, v4, v1)

			if t[p1] == t3 and p1.Parent == GuardAreas then
				t3.GuardEscapeSignController = v2
				t3.RequiredSpeedSign = v1
			else
				v2:Destroy()
				v1:Destroy()
			end
		end)
	else
		v2:Destroy()

		if v1 == nil then
			return
		end

		v1:Destroy()
	end
end

local function cleanupAreaModel(p1) --[[ cleanupAreaModel | Line: 98 | Upvalues: t (copy), t2 (copy) ]]
	local v1 = t[p1]

	if v1 == nil then
		return
	end

	t[p1] = nil
	t2[v1.Guard:GetGuardModel()] = nil

	local GuardEscapeSignController = v1.GuardEscapeSignController

	if GuardEscapeSignController ~= nil then
		v1.GuardEscapeSignController = nil
		GuardEscapeSignController:Destroy()
	end

	local RequiredSpeedSign = v1.RequiredSpeedSign

	if RequiredSpeedSign ~= nil then
		v1.RequiredSpeedSign = nil
		RequiredSpeedSign:Destroy()
	end

	v1.Guard:Destroy()

	if v1.ForestRuntime == nil then
		return
	end

	v1.ForestRuntime:Destroy()
end

for i, v in ipairs(GuardAreas:GetChildren()) do
	local v5 = v:IsA("Model")

	assert(v5, (("%* must be a guard area Model"):format((v:GetFullName()))))
	task.spawn(setupAreaModel, v)
end

GuardAreas.ChildAdded:Connect(function(p1) --[[ Line: 131 | Upvalues: setupAreaModel (copy) ]]
	local v1 = p1:IsA("Model")

	assert(v1, (("%* must be a guard area Model"):format((p1:GetFullName()))))
	setupAreaModel(p1)
end)
GuardAreas.ChildRemoved:Connect(function(p1) --[[ Line: 136 | Upvalues: cleanupAreaModel (copy) ]]
	local v1 = p1:IsA("Model")

	assert(v1, (("%* must be a guard area Model"):format((p1:GetFullName()))))
	cleanupAreaModel(p1)
end)
Network.Fired(Guards.WAKE_UP):Connect(function(p1) --[[ Line: 141 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if v1 ~= nil then
		v1:PlayWakeUp()
	end
end)
v1:Start()