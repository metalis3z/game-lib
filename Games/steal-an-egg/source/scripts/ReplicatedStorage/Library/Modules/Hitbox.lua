-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Settings = script:WaitForChild("Settings")

assert(Settings:FindFirstChild("Alive Folder"), "No Alive Folder setting found in HitboxClass settings! Make an object value and name it \'Alive Folder\' and parent it there!")

local MobsCache = workspace:WaitForChild("MobsCache", Constants.STUDIO_YIELD_TIMEOUT)

assert(Settings:FindFirstChild("Projectile Folder"), "No Projectile Folder setting found in HitboxClass settings! Make an object value and name it \'Projectile Folder\' and parent it there!")

local SpawnedObjects = workspace:WaitForChild("SpawnedObjects")
local v3 = Settings:FindFirstChild("Velocity Prediction Constant")

if not v3 then
	warn("Velocity Constant Setting has been deleted! 6 will be used as a default. (HitboxClass)")
end

assert(if MobsCache == nil then false else true, "Set the alive characters folder in the HitboxClass settings!")
assert(if SpawnedObjects == nil then false else true, "Set the projectiles folder in the HitboxClass settings!")
assert(MobsCache:IsDescendantOf(workspace), "The alive folder must be a descendant of workspace! (HitboxClass)")
assert(SpawnedObjects:IsDescendantOf(workspace), "The projectile folder must be a descendant of workspace! (HitboxClass)")
require(script.Types)

local Signal = require(script.Signal)
local Timer = require(script.Timer)
local v8 = OverlapParams.new()

v8.FilterDescendantsInstances = { MobsCache }
v8.FilterType = Enum.RaycastFilterType.Include
v8.MaxParts = 150

local v9 = OverlapParams.new()

v9.FilterDescendantsInstances = { SpawnedObjects }
v9.FilterType = Enum.RaycastFilterType.Exclude

local v10 = CFrame.new(Vector3.new(0, 0, 0))
local v11 = nil

local function SetupClients() --[[ SetupClients | Line: 74 | Upvalues: ReplicatedStorage (copy), v11 (ref), StarterPlayer (copy), Players (copy) ]]
	local HitboxClassRemote = Instance.new("RemoteEvent")

	HitboxClassRemote.Name = "HitboxClassRemote"
	HitboxClassRemote.Parent = ReplicatedStorage
	v11 = HitboxClassRemote

	local v1 = script.HitboxClassLocal:Clone()
	local v2 = script.Signal:Clone()
	local v3 = Instance.new("ObjectValue")

	v3.Value = script
	v3.Name = "HitboxClass Module"
	v3.Parent = v1
	v2.Parent = v1
	v1.Parent = StarterPlayer:FindFirstChildOfClass("StarterPlayerScripts")
	task.spawn(function() --[[ Line: 92 | Upvalues: Players (ref), v1 (copy) ]]
		for k, v in pairs(Players:GetChildren()) do
			local HitboxClassContainer = Instance.new("ScreenGui")

			HitboxClassContainer.Name = "HitboxClassContainer"
			HitboxClassContainer.ResetOnSpawn = false

			local v12 = v1:Clone()

			v12.Parent = HitboxClassContainer
			v12.Enabled = true
			HitboxClassContainer.Parent = v:WaitForChild("PlayerGui")
		end
	end)
	v1.Enabled = true
end

if RunService:IsServer() then
	SetupClients()
else
	v11 = ReplicatedStorage:FindFirstChild("HitboxClassRemote")

	if not v11 then
		warn("HitboxClass must be initialized on the server before using it on the client! Waiting for RemoteEvent!")
		v11 = ReplicatedStorage:WaitForChild("HitboxClassRemote")
	end
end

local t = {}
local t2 = {}

local function v12(p1) --[[ DeepCopyTable | Line: 123 | Upvalues: v12 (copy) ]]
	local t = {}

	for k, v in pairs(p1) do
		if type(v) == "table" then
			t[k] = v12(v)

			continue
		end

		t[k] = v
	end

	return t
end

