local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid')
local Boost = Character:WaitForChild('Boost')
local CrouchSystem = Player.PlayerGui:WaitForChild('CrouchSystem')

local RunAnimation = Instance.new('Animation')
RunAnimation.Name ="RUNANIM_2"
RunAnimation.AnimationId = 'rbxassetid://16210196896'
local GunHoldrunRR = Instance.new('Animation')
GunHoldrunRR.Name = 'GUNHOLDRUN'
GunHoldrunRR.AnimationId = 'rbxassetid://16276407948'
GunHoldrun = Humanoid:LoadAnimation(GunHoldrunRR)
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
			gunHoldAnimation = v
			return
		else
			continue
		end
	end
	for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
		if string.lower(v.Name) == 'holddownanim'  then
			HoldDownAnim = v
			return
		else
			continue
		end
	end
end

function CanRun()
	if Character:FindFirstChildOfClass('Tool') then
		local Tool = Character:FindFirstChildOfClass('Tool')
		if Tool:FindFirstChild('CantRun') then
			return false
		else
			return true
		end
	else
		return true
	end
end


function Handler(BindName, InputState)
	checkAnimations()

	if InputState == Enum.UserInputState.Begin and BindName == 'RunBind' and _G.Crouching == false then
		if CanRun() then
			Running = true
			if Boost.Value == true then
				Humanoid.WalkSpeed = 20
			else
				Humanoid.WalkSpeed = 16
			end
			if gunHoldAnimation ~= nil and Humanoid.MoveDirection.Magnitude ~= 0 and gunHoldAnimation.IsPlaying then gunHoldAnimation:Stop() end
			stopHoldAnimation = true
		else
			Running = true
			if Boost.Value == true then
				Humanoid.WalkSpeed = 19
			else
				Humanoid.WalkSpeed = 15
			end
			if gunHoldAnimation ~= nil and Humanoid.MoveDirection.Magnitude ~= 0 and gunHoldAnimation.IsPlaying then gunHoldAnimation:Stop() end
			stopHoldAnimation = true
		end
	elseif InputState == Enum.UserInputState.End and BindName == 'RunBind' and _G.Crouching == false then
		Running = false
		if RAnimation.IsPlaying then
			RAnimation:Stop()
		end
		if GunHoldrun.IsPlaying then
			GunHoldrun:Stop()
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
	checkAnimations()
	if Speed >= 10 and Running and not RAnimation.IsPlaying then
		RAnimation:Play()
		if CanRun() then
			if Boost.Value == true then
				Humanoid.WalkSpeed = 20
			else
				Humanoid.WalkSpeed = 16
			end
		else
			GunHoldrun:Play()
			if Boost.Value == true then
				Humanoid.WalkSpeed = 19
			else
				Humanoid.WalkSpeed = 15
			end
		end
	elseif Speed >= 10 and not Running and RAnimation.IsPlaying then
		RAnimation:Stop()
		if CanRun() then
			if Boost.Value == true then
				Humanoid.WalkSpeed = 20
			else
				Humanoid.WalkSpeed = 16
			end
		else
			GunHoldrun:Stop()
			if Boost.Value == true then
				Humanoid.WalkSpeed = 19
			else
				Humanoid.WalkSpeed = 15
			end
		end
	elseif Speed < 10 and RAnimation.IsPlaying then
		RAnimation:Stop()
		Humanoid.WalkSpeed = 7.5
		GunHoldrun:Stop()
	end
end)

Character.ChildRemoved:Connect(function(Child)
	if Child:IsA('Tool') then
		if Child.Name == 'Phone' then
			if game:FindService('UserInputService').TouchEnabled then
				game:GetService('ContextActionService'):BindAction('RunBind', Handler, true, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL2)
				CrouchSystem.Enabled = true
			end
		end
		if not Character:FindFirstChildOfClass('Tool') then
			if GunHoldrun and GunHoldrun.IsPlaying then
				GunHoldrun:Stop()
			end
		end
	end
end)

Character.ChildAdded:Connect(function(Child)
	if Child:IsA('Tool') then
		if Child.Name == 'Phone' then
			if game:FindService('UserInputService').TouchEnabled then
				game:GetService('ContextActionService'):UnbindAction('RunBind')
				CrouchSystem.Enabled = false
			end
		end
		if not CanRun() then
			if GunHoldrun and not GunHoldrun.IsPlaying then
				GunHoldrun:Play()
			end
		end
	end
end)

Humanoid.Seated:Connect(function(Seated)
	if Seated then
		if game:FindService('UserInputService').TouchEnabled then
			game:GetService('ContextActionService'):UnbindAction('RunBind')
			CrouchSystem.Enabled = false
		end
	else
		if game:FindService('UserInputService').TouchEnabled then
			game:GetService('ContextActionService'):BindAction('RunBind', Handler, true, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL2)
			CrouchSystem.Enabled = true
		end
	end
end)

game:GetService('ContextActionService'):BindAction('RunBind', Handler, true, Enum.KeyCode.LeftShift, Enum.KeyCode.ButtonL2)

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
	if CanRun() == false and Humanoid.WalkSpeed > 19 then
		RAnimation:Stop()
		GunHoldrun:Stop()
		Humanoid.WalkSpeed = 7.5
	end
end