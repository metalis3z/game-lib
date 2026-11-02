-- Decompiled with the Synapse X Luau decompiler.

local u1 = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("GameTimer"));
local l__TweenService__2 = game:GetService("TweenService");
return function(p1)
	local v1, v2, v3 = u1();
	local l__AnimationController__4 = p1:FindFirstChild("AnimationController");
	if l__AnimationController__4 then
		l__AnimationController__4:LoadAnimation(p1.Animation):Play();
	end;
	local l__Position__3 = p1.PrimaryPart.Position;
	local l__ClickSound__4 = p1:FindFirstChild("ClickSound", true);
	local l__ClickSoundDouble__5 = p1:FindFirstChild("ClickSoundDouble", true);
	local u6 = v1;
	local u7 = v2;
	local u8 = v3;
	task.spawn(function()
		local function v5(p2, p3, p4, p5)
			local l__Magnitude__6 = (workspace.CurrentCamera.CFrame.Position - l__Position__3).Magnitude;
			local v7 = {
				HandHour = p1.HandCenter.CFrame * CFrame.Angles(math.pi / 2, 0, 0) * CFrame.Angles(0, 0, math.rad(p2 * 30 + p3 * 0.5)) * CFrame.new(0, p1.HandHour.Size.Y / 2, 0), 
				HandMinute = p1.HandCenter.CFrame * CFrame.Angles(math.pi / 2, 0, 0) * CFrame.Angles(0, 0, math.rad(p3 * 6 + p4 * 0.1)) * CFrame.new(0, p1.HandMinute.Size.Y / 2, 0), 
				HandSecond = p1.HandCenter.CFrame * CFrame.Angles(math.pi / 2, 0, 0) * CFrame.Angles(0, 0, math.rad(p4 * 6)) * CFrame.new(0, p1.HandSecond.Size.Y / 2, 0)
			};
			if l__Magnitude__6 > 120 and p5 ~= true then
				return;
			end;
			if l__Magnitude__6 > 45 or p5 then
				for v8, v9 in pairs(p1:GetChildren()) do
					if v7[v9.Name] then
						v9.CFrame = v7[v9.Name];
					end;
				end;
				return;
			end;
			for v10, v11 in pairs(p1:GetChildren()) do
				if v7[v11.Name] then
					l__TweenService__2:Create(v11, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						CFrame = v7[v11.Name]
					}):Play();
				end;
			end;
			if l__ClickSound__4 then
				l__ClickSound__4:Play();
				return;
			end;
			if l__ClickSoundDouble__5 and p4 / 2 == math.round(p4 / 2) then
				l__ClickSoundDouble__5:Play();
			end;
		end;
		v5(u6, u7, u8, true);
		for v12 = 1, 10000000000 do
			task.wait(1);
			if not p1 then
				break;
			end;
			if not p1.Parent then
				break;
			end;
			if not game.ReplicatedStorage.GameData.StopTime.Value then
				u8 = u8 + 1;
				if u8 >= 60 then
					u7 = u7 + 1;
					u8 = 0;
					if u7 >= 60 then
						u6 = u6 + 1;
						u7 = 0;
						if u6 >= 12 then
							u6 = 0;
						end;
					end;
				end;
				v5(u6, u7, u8);
			end;
		end;
	end);
end;
