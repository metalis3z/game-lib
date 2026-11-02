local TrickOrTreat = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService= game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Synchronizer = require(Packages.Synchronizer)
local Observers = require(Packages.Observers)
local CandyService = require(game.ServerScriptService.Services.CandyService)
local Ragdoll = require(Packages.Ragdoll)

local Animals = require(ReplicatedStorage.Datas.Animals)

local v_u_23 = script.Name
local v_u_24 = Net:RemoteEvent((("EventService/%*/BrainrotCandyAnimation"):format(v_u_23)))
local v_u_25 = Net:RemoteEvent((("EventService/%*/BrainrotHitAnimation"):format(v_u_23)))
local v_u_26 = Net:RemoteEvent((("EventService/%*/PlayerCandyAnimation"):format(v_u_23)))
local v_u_27 = Net:RemoteEvent((("EventService/%*/ScreenCandyAnimation"):format(v_u_23)))
local v_u_28 = Net:RemoteEvent((("EventService/%*/Burst"):format(v_u_23)))
local atugofwarofleaveandstay = Net:RemoteEvent((("EventService/%*/FollowBrainrot"):format(v_u_23)))
local Notify = Net:RemoteEvent("NotificationService/Notify");

local HitAnimations = game.ReplicatedStorage.Controllers.EventController.Events["Trick or Treat"].HitAnimations
local Animations = game.ReplicatedStorage.Controllers.EventController.Events["Trick or Treat"].Animations
local Map = workspace.Map
local Pumpkins = workspace.Events["Trick or Treat"].pumpkinLocations
local sharedAnimal

local eventStartTime
local isActive


local radAnimals = {
	"La Casa Boo",
	"Pot Pumpkin",
	"Trickolino"
}

local targetted = {}
local occupied = {}
local pTasks = {}

function occupy(pumpkin)
	table.insert(occupied, pumpkin)
end

local function unoccupy(pumpkin)
	local connection = pTasks[pumpkin]
	if connection then
		connection:Disconnect()
	end
	pTasks[pumpkin] = nil
end

local function isoccupied(pumpkin)
	return pTasks[pumpkin] ~= nil
end

function pickpumpkin()
	for _, pumpkin in ipairs(Pumpkins:GetChildren()) do
		if not isoccupied(pumpkin) then
			return pumpkin
		end
	end
	warn("No pumpkins available!")
	return nil
end

function has(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then
		return false
	end

	local currentTraitsJson = animalTemplate:GetAttribute("Traits")
	local currentTraits = {}
	if currentTraitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(currentTraitsJson)
		end)
		if success and type(decoded) == "table" then
			currentTraits = decoded
		end
	end

	for _, trait in ipairs(currentTraits) do
		if trait == "Jackolantern Pet" then
			return true
		end
	end

	return false
end

function apply(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then
		return
	end

	local currentTraitsJson = animalTemplate:GetAttribute("Traits")
	local currentTraits = {}
	if currentTraitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(currentTraitsJson)
		end)
		if success and type(decoded) == "table" then
			currentTraits = decoded
		end
	end

	for _, trait in ipairs(currentTraits) do
		if trait == "Jackolantern Pet" then
			return
		end
	end

	table.insert(currentTraits, "Jackolantern Pet")
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
end

