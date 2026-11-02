script.Parent.Buy.Event:Connect(function()
	local anim = script.Parent.AnimationController
	local animfolder = script.Parent.Animations
	local playanim = anim:LoadAnimation(animfolder.Happy)
	local playanimIdle = anim:LoadAnimation(animfolder.Idle)
	
	playanim:Play()
	playanimIdle:Play()
end)

script.Parent.Intro.Event:Connect(function()
	local anim = script.Parent.AnimationController
	local animfolder = script.Parent.Animations
	local playanim = anim:LoadAnimation(animfolder.Intro)
	local playanimIdle = anim:LoadAnimation(animfolder.Idle)

	playanim:Play()
	playanimIdle:Play()
end)

script.Parent.BuyDonate.Event:Connect(function()
	local anim = script.Parent.AnimationController
	local animfolder = script.Parent.Animations
	local playanim = anim:LoadAnimation(animfolder.HappyDonate)
	local playanimIdle = anim:LoadAnimation(animfolder.Idle)

	playanim:Play()
	playanimIdle:Play()
end)

wait()
script.Parent.Intro:Fire()