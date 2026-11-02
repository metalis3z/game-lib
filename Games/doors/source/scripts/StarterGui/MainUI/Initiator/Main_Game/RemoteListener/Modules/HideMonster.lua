-- Decompiled with the Synapse X Luau decompiler.

local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
local l__LocalPlayer__3 = game.Players.LocalPlayer;

local can = true

return function(p1, p2)
	if can == false then
		return
	end
	if p1.dead then
		return;
	end;
	if l__LocalPlayer__3.Character:GetAttribute("Hiding") == false then
		return;
	end
	if l__LocalPlayer__3.Character:GetAttribute("HideSickness") == true then
		return;
	end
	can = false
	local v1 = game.Lighting.Sanity:Clone();
	v1.Name = "LiveSanity";
	v1.Enabled = true;
	v1.Parent = game.Lighting;
	local v2 = u1.MainFrame.SanityVignette:Clone();
	v2.Name = "LiveSanityVignette";
	v2.Visible = true;
	v2.Parent = u1;
	local v3 = game.SoundService.Main.SanityEqualizer:Clone();
	v3.Name = "SanityEqualizerLive";
	v3.Enabled = true;
	v3.Parent = game.SoundService.Main;
	local v4 = script.Heartbeat:Clone();
	v4.Name = "LiveHeartbeat";
	v4.Parent = script;
	v4:Play();
	local v5 = script.Whispers:Clone();
	v5.Name = "LiveWhispers";
	v5.Parent = script;
	v5:Play();
	local v6 = script.Static:Clone();
	v6.Name = "LiveStatic";
	v6.Parent = script;
	v6:Play();
	l__TweenService__2:Create(v1, TweenInfo.new(p2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		Saturation = -0.8, 
		Contrast = 0.3, 
		TintColor = Color3.new(1, 0.9, 0.92)
	}):Play();
	l__TweenService__2:Create(v2, TweenInfo.new(p2 * 0.66, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		ImageTransparency = 0, 
		Size = UDim2.new(1.2, 0, 1.2, 0)
	}):Play();
	l__TweenService__2:Create(v2.DamageVignette, TweenInfo.new(p2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		ImageTransparency = 0
	}):Play();
	l__TweenService__2:Create(v3, TweenInfo.new(p2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		LowGain = 0, 
		MidGain = -20, 
		HighGain = -40
	}):Play();
	l__TweenService__2:Create(v4, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		PlaybackSpeed = 2
	}):Play();
	l__TweenService__2:Create(v5, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		PlaybackSpeed = 2
	}):Play();
	l__TweenService__2:Create(v4, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Volume = 1.6
	}):Play();
	l__TweenService__2:Create(v5, TweenInfo.new(p2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		Volume = 1.6
	}):Play();
	--local v7 = p1.camShaker:StartShake(1, 16, p2, Vector3.new(0, 0, 0));
	--local v8 = p1.camShaker:StartShake(8, 1, p2, Vector3.new(0, 0, 0));
	local v9 = tick() + p2;
	local v10 = tick() + p2 / 2;
	local u4 = true;
	local l__Jumpscare_Hide__5 = u1.Jumpscare.Jumpscare_Hide;
	task.spawn(function()
		pcall(function()
			while u4 do
				task.wait();
				local v11 = math.clamp(v4.PlaybackLoudness * v4.Volume / 1000, 0, 0.8);
				v2.DamageVignette.ImageColor3 = Color3.new(0.1 + v11, v11 / 4, v11 / 4);
				l__Jumpscare_Hide__5.Static.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0);
				l__Jumpscare_Hide__5.Static.Rotation = math.random(0, 1) * 180;
				l__Jumpscare_Hide__5.Static.ImageTransparency = 1 - v11 - math.clamp(v5.PlaybackLoudness * v5.Volume / 1000, 0, 0.8);			
				if l__LocalPlayer__3.Character:GetAttribute("Hiding") == false then
					u4 = false;
					v1:Destroy();
					v2:Destroy();
					v3:Destroy();
					v4:Destroy();
					v5:Destroy();
					v6:Destroy();
					l__Jumpscare_Hide__5.Visible = false;
					l__LocalPlayer__3.Character:SetAttribute("HideSickness", false)
					wait(15)
					can = true
					break;
				end
			end;
		end);
	end);
	l__Jumpscare_Hide__5.Visible = true;
	task.spawn(function()
		for v12 = 1, 10000 do
			task.wait(0.03333333333333333);
			if v10 <= tick() then
				if math.random(1, 20) == 5 then
					l__Jumpscare_Hide__5.Overlay.Position = UDim2.new(math.random(30, 70) / 100, 0, math.random(30, 70) / 100, 0);
					l__Jumpscare_Hide__5.Overlay.Visible = true;
					v6.Volume = 0.12;
				else
					l__Jumpscare_Hide__5.Overlay.Visible = false;
					v6.Volume = 0;
				end;
			end;
			if v9 <= tick() then

			end;
			if p1.camlock == nil then
				break;
			end;
			if p1.dead then
				break;
			end;
			if l__LocalPlayer__3.Character:GetAttribute("HideSickness") == true then
				return;
			end
			if l__LocalPlayer__3.Character:GetAttribute("Hiding") == false then
				u4 = false;
				v1:Destroy();
				v2:Destroy();
				v3:Destroy();
				v4:Destroy();
				v5:Destroy();
				v6:Destroy();
				l__Jumpscare_Hide__5.Visible = false;
				l__LocalPlayer__3.Character:SetAttribute("HideSickness", false)
				wait(15)
				can = true
				break;
			end
		end;
	end)
	if l__LocalPlayer__3.Character:GetAttribute("HideSickness") == true then
		return;
	end
	if l__LocalPlayer__3.Character:GetAttribute("Hiding") == false then
		u4 = false;
		v1:Destroy();
		v2:Destroy();
		v3:Destroy();
		v4:Destroy();
		v5:Destroy();
		v6:Destroy();
		l__Jumpscare_Hide__5.Visible = false;
		l__LocalPlayer__3.Character:SetAttribute("HideSickness", false)
		wait(15)
		can = true
		return;
	end
	--v7:StartFadeOut(0.3);
	--v8:StartFadeOut(0.3);
	task.wait(10)
	if l__LocalPlayer__3.Character:GetAttribute("Hiding") == false then
		u4 = false;
		v1:Destroy();
		v2:Destroy();
		v3:Destroy();
		v4:Destroy();
		v5:Destroy();
		v6:Destroy();
		l__Jumpscare_Hide__5.Visible = false;
		l__LocalPlayer__3.Character:SetAttribute("HideSickness", false)
		wait(15)
		can = true
		return;
	else
		--if p1.dead == false then
		l__LocalPlayer__3.Character:SetAttribute("HideSickness", true)
		p1.camShaker:ShakeOnce(72, 22, 0, 2, Vector3.new(0, 0, 0));
		p1.camShaker:ShakeOnce(3, 6, 0, 18, Vector3.new(0, 0, 0));
		p1.camShaker:ShakeOnce(12, 0.5, 0, 18, Vector3.new(0, 0, 0));
		l__Jumpscare_Hide__5.Overlay.Visible = false;
		v6.Volume = 0;
		l__TweenService__2:Create(v1, TweenInfo.new(0.06, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {
			Brightness = 0.5
		}):Play();
		script.Scare:Play();
		wait(2);
	end
	if l__LocalPlayer__3.Character:GetAttribute("HideSickness") == true then
		return;
	end
	if l__LocalPlayer__3.Character:GetAttribute("Hiding") == false then
		return
	else
		l__TweenService__2:Create(v1, TweenInfo.new(15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Saturation = 0, 
			Contrast = 0, 
			TintColor = Color3.new(1, 1, 1)
		}):Play();
		l__TweenService__2:Create(v2, TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			ImageTransparency = 1, 
			Size = UDim2.new(1.6, 0, 1.6, 0)
		}):Play();
		l__TweenService__2:Create(v2.DamageVignette, TweenInfo.new(15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			ImageTransparency = 1
		}):Play();
		l__TweenService__2:Create(v3, TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			LowGain = 0, 
			MidGain = 0, 
			HighGain = 0
		}):Play();
		l__TweenService__2:Create(v4, TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			PlaybackSpeed = 1.2
		}):Play();
		l__TweenService__2:Create(v5, TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			PlaybackSpeed = 1
		}):Play();
		l__TweenService__2:Create(v4, TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();
		l__TweenService__2:Create(v5, TweenInfo.new(15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();
		wait(15);
	--[[else
		v7:StartFadeOut(0.3);
		v8:StartFadeOut(0.3);
	end;]]
		u4 = false;
		v1:Destroy();
		v2:Destroy();
		v3:Destroy();
		v4:Destroy();
		v5:Destroy();
		v6:Destroy();
		l__Jumpscare_Hide__5.Visible = false;
		l__LocalPlayer__3.Character:SetAttribute("HideSickness", false)
		can = true
	end
end;