function t.new(p1) --[[ new | Line: 137 | Upvalues: t (copy), RunService (copy), Signal (copy), v12 (copy), v11 (ref), v10 (copy), t2 (copy) ]]
	local v1 = setmetatable({}, {
		__index = t
	})

	v1.TaggedChars = {}
	v1.TaggedObjects = {}
	v1.SendingChars = {}
	v1.SendingObjects = {}
	v1.DelayThreads = {}

	if RunService:IsClient() and p1._Tick then
		v1.TickVal = p1._Tick
	else
		v1.TickVal = workspace:GetServerTimeNow()
	end

	if p1.ID then
		v1.ID = p1.ID
	end

	v1.Blacklist = p1.Blacklist
	v1.HitSomeone = Signal.new()
	v1.HitObject = Signal.new()
	v1.DebugMode = p1.Debug or false
	v1.Lifetime = p1.Debris or 0
	v1.LookingFor = p1.LookingFor or "Humanoid"

	if p1.UseClient then
		v1.Client = p1.UseClient

		local v2 = v12(p1)

		v2.UseClient = nil
		v2._Tick = v1.TickVal

		local v3 = false
		local v4 = v11.OnServerEvent:Connect(function(p1, p2) --[[ Line: 184 | Upvalues: v1 (copy), v3 (ref) ]]
			if p1 ~= v1.Client then
				return
			end

			if p2 == v1.TickVal then
				v3 = true
			end
		end)

		assert(v1.Client, "No client provided for the hitbox! (HitboxClass)")

		local v5 = workspace:GetServerTimeNow()

		v11:FireClient(v1.Client, "New", v2)

		repeat
			task.wait()
		until v3 or workspace:GetServerTimeNow() - v5 >= 1.5

		v4:Disconnect()

		if not v3 then
			return v1, false
		end
	else
		v1.Position = p1.InitialPosition or v10
		v1.Frequency = p1.Frequency or 0
		v1.HitSomeoneDebounce = p1.HitSomeoneDebounce or 0
		v1.VelocityPrediction = p1.VelocityPrediction

		if v1.VelocityPrediction == nil then
			v1.VelocityPrediction = true
		end

		v1.DotProductRequirement = p1.DotProductRequirement
		v1.DebugMode = p1.Debug or false

		if typeof(p1.SizeOrPart) == "Vector3" then
			v1.SpatialOption = p1.SpatialOption or "InBox"
			assert(v1.SpatialOption ~= "InRadius", "You can\'t use InRadius as the SpatialOption if a Vector3 is passed! Only InPart and InBox! (HitboxClass)")
			v1.Mode = "Part"
			v1.Size = p1.SizeOrPart

			if v1.SpatialOption == "InPart" then
				v1:_GeneratePart()
			end
		elseif type(p1.SizeOrPart) == "number" then
			v1.SpatialOption = p1.SpatialOption or "Magnitude"

			if v1.SpatialOption == "InRadius" then
				v1.Mode = "Part"
				v1.Size = p1.SizeOrPart
			elseif v1.SpatialOption == "InPart" then
				v1.Mode = "Part"
				v1.Size = Vector3.new(p1.SizeOrPart, p1.SizeOrPart, p1.SizeOrPart)
				v1:_GeneratePart()
			elseif v1.SpatialOption == "InBox" then
				v1.Mode = "Part"
				v1.Size = Vector3.new(p1.SizeOrPart, p1.SizeOrPart, p1.SizeOrPart)
			else
				v1.Mode = "Magnitude"
				v1.Size = p1.SizeOrPart
			end
		else
			v1.Mode = "Part"
			v1.Size = p1.SizeOrPart.Size
			v1.Part = p1.SizeOrPart:Clone()
			v1.SpatialOption = "InPart"
			assert(v1.Part, "No part provided?")
			assert(v1.Part and v1.Part:IsA("Part"), "SizeOrPart must be a part or a number! Type given: " .. typeof(p1.SizeOrPart))
			v1.Part.Color = Color3.new(255/255, 0/255, 0/255)
			v1.Part.Name = "Hitbox" .. v1.TickVal
		end

		if v1.DebugMode then
			v1:SetDebug(true)
		end
	end

	table.insert(t2, v1)

	return v1, true
