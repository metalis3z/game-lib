-- Decompiled with the Synapse X Luau decompiler.

local l__SetPlayerRagdolled__1 = game:GetService("ReplicatedStorage").RemoteEvents:WaitForChild("SetPlayerRagdolled");
game.Players.LocalPlayer.CameraMinZoomDistance = 2;
game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics or Enum.HumanoidStateType.GettingUp);
game.Players.LocalPlayer.Character.Animate.Disabled = true;
l__SetPlayerRagdolled__1:FireServer();
local v2 = Instance.new("BoolValue");
v2.Name = "Ragdolled";
v2.Parent = game.Players.LocalPlayer.Character;
for v3, v4 in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
	if v4.Looped == true then
		v4:Stop(0.05);
	end;
end;
wait(5);
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 26 then
	game.Players.LocalPlayer.CameraMinZoomDistance = 0.5;
	game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);
	game.Players.LocalPlayer.Character.Animate.Disabled = false;
	local l__HumanoidRootPart__5 = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart");
	local v6, v7 = workspace:FindPartOnRay(Ray.new(l__HumanoidRootPart__5.Position, l__HumanoidRootPart__5.CFrame.lookVector * -10), game.Players.LocalPlayer.Character);
	if not v6 then
		local v8 = math.random(1, 3);
		if v8 == 1 then
			local v9 = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Front);
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
	v9:Play();
	local u1 = false;
	spawn(function()
		while true do
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0;
			wait();
			if u1 == true then
				break;
			end;
			if v9.IsPlaying == false then
				break;
			end;		
		end;
	end);
	wait(0.1);
	if game.Players.LocalPlayer.Character:FindFirstChild("Ragdolled") then
		game.Players.LocalPlayer.Character:FindFirstChild("Ragdolled"):Destroy();
	end;
	wait(0.7);
	u1 = true;
	game.Players.LocalPlayer.Character.Humanoid.walkspeed = 6;
end;
