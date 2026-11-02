local TrickOrTreat = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")

local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Synchronizer = require(Packages.Synchronizer)
local Observers = require(Packages.Observers)
local Ragdoll = require(Packages.Ragdoll)

local eventName = script.Name
local BrainrotCandyAnimation = Net:RemoteEvent(("EventService/%*/BrainrotCandyAnimation"):format(eventName))
local BrainrotHitAnimation = Net:RemoteEvent(("EventService/%*/BrainrotHitAnimation"):format(eventName))
local PlayerCandyAnimation = Net:RemoteEvent(("EventService/%*/PlayerCandyAnimation"):format(eventName))
local ScreenCandyAnimation = Net:RemoteEvent(("EventService/%*/ScreenCandyAnimation"):format(eventName))
local Burst = Net:RemoteEvent(("EventService/%*/Burst"):format(eventName))
local Notify = Net:RemoteEvent("NotificationService/Notify")

local HitAnimations = ReplicatedStorage.Controllers.EventController.Events["Trick or Treat"].HitAnimations
local Animations = ReplicatedStorage.Controllers.EventController.Events["Trick or Treat"].Animations
local Map = workspace.Map

local isActive = false
local connections = {}

local radAnimals = {
	"La Casa Boo",
	"Pot Pumpkin",
	"Trickolino"
}

local function addCandyCorn(player, amount)
	local channel = Synchronizer:Get(player)
	if not channel then return 0 end

	local current = channel:Get("HalloweenEvent.CandyCorn") or 0
	local newAmount = current + amount

	channel:Set("HalloweenEvent.CandyCorn", newAmount)
	return newAmount
end

function TrickOrTreat.OnStart()
	if isActive then return end
	isActive = true

	ReplicatedStorage:SetAttribute("TrickOrTreatEvent", true)

	local Houses = script.Houses:Clone()
	Houses.Parent = workspace

	for _, part in ipairs(Map:GetDescendants()) do
		if part:IsA("Part") and part:GetAttribute("Side") then
			local side = part:GetAttribute("Side")
			if (side == "Right" and part.Name ~= "Ground_Right") or (side == "Left" and part.Name ~= "Ground_Left") then
				part.Transparency = 1
			end
		end
	end

	Observers.observeTag("TrickOrTreatHousePrompt", function(prmpt)
		local prompt = prmpt:FindFirstChildWhichIsA("ProximityPrompt")
		if not prompt then return end

		local radCandies = math.random(500, 501)

		local connection = prompt.Triggered:Connect(function(plr)
			if not plr or not plr:IsA("Player") then return end

			local animalName = radAnimals[math.random(#radAnimals)]
			local door = prmpt.Parent:FindFirstChild("Door")
			local spawnPoint = prmpt.Parent:FindFirstChild("SpawnBrainrot")
			if not door or not spawnPoint then return end

			local animal = SharedAnimals.GetAnimatedModel(nil, animalName, "Idle")
			local sound = script.Doorbell:Clone()

			prompt.Enabled = false

			sound.Parent = prmpt
			sound:Play()

			animal.Parent = workspace
			animal:PivotTo(spawnPoint.CFrame)
			animal.PrimaryPart.Anchored = true

			task.wait(1.5)
			sound:Destroy()

			door:SetAttribute("Open", true)
			task.wait(1)

				local anim = Animations:FindFirstChild(animal.Name)
				if anim then
					local track = animal.AnimationController.Animator:LoadAnimation(anim)
					track:Play()

				BrainrotCandyAnimation:FireClient(plr, "", spawnPoint.CFrame)
				ScreenCandyAnimation:FireClient(plr, plr)

				local total = addCandyCorn(plr, radCandies)

				Notify:FireClient(
					plr,
					string.format("<b>%s</b> gave you %d <font color='#FFA500'>Candy Corn</font>!", animal.Name, radCandies),
					6,
					"Sounds.Sfx.Success"
				)

				task.wait(1)
			else
				local anim = HitAnimations:FindFirstChild(animal.Name)
				if anim then
					local track = animal.AnimationController.Animator:LoadAnimation(anim)
					track:Play()
				end

				plr:SetAttribute("Ragdolled", true)
				Ragdoll.Ragdoll(plr.Character)

				task.wait(1)

				plr:SetAttribute("Ragdolled", nil)
				Ragdoll.Unragdoll(plr.Character)
			end

			door:SetAttribute("Open", false)
			task.wait(2)
			animal:Destroy()
		end)

		table.insert(connections, connection)
	end)

	local spookyBlock = workspace:FindFirstChild("Spooky Lucky Block")
	if spookyBlock then
		local prompt = spookyBlock:FindFirstChildWhichIsA("ProximityPrompt", true)
		if prompt then
			local connection = prompt.Triggered:Connect(function(player)
				local channel = Synchronizer:Get(player)
				if not channel then return end

				local candy = channel:Get("HalloweenEvent.CandyCorn") or 0

				if candy >= 500 then
					channel:Set("HalloweenEvent.CandyCorn", candy - 500)

					local animalData = Animals["Spooky Lucky Block"]
					if animalData then
						AnimalService.spawnAnimalCustom(animalData, nil, nil, nil)
						Notify:FireClient(player, "<b>You Spawned In A Spooky Lucky Block</b>", 5, "Sounds.Sfx.Success")
					end
				else
					Notify:FireClient(player, "<b>You need 500 Candy Corn!</b>", 4, "Sounds.Sfx.Error")
				end
			end)

			table.insert(connections, connection)
		end
	end
end

function TrickOrTreat.OnStop()
	if not isActive then return end

	for _, part in ipairs(Map:GetDescendants()) do
		if part:IsA("Part") and part:GetAttribute("Side") then
			part.Transparency = 0
		end
	end

	for _, c in ipairs(connections) do
		c:Disconnect()
	end
	connections = {}

	local houses = workspace:FindFirstChild("Houses")
	if houses then
		houses:Destroy()
	end

	isActive = false
	ReplicatedStorage:SetAttribute("TrickOrTreatEvent", nil)
end

return TrickOrTreat