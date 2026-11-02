-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local v3 = require(script.Parent);
local v4 = game["Run Service"];
local l__TweenService__5 = game:GetService("TweenService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__WarningScreen__7 = script.Parent.Parent.Parent:WaitForChild("LobbyFrame"):WaitForChild("WarningScreen");
l__WarningScreen__7.Visible = true;
local v8 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
wait(0.5);
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
wait(2);
l__UserInputService__6.InputChanged:Wait();
local u1 = false;
l__TweenService__5:Create(l__WarningScreen__7.Continue, v8, {
	Size = UDim2.new(1, 0, 0.15, 0)
}):Play();
wait(0.5);
l__TweenService__5:Create(l__WarningScreen__7.Continue, v8, {
	TextTransparency = 0
}):Play();
wait(0.5);
l__UserInputService__6.InputBegan:Wait();
(function()
	if u1 == true then
		return;
	end;
	u1 = true;
	l__TweenService__5:Create(l__WarningScreen__7, v8, {
		BackgroundTransparency = 1, 
		Size = UDim2.new(2, 0, 2, 0)
	}):Play();
	for v9, v10 in pairs(l__WarningScreen__7:GetDescendants()) do
		if v10:IsA("TextLabel") then
			l__TweenService__5:Create(v10, v8, {
				TextTransparency = 1, 
				TextStrokeTransparency = 1
			}):Play();
		elseif v10:IsA("ImageLabel") then
			l__TweenService__5:Create(v10, v8, {
				ImageTransparency = 1
			}):Play();
		end;
	end;
	wait(1);
	l__WarningScreen__7.Visible = false;
end)();
