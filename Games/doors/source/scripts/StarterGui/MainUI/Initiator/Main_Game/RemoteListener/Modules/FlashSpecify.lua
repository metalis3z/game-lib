-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
return function(p1, p2, ...)
	local v3
	if script.Modules:FindFirstChild(p2) then
		v3 = require(script.Modules:FindFirstChild(p2));
	else
		v3 = nil;
	end;
	for v4, v5 in pairs(u1.MainFrame.FlashSpecify:GetChildren()) do
		if v5.Visible == true then
			v5.Visible = false;
		end;
	end;
	if u1:FindFirstChild("LiveCaption") then
		u1:FindFirstChild("LiveCaption"):Destroy();
	end;
	if v3 then
		v3(p1, ...);
		return;
	end;
	local v6 = u1.MainFrame.FlashSpecify:FindFirstChild(p2);
	if not v6 then
		warn("He will never be Query: " .. p2);
		return;
	end;
	local v7 = v6:Clone();
	v7.Name = v7.Name .. "Live";
	v7.Parent = u1.MainFrame.FlashSpecify;
	v7.Visible = true;
	l__TweenService__2:Create(v7, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__2:Create(v7, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__2:Create(v7, TweenInfo.new(0.17, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2, true, 0), {
		ImageColor3 = Color3.fromRGB(255, 255, 255)
	}):Play();
	wait(1.5);
	v7:Destroy();
end;
