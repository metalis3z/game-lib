local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ServicesFolder = ServerScriptService:WaitForChild("Services")
local AnimalServiceModule = ServicesFolder:WaitForChild("AnimalService")
local AnimalService = require(AnimalServiceModule)

local Animals = require(ReplicatedStorage.Datas.Animals)
local PlotService = require(ServerScriptService.Services.PlotService)

local Net = require(ReplicatedStorage.Packages.Net)
local EventService
local HitEvent = Net:RemoteEvent("PinataService/Hit")
local BurstEvent = Net:RemoteEvent("PinataService/Burst")
local SpawnGearEvent = Net:RemoteEvent("PinataService/SpawnGear")
local DestroyGearEvent = Net:RemoteEvent("PinataService/DestroyGear")
local PickGearEvent = Net:RemoteEvent("PinataService/PickGear")
local BlinkEvent = Net:RemoteEvent("PinataService/Blink")

local PinataEvent = {}
PinataEvent.__index = PinataEvent

local HIT_DAMAGE = 20
local HIT_SOUND_ID = "rbxassetid://87356355345397"
local DESTROY_SOUND_ID = "rbxassetid://74218058320776"

local HIT_RADIUS = 15
local PUSH_FORCE = 50
local IMPULSE_DURATION = 0.5
local SPIN_FORCE = 80

local activeGearVisuals = {}

function PinataEvent.new()
	return setmetatable({}, PinataEvent)
end

