
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v12 = require(ReplicatedStorage.Packages.Net):RemoteEvent("EventService/RainingBurgers/Strike")
local scriptName = script.Name
local v14 = Trove.new()
local t2 = {}
local u16 = false

local function getBurgerTemplate()
	local Burger = script:FindFirstChild("Burger")

	if Burger and (Burger:IsA("Model") and Burger.PrimaryPart) then
		return Burger
	end

	return nil
end
local function setupBurger(p1)
	local PrimaryPart = p1.PrimaryPart

	if not PrimaryPart then
		return nil
	end

	for _, descendant in p1:GetDescendants() do
		if descendant:IsA("BasePart") then
			descendant.Anchored = false
		end
	end

	local __burger_transform = PrimaryPart:FindFirstChild("__burger_transform")

	if __burger_transform and __burger_transform:IsA("Motor6D") then
		return __burger_transform
	end

	local Motor6D = Instance.new("Motor6D")

	Motor6D.Name = "__burger_transform"
	Motor6D.Part0 = workspace.Terrain
	Motor6D.Part1 = PrimaryPart
	Motor6D.Parent = PrimaryPart

	return Motor6D
end
local function isBrainrotBelow(vector3: Vector3)
	for _, v29 in AnimalController:GetAnimals() do
		local AnimalModel = v29.AnimalModel

		if not AnimalModel then
			continue
		end

		local Position = AnimalModel:GetPivot().Position
		local v32 = Position.X - vector3.X
		local v33 = Position.Z - vector3.Z

		if v32 * v32 + v33 * v33 <= 64 then
			return true
		end
	end

	return false
end

function t1.OnStart(_)
	assert((EventController:GetActiveEventData(scriptName)))
	u16 = true
	v14:Add(function()
		u16 = false
		table.clear(t2)
	end)
	EffectController:Activate("Blink")
	v14:Add(function()
		EffectController:Activate("Blink")
	end)
	ReplicatedStorage:SetAttribute("RainingBurgersEvent", true)
	SoundController:UpdateOST()
	v14:Add(function()
		ReplicatedStorage:SetAttribute("RainingBurgersEvent", nil)
		SoundController:UpdateOST()
	end)

	local RainingBurgersMap = script:FindFirstChild("RainingBurgersMap")

	if RainingBurgersMap then
		v14:Clone(RainingBurgersMap).Parent = workspace
	end

	v14:Add(Observers.observeTag("HideInRainingBurgers", function(p3)
		local p3Parent = p3.Parent

		p3.Parent = script

		return function()
			pcall(function()
				p3.Parent = p3Parent
			end)
		end
	end, {
		workspace,
		script
	}))

	local Folder = Instance.new("Folder")

	Folder.Name = "RainingBurgers"
	Folder.Parent = workspace
	v14:Add(Folder)

	local GroundVFX = script:FindFirstChild("GroundVFX")
	local StruckVFX = script:FindFirstChild("StruckVFX")
	local raycastParams = RaycastParams.new()

	raycastParams.IncludeInstances = {
		workspace.Map,
		workspace.Plots
	}
	raycastParams.RespectCanCollide = true
	raycastParams.CollisionGroup = "Burger"

	local t3 = {}

	local function dropBurger(vector3: Vector3, p4, s1: string?, n1: number?)
		local Burger = script:FindFirstChild("Burger")
		local v52 = if not Burger or (not Burger:IsA("Model") or not Burger.PrimaryPart) then nil else Burger

		if not v52 then
			return
		end

		if n1 then
		else
			local raycastResult = workspace:Raycast(vector3, Vector3.new(0, -3000, 0), raycastParams)

			n1 = if not raycastResult then vector3.Y - 3000 else raycastResult.Position.Y
		end

		local v54 = table.remove(t2, 1) or v52:Clone()
		local v55 = setupBurger(v54)

		if not v55 then
			v54:Destroy()

			return
		end

		if v54.Parent == nil then
			v54.Parent = Folder
		end

		table.insert(t3, {
			model = v54,
			motor = v55,
			x = vector3.X,
			z = vector3.Z,
			y = vector3.Y,
			groundY = n1,
			rotation = CFrame.Angles(math.random() * 6.283185307179586, math.random() * 6.283185307179586, math.random() * 6.283185307179586),
			expires = os.clock() + 12,
			impactVFX = p4,
			strikeUid = s1
		})
	end
	local function release(t4: {[any]: any})
		if u16 and #t2 < 64 then
			t4.motor.Transform = CFrame.new(0, -100000, 0)
			table.insert(t2, t4.model)

			return
		end

		t4.model:Destroy()
	end

	v14:Add(RunService.PostSimulation:Connect(function(n2: number)
		local elapsed = os.clock()

		for i = #t3, 1, -1 do
			local v60 = t3[i]

			if not v60.model.Parent then
				table.remove(t3, i)
			else
				v60.y = v60.y - n2 * 145

				if v60.strikeUid then
					local v61 = ClientEventUtils.getAnimalPosition(v60.strikeUid, {
						top = true
					})

					if v61 and v61 ~= Vector3.new(0, 0, 0) then
						v60.x = v61.X
						v60.z = v61.Z
						v60.groundY = v61.Y
					end
				end

				v60.motor.Transform = CFrame.new(v60.x, v60.y, v60.z) * v60.rotation

				local v62 = v60.y <= v60.groundY

				if v62 or elapsed >= v60.expires then
					local impactVFX = v60.impactVFX

					if v62 and impactVFX and impactVFX:IsA("BasePart") then
						if v60.strikeUid then
							ClientEventUtils.playBurst(impactVFX, v60.strikeUid, { ReplicatedStorage.Sounds.Events["Raining Burgers"]["Brainrot Hit"] })
						else
							ClientEventUtils.playBurst(impactVFX, Vector3.new(v60.x, v60.groundY, v60.z), { ReplicatedStorage.Sounds.Events["Raining Burgers"]["Hit Nothing"] })
						end
					end

					if u16 and #t2 < 64 then
						v60.motor.Transform = CFrame.new(0, -100000, 0)
						table.insert(t2, v60.model)
					else
						v60.model:Destroy()
					end

					table.remove(t3, i)
				end
			end
		end
	end))
	v14:Add(Timer.Simple(0.1, function()
		local AmbientSpawnArea = script:FindFirstChild("AmbientSpawnArea")

		if not AmbientSpawnArea or not AmbientSpawnArea:IsA("BasePart") then
			return
		end

		local AmbientSpawnAreaCFrame = AmbientSpawnArea.CFrame
		local AmbientSpawnAreaSize = AmbientSpawnArea.Size

		for _ = 1, 2 do
			local v68 = AmbientSpawnAreaCFrame * Vector3.new((math.random() - 0.5) * AmbientSpawnAreaSize.X, (math.random() - 0.5) * AmbientSpawnAreaSize.Y, (math.random() - 0.5) * AmbientSpawnAreaSize.Z)

			if not isBrainrotBelow(v68) then
				dropBurger(v68, GroundVFX)
			end
		end
	end))
	v14:Add(v12.OnClientEvent:Connect(function(s2: string)
		local v70 = ClientEventUtils.getAnimalPosition(s2, {
			top = true
		})

		if not v70 or v70 == Vector3.new(0, 0, 0) then
			return
		end

		dropBurger(v70 + Vector3.new(0, 120, 0), StruckVFX, s2, v70.Y)
	end))
end
function t1.OnStop(_)
	v14:Destroy()
end
function t1.OnLoad(_)
end

return t1
