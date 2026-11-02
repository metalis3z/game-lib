
local Player = game.Players.LocalPlayer
	local Character = workspace:WaitForChild(Player.Name)
		local Humanoid = Character:WaitForChild('Humanoid')
		
local RunAnimation = Instance.new('Animation')
RunAnimation.Name ="RUNANIM_2"
RunAnimation.AnimationId = 'rbxassetid://15023624624' --(here animation code)
RAnimation = Humanoid:LoadAnimation(RunAnimation)

Running = false


local gunHoldAnimation = nil
local HoldDownAnim = nil
local stopHoldAnimation = false

Character.ChildAdded:Connect(function(child)
	if child:IsA("Tool") and child:FindFirstChild("Setting") then
		if Running then
			stopHoldAnimation = true
		end
	end
end)

Character.ChildRemoved:Connect(function(child)
	if child:IsA("Tool") then
		gunHoldAnimation = nil
		stopHoldAnimation = false
	end
end)

function checkAnimations()
	for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
		if tostring(v) == "IdleAnim" then
			print("caught idle anim")
			gunHoldAnimation = v
			return
		else
			continue
		end
	end
	for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
		if tostring(v) == "HoldDownAnim" then
			print("caught holddown anim")
			HoldDownAnim = v
			return
		else
			continue
		end
	end
end

function Handler(BindName, InputState)
	checkAnimations()

	if game.Players.LocalPlayer and game.Players.LocalPlayer.PlayerGui and game.Players.LocalPlayer.PlayerGui:FindFirstChild("HANDCUFF_LEAVE") then
		Humanoid.WalkSpeed = 3
		if not RAnimation.IsPlaying then RAnimation:Stop() end
		return 
	end
	
	if InputState == Enum.UserInputState.Begin and BindName == 'RunBind' then
		Running = true
		Humanoid.WalkSpeed = 16
		if gunHoldAnimation ~= nil and Humanoid.MoveDirection.Magnitude ~= 0 and gunHoldAnimation.IsPlaying then gunHoldAnimation:Stop() end
		stopHoldAnimation = true
	elseif InputState == Enum.UserInputState.End and BindName == 'RunBind' then
		Running = false
		if RAnimation.IsPlaying then
			RAnimation:Stop()
		end
		Humanoid.WalkSpeed = 7.5
		if not HoldDownAnim then
			if gunHoldAnimation ~= nil and not gunHoldAnimation.IsPlaying then gunHoldAnimation:Play() end
		else
			if HoldDownAnim.IsPlaying then
				
			else
				if gunHoldAnimation ~= nil and not gunHoldAnimation.IsPlaying then gunHoldAnimation:Play() end
			end
		end
		stopHoldAnimation = false
	end
end

Humanoid.Running:connect(function(Speed)
	
	if game.Players.LocalPlayer and game.Players.LocalPlayer.PlayerGui and game.Players.LocalPlayer.PlayerGui:FindFirstChild("HANDCUFF_LEAVE") then
		Humanoid.WalkSpeed = 3
		if not RAnimation.IsPlaying then RAnimation:Stop() end
		return 
	end

	if Speed >= 10 and Running and not RAnimation.IsPlaying then
		RAnimation:Play()
		Humanoid.WalkSpeed = 16
	elseif Speed >= 10 and not Running and RAnimation.IsPlaying then
		RAnimation:Stop()
		Humanoid.WalkSpeed = 16
	elseif Speed < 10 and RAnimation.IsPlaying then
		RAnimation:Stop()
		Humanoid.WalkSpeed = 7.5
	end
end)

Humanoid.Changed:connect(function()
	
	if game.Players.LocalPlayer and game.Players.LocalPlayer.PlayerGui and game.Players.LocalPlayer.PlayerGui:FindFirstChild("HANDCUFF_LEAVE") then
		Humanoid.WalkSpeed = 3
		if not RAnimation.IsPlaying then RAnimation:Stop() end
		return 
	end
	
	if Humanoid.Jump and RAnimation.IsPlaying then
		RAnimation:Stop()
	end
end)

game:GetService('ContextActionService'):BindAction('RunBind', Handler, true, Enum.KeyCode.LeftShift)

while wait(0.05) do
	
	if stopHoldAnimation then
		if stopHoldAnimation and Humanoid.MoveDirection.Magnitude ~= 0 and RAnimation.IsPlaying then
			if not gunHoldAnimation then checkAnimations() end
			if gunHoldAnimation and gunHoldAnimation.IsPlaying then gunHoldAnimation:Stop() end
		else
			if stopHoldAnimation and Humanoid.MoveDirection.Magnitude == 0 then
				if not gunHoldAnimation then checkAnimations() end
				if gunHoldAnimation and not gunHoldAnimation.IsPlaying then gunHoldAnimation:Play() end
			else
				if stopHoldAnimation and Humanoid.WalkSpeed ~= 16 then
					if not gunHoldAnimation then checkAnimations() end
					if gunHoldAnimation and not gunHoldAnimation.IsPlaying then gunHoldAnimation:Play() end
				end
			end
		end
	end
	
end