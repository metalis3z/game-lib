-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

require(ReplicatedStorage.Controllers.AnimalController).OnAnimalSpawn:Connect(function(instanceObj)
	local humanoid = instanceObj.AnimalModel:FindFirstChildOfClass("Humanoid")
	local animationController = instanceObj.AnimalModel:FindFirstChildOfClass("AnimationController")

	local controller = humanoid or animationController
	if not controller then
		return
	end

	local animator = controller:FindFirstChildOfClass("Animator") or Instance.new("Animator", controller)
	local tweenObj = animator:LoadAnimation(script.Dance)
	tweenObj.Priority = Enum.AnimationPriority.Action2
	tweenObj.Looped = true
	local tweenObj_2 = animator:LoadAnimation(script.GettingUpTransition)
	tweenObj_2.Priority = Enum.AnimationPriority.Action3
	tweenObj_2.Looped = false
	local tweenObj_3 = animator:LoadAnimation(script.GroundDance)
	tweenObj_3.Priority = Enum.AnimationPriority.Action3
	tweenObj_3.Looped = true
	tweenObj_3.Stopped:Connect(function()
		tweenObj_2:Play()
	end)
	local tweenObj_4 = animator:LoadAnimation(script.GroundTransition)
	tweenObj_4.Priority = Enum.AnimationPriority.Action3
	tweenObj_4.Looped = false
	tweenObj_4.Stopped:Connect(function()
		tweenObj_3:Play()
	end)

	local function updateDance()

		if instanceObj.Instance:GetAttribute("Dance") then
			if not tweenObj.IsPlaying then
				if instanceObj.WalkTrack then instanceObj.WalkTrack:Stop() end
				if instanceObj.IdleTrack then instanceObj.IdleTrack:Stop() end
				tweenObj:Play()
				return
			end
		elseif tweenObj.IsPlaying then
			tweenObj:Stop()
			if instanceObj.Instance:GetAttribute("ForceIdle") then
				if instanceObj.IdleTrack then instanceObj.IdleTrack:Play() end
				return
			else
				if instanceObj.WalkTrack then instanceObj.WalkTrack:Play() end
			end
		end
	end
	instanceObj.Collector:Add(instanceObj.Instance:GetAttributeChangedSignal("Dance"):Connect(updateDance))
	instanceObj.Collector:Add(task.spawn(updateDance))

	local function updateGroundDance()

		if instanceObj.Instance:GetAttribute("GroundDance") then
			if instanceObj.WalkTrack then instanceObj.WalkTrack:Stop() end
			if instanceObj.IdleTrack then instanceObj.IdleTrack:Stop() end

			if not tweenObj_4.IsPlaying and not tweenObj_3.IsPlaying then
				if tweenObj_2.IsPlaying then
					tweenObj_2:Stop()
				end
				tweenObj_4:Play()
				return
			end
		elseif tweenObj_4.IsPlaying or tweenObj_3.IsPlaying then
			if tweenObj_4.IsPlaying then
				tweenObj_4:Stop()
			end

			if tweenObj_3.IsPlaying then
				tweenObj_3:Stop()
			end
			tweenObj_2:Play()

			if instanceObj.Instance:GetAttribute("ForceIdle") then
				if instanceObj.IdleTrack then instanceObj.IdleTrack:Play() end
				return
			elseif not tweenObj.IsPlaying then
				if instanceObj.WalkTrack then instanceObj.WalkTrack:Play() end
			end
		end
	end
	instanceObj.Collector:Add(instanceObj.Instance:GetAttributeChangedSignal("GroundDance"):Connect(updateGroundDance))
	instanceObj.Collector:Add(task.spawn(updateGroundDance))
end)

return {
	Start = function()
		task.spawn(function()
			local assetsToLoad = script:GetChildren()
			table.insert(assetsToLoad, ReplicatedStorage.Sounds.Others:WaitForChild("Coffin", 5))
			local success, err = pcall(function()
				ContentProvider:PreloadAsync(assetsToLoad)
			end)

			if not success then
				warn("Failed to preload animations: " .. tostring(err))
			end
		end)
	end
}