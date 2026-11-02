-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
return function(p1, p2)
	local l__BreakerPoles__3 = u1.MainFrame.FlashSpecify:FindFirstChild("BreakerPoles");
	if not l__BreakerPoles__3 then
		return;
	end;
	local v4 = l__BreakerPoles__3:Clone();
	v4.Name = v4.Name .. "Live";
	v4.Durability.Bar.Size = UDim2.new(p2 / 10, 0, 1, 0);
	v4.Parent = u1.MainFrame.FlashSpecify;
	v4.Visible = true;
	l__TweenService__2:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.5, 0, 0.2, 0)
	}):Play();
	l__TweenService__2:Create(v4, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__2:Create(v4.Durability.Bar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 4, true, 0), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 111, 106)
	}):Play();
	wait(2);
	l__TweenService__2:Create(v4.Durability, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v5, v6 in pairs(v4:GetDescendants()) do
		if v6:IsA("Frame") then
			l__TweenService__2:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v4:Destroy();
end;
