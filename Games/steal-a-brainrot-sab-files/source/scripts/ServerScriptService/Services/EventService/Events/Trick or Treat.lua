local TrickOrTreat = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Synchronizer = require(Packages.Synchronizer)
local Observers = require(Packages.Observers)
local CandyService = require(game.ServerScriptService.Services.CandyService)
local Ragdoll = require(Packages.Ragdoll)
local Trove = require(ReplicatedStorage.Packages.Trove)

local Animals = require(ReplicatedStorage.Datas.Animals)

local v_u_23 = script.Name
local v_u_24 = Net:RemoteEvent((("EventService/%*/BrainrotCandyAnimation"):format(v_u_23)))
local v_u_25 = Net:RemoteEvent((("EventService/%*/BrainrotHitAnimation"):format(v_u_23)))
local v_u_26 = Net:RemoteEvent((("EventService/%*/PlayerCandyAnimation"):format(v_u_23)))
local v_u_27 = Net:RemoteEvent((("EventService/%*/ScreenCandyAnimation"):format(v_u_23)))
local v_u_28 = Net:RemoteEvent((("EventService/%*/Burst"):format(v_u_23)))
local atugofwarofleaveandstay = Net:RemoteEvent((("EventService/%*/FollowBrainrot"):format(v_u_23)))
local Notify = Net:RemoteEvent("NotificationService/Notify")

local HitAnimations = game.ReplicatedStorage.Controllers.EventController.Events["Trick or Treat"].HitAnimations
local Animations = game.ReplicatedStorage.Controllers.EventController.Events["Trick or Treat"].Animations
local Map = workspace.Map
local Pumpkins = workspace.Events["Trick or Treat"]:WaitForChild("Pumpkins")

local eventStartTime
local isActive

local eventTrove = Trove.new()

local radAnimals = {
	"La Casa Boo",
	"Pot Pumpkin",
	"Trickolino"
}

local targetted = {}
local pTasks = {}

local function isoccupied(pumpkin)
	return pTasks[pumpkin] ~= nil
end

