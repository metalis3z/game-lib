local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)

AnimalController.OnAnimalSpawn:Connect(function(self)
	local animationController = self.AnimalModel.AnimationController
	local animator = animationController:FindFirstChildOfClass("Animator") 
		or Instance.new("Animator", animationController)

	local Dance = animator:LoadAnimation(script.Dance)
	Dance.Priority = Enum.AnimationPriority.Action2
	Dance.Looped = true

	local GettingUpTransition = animator:LoadAnimation(script.GettingUpTransition)
	GettingUpTransition.Priority = Enum.AnimationPriority.Action3
	GettingUpTransition.Looped = false

	local GroundDance = animator:LoadAnimation(script.GroundDance)
	GroundDance.Priority = Enum.AnimationPriority.Action3
	GroundDance.Looped = true
	GroundDance.Stopped:Connect(function()
		GroundDance:Play()
	end)

	local GroundTransition = animator:LoadAnimation(script.GroundTransition)
	GroundTransition.Priority = Enum.AnimationPriority.Action3
	GroundTransition.Looped = false
	GroundTransition.Stopped:Connect(function()
		GroundTransition:Play()
	end)

	local function updateDance()
		if self.Instance:GetAttribute("Dance") then
			if not Dance.IsPlaying then
				self.WalkTrack:Stop()
				self.IdleTrack:Stop()
				Dance:Play()
			end
		elseif Dance.IsPlaying then
			Dance:Stop()
			if self.Instance:GetAttribute("ForceIdle") then
				self.IdleTrack:Play()
			else
				self.WalkTrack:Play()
			end
		end
	end

	self.Collector:Add(
		self.Instance:GetAttributeChangedSignal("Dance"):Connect(updateDance)
	)
	task.spawn(updateDance)

	local function updateGroundDance()
		if self.Instance:GetAttribute("GroundDance") then
			self.WalkTrack:Stop()
			self.IdleTrack:Stop()

			if not GroundDance.IsPlaying then
				Dance:Stop()
				GroundDance:Play()
			end
		elseif GroundDance.IsPlaying then
			GroundDance:Stop()

			if self.Instance:GetAttribute("ForceIdle") then
				self.IdleTrack:Play()
			else
				self.WalkTrack:Play()
			end
		end
	end

	self.Collector:Add(
		self.Instance:GetAttributeChangedSignal("GroundDance"):Connect(updateGroundDance)
	)
	task.spawn(updateGroundDance)
end)

return {
	Start = function()
		task.spawn(function()
			pcall(function()
				ContentProvider:PreloadAsync(script:GetChildren())
			end)
		end)
	end
}