function PinataEvent:OnStart()
	PickGearEvent.OnServerEvent:Connect(function(player, gearName)
		if not player or not gearName then return end
		local gearTemplate = ReplicatedStorage:FindFirstChild("Items") and ReplicatedStorage.Items:FindFirstChild(gearName)
		if not gearTemplate then
			warn("PickGearEvent: Gear not found:", gearName)
			return
		end

		local gearClone = gearTemplate:Clone()
		gearClone.Parent = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack")
		DestroyGearEvent:FireAllClients(gearName)
	end)
	local sourceFolder = script:FindFirstChild("PinataEvent")
	if not sourceFolder then return end

	local clonedFolder = sourceFolder:Clone()
	clonedFolder.Name = "PinataEvent"
	clonedFolder.Parent = Workspace

	local mainPinataPart = nil
	for _, part in ipairs(clonedFolder:GetDescendants()) do
		if part:IsA("BasePart") and CollectionService:HasTag(part, "Pinata") then
			mainPinataPart = part
			if part:GetAttribute("Health") == nil then
				part:SetAttribute("Health", 100)
			end
			part.CanTouch = true
		end
	end

	local pinataModel = clonedFolder:FindFirstChild("Pinata")
	if pinataModel then
		for _, part in ipairs(pinataModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanTouch = true
				if not CollectionService:HasTag(part, "Pinata") then
					CollectionService:AddTag(part, "Pinata")
				end
			end
		end
	end
end

function PinataEvent:HandleHit(player, handle)
	if not handle or not handle:IsA("BasePart") then return end
	local folder = Workspace:FindFirstChild("PinataEvent")
	if not folder then return end

	local mainPinataPart = nil
	local pinataModel = folder:FindFirstChild("Pinata")
	if pinataModel then
		for _, part in ipairs(pinataModel:GetDescendants()) do
			if part:IsA("BasePart") and part:GetAttribute("Health") then
				mainPinataPart = part
				break
			end
		end
		if not mainPinataPart then
			for _, part in ipairs(pinataModel:GetDescendants()) do
				if part:IsA("BasePart") and part.Name == "Part" and part:FindFirstChild("Attachment") then
					mainPinataPart = part
					break
				end
			end
		end
	end

	if not mainPinataPart then return end

	local health = mainPinataPart:GetAttribute("Health") or 100
	local distance = (handle.Position - mainPinataPart.Position).Magnitude

	if distance <= HIT_RADIUS then
		health = math.max(0, health - HIT_DAMAGE)
		mainPinataPart:SetAttribute("Health", health)

		local pushDir = (mainPinataPart.Position - handle.Position).Unit
		pushDir = (pushDir + Vector3.new(0, 0.35, 0)).Unit

		for _, child in ipairs(mainPinataPart:GetChildren()) do
			if child:IsA("BodyVelocity") or child:IsA("AngularVelocity") then
				child:Destroy()
			end
		end

		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Velocity = pushDir * PUSH_FORCE
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVelocity.P = 1e5
		bodyVelocity.Parent = mainPinataPart

		local spinVec = Vector3.new(
			math.random(-SPIN_FORCE, SPIN_FORCE),
			math.random(-SPIN_FORCE, SPIN_FORCE),
			math.random(-SPIN_FORCE, SPIN_FORCE)
		)
		local angularVelocity = Instance.new("AngularVelocity")
		angularVelocity.AngularVelocity = spinVec
		angularVelocity.MaxTorque = 1e6
		angularVelocity.ReactionTorqueEnabled = false
		angularVelocity.Parent = mainPinataPart

		local STEPS     = 60
		local STEP_TIME = IMPULSE_DURATION / STEPS
		local startVel  = pushDir * PUSH_FORCE
		local startSpin = spinVec

		task.spawn(function()
			for i = 1, STEPS do
				local t     = 1 - (i / STEPS)
				local eased = t * t * t

				if not bodyVelocity.Parent or not angularVelocity.Parent then break end

				bodyVelocity.Velocity           = startVel   * eased
				angularVelocity.AngularVelocity = startSpin  * eased

				task.wait(STEP_TIME)
			end

			if bodyVelocity.Parent    then bodyVelocity:Destroy()    end
			if angularVelocity.Parent then angularVelocity:Destroy() end
		end)

		local hitSound = Instance.new("Sound")
		hitSound.SoundId = HIT_SOUND_ID
		hitSound.Volume = 1
		hitSound.Parent = mainPinataPart
		hitSound:Play()
		Debris:AddItem(hitSound, 2)

		HitEvent:FireAllClients(mainPinataPart.Position)

		if health <= 0 then
			local destroySound = Instance.new("Sound")
			destroySound.SoundId = DESTROY_SOUND_ID
			destroySound.Volume = 1
			destroySound.Parent = mainPinataPart
			destroySound.PlayOnRemove = true
			destroySound:Play()
			Debris:AddItem(destroySound, 3)

			BurstEvent:FireAllClients(mainPinataPart.Position)

			BlinkEvent:FireAllClients()

			local pinataFolder = Workspace:FindFirstChild("Events") and Workspace.Events:FindFirstChild("Pinata")
			if pinataFolder then
				local gearList = {
					"Candy Bomb",
					"Candy Coils",
					"Candy Launcher",
					"Confetti Cannon",
					"Jelly Gun",
					"Sweet Scythe",
					"Lollipop"
				}

				for _, gearName in ipairs(gearList) do
					local parts = {}
					for _, p in ipairs(pinataFolder:GetDescendants()) do
						if p:IsA("BasePart") then
							table.insert(parts, p)
						end
					end
					if #parts > 0 then
						local randomPart = parts[math.random(1, #parts)]
						local size = randomPart.Size
						local randomPos = randomPart.Position
							+ Vector3.new(
								math.random(-size.X/2, size.X/2),
								math.random(0, size.Y),
								math.random(-size.Z/2, size.Z/2)
							)

						SpawnGearEvent:FireAllClients(
							gearName,
							gearName,
							randomPos,
							randomPos + Vector3.new(0,5,0),
							tick(),
							1
						)
					end
				end
			end

			local ANIMAL_POOL = {
				{ name = "Corn Corn Corn Sahur", weight = 70 },
				{ name = "Mariachi Corazoni",    weight = 20 },
				{ name = "Los Mariachis",        weight = 10 },
			}

			local totalWeight = 0
			for _, entry in ipairs(ANIMAL_POOL) do
				totalWeight += entry.weight
			end

			local roll = math.random() * totalWeight
			local chosen = ANIMAL_POOL[1].name
			local cumulative = 0
			for _, entry in ipairs(ANIMAL_POOL) do
				cumulative += entry.weight
				if roll <= cumulative then
					chosen = entry.name
					break
				end
			end

			print("✨ Successfully spawned animal: " .. chosen)
			local id = nil
			local playerPlot = PlotService.getPlot(player)
			if playerPlot and Animals[chosen] then
				local animalInfo = Animals[chosen]
				id = AnimalService:SpawnNoDelay(animalInfo, nil, nil, nil, {
					Start = mainPinataPart,
					End   = playerPlot.AnimalTarget,
					Owner = player,
				})
			end
			local TweenService = game:GetService("TweenService")

			local animalmodel = workspace:WaitForChild(id, 5)

			if animalmodel and animalmodel.PrimaryPart then
				animalmodel:SetAttribute("ForceIdle", true)

				local info = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

				local currentPos = animalmodel.PrimaryPart.Position
				local targetY = workspace.MapCenterGround.Position.Y

				local targetCFrame = CFrame.new(currentPos.X, targetY, currentPos.Z) 
					* CFrame.Angles(0, math.rad(180), 0)

				local goal = {CFrame = targetCFrame}

				local tween = TweenService:Create(animalmodel.PrimaryPart, info, goal)
				tween:Play()

				task.delay(3, function()
					if animalmodel then
						animalmodel:SetAttribute("ForceIdle", nil)
					end
				end)
			else
				warn("Animal model or PrimaryPart not found!")
			end
			task.delay(0.1, function()
				local pinataModel = mainPinataPart.Parent
				if pinataModel then
					pinataModel:Destroy()
				else
					mainPinataPart:Destroy()
				end
				if not EventService then EventService = require(ServerScriptService.Services.EventService) end
				EventService:CancelEvent(script.Name)
			end)
		end
	end
end


function PinataEvent:OnStop()
	local folderInWorkspace = Workspace:FindFirstChild("PinataEvent")
	if folderInWorkspace then
		folderInWorkspace:Destroy()
	end
end

return PinataEvent