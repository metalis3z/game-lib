-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
return function(p1, p2)
	if p1.dead then
		return;
	end;
	print("Yay.");
	local v4 = game.Lighting.Sanity:Clone();
	v4.Name = "LiveSanity";
	v4.Enabled = true;
	v4.Parent = game.Lighting;
	local v5 = u1.MainFrame.HasteVignette:Clone();
	v5.Name = "LiveSanityVignette";
	v5.Visible = true;
	v5.Parent = u1;
	local v6 = game.SoundService.Main.SanityEqualizer:Clone();
	v6.Name = "SanityEqualizerLive";
	v6.Enabled = true;
	v6.Parent = game.SoundService.Main;
	local v7 = script.Heartbeat:Clone();
	v7.Name = "LiveHeartbeat";
	v7.Parent = script;
	v7:Play();
	local v8 = script.Whispers:Clone();
	v8.Name = "LiveWhispers";
	v8.Parent = script;
	v8:Play();
	local v9 = script.Static:Clone();
	v9.Name = "LiveStatic";
	v9.Parent = script;
	v9:Play();
	print("erm.. hello bro");
	l__TweenService__2:Create(v4, TweenInfo.new(p2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		Saturation = -0.8, 
		Contrast = 0.3, 
		TintColor = Color3.new(2, 1.3, 1)
	}):Play();
	l__TweenService__2:Create(v5, TweenInfo.new(p2 * 0.66, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		ImageTransparency = 0, 
		Size = UDim2.new(1, 0, 1, 0)
	}):Play();
	l__TweenService__2:Create(v5.DamageVignette, TweenInfo.new(p2 + 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		Rotation = (p2 + 2) * 60
	}):Play();
	l__TweenService__2:Create(v5.DamageVignette, TweenInfo.new(p2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		ImageTransparency = 0
	}):Play();
	l__TweenService__2:Create(v6, TweenInfo.new(p2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		LowGain = 0, 
		MidGain = -20, 
		HighGain = -40
	}):Play();
	l__TweenService__2:Create(v7, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		PlaybackSpeed = 2
	}):Play();
	l__TweenService__2:Create(v8, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		PlaybackSpeed = 2
	}):Play();
	l__TweenService__2:Create(v7, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Volume = 1.6
	}):Play();
	l__TweenService__2:Create(v8, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Volume = 1.6
	}):Play();
	local v10 = p1.camShaker:StartShake(1, 16, p2, Vector3.new(0, 0, 0));
	local v11 = p1.camShaker:StartShake(8, 1, p2, Vector3.new(0, 0, 0));
	local v12 = tick() + p2;
	local v13 = tick();
	local u3 = true;
	task.spawn(function()
		pcall(function()
			while u3 do
				task.wait();
				local v14 = math.clamp(v7.PlaybackLoudness * v7.Volume / 1000, 0, 0.8);
				local v15 = math.clamp(v8.PlaybackLoudness * v8.Volume / 1000, 0, 0.8);
				v5.DamageVignette.ImageColor3 = Color3.new(0.1 + v14, 0.01 + v14 / 4, v14 / 4);			
			end;
		end);
	end);
	for v16 = 1, 10000000 do
		task.wait(0.03333333333333333);
		if v12 <= tick() then

		end;
		if p1.dead then
			break;
		end;
	end;
	print("stopped");
	v10:StartFadeOut(0.3);
	v11:StartFadeOut(0.3);
	if p1.dead == false then
		wait(0.1);
		l__TweenService__2:Create(v4, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Saturation = 0, 
			Contrast = 0, 
			TintColor = Color3.new(1, 1, 1)
		}):Play();
		l__TweenService__2:Create(v5, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			ImageTransparency = 1, 
			Size = UDim2.new(1.6, 0, 1.6, 0)
		}):Play();
		l__TweenService__2:Create(v5.DamageVignette, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			ImageTransparency = 1
		}):Play();
		l__TweenService__2:Create(v6, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			LowGain = 0, 
			MidGain = 0, 
			HighGain = 0
		}):Play();
		l__TweenService__2:Create(v7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			PlaybackSpeed = 1.2
		}):Play();
		l__TweenService__2:Create(v8, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			PlaybackSpeed = 1
		}):Play();
		l__TweenService__2:Create(v7, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();
		l__TweenService__2:Create(v8, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();
		wait(1);
	else
		v10:StartFadeOut(0.3);
		v11:StartFadeOut(0.3);
	end;
	u3 = false;
	v4:Destroy();
	v5:Destroy();
	v6:Destroy();
	v7:Destroy();
	v8:Destroy();
	v9:Destroy();
end;
