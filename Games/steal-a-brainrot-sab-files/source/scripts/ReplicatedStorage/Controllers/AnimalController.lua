-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Packages = ReplicatedStorage:WaitForChild("Packages")

local Observers = require(Packages.Observers)
local Synchronizer = require(Packages.Synchronizer)
local Signal = require(Packages.Signal)
local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local AnimalClient = require(Classes.AnimalClient)

local AnimalCache = {}
local LocalPlayer = Players.LocalPlayer
local GlobalFireServer = Instance.new("RemoteEvent").FireServer

local PurchaseRemote = Net:RemoteEvent("156ed911-fc4b-4d24-a648-acd1e9761e4f")
local InteractRemote = Net:RemoteEvent("f756228f-15f8-4b6d-93a4-dfe62bb409cb")

local AnimalController = {
	OnAnimalSpawn = Signal.new(),
	OnAnimalDestroyed = Signal.new(),
	OnFollowingChanged = Signal.new(),

	HasAnimalMovingToBase = function()
		for _, animal in pairs(AnimalCache) do
			local instance = animal.Instance
			local primaryPart = instance and instance.PrimaryPart
			local attachment = primaryPart and primaryPart:FindFirstChild("PromptAttachment")
			local prompt = attachment and attachment:FindFirstChild("ProximityPrompt")

			if prompt and prompt:GetAttribute("TargetPlayer") == LocalPlayer.UserId then
				return animal
			end
		end
	end,

	HasAnimal = function(self, animalIndex, requiredCount)
		local countThreshold = requiredCount or 1
		local syncData = Synchronizer:Get(LocalPlayer)

		if not syncData then
			return false
		else
			local ownedCount = 0
			local podiumIds = {}
			for podiumId, data in syncData:Get("AnimalPodiums") do
				if data ~= "Empty" and data.Index == animalIndex then
					ownedCount = ownedCount + 1
					table.insert(podiumIds, podiumId)
				end
			end
			return countThreshold <= ownedCount, podiumIds
		end
	end,

	GetAnimals = function()
		return AnimalCache
	end
}

AnimalController.Start = function()
	Observers.observeTag("Animal", function(instance)
		local animalObj

		if instance:GetAttribute("BackroomsToAnimalSwap") then
			for _, cached in pairs(AnimalCache) do
				if cached.Instance == instance then
					animalObj = cached
					break
				end
			end
			instance:SetAttribute("BackroomsToAnimalSwap", nil)
		end

		if not animalObj and instance:GetAttribute("1x1x1x1ToAnimalSwap") then
			for _, cached in pairs(AnimalCache) do
				if cached.Instance == instance then
					animalObj = cached
					break
				end
			end
			instance:SetAttribute("1x1x1x1ToAnimalSwap", nil)
		end

		if not animalObj then
			animalObj = AnimalClient.new(instance)
			if not animalObj then return end
			AnimalCache[animalObj:GetUID()] = animalObj
			AnimalController.OnAnimalSpawn:Fire(animalObj)
		end

		return function()
			if not animalObj then return end
			if AnimalCache[animalObj:GetUID()] ~= animalObj then return end
			local uid = animalObj.UID
			animalObj:Destroy()
			AnimalCache[uid] = nil
			AnimalController.OnAnimalDestroyed:Fire(uid)
		end
	end)
	Observers.observeTag("1x1x1x1animal", function(instance)
		local animalObj = AnimalClient.new(instance)
		if not animalObj then return function() end end
		AnimalCache[animalObj:GetUID()] = animalObj

		AnimalController.OnAnimalSpawn:Fire(animalObj)

		return function()
			if instance:GetAttribute("1x1x1x1ToAnimalSwap") then
				task.delay(0.5, function()
					if AnimalCache[animalObj:GetUID()] == animalObj
						and not instance:HasTag("Animal") then
						local uid = animalObj.UID
						animalObj:Destroy()
						AnimalCache[uid] = nil
						AnimalController.OnAnimalDestroyed:Fire(uid)
					end
				end)
				return
			end
			local uid = animalObj.UID
			animalObj:Destroy()
			AnimalCache[uid] = nil
			AnimalController.OnAnimalDestroyed:Fire(uid)
		end
	end)
	Observers.observeTag("AnimalPurchasePrompt", function(prompt)
		local tracker = Trove.new()

		local function updateVisibility()
			local isVisible = false
			if prompt:GetAttribute("TargetPlayer") ~= LocalPlayer.UserId then
				isVisible = not prompt:GetAttribute("Disabled")
			end
			prompt.Enabled = isVisible
		end

		tracker:Add(prompt:GetAttributeChangedSignal("TargetPlayer"):Connect(updateVisibility))
		tracker:Add(prompt:GetAttributeChangedSignal("Disabled"):Connect(updateVisibility))

		updateVisibility()

		local animalUID = prompt:GetAttribute("UID")

		tracker:Add(prompt.PromptButtonHoldBegan:Connect(function()
			local timestamp = workspace:GetServerTimeNow() + 142
			GlobalFireServer(InteractRemote, timestamp, "fa977cd5-427c-407c-a672-f287d64070ce")
			InteractRemote:FireServer(timestamp, "a522d125-48d8-497c-a586-d42e60018a78")
		end))

		tracker:Add(prompt.Triggered:Connect(function()
			local timestamp = workspace:GetServerTimeNow() + 159
			GlobalFireServer(PurchaseRemote, timestamp, "bee1f514-73ec-4598-8df6-e25dd89b6f73", animalUID)
			PurchaseRemote:FireServer(timestamp, "338d0008-b86e-45c8-b1f6-50aaf710e48d", animalUID)
		end))

		return function()
			tracker:Destroy()
		end
	end)
end

return AnimalController