function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()

	for animalId, lastTime in pairs(targetted) do
		if (currentTime - lastTime) > 20 then
			targetted[animalId] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart then
			local animalId = animal.Name
			if not targetted[animalId] and not has(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

function hit(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then
		return
	end

	local pumpkin = pickpumpkin()
	if not pumpkin then
		warn("No free pumpkins available!")
		return
	end

	occupy(pumpkin)
	pumpkin:SetAttribute("Moving", true)

	if pTasks[pumpkin] then
		pTasks[pumpkin]:Disconnect()
		pTasks[pumpkin] = nil
	end

	local animalId = targetAnimal.Name
	local origPos = pumpkin.Position

	targetted[animalId] = workspace:GetServerTimeNow()

	task.spawn(function()
		local connection
		connection = RunService.Heartbeat:Connect(function(dt)
			if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then
				connection:Disconnect()
				unoccupy(pumpkin)
				pTasks[pumpkin] = nil
				return
			end

			local currentPos = pumpkin.Position
			local targetPos = targetAnimal.PrimaryPart.Position
			local dir = (targetPos - currentPos)
			local distance = dir.Magnitude

			local speed = 15
			local moveStep = math.min(distance, speed * dt)

			if distance < 1 then
				connection:Disconnect()
				pumpkin:SetAttribute("Moving", false)
				apply(targetAnimal)
				v_u_28:FireAllClients(animalId)

				task.wait(1.5)
				pumpkin:SetAttribute("Moving", true)
				local backConnection
				backConnection = RunService.Heartbeat:Connect(function(dt2)
					local currPos = pumpkin.Position
					local dirBack = (origPos - currPos)
					local distBack = dirBack.Magnitude

					if distBack < 0.5 then
						pTasks[pumpkin] = nil
						backConnection:Disconnect()
						pumpkin:SetAttribute("Moving", false)
						unoccupy(pumpkin)
						return
					end

					local moveBackStep = math.min(distBack, 10 * dt2)
					local newPos = currPos + dirBack.Unit * moveBackStep

					local lookCFrame = CFrame.lookAt(newPos, newPos + dirBack.Unit)
					pumpkin.CFrame = lookCFrame
				end)

				return
			end

			local newPos = currentPos + dir.Unit * moveStep
			local lookCFrame = CFrame.lookAt(newPos, newPos + dir.Unit)
			pumpkin.CFrame = lookCFrame
		end)

		pTasks[pumpkin] = connection
	end)
end



function TrickOrTreat.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("TrickOrTreatEvent", true)
	local Houses = script.Houses:Clone()
	Houses.Parent = workspace
	eventStartTime = workspace:GetServerTimeNow()

	for _, wallSides in pairs(Map:GetDescendants()) do
		if wallSides and Map:FindFirstChild("GenerationBoard") then
			if wallSides:IsA("Part") and wallSides:GetAttribute("Side") and wallSides.Name ~= "Ground_Right" and wallSides:GetAttribute("Side") == "Right" or wallSides.Name ~= "Ground_Left" and wallSides:GetAttribute("Side") == "Left" then
				wallSides.Transparency = 1
			end
		end
	end

	task.spawn(function()
		while isActive do
			task.wait(3)
			local targetAnimal = pick()
			if targetAnimal then
				hit(targetAnimal)
			end
		end
	end)

	Observers.observeTag("TrickOrTreatHousePrompt", function(prmpt: Part)
		local prompt = prmpt:FindFirstChildWhichIsA("ProximityPrompt")
		if not prompt then return end

		prompt.Triggered:Connect(function(plr)
			-- unchanged logic from script 1
			local playerChannel = Synchronizer:Get(plr)
			if not playerChannel then
				warn(("[TrickOrTreat] No Synchronizer channel for player %s"):format(plr.Name))
				return
			end

			if playerChannel:Get("Candies") == nil then
				playerChannel:Set("Candies", 0)
			end

			local possibleValues = {50, 20, 30}
			local radCandies = possibleValues[math.random(1, #possibleValues)]
			local oldAmount = playerChannel:Get("Candies") or 0

			local animalRad = radAnimals[math.random(1, #radAnimals)]
			local door = prmpt.Parent.Door
			local treatChance = 70

			local chanceRoll = math.random(1, 100)
			local chance
			if chanceRoll <= treatChance then
				chance = 1
			else
				chance = 2
			end
			local animal = SharedAnimals.GetAnimatedModel(nil, animalRad, "Idle")

			prompt.Enabled = false
			prompt:Destroy()

			local doorbell = script.Doorbell:Clone()
			doorbell.Parent = prmpt
			doorbell:Play()

			animal.Parent = workspace
			local startTime = tick()
			while not animal.PrimaryPart and tick() - startTime < 2 do
				task.wait(0.05)
			end
			if animal.PrimaryPart then
				animal:PivotTo(prmpt.Parent.SpawnBrainrot.CFrame)
				animal.PrimaryPart.Anchored = true
			end

			task.wait(1.5)
			doorbell:Destroy()

			if not door:GetAttribute("Open") then
				door:SetAttribute("Open", true)
			end

			task.wait(1)

			if chance == 1 then
				local Animation = Animations:FindFirstChild(animal.Name)
				local Anim = animal.AnimationController.Animator:LoadAnimation(Animation)
				Anim:Play()

				v_u_24:FireClient(plr, "", prmpt.Parent.SpawnBrainrot.CFrame)
				v_u_27:FireClient(plr, plr)
				Notify:FireClient(plr,
					string.format("<b>%s</b> gave you %s <font color='#FFA500'>Candies</font>!", animal.Name, radCandies),
					6,
					nil
				)

				pcall(function()
					local candySound = Instance.new("Sound")
					candySound.SoundId = "rbxassetid://131349551014486"
					candySound.Volume = 0.5
					candySound.Parent = prmpt
					candySound:Play()
					CandyService:Add(plr, radCandies)
					task.wait(1.5)
					candySound:Destroy()
				end)

				task.wait(1)
				door:SetAttribute("Open", false)
				plr:SetAttribute("Ragdolled", nil)
				Ragdoll.Unragdoll(plr.Character)
				task.wait(2)
				animal:Destroy()
			else
				local Animation = HitAnimations:FindFirstChild(animal.Name)
				local Anim = animal.AnimationController.Animator:LoadAnimation(Animation)
				Anim:Play()

				pcall(function()
					local hitSound = Instance.new("Sound")
					hitSound.SoundId = "rbxassetid://120943278915142"
					hitSound.Volume = 0.5
					hitSound.Parent = prmpt
					hitSound:Play()
					task.wait(1)
					hitSound:Destroy()
				end)

				plr:SetAttribute("Ragdolled", true)
				Ragdoll.Ragdoll(plr.Character)

				task.wait(0.419)
				Anim:Stop()
				task.wait(1)

				door:SetAttribute("Open", false)
				plr:SetAttribute("Ragdolled", nil)
				Ragdoll.Unragdoll(plr.Character)
				task.wait(2)
				animal:Destroy()
			end
		end)
	end)

end

function TrickOrTreat.OnStop()
	if not isActive then return end
	for _, wallSides in pairs(Map:GetDescendants()) do
		if wallSides and Map:FindFirstChild("GenerationBoard") then
			if wallSides:IsA("Part") and not wallSides.Parent:IsA("Model") and wallSides:GetAttribute("Side") then
				wallSides.Transparency = 0
			else
				warn("no walls!")
			end
		end
	end
	if workspace:FindFirstChild("Houses") and workspace:FindFirstChild("Houses"):IsA("Folder") then
		workspace:FindFirstChild("Houses"):Destroy()
	end

	isActive = false
	ReplicatedStorage:SetAttribute("TrickOrTreatEvent", false)
	ReplicatedStorage:SetAttribute("TrickOrTreatEvent", nil)
end

return TrickOrTreat
