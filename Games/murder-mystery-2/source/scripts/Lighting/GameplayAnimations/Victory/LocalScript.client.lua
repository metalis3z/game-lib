-- Decompiled with the Synapse X Luau decompiler.

local l__SheriffVictory__1 = script.Parent.SheriffVictory;
l__SheriffVictory__1.Visible = true;
local l__TweenService__2 = game:GetService("TweenService");
local v3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
for v4, v5 in pairs({ l__TweenService__2:Create(l__SheriffVictory__1.Container, v3, {
		Size = UDim2.new(1, 0, 1, 0)
	}), l__TweenService__2:Create(l__SheriffVictory__1.KnifeRight, v3, {
		Position = UDim2.new(0.975, 0, 0.5, 0), 
		Rotation = 0
	}), l__TweenService__2:Create(l__SheriffVictory__1.KnifeLeft, v3, {
		Position = UDim2.new(0.025, 0, 0.5, 0), 
		Rotation = 0
	}) }) do
	v5:Play();
end;