end
function t.ClearTaggedChars(p1) --[[ ClearTaggedChars | Line: 282 | Upvalues: v11 (ref) ]]
	if p1.Client then
		v11:FireClient(p1.Client, "ClrTag", {
			_Tick = p1.TickVal
		})
	else
		table.clear(p1.TaggedChars)
	end
end
function t.Start(p1) --[[ Start | Line: 290 | Upvalues: Timer (copy), v11 (ref), MobsCache (copy), SpawnedObjects (copy), RunService (copy), v10 (copy), v8 (copy), v9 (copy) ]]
	if p1.Lifetime > 0 then
		if p1.Timer then
			p1.Timer:On()
		else
			p1.Timer = Timer.new(0.1, function() --[[ Line: 296 | Upvalues: p1 (copy) ]]
				local v1 = p1

				v1.Lifetime = v1.Lifetime - 0.1

				if not (p1.Lifetime <= 0) then
					return
				end

				p1:Destroy()
			end)
		end
	end

	if p1.Client then
		p1.ClientConnection = v11.OnServerEvent:Connect(function(p12, p2, p3) --[[ Line: 308 | Upvalues: p1 (copy), MobsCache (ref) ]]
			if p3 == nil then
				return
			end

			if p12 ~= p1.Client then
				return
			end

			if p2 ~= p1.TickVal then
				return
			end

			if type(p3) ~= "table" then
				return
			end

			if p1.LookingFor == "Humanoid" then
				for i = #p3, 1, -1 do
					if p3[i] then
						if typeof(p3[i]) ~= "Instance" or not (p3[i]:IsDescendantOf(MobsCache) and (p3[i]:FindFirstChildOfClass("Humanoid") and p3[i]:IsA("Model"))) then
							table.remove(p3, i)
						end
					else
						table.remove(p3, i)
					end

					if p1.Blacklist and table.find(p1.Blacklist, p3[i]) then
						table.remove(p3, i)
					end
				end

				if not (#p3 <= 0) then
					p1.HitSomeone:Fire(p3)
				end
			else
				if p1.LookingFor ~= "Object" then
					return
				end

				for j = #p3, 1, -1 do
					if p3[j] and (typeof(p3[j]) == "Instance" and p3[j]:IsA("BasePart")) then
						if p1.Blacklist then
							for k, v in pairs(p1.Blacklist) do
								if p3[j] == v or p3[j]:IsDescendantOf(v) then
									table.remove(p3, j)
								end
							end
						end

						continue
					end

					table.remove(p3, j)
				end

				if #p3 <= 0 then
					return
				end

				p1.HitObject:Fire(p3)
			end
		end)
		v11:FireClient(p1.Client, "Start", {
			_Tick = p1.TickVal
		})

		return
	end

	if p1.Mode == "Magnitude" then
		assert(typeof(p1.Size) == "number", "Magnitude hitbox wasn\'t given a number! Type given: " .. typeof(p1.Size))

		if p1.Part and p1.DebugMode then
			p1.Part.Parent = SpawnedObjects
		end

		local v3 = 0
		local v4 = 0

		p1.RunServiceConnection = RunService.Heartbeat:Connect(function() --[[ Line: 389 | Upvalues: v3 (ref), v4 (ref), p1 (copy), v10 (ref), v8 (ref) ]]
			local v1 = os.clock() - v3

			if v1 < p1.Frequency or os.clock() - v4 < p1.HitSomeoneDebounce then
				return
			end

			v3 = os.clock()

			if p1.PartWeld then
				p1:SetPosition(p1.PartWeld.CFrame * (p1.PartWeldOffset or v10))
			end

			local v6 = workspace:GetPartBoundsInRadius(p1.Position.Position, p1.Size, v8)

			if #v6 ~= 0 then
				v4 = os.clock()
				p1.HitSomeone:Fire(v6)
			end
		end)
	else
		if p1.SpatialOption == "InPart" or p1.Part and p1.DebugMode == true then
			p1.Part.Parent = SpawnedObjects
		end

		p1.RunServiceConnection = RunService.Heartbeat:Connect(function(p12) --[[ Line: 416 | Upvalues: p1 (copy), v10 (ref), v8 (ref), v9 (ref) ]]
			if p1.PartWeld then
				p1:SetPosition(p1.PartWeld.CFrame * (p1.PartWeldOffset or v10))
			end

			for k, v in pairs(if p1.SpatialOption == "InBox" then if p1.LookingFor == "Humanoid" then workspace:GetPartBoundsInBox(p1.Position, p1.Size, v8) else workspace:GetPartBoundsInBox(p1.Position, p1.Size, v9) elseif p1.SpatialOption == "InRadius" then if p1.LookingFor == "Humanoid" then workspace:GetPartBoundsInRadius(p1.Position.Position, p1.Size, v8) else workspace:GetPartBoundsInRadius(p1.Position.Position, p1.Size, v9) elseif p1.LookingFor == "Humanoid" then workspace:GetPartsInPart(p1.Part, v8) else workspace:GetPartsInPart(p1.Part, v9)) do
				if v.Parent then
					if p1.LookingFor == "Humanoid" then
						local v11 = v.Parent
						local v12 = v11:IsA("Model") and (if v11.PrimaryPart == nil then false else v11:FindFirstChildOfClass("Humanoid"))

						if v12 and not (p1.Blacklist and table.find(p1.Blacklist, v11)) and not (table.find(p1.SendingChars, v11) or p1.TaggedChars[v11]) then
							table.insert(p1.SendingChars, v11)
						end

						continue
					end

					local v13 = false

					if p1.Blacklist then
						for i = #p1.Blacklist, 1, -1 do
							local v14 = p1.Blacklist[i]

							if v == v14 or v:IsDescendantOf(v14) then
								v13 = true

								break
							end
						end
					end

					if not (table.find(p1.SendingObjects, v) or (p1.TaggedObjects[v] or v13)) then
						table.insert(p1.SendingObjects, v)
					end
				end
			end

			if p1.LookingFor == "Humanoid" then
				p1:_SiftThroughSendingCharsAndFire()

				return
			end

			if p1.LookingFor ~= "Object" then
				return
			end

			p1:_SiftThroughSendingObjectsAndFire()
		end)
	end
end
function t.Stop(p1) --[[ Stop | Line: 501 | Upvalues: v11 (ref) ]]
	if p1.Timer then
		p1.Timer:Off()
	end

	if p1.Client then
		if p1.ClientConnection then
			p1.ClientConnection:Disconnect()
			p1.ClientConnection = nil
		end

		v11:FireClient(p1.Client, "Stop", {
			_Tick = p1.TickVal
		})
	else
		if p1.Part then
			p1.Part:Remove()
		end

		if not p1.RunServiceConnection then
			return
		end

		p1.RunServiceConnection:Disconnect()
		p1.RunServiceConnection = nil
	end
end
function t.SetPosition(p1, p2) --[[ SetPosition | Line: 524 | Upvalues: v11 (ref), v3 (copy), RunService (copy) ]]
	if p1.Client then
		v11:FireClient(p1.Client, "PosCh", {
			_Tick = p1.TickVal,
			Position = p2
		})
	end

	local v1 = if v3 then v3.Value or 6 else 6

	if RunService:IsServer() and (p1.PartWeld and p1.VelocityPrediction) then
		p2 = p2 * CFrame.new(p2:VectorToObjectSpace(p1.PartWeld.AssemblyLinearVelocity) / v1)
	end

	p1.Position = p2

	if not p1.Part then
		return
	end

	p1.Part.CFrame = p2
end
function t.WeldTo(p1, p2, p3) --[[ WeldTo | Line: 549 | Upvalues: v11 (ref) ]]
	if p1.Client then
		v11:FireClient(p1.Client, "Weld", {
			_Tick = p1.TickVal,
			WeldTo = p2,
			Offset = p3
		})
	end

	p1.PartWeld = p2
	p1.PartWeldOffset = p3
end
function t.Unweld(p1) --[[ Unweld | Line: 562 | Upvalues: v11 (ref) ]]
	if p1.Client then
		v11:FireClient(p1.Client, "Unweld", {
			_Tick = p1.TickVal
		})
	end

	p1.PartWeld = nil
	p1.PartWeldOffset = nil
end
function t.ChangeWeldOffset(p1, p2) --[[ ChangeWeldOffset | Line: 571 | Upvalues: v11 (ref) ]]
	if p1.Client then
		v11:FireClient(p1.Client, "WeldOfs", {
			_Tick = p1.TickVal,
			Offset = p2
		})
	end

	p1.PartWeldOffset = p2
end
function t.SetVelocityPrediction(p1, p2) --[[ SetVelocityPrediction | Line: 579 ]]
	p1.VelocityPrediction = p2
end
function t.SetDebug(p1, p2) --[[ SetDebug | Line: 583 | Upvalues: v11 (ref), SpawnedObjects (copy) ]]
	p1.DebugMode = p2

	if p1.Client then
		v11:FireClient(p1.Client, "Dbg", {
			_Tick = p1.TickVal,
			Debug = p2
		})

		return
	end

	if p1.DebugMode then
		if p1.Part then
			p1.Part.Transparency = 0.45

			if p1.SpatialOption ~= "InPart" and p1.RunServiceConnection then
				p1.Part.Parent = SpawnedObjects
			end
		else
			p1:_GeneratePart()
			assert(p1.Part, "Part wasn\'t generated after the GeneratePart method?")

			if p1.RunServiceConnection then
				p1.Part.Parent = SpawnedObjects
			end
		end
	else
		if not p1.Part then
			return
		end

		if p1.SpatialOption ~= "InPart" then
			p1.Part:Remove()
		end

		p1.Part.Transparency = 1
	end
end
function t.ClearHitboxesWithID(p1) --[[ ClearHitboxesWithID | Line: 617 | Upvalues: RunService (copy), t2 (copy) ]]
	if RunService:IsClient() then
		return
	end

	for i = #t2, 1, -1 do
		local v1 = t2[i]

		if v1.ID and v1.ID == p1 then
			pcall(function() --[[ Line: 627 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end)
		end
	end
end
function t.ClearClientHitboxes(p1) --[[ ClearClientHitboxes | Line: 634 | Upvalues: RunService (copy), t2 (copy), v11 (ref) ]]
	if RunService:IsClient() then
		return
	end

	for i = #t2, 1, -1 do
		local v1 = t2[i]

		if v1.Client and v1.Client == p1 then
			pcall(function() --[[ Line: 644 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end)
		end
	end

	v11:FireClient(p1, "Clr")
end
function t.GetHitboxCache() --[[ GetHitboxCache | Line: 654 | Upvalues: t2 (copy) ]]
	return t2
end
function t._SiftThroughSendingObjectsAndFire(p1) --[[ _SiftThroughSendingObjectsAndFire | Line: 658 ]]
	if #p1.SendingObjects <= 0 then
		return
	end

	local t = {}

	for k, v in pairs(p1.SendingObjects) do
		table.insert(t, v)
		p1.TaggedObjects[v] = true

		if p1.Frequency > 0 then
			local v1 = task.delay(p1.Frequency, function() --[[ Line: 671 | Upvalues: p1 (copy), v (copy) ]]
				p1.TaggedObjects[v] = nil
			end)

			table.insert(p1.DelayThreads, v1)
		end
	end

	if #t > 0 then
		p1.HitObject:Fire(t)
	end

	if not p1.SendingObjects then
		return
	end

	table.clear(p1.SendingObjects)
end
function t._SiftThroughSendingCharsAndFire(p1) --[[ _SiftThroughSendingCharsAndFire | Line: 692 ]]
	if #p1.SendingChars <= 0 then
		return
	end

	local t = {}

	for k, v in pairs(p1.SendingChars) do
		table.insert(t, v)
		p1.TaggedChars[v] = true

		if p1.Frequency > 0 then
			local v1 = task.delay(p1.Frequency, function() --[[ Line: 705 | Upvalues: p1 (copy), v (copy) ]]
				p1.TaggedChars[v] = nil
			end)

			table.insert(p1.DelayThreads, v1)
		end
	end

	if #t > 0 then
		p1.HitSomeone:Fire(t)
	end

	if not p1.SendingChars then
		return
	end

	table.clear(p1.SendingChars)
end
function t._GeneratePart(p1) --[[ _GeneratePart | Line: 726 ]]
	if p1.Part then
		return
	end

	if typeof(p1.Size) == "Vector3" then
		p1.Mode = "Part"
		p1.Part = Instance.new("Part")
		assert(p1.Part, "Part was nil!")
		assert(typeof(p1.Size) == "Vector3", "self.Size wasn\'t a vector3 when making a part!")
		p1.Part.Color = Color3.new(255/255, 0/255, 0/255)

		if p1.DebugMode then
			p1.Part.Transparency = 0.45
		else
			p1.Part.Transparency = 1
		end

		p1.Part.Anchored = true
		p1.Part.Massless = true
		p1.Part.CanCollide = false
		p1.Part.Size = p1.Size
	else
		if type(p1.Size) ~= "number" then
			return
		end

		p1.Part = Instance.new("Part")
		assert(p1.Part and p1.Part:IsA("Part"), "Part wasn\'t created when making a sphere part!")
		assert(typeof(p1.Size) == "number", "self.Size wasn\'t a number when making a sphere part!")
		p1.Part.Shape = Enum.PartType.Ball
		p1.Part.Anchored = true
		p1.Part.Massless = true
		p1.Part.CanCollide = false
		p1.Part.Size = Vector3.new(p1.Size * 2, p1.Size * 2, p1.Size * 2)
		p1.Part.Transparency = 0.45
		p1.Part.Color = Color3.new(255/255, 0/255, 0/255)
	end

	p1.Part.CFrame = p1.Position
	p1.Part.Name = "Hitbox" .. p1.TickVal
end
function t.Destroy(p1) --[[ Destroy | Line: 772 | Upvalues: t2 (copy), v11 (ref) ]]
	table.remove(t2, table.find(t2, p1))

	if p1.Client then
		v11:FireClient(p1.Client, "Des", {
			_Tick = p1.TickVal
		})
	end

	if p1.Client then
		if p1.ClientConnection then
			p1.ClientConnection:Disconnect()
			p1.ClientConnection = nil
		end
	else
		if p1.Part then
			p1.Part:Remove()
		end

		if p1.RunServiceConnection then
			p1.RunServiceConnection:Disconnect()
			p1.RunServiceConnection = nil
		end
	end

	pcall(function() --[[ Line: 799 | Upvalues: p1 (copy) ]]
		p1.HitSomeone:Destroy()
	end)
	pcall(function() --[[ Line: 804 | Upvalues: p1 (copy) ]]
		p1.HitObject:Destroy()
	end)
	pcall(function() --[[ Line: 809 | Upvalues: p1 (copy) ]]
		if not p1.Timer then
			return
		end

		p1.Timer:Destroy()
	end)

	if p1.DelayThreads then
		for k, v in pairs(p1.DelayThreads) do
			pcall(function() --[[ Line: 818 | Upvalues: v (copy) ]]
				task.cancel(v)
			end)
		end
	end

	if p1.Part then
		p1.Part:Destroy()
	end

	pcall(function() --[[ Line: 830 | Upvalues: p1 (copy) ]]
		table.clear(p1.TaggedChars)
	end)
	pcall(function() --[[ Line: 834 | Upvalues: p1 (copy) ]]
		table.clear(p1.SendingChars)
	end)
	pcall(function() --[[ Line: 838 | Upvalues: p1 (copy) ]]
		table.clear(p1)
	end)
end

return t