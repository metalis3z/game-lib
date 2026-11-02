local Players = game:GetService("Players")

-- High-power treadmills use the run animation; lower-power ones use walk
local RUN_TREADMILLS = {
	Diamond = true,
	Candy = true,
	Admin = true,
	Kitty = true,
}

local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid then return end
	local animator = humanoid:WaitForChild("Animator", 10)
	if not animator then return end

	local walkTrack = nil
	local runTrack = nil
	local currentTrack = nil

	local function getAnimation(animName)
		local animate = character:FindFirstChild("Animate")
		if not animate then return nil end
		local animFolder = animate:FindFirstChild(animName)
		if not animFolder then return nil end
		return animFolder:FindFirstChildOfClass("Animation")
	end

	local function loadTracks()
		if not walkTrack then
			local walkAnim = getAnimation("walk")
			if walkAnim then
				walkTrack = animator:LoadAnimation(walkAnim)
				walkTrack.Priority = Enum.AnimationPriority.Movement
				walkTrack.Looped = true
			end
		end
		if not runTrack then
			local runAnim = getAnimation("run")
			if runAnim then
				runTrack = animator:LoadAnimation(runAnim)
				runTrack.Priority = Enum.AnimationPriority.Movement
				runTrack.Looped = true
			end
		end
	end

	local function updateAnimation()
		if character:GetAttribute("IsOnTreadmill") then
			loadTracks()

			local treadmillType = character:GetAttribute("TreadmillType") or "Normal"
			local shouldRun = RUN_TREADMILLS[treadmillType] or false
			local desiredTrack = shouldRun and runTrack or walkTrack

			-- Stop current track if switching between walk and run
			if currentTrack and currentTrack ~= desiredTrack then
				currentTrack:Stop(0.3)
				currentTrack = nil
			end

			-- Play the desired track if not already playing
			if desiredTrack and not desiredTrack.IsPlaying then
				desiredTrack:Play(0.3)
				currentTrack = desiredTrack
			end
		else
			-- Stop all treadmill animations when off treadmill
			if walkTrack and walkTrack.IsPlaying then
				walkTrack:Stop(0.3)
			end
			if runTrack and runTrack.IsPlaying then
				runTrack:Stop(0.3)
			end
			currentTrack = nil

			task.defer(function()
				if humanoid and humanoid.Parent then
					humanoid:ChangeState(Enum.HumanoidStateType.Landed)
				end
			end)
		end
	end

	character:GetAttributeChangedSignal("IsOnTreadmill"):Connect(updateAnimation)
	character:GetAttributeChangedSignal("TreadmillType"):Connect(updateAnimation)
	updateAnimation()
end

Players.PlayerAdded:Connect(function(player)
	if player.Character then
		task.spawn(setupCharacter, player.Character)
	end
	player.CharacterAdded:Connect(setupCharacter)
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player.Character then
		task.spawn(setupCharacter, player.Character)
	end
	player.CharacterAdded:Connect(setupCharacter)
end