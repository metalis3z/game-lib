-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
return function(p1, p2)
	local l__ChargeMax__3 = u1.MainFrame.FlashSpecify:FindFirstChild("ChargeMax");
	if not l__ChargeMax__3 then
		return;
	end;
	local v4 = p2:GetAttribute("DurabilityMax");
	local v5 = l__ChargeMax__3:Clone();
	v5.Image = p2.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.Parent = u1.MainFrame.FlashSpecify;
	v5.Visible = true;
	l__TweenService__2:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__2:Create(v5, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__2:Create(v5.Reason, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__2:Create(v5.Durability.Bar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 4, true, 0), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	}):Play();
	l__TweenService__2:Create(v5.Durability, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 1.05, 4)
	}):Play();
	wait(2);
	l__TweenService__2:Create(v5.Durability, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__2:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v5:Destroy();
end;
