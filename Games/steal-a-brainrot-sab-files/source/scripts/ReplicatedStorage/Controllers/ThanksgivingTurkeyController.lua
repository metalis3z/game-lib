local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local ThanksgivingTurkeyController = {}
local UpdateAnimationEvent = Net:RemoteEvent("ThanksgivingTurkeyService/UpdateAnimation")
local UpdateHealthBarEvent = Net:RemoteEvent("ThanksgivingTurkeyService/UpdateHealthBar")
local PlayAnimationEvent = Net:RemoteEvent("ThanksgivingTurkeyService/PlayAnimation")
local DespawnEvent = Net:RemoteEvent("ThanksgivingTurkeyService/Despawn")
local SpawnEvent = Net:RemoteEvent("ThanksgivingTurkeyService/Spawn")
local trove = Trove.new()
local maxHealth = 10
local currentHealth = maxHealth
local healthBarGui = nil

function ThanksgivingTurkeyController.Start(_)
	local function updateHealthBar()
		if healthBarGui then
			healthBarGui.Progress.Label.Text = ("%*/%*"):format(currentHealth, maxHealth)
			healthBarGui.Enabled = currentHealth > 0
			local fillRatio = currentHealth / maxHealth
			Spr.target(healthBarGui.Progress.Fill, 1, 5, {
				["Size"] = UDim2.fromScale(fillRatio, 1)
			})
		end
	end

	SpawnEvent.OnClientEvent:Connect(function(animalId)
		trove:Clean()
		trove:Clone(script.VFX).Parent = workspace
		maxHealth = 10
		local timeout = 5
		while not AnimalController:GetAnimals()[animalId] and timeout > 0 do
			timeout = timeout - task.wait()
		end
		local animal = AnimalController:GetAnimals()[animalId]
		if animal then
			healthBarGui = trove:Clone(script.HealthBar)
			local guiRef = healthBarGui
			assert(guiRef)
			healthBarGui.Parent = animal.AnimalModel:FindFirstChild("OVERHEAD_ATTACHMENT", true) or animal.AnimalModel.PrimaryPart
			updateHealthBar()
			local animalData = AnimalController:GetAnimals()[animalId]
			if animalData then
				local overheadGui = animalData.AnimalModel:FindFirstChild("AnimalOverhead", true)
				if overheadGui and overheadGui:IsA("BillboardGui") then
					overheadGui.Enabled = healthBarGui == nil
				end
			end
			trove:Add(function()
				healthBarGui = nil
			end)
		end
	end)

	DespawnEvent.OnClientEvent:Connect(function(animalId)
		trove:Clean()
		local animal = AnimalController:GetAnimals()[animalId]
		if animal then
			local overheadGui = animal.AnimalModel:FindFirstChild("AnimalOverhead", true)
			if overheadGui and overheadGui:IsA("BillboardGui") then
				overheadGui.Enabled = healthBarGui == nil
			end
		end
		currentHealth = 10
	end)

	UpdateHealthBarEvent.OnClientEvent:Connect(function(animalId, newHealth)
		currentHealth = newHealth
		updateHealthBar()
		local animal = AnimalController:GetAnimals()[animalId]
		if animal then
			local overheadGui = animal.AnimalModel:FindFirstChild("AnimalOverhead", true)
			if overheadGui and overheadGui:IsA("BillboardGui") then
				overheadGui.Enabled = healthBarGui == nil
			end
		end
	end)

	PlayAnimationEvent.OnClientEvent:Connect(function(animalId, animationName)
		local animal = AnimalController:GetAnimals()[animalId]
		if not animal then return end

		local animationController = animal.AnimalModel:FindFirstChild("AnimationController")
		if not animationController then return end

		local animator = animationController:FindFirstChildOfClass("Animator")
			or Instance.new("Animator", animationController)

		if animationName then
			local animObject = script.Animations:FindFirstChild(animationName)
			if animObject then
				local animTrack = animator:LoadAnimation(animObject)
				animTrack.Looped = false
				animTrack:Play()
				animTrack:AdjustSpeed(animObject:GetAttribute("Speed") or 1)
				animal.Collector:Add(function()
					if animTrack then
						animTrack:Stop(0)
						animTrack:Destroy()
					end
				end)
			end
		end
	end)

	UpdateAnimationEvent.OnClientEvent:Connect(function(animalId, animationName, speed)
		local animal = AnimalController:GetAnimals()[animalId]
		if not animal then return end

		local animationController = animal.AnimalModel:FindFirstChild("AnimationController")
		if not animationController then return end

		local animator = animationController:FindFirstChildOfClass("Animator") 
			or Instance.new("Animator", animationController)

		if animal.TurkeyTrack then
			animal.TurkeyTrack:Stop(0)
			animal.TurkeyTrack:Destroy()
			animal.TurkeyTrack = nil
		end

		if animationName then
			local animObject = script.Animations:FindFirstChild(animationName)
			if animObject then
				local animTrack = animator:LoadAnimation(animObject)
				animTrack.Looped = true
				animTrack:Play()
				animTrack:AdjustSpeed(speed or animObject:GetAttribute("Speed") or 1)
				animal.TurkeyTrack = animTrack
				animal.Collector:Add(function()
					if animal.TurkeyTrack then
						animal.TurkeyTrack:Stop(0)
						animal.TurkeyTrack:Destroy()
						animal.TurkeyTrack = nil
					end
				end)
			end
		end
	end)
end

return ThanksgivingTurkeyController