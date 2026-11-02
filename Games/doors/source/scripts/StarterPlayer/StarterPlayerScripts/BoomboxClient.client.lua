local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local l__Events__4 = game:GetService("ReplicatedStorage"):WaitForChild("Events");
local l__MonitorBoombox__5 = l__Events__4:WaitForChild("MonitorBoombox");
local l__PlayBoombox__6 = l__Events__4:WaitForChild("PlayBoombox");
local l__CurrentCamera__7 = workspace.CurrentCamera;
local v8 = Instance.new("ColorCorrectionEffect", l__CurrentCamera__7);
local v9 = Instance.new("BlurEffect", l__CurrentCamera__7);
v9.Size = 0;
while true do
	wait(0.5);
	if _G.WaitForChar and _G.GVF then
		break;
	end;
end;
local u1 = nil;
local u2 = Instance.new("NumberValue", script);
local u3 = nil;
local function v10(p1)
	wait();
	if not p1 or not p1.Parent then
		return;
	end;
	pcall(function()
		u1:Cancel();
	end);
	u2.Value = 0;
	_G.WaitForChar();
	u3 = Instance.new("NumberValue", _G.GVF().FOVs);
end;
l__LocalPlayer__3.CharacterAdded:Connect(v10);
v10(l__LocalPlayer__3.Character);
local u4 = {};
local u5 = 0;
local u6 = false;
local function u7()
	if u3 and u3.Parent then
		local u8 = {};
		local u9 = 0;
		local function v11(p2)
			local v12 = p2[1];
			local v13 = p2[2];
			if not v13 then
				return;
			end;
			if not v12 or not v12.Parent then
				return;
			end;
			local v14 = (1 - math.clamp(((v12.Parent.Position - l__CurrentCamera__7.CFrame.Position).Magnitude + 3) / v13.Shake.MaxDist, 0.01, 1)) * v12.PlaybackLoudness / 5 * v13.Shake.Multi;
			u8[v12] = v14;
			u9 = u9 + v14;
			local v15 = v12.Parent:FindFirstChildWhichIsA("SpecialMesh");
		end;
		for v19, v20 in pairs(u4) do
			v11(v20);
		end;
		pcall(function()
			u1:Cancel();
		end);
		u1 = l__TweenService__2:Create(u2, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Value = u9
		});
		u1:Play();
		u9 = u2.Value;
		l__CurrentCamera__7.CFrame = l__CurrentCamera__7.CFrame * CFrame.Angles(0, 0, math.rad(math.random(-u9, u9) * 0.01)) + Vector3.new(math.rad(math.random(-u9 * 0.05, u9 * 0.05) * 0.05), math.rad(math.random(-u9 * 0.05, u9 * 0.05) * 0.05), math.rad(math.random(-u9 * 0.05, u9 * 0.05) * 0.05));
		u3.Value = u9 * 0.1;
		v9.Size = u9 * 0.1;
		v8.Brightness = u9 * 0.001;
	end;
end;
l__PlayBoombox__6.OnClientEvent:Connect(function(p3, p4)
	if p4 == "Play" then
		p3:Play();
		return;
	end;
	if p4 == "Pause" then
		p3:Pause();
		return;
	end;
	if p4 == "Resume" then
		p3:Resume();
		return;
	end;
	if p4 == "Stop" then
		p3:Stop();
	end;
end);
local function u10()
	if u5 <= 0 then
		u6 = false;
		pcall(function()
			l__RunService__1:UnbindFromRenderStep("BoomboxTing");
		end);
		return;
	end;
	if not u6 then
		u6 = true;
		l__RunService__1:BindToRenderStep("BoomboxTing", 10000, u7);
	end;
end;
l__MonitorBoombox__5.OnClientEvent:Connect(function(p5, p6)
	u4[p5] = { p5, p6 };
	u5 = u5 + 1;
	p5.AncestryChanged:Connect(function(p7, p8)
		if p8 == nil and u4[p5] then
			u4[p5] = nil;
			u5 = u5 - 1;
		elseif not u4[p5] then
			u4[p5] = { p5, p6 };
			u5 = u5 + 1;
		end;
		u10();
	end);
	u10();
end);