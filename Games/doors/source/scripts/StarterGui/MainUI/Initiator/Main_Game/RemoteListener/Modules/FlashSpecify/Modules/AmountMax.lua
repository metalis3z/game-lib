-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
return function(p1, p2, p3)
	local l__AmountMax__3 = u1.MainFrame.FlashSpecify:FindFirstChild("AmountMax");
	if not l__AmountMax__3 then
		return;
	end;
	local v4 = p2:GetAttribute("DurabilityMax");
	local v5 = l__AmountMax__3:Clone();
	v5.Image = p2.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.DurabilityNumber.Text = p3 .. "/" .. p3;
	v5.Parent = u1.MainFrame.FlashSpecify;
	v5.Visible = true;
	l__TweenService__2:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__2:Create(v5, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	wait(2);
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__2:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		elseif v7:IsA("TextLabel") then
			l__TweenService__2:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				TextTransparency = 1
			}):Play();
		elseif v7:IsA("UIStroke") then
			l__TweenService__2:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				Transparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v5:Destroy();
end;
