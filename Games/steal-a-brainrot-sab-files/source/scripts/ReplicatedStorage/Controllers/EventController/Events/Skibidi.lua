

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local LocalPlayer = Players.LocalPlayer

local Name = script.Name

local onClientEventObj = Net:RemoteEvent((("EventService/%*/SpawnSkibidi"):format(Name)))
local onClientEventObj_2 = Net:RemoteEvent((("EventService/%*/Burst"):format(Name)))

local managedObj = Trove.new()

local flag = false

local identity = CFrame.identity

local function _(val1)

	return (math.sin(val1 * 3.141592653589793 * 0.5))
end

local function _(val2)

	return 1 - math.cos(val2 * 3.141592653589793 * 0.5)
end

local c1 = CFrame.new(0, -2.441, 0.21)
local data_2 = {}

local function spawnSkibidi(ref1, _, val3)

	local managedObj_2 = Trove.new()
	SoundController:PlaySound(ReplicatedStorage.Sounds.Events.Skibidi.Pop, ref1.Position, false)
	local managedObj_3 = table.remove(data_2, 1) or script.Skibidi:Clone()
	local flag_2 = managedObj_3.Parent ~= nil
	local val4 = 0
	local val5 = -5.1
	local val6 = time()
	local PrimaryPart = managedObj_3.PrimaryPart
	local l___skibidi_transform_0 = PrimaryPart.__skibidi_transform
	PrimaryPart.Anchored = false
	if not flag_2 then
		l___skibidi_transform_0.C1 = c1
		l___skibidi_transform_0.Part0 = workspace.Terrain
		l___skibidi_transform_0.Part1 = PrimaryPart
		managedObj_3.Parent = workspace
	end
	managedObj_2:Add(RunService.PostSimulation:Connect(function()

		debug.profilebegin("skibidi:update")
		local flag_3 = time() - val6
		if flag_3 <= 0.75 then
			local val7 = math.sin(flag_3 / 0.75 * 3.141592653589793 * 0.5)
			val4 = math.lerp(0, 12.566370614359172, val7)
			val5 = math.lerp(-5.1, -0.5, val7)
		elseif flag_3 >= 1.25 then
			local val8 = 1 - math.cos(math.clamp((flag_3 - 1.25) / 0.75, 0, 1) * 3.141592653589793 * 0.5)
			val4 = math.lerp(12.566370614359172, 25.132741228718345, val8)
			val5 = math.lerp(-0.5, -5.1, val8)
		end
		local ref2 = ref1 * CFrame.new(0, val5, 0)
		l___skibidi_transform_0.Transform = CFrame.lookAt(ref2.Position, (Vector3.new(identity.X, ref2.Y, identity.Z))) * CFrame.Angles(0, val4, 0)
		debug.profileend()
	end))
	local val9 = val3 and 0.5 or 2
	managedObj_2:Add(task.delay(val9, function()

		if flag then
			l___skibidi_transform_0.Transform = CFrame.identity
			table.insert(data_2, managedObj_3)
		else
			managedObj_3:Destroy()
		end
		managedObj_2:Destroy()
	end))
end

data.OnStart = function(_)

	local l_v12_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v12_ActiveEventData_0)
	local attribute = ReplicatedStorage:GetAttribute("SkibidiEventSeed")

	local function _(val10)

		return attribute + (val10 - l_v12_ActiveEventData_0.startedAt) // 5
	end
	ReplicatedStorage:SetAttribute("SkibidiEvent", true)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("SkibidiEvent", nil)
	end)
	flag = true
	managedObj:Add(function()

		flag = false
		task.defer(function()

			for _, v34Entry in data_2 do
				v34Entry:Destroy()
			end
			table.clear(data_2)
		end)
	end)
	EffectController:Activate("Blink")
	SoundController:UpdateOST()
	CycleController:Update()
	managedObj:Add(function()

		EffectController:Activate("Blink")
		SoundController:UpdateOST()
		CycleController:Update()
	end)
	local Atmosphere = Lighting:FindFirstChild("Atmosphere")
	if Atmosphere then
		Atmosphere.Parent = script
		managedObj:Add(function()

			Atmosphere.Parent = Lighting
		end)
	end
	managedObj:Clone(script.Atmosphere).Parent = Lighting
	local ref3 = managedObj:Clone(script.MapVFX)
	ref3.Parent = workspace
	local serverTimeNow = attribute + (workspace:GetServerTimeNow() - l_v12_ActiveEventData_0.startedAt) // 5
	local nextNumberObj = Random.new(serverTimeNow)
	local children = (workspace.Events.Skibidi.Ground):GetChildren()
	local children_2 = (workspace.Events.Skibidi.WallTop):GetChildren()
	@native

	local function generateRandomTargetPosition(flag_4)

		local val11 = if flag_4 == "WallTop" then children_2 else children
		local ref4 = val11[nextNumberObj:NextInteger(1, #val11)]
		local Frame = ref4.CFrame
		local Size = ref4.Size

		return Frame * CFrame.new(nextNumberObj:NextNumber(-Size.X * 0.5, Size.X * 0.5), Size.Y * 0.5, nextNumberObj:NextNumber(-Size.Z * 0.5, Size.Z * 0.5))
	end
	local Character = LocalPlayer.Character
	managedObj:Add(LocalPlayer.CharacterAdded:Connect(function(val15)

		Character = val15
	end))
	managedObj:Add(RunService.PostSimulation:Connect(function()

		identity = Character:GetPivot()
	end))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	onClientEventObj.OnClientEvent:Connect(function(typeofArg)

		if typeof(typeofArg) == "CFrame" then
			spawnSkibidi(typeofArg, "Ground")
			return
		else
			local val16 = ClientEventUtils.getAnimalCFrame(typeofArg, {
				bottom = true
			})
			spawnSkibidi(val16, "Ground", true)
			return
		end
	end)
	onClientEventObj_2.OnClientEvent:Connect(function(val17)

		ClientEventUtils.playBurst(script.Burst, val17, {
			ReplicatedStorage.Sounds.Events.Skibidi.BrainrotHit
		})
	end)
end

return data
