--!strict
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Fix for syntax highlighting: split into multiple steps
local ServicesFolder = ServerScriptService:WaitForChild("Services")
local AnimalServiceModule = ServicesFolder:WaitForChild("AnimalService")
local AnimalService = require(AnimalServiceModule)

local Animals = require(ReplicatedStorage.Datas.Animals)
local PlotService = require(ServerScriptService.Services.PlotService)

local Net = require(ReplicatedStorage.Packages.Net)

-- RemoteEvents from your original VFX script
local HitEvent = Net:RemoteEvent("PinataService/Hit")
local BurstEvent = Net:RemoteEvent("PinataService/Burst")
local SpawnGearEvent = Net:RemoteEvent("PinataService/SpawnGear")
local DestroyGearEvent = Net:RemoteEvent("PinataService/DestroyGear")
local PickGearEvent = Net:RemoteEvent("PinataService/PickGear")
local BlinkEvent = Net:RemoteEvent("PinataService/Blink")

local PinataEvent = {}
PinataEvent.__index = PinataEvent

local HIT_DAMAGE = 20
local HIT_SOUND_ID = "rbxassetid://85269399427327"
local DESTROY_SOUND_ID = "rbxassetid://95194617706004"

local HIT_RADIUS = 15
local PUSH_FORCE = 40
local IMPULSE_DURATION = 0.3

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

		-- Clone the gear and parent it to the player's Backpack
		local gearClone = gearTemplate:Clone()
		gearClone.Parent = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack")
		DestroyGearEvent:FireAllClients(gearName)
	end)
	local sourceFolder = script:FindFirstChild("PinataEvent")
	if not sourceFolder then return end

	local clonedFolder = sourceFolder:Clone()
	clonedFolder.Name = "PinataEvent"
	clonedFolder.Parent = Workspace

	for _, part in ipairs(clonedFolder:GetDescendants()) do
		if part:IsA("BasePart") and CollectionService:HasTag(part, "Pinata") then
			if part:GetAttribute("Health") == nil then
				part:SetAttribute("Health", 100)
			end
		end
	end
end

function PinataEvent:HandleHit(player, handle)
	if not handle or not handle:IsA("BasePart") then return end
	local folder = Workspace:FindFirstChild("PinataEvent")
	if not folder then return end

	for _, part in ipairs(folder:GetDescendants()) do
		if part:IsA("BasePart") and CollectionService:HasTag(part, "Pinata") then
			local health = part:GetAttribute("Health") or 100
			local distance = (handle.Position - part.Position).Magnitude

			if distance <= HIT_RADIUS then
				-- Reduce health
				health = math.max(0, health - HIT_DAMAGE)
				part:SetAttribute("Health", health)

				-- Swing away from hit
				local pushDir = (part.Position - handle.Position)
				pushDir = Vector3.new(pushDir.X, 0, pushDir.Z).Unit
				local bodyVelocity = Instance.new("BodyVelocity")
				bodyVelocity.Velocity = pushDir * PUSH_FORCE
				bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
				bodyVelocity.P = 1e5
				bodyVelocity.Parent = part
				Debris:AddItem(bodyVelocity, IMPULSE_DURATION)

				-- Play hit sound
				local hitSound = Instance.new("Sound")
				hitSound.SoundId = HIT_SOUND_ID
				hitSound.Volume = 1
				hitSound.Parent = part
				hitSound:Play()
				Debris:AddItem(hitSound, 2)

				-- Fire Hit VFX
				HitEvent:FireAllClients(part.Position)

				-- Destroy Piñata if health <= 0
				if health <= 0 then
					-- Play destroy sound
					local destroySound = Instance.new("Sound")
					destroySound.SoundId = DESTROY_SOUND_ID
					destroySound.Volume = 1
					destroySound.Parent = part
					destroySound.PlayOnRemove = true
					destroySound:Play()
					Debris:AddItem(destroySound, 3)

					-- Fire Burst VFX
					BurstEvent:FireAllClients(part.Position)

					-- Fire Blink effect ONCE
					BlinkEvent:FireAllClients()

					-- Spawn multiple gear items at random positions within Workspace.Events.Pinata
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
							-- Choose a random part from the Pinata folder
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
										math.random(0, size.Y), -- spawn above the part
										math.random(-size.Z/2, size.Z/2)
									)

								-- Fire spawn event
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
					
					if math.random() <= 0.5 then
						--wait(1)
					local playerPlot = PlotService.getPlot(player)
					if playerPlot and Animals["La Grande Combinasion"] then
						local animalInfo = Animals["La Grande Combinasion"]
						local char = player.Character
						if char then
							local playerPlot = PlotService.getPlot(player)
							if playerPlot and Animals["La Grande Combinasion"] then
								local animalInfo = Animals["La Grande Combinasion"]
								AnimalService.createPurchasableAnimal(animalInfo, nil, nil, nil, {
									Start = part, -- <-- use player's HumanoidRootPart
									End = playerPlot.AnimalTarget,
									Owner = player
								})
							end
						end
						end
					end
					
					-- Destroy Piñata after a short delay
					task.delay(0.1, function()
						part:Destroy()
					end)
				end
			end
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
