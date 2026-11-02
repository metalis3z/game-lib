-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local v3 = require(script.Parent);
local v4 = require(l__LocalPlayer__2:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v5 = game["Run Service"];
local l__UserInputService__6 = game:GetService("UserInputService");
local l__TweenService__7 = game:GetService("TweenService");
local l__Parent__8 = script.Parent.Parent.Parent;
local v9 = v3.hideplayers;
task.delay(2, function()
	for v10 = 1, 7 do
		for v11, v12 in pairs(game.Players:GetChildren()) do
			pcall(function()
				local l__Humanoid__13 = v12.Character:FindFirstChild("Humanoid");
				local l__SpecLight__14 = v12.Character:FindFirstChild("SpecLight", true);
				if l__SpecLight__14 and v3.dead == false then
					l__SpecLight__14:Destroy();
				end;
				if l__Humanoid__13 and (l__Humanoid__13:GetAttribute("LoadedAppearance") or l__Humanoid__13:GetAttribute("AppearanceFinal")) then
					return;
				end;
				l__Humanoid__13:SetAttribute("LoadedAppearance", true);
				wait();
				l__Humanoid__13.AutomaticScalingEnabled = true;
				wait();
				l__Humanoid__13.AutomaticScalingEnabled = false;
				wait();
				l__Humanoid__13.AutomaticScalingEnabled = true;
			end);
		end;
		wait(5);
	end;
end);
while true do
	wait(0.5);
	if v3.hideplayers ~= v9 then
		v3.update();
		v9 = v3.hideplayers;
		local v15 = math.clamp(v3.hideplayers, 0, 1);
		for v16, v17 in pairs(game.Players:GetPlayers()) do
			pcall(function()
				if v17 ~= l__LocalPlayer__2 then
					for v18, v19 in pairs(v17.Character:GetDescendants()) do
						if v19:IsA("BasePart") or v19:IsA("Decal") then
							l__TweenService__7:Create(v19, TweenInfo.new(0.1), {
								LocalTransparencyModifier = v15
							}):Play();
							if v19:IsA("BasePart") then
								v19.CollisionGroupId = 1;
							end;
						end;
					end;
				end;
			end);
		end;
		wait(0.5);
	end;
end;
