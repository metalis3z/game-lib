local RagdollClientEvent = game.ReplicatedStorage:WaitForChild("RagdollClient")
local PlayEffect = game.ReplicatedStorage:WaitForChild("PlayEffect")

local UserInputService = game:GetService("UserInputService")
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")

local effects = {}
_G.Ragdolled = false

for i,v in pairs(game.ReplicatedStorage.Effects:GetChildren()) do
	effects[v.Name] = require(v)
end

workspace.CurrentCamera.CameraSubject = humanoid

local function ragdoll()
	if character:FindFirstChild('RAGDOLLED') then return end
	game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics or Enum.HumanoidStateType.GettingUp);
	game.Players.LocalPlayer.Character.Animate.Disabled = true;
	_G.Ragdolled = true
	workspace.CurrentCamera.CameraSubject = humanoid.Parent:FindFirstChild('Head')
	--[[
	spawn(function()
		wait(0.2);
		if _G.Ragdolled == true then
			for v3, v4 in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
				if v4.Looped == true then
					v4:Stop(0.05);
				end;
			end;
		end;
	end);
	]]
end

local function unragdoll()
	game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);
	game.Players.LocalPlayer.Character.Animate.Disabled = false;
	local l__HumanoidRootPart__5 = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart");
	local v6, v7 = workspace:FindPartOnRay(Ray.new(l__HumanoidRootPart__5.Position, l__HumanoidRootPart__5.CFrame.lookVector * -10), game.Players.LocalPlayer.Character);
	local v9 = nil
	if not v6 then
		local v8 = math.random(1, 3);
		if v8 == 1 then
			v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Front);
		elseif v8 == 2 then
			v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Front.Front1);
		else
			v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Front.Front2);
		end;
	else
		local v10 = math.random(1, 3);
		if v10 == 1 then
			v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Back);
		elseif v10 == 2 then
			v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Back.Back1);
		else
			v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Back.Back2);
		end;
	end;
	if v9 == nil then v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Front.Front2) end
	v9:Play();
	local u4 = false;
	spawn(function()
		while true do
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0;
			wait();
			if u4 == true then
				break;
			end;
			if v9.IsPlaying == false then
				break;
			end;				
		end;
	end);
	workspace.CurrentCamera.CameraSubject = humanoid
	wait(0.8);
	u4 = true;
	_G.Ragdolled = false
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 6;
end

RagdollClientEvent.OnClientEvent:Connect(function(state)
	if state == "ragdoll" then ragdoll() end
	if state == "unragdoll" then unragdoll() end
end)

_G.playEffect = function(effect)
	if effects[effect] then
		effects[effect].play()
	else
	end
end

PlayEffect.OnClientEvent:Connect(function(effect)
	if effects[effect] then
		effects[effect].play()
	else
	end
end)