local function loadAnims(char)
	local hum = char:WaitForChild("Humanoid")
	local animator = hum:WaitForChild("Animator")
	
	for _,track in pairs(animator:GetPlayingAnimationTracks()) do
		track:Stop(0)
	end
	
	local animScript = char:WaitForChild("Animate")
	animScript.run.RunAnim.AnimationId = "rbxassetid://9837005350"
	animScript.walk.WalkAnim.AnimationId = "rbxassetid://9837005350"
	--animScript.idle.IdleAnim.AnimationId = "rbxassetid://0"
end

game.Players.PlayerAdded:Connect(function(p)
	--p.CharacterAppearanceLoaded:Connect(loadAnims)
end)