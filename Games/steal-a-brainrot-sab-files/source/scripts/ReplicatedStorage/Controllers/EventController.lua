-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("RunService")
game:GetService("Players")
require(ReplicatedStorage.Packages.Net)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

require(ReplicatedStorage.Shared.EventTypes)

local u3 = nil
local EventController = {
	Events = {},
	GetActiveEvents = function(_)
		if not u3 then
			return {}
		end

		return u3:Get("ActiveEvents") or {}
	end
}

function EventController.GetActiveEventData(_: {[any]: any}, s1: string)
	for v8, v9 in EventController:GetActiveEvents() do
		if s1 == v9.eventName then
			return v9, v8
		end
	end

	return nil, nil
end
function EventController.IsActive(_: {[any]: any}, s2: string)
	local v12, v13 = EventController:GetActiveEventData(s2)

	return v12 ~= nil, v13
end
function EventController.Execute(_: {[any]: any}, s3: string, _: number?)
	local v17 = EventController.Events[s3]

	if not v17 then
		return false
	end

	if v17.Active then
		return false
	end

	v17.Active = true

	if type(v17.OnStart) == "function" then
		v17:OnStart()
	end

	return true
end
function EventController.Cancel(_: {[any]: any}, s4: string)
	local v20 = EventController.Events[s4]

	if not v20 then
		return false
	end

	if not v20.Active then
		return false
	end

	v20.Active = false

	if type(v20.OnStop) == "function" then
		v20:OnStop()
	end

	return true
end
function EventController.Load(_)
	task.spawn(function()
		while not ReplicatedStorage:GetAttribute("EventsLoaded") do
			task.wait()
		end

		for _, v26 in script.Events:GetChildren() do
			if not v26:IsA("ModuleScript") then
				continue
			end

			local ok, result = coroutine.resume(coroutine.create(require), v26)

			if ok and type(result) == "table" then
				if type(result.OnLoad) == "function" then
					local ok2, result2 = coroutine.resume(coroutine.create(result.OnLoad), result)

					if not ok2 then
						warn(`Event { v26:GetFullName() } failed to call Load function:\n{ (if result2 ~= nil then result2 else "yielded (possibly)") }`)

						continue
					end
				end

				EventController.Events[v26.Name] = result

				continue
			end

			warn(`Event { v26:GetFullName() } failed to load:\n{ (if result ~= nil then result else "yielded (possibly)") }`)
		end
	end)
end
function EventController.Start(_)
	u3 = Synchronizer:Wait("Events")
	u3:OnArrayInserted("ActiveEvents", function(p4)
		EventController:Execute(p4.eventName)
	end)
	u3:OnArrayRemoved("ActiveEvents", function(p5)
		EventController:Cancel(p5.eventName)
	end)

	for _, v24 in EventController:GetActiveEvents() do
		task.spawn(function()
			EventController:Execute(v24.eventName)
		end)
	end
end

return EventController
