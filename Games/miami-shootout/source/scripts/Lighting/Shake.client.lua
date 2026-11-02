-- Decompiled with the Synapse X Luau decompiler.

wait(0.5);
while true do
	wait(1);
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
		break;
	end;
end;
local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__mouse__2 = l__LocalPlayer__1:GetMouse();
game.ReplicatedStorage.loca.OnClientEvent:Connect(function(p1)
	print("a");
	game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(script.pushd):Play();
	local v3 = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart);
	v3.Name = "Pushed";
	v3.MaxForce = Vector3.new(math.huge, 0, math.huge);
	v3.Velocity = p1.Character.HumanoidRootPart.CFrame.LookVector * 8;
	game.Debris:AddItem(v3, 0.4);
	if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
		if not game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("ClipSize") then
			if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Damage") and math.random(1, 4) == 1 then
				local v4 = script.RAGG:Clone();
				v4.Parent = game.Players.LocalPlayer.Character;
				v4.Disabled = false;
				game.Debris:AddItem(v4, 7);
			end;
		elseif math.random(1, 4) == 1 then
			v4 = script.RAGG:Clone();
			v4.Parent = game.Players.LocalPlayer.Character;
			v4.Disabled = false;
			game.Debris:AddItem(v4, 7);
		end;
	end;
end);
game.ReplicatedStorage.locall.OnClientEvent:Connect(function(p2)
	game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(script.pushd):Play();
	local v5 = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart);
	v5.Name = "Pushed";
	v5.MaxForce = Vector3.new(math.huge, 0, math.huge);
	v5.Velocity = p2.Character.HumanoidRootPart.CFrame.LookVector * 9;
	game.Debris:AddItem(v5, 0.6);
	local v6 = math.random(1, 3);
end);
local u1 = false;
local l__Character__2 = l__LocalPlayer__1.Character;
l__mouse__2.KeyDown:connect(function(p3)
	if string.lower(p3) == "f" and script.Can.Value == true and not l__LocalPlayer__1.Character:FindFirstChildWhichIsA("Tool") then
		local l__HumanoidRootPart__7 = l__LocalPlayer__1.Character:WaitForChild("HumanoidRootPart");
		local v8, v9 = workspace:FindPartOnRay(Ray.new(l__HumanoidRootPart__7.Position, l__HumanoidRootPart__7.CFrame.lookVector * 50), l__LocalPlayer__1.Character);
		if not v8 then
			print("RETURN");
			return;
		end;
		local l__Parent__10 = v8.Parent;
		if v8.Parent:FindFirstChild("Humanoid") then
			local v11 = v8.Parent;
		else
			v11 = v8.Parent.Parent;
		end;
		if v11:FindFirstChild("Humanoid") or v11:findFirstChild("Humanoid") then
			local l__HumanoidRootPart__12 = v11:FindFirstChild("HumanoidRootPart");
			if l__HumanoidRootPart__12 then
				u1 = true;
				if l__Character__2:FindFirstChild("HumanoidRootPart") and (l__Character__2.HumanoidRootPart.Position - l__HumanoidRootPart__12.Position).magnitude < 5 and game.Players:FindFirstChild(v11.Name) then
					local v13 = game.Players:GetPlayerFromCharacter(v11);
					if not v13.Backpack:FindFirstChild("Shake") then
						return;
					end;
					if v13.Backpack.Shake.Value.Value == true and l__LocalPlayer__1.Backpack.Shake.Value.Value == true and l__LocalPlayer__1.Backpack.Shake.Can.Value == true and v13.Backpack.Shake.Can.Value == true then
						l__Character__2.Humanoid:UnequipTools();
						script.uhah:FireServer(v11, l__LocalPlayer__1, (math.random(-2, 6)));
						wait(2);
						u1 = false;
						return;
					end;
					u1 = true;
					script.G:FireServer(v11, l__LocalPlayer__1, (math.random(-2, 6)));
					wait(2.1);
					u1 = false;
				end;
			end;
		end;
	end;
end);
