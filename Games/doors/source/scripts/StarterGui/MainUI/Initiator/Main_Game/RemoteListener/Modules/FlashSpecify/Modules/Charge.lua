-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
return function(p2, p3, p4, p5)
	local l__Charge__3 = u1.MainFrame.FlashSpecify:FindFirstChild("Charge");
	if not l__Charge__3 then
		return;
	end;
	print(p3)
	local v4 = p3:GetAttribute("DurabilityMax");
	local v5 = l__Charge__3:Clone();
	v5.Image = p3.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.Durability.Bar.Size = UDim2.new(p4 / v4, 0, 1, 0);
	v5.Durability.BarOld.Size = UDim2.new(p4 / v4, 0, 1, 0);
	v5.Parent = u1.MainFrame.FlashSpecify;
	v5.Visible = true;
	l__TweenService__2:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__2:Create(v5, TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__2:Create(v5.Reason, TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	wait(0.3);
	l__TweenService__2:Create(v5.Ol, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(p5 / v4, 0, 1, 0)
	}):Play();
	l__TweenService__2:Create(v5.Durability.Bar, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 222, 189)
	}):Play();
	l__TweenService__2:Create(v5.Durability.BarOld, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	}):Play();
	wait(2);
	l__TweenService__2:Create(v5.Durability, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__2:Create(v7, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.39);
	v5:Destroy();
end;
