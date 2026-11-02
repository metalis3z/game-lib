-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u1 = script:FindFirstAncestor("MainUI");
local l__TweenService__2 = game:GetService("TweenService");
return function(p1)
	local v3 = u1.MainFrame.WhiteVignette:Clone();
	if v3 then
		local v4 = v3:Clone();
		v4.Name = v4.Name .. "Live";
		v4.ImageColor3 = Color3.fromRGB(186, 255, 154);
		v4.ImageTransparency = 1;
		v4.Parent = u1.MainFrame;
		v4.Visible = true;
		l__TweenService__2:Create(v4, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1.5, 0, 1.5, 0)
		}):Play();
		l__TweenService__2:Create(v4, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			ImageTransparency = 0.5
		}):Play();
		wait(0.5);
		l__TweenService__2:Create(v4, TweenInfo.new(4.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			ImageTransparency = 1
		}):Play();
		wait(4.5);
		v4:Destroy();
	end;
end;
