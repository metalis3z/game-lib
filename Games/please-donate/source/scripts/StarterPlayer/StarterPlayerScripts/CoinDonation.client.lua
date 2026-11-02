-- Decompiled with the Synapse X Luau decompiler.

local l__VFXObjects__1 = game.ReplicatedStorage.Templates.VFXObjects;
local l__TweenService__1 = game:GetService("TweenService");
local l__task_wait__2 = task.wait;
local l__RunService__3 = game:GetService("RunService");
l__VFXObjects__1.CreateVfx.OnClientEvent:Connect(function(p1, ...)
	local v2 = { ... };
	if v2[2] ~= game.Players.LocalPlayer.Character then
		return;
	end;
	if p1 == "GiveCurrency" or p1 == "GiveGiftbux" then
		local v3 = -1;
		local v4 = 1;
		local v5 = 1;
		if p1 == "GiveCurrency" then
			if v2[3] >= 1000000 then
				v4 = 600;
				v5 = 0.05;
			elseif v2[3] >= 100000 then
				v4 = 300;
				v5 = 0.1;
			elseif v2[3] >= 10000 then
				v4 = 75;
				v5 = 0.15;
			elseif v2[3] >= 1000 then
				v4 = 20;
				v5 = 0.25;
			elseif v2[3] >= 100 then
				v4 = 5;
				v5 = 0.5;
			else
				v4 = 1;
				v5 = 1;
			end;
		end;
		if p1 == "GiveGiftbux" then
			v4 = math.clamp(math.round(v2[3] / 10 + 0.5) + 1, 0, 50);
			v5 = (v4 / 10 + 0.25) / v4;
		end;
		print((math.round(v4)));
		for v6 = 1, v4 + 1 do
			local v7 = Instance.new("Attachment");
			v7.Name = "CurrencyPositionGoal";
			local v8, v9 = pcall(function()
				v7.Parent = v2[2].HumanoidRootPart;
			end);
			if v8 == false then
				warn("Unable to find Humanoid (" .. v9 .. ")");
			end;
			local v10 = nil;
			if p1 == "GiveCurrency" then
				v10 = l__VFXObjects__1.CurrencyCoin:Clone();
			end;
			if p1 == "GiveGiftbux" then
				v10 = l__VFXObjects__1.GiftbuxCoin:Clone();
			end;
			v10.Position = v2[1];
			v10.AlignPosition.Position = v10.Position + Vector3.new(math.random(-10, 10), math.random(10, 20), math.random(-10, 10));
			v10.Spin.AngularVelocity = Vector3.new(0, math.random(50, 100) / 10, 0);
			v10.Parent = workspace;
			l__TweenService__1:Create(v10, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
				Size = v10.Size
			}):Play();
			l__TweenService__1:Create(v10.Center.Glow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
				Brightness = 0.5
			}):Play();
			local u4 = false;
			local u5 = v3;
			local u6 = nil;
			local function u7()
				if u4 ~= false then
					return;
				end;
				u4 = true;
				if not v7:IsDescendantOf(game) then
					v10.Trail.Enabled = false;
					v10.AlignPosition.MaxVelocity = 0;
					v10.AlignPosition.Responsiveness = 200;
					v10.AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
					v10.AlignPosition.Attachment0 = v10.Center;
					v10.AlignPosition.Position = v10.Position;
					l__TweenService__1:Create(v10.Center.Glow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
						Brightness = 0, 
						Range = 5
					}):Play();
					l__TweenService__1:Create(v10, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
						Size = Vector3.new(0, 0, 0), 
						Transparency = 1
					}):Play();
					l__task_wait__2(0.5);
					v10:Destroy();
					v7:Destroy();
					return;
				end;
				v10.Position = v7.WorldPosition + Vector3.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2));
				v10.Transparency = 1;
				for v11, v12 in pairs(v10:GetChildren()) do
					if v12:IsA("SurfaceGui") then
						v12.Enabled = false;
					end;
				end;
				v10.Anchored = true;
				v10.Center.Glow.Brightness = 1;
				v10.Center.Glow.Range = 7.5;
				l__TweenService__1:Create(v10.Center.Glow, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
					Brightness = 0, 
					Range = 5
				}):Play();
				for v13, v14 in pairs(v10.Center:GetChildren()) do
					if v14:IsA("ParticleEmitter") then
						v14:Emit(v14:GetAttribute("EmitCount"));
					end;
				end;
				v10.Collect.PlaybackSpeed = u5 + 2;
				u5 = u5 * 0.99;
				v10.Collect:Play();
				l__task_wait__2(3);
				v10:Destroy();
				v7:Destroy();
			end;
			local function u8(p2)
				if v7:IsDescendantOf(game) == false then
					u6:Disconnect();
					u7();
					return;
				end;
				if (v10.Center.WorldPosition - v7.WorldPosition).Magnitude < 2.5 then
					u6:Disconnect();
					u7();
				end;
			end;
			spawn(function()
				l__task_wait__2(1);
				u6 = l__RunService__3.Heartbeat:Connect(u8);
				v10.Trail.Enabled = true;
				v10.AlignPosition.MaxVelocity = 1;
				v10.AlignPosition.Responsiveness = 100;
				v10.AlignPosition.Mode = Enum.PositionAlignmentMode.TwoAttachment;
				v10.AlignPosition.Attachment1 = v7;
				l__TweenService__1:Create(v10.AlignPosition, TweenInfo.new(math.random(200, 300) / 100, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {
					MaxVelocity = 150
				}):Play();
				l__task_wait__2(10);
				if u4 == false then
					v7:Destroy();
				end;
			end);
			l__task_wait__2(v5);
		end;
	end;
end);