local function unoccupy(pumpkin)
	local trove = pTasks[pumpkin]
	if trove then
		trove:Clean()
	end
	pTasks[pumpkin] = nil
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

	local pumpkinTrove = Trove.new()
	pTasks[pumpkin] = pumpkinTrove

	pumpkin:SetAttribute("Moving", true)
	pumpkinTrove:Add(function()
		pumpkin:SetAttribute("Moving", false)
	end)

	local animalId = targetAnimal.Name
	local origPos = pumpkin.Position

	targetted[animalId] = workspace:GetServerTimeNow()

	task.spawn(function()
		pumpkinTrove:Connect(RunService.Heartbeat, function(dt)
			if not targetAnimal or not targetAnimal.Parent or not targetAnimal.PrimaryPart then
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
				pumpkinTrove:Clean()
				apply(targetAnimal)
				v_u_28:FireAllClients(animalId)

				task.wait(1.5)

				local returnTrove = Trove.new()
				pTasks[pumpkin] = returnTrove

				pumpkin:SetAttribute("Moving", true)
				returnTrove:Add(function()
					pumpkin:SetAttribute("Moving", false)
				end)

				returnTrove:Connect(RunService.Heartbeat, function(dt2)
					local currPos = pumpkin.Position
					local dirBack = (origPos - currPos)
					local distBack = dirBack.Magnitude

					if distBack < 0.5 then
						returnTrove:Clean()
						pTasks[pumpkin] = nil
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
	end)
end

function TrickOrTreat.OnStart()
	if isActive then return end
	isActive = true

	eventTrove = Trove.new()

	ReplicatedStorage:SetAttribute("TrickOrTreatEvent", true)
	eventTrove:Add(function()
		ReplicatedStorage:SetAttribute("TrickOrTreatEvent", false)
		ReplicatedStorage:SetAttribute("TrickOrTreatEvent", nil)
	end)

	local Houses = eventTrove:Clone(script.Houses)
	Houses.Parent = workspace

	eventStartTime = workspace:GetServerTimeNow()

	local hiddenWalls = {}

	for _, wallSides in pairs(Map:GetDescendants()) do
		if wallSides and Map:FindFirstChild("GenerationBoard") then
			if wallSides:IsA("Part") and wallSides:GetAttribute("Side") and wallSides.Name ~= "Ground_Right" and wallSides:GetAttribute("Side") == "Right" or wallSides.Name ~= "Ground_Left" and wallSides:GetAttribute("Side") == "Left" then
				local originalTransparency = wallSides.Transparency
				wallSides.Transparency = 1
				table.insert(hiddenWalls, { wall = wallSides, original = originalTransparency })
			end
		end
	end

	eventTrove:Add(function()
		for _, entry in ipairs(hiddenWalls) do
			if entry.wall and entry.wall.Parent then
				entry.wall.Transparency = entry.original
			end
		end
	end)

	local loopThread = task.spawn(function()
		while isActive do
			task.wait(3)
			local targetAnimal = pick()
			if targetAnimal then
				hit(targetAnimal)
			end
		end
	end)
	eventTrove:Add(loopThread)

	eventTrove:Add(function()
		for pumpkin, trove in pairs(pTasks) do
			trove:Clean()
			pTasks[pumpkin] = nil
		end
		table.clear(targetted)
	end)

	local observerCleanup = Observers.observeTag("TrickOrTreatHousePrompt", function(prmpt: Part)
		local prompt = prmpt:FindFirstChildWhichIsA("ProximityPrompt")
		if not prompt then return end

		local promptTrove = Trove.new()

		promptTrove:Connect(prompt.Triggered, function(plr)
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
			local chance = chanceRoll <= treatChance and 1 or 2

			local animal = SharedAnimals.GetAnimatedModel(nil, animalRad, "Idle")

			prompt.Enabled = false
			prompt:Destroy()

			local doorbell = promptTrove:Clone(script.Doorbell)
			doorbell.Parent = prmpt
			doorbell:Play()

			animal.Parent = workspace
			promptTrove:Add(animal)

			local startTime = tick()
			while not animal.PrimaryPart and tick() - startTime < 2 do
				task.wait(0.05)
			end
			if animal.PrimaryPart then
				animal:PivotTo(prmpt.Parent.SpawnBrainrot.CFrame)
				animal.PrimaryPart.Anchored = true
			end

			task.wait(1.5)
			promptTrove:Remove(doorbell)
			doorbell:Destroy()

			if not door:GetAttribute("Open") then
				door:SetAttribute("Open", true)
			end

			promptTrove:Add(function()
				if door and door.Parent then
					door:SetAttribute("Open", false)
				end
			end)

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
					candySound.SoundId = "rbxassetid://119143644355689"
					candySound.Volume = 0.5
					candySound.Parent = prmpt
					candySound:Play()
					CandyService:Add(plr, radCandies)
					task.wait(1.5)
					candySound:Destroy()
				end)

				task.wait(1)
				door:SetAttribute("Open", false)

				if plr.Character then
					plr:SetAttribute("Ragdolled", nil)
					Ragdoll.Unragdoll(plr.Character)
				end

				task.wait(2)
				promptTrove:Remove(animal)
				animal:Destroy()
			else
				local Animation = HitAnimations:FindFirstChild(animal.Name)
				local Anim = animal.AnimationController.Animator:LoadAnimation(Animation)
				Anim:Play()

				pcall(function()
					local hitSound = Instance.new("Sound")
					hitSound.SoundId = "rbxassetid://128476264357679"
					hitSound.Volume = 0.5
					hitSound.Parent = prmpt
					hitSound:Play()
					task.wait(1)
					hitSound:Destroy()
				end)

				plr:SetAttribute("Ragdolled", true)
				Ragdoll.Ragdoll(plr.Character)

				promptTrove:Add(function()
					if plr and plr.Parent and plr.Character then
						plr:SetAttribute("Ragdolled", nil)
						Ragdoll.Unragdoll(plr.Character)
					end
				end)

				task.wait(0.419)
				Anim:Stop()
				task.wait(1)

				door:SetAttribute("Open", false)
				plr:SetAttribute("Ragdolled", nil)
				Ragdoll.Unragdoll(plr.Character)
				task.wait(2)
				promptTrove:Remove(animal)
				animal:Destroy()
			end

			promptTrove:Clean()
		end)

		return function()
			promptTrove:Clean()
		end
	end)

	if observerCleanup then
		eventTrove:Add(observerCleanup)
	end
end

function TrickOrTreat.OnStop()
	if not isActive then return end
	isActive = false

	eventTrove:Clean()
end

return TrickOrTreat