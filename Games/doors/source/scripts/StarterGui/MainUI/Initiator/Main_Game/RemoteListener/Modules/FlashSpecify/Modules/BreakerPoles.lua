-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__TweenService__3 = game:GetService("TweenService");
return function(p1, p2, p3)
	local l__BreakerPoles__2 = u1.MainFrame.FlashSpecify:FindFirstChild("BreakerPoles");
	if not l__BreakerPoles__2 then
		return;
	end;
	local v3 = l__BreakerPoles__2:Clone();
	v3.Name = v3.Name .. "Live";
	v3.Durability.Bar.Size = UDim2.new((p2 - 1) / 10, 0, 1, 0);
	v3.Parent = u1.MainFrame.FlashSpecify;
	if p3 and p3 ~= l__LocalPlayer__2.UserId then
		v3.User.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p3 .. "&w=48&h=48";
		v3.User.Visible = true;
	end;
	v3.Visible = true;
	l__TweenService__3:Create(v3, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.5, 0, 0.2, 0)
	}):Play();
	l__TweenService__3:Create(v3, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__3:Create(v3.User, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__3:Create(v3.Durability.Bar, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		Size = UDim2.new(p2 / 10, 0, 1, 0)
	}):Play();
	l__TweenService__3:Create(v3.Durability.Bar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 4, true, 0), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	}):Play();
	wait(2);
	l__TweenService__3:Create(v3.Durability, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v4, v5 in pairs(v3:GetDescendants()) do
		if v5:IsA("Frame") then
			l__TweenService__3:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v3:Destroy();
end;
