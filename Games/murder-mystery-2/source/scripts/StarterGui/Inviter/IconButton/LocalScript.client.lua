-- Decompiled with the Synapse X Luau decompiler.

local l__Parent__1 = script.Parent;
local l__SocialService__1 = game:GetService("SocialService");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
function onButtonPressed()
	local v2, v3 = pcall(function()
		return l__SocialService__1:CanSendGameInviteAsync(l__LocalPlayer__2);
	end);
	if v3 == true then
		l__SocialService__1:PromptGameInvite(l__LocalPlayer__2);
		script.Parent.IconImage.ImageColor3 = Color3.new(0.67451, 0.67451, 0.67451);
		script.Parent.Tooltip:Destroy();
		script.Parent.LocalScriptExtra.Disabled = false;
		script.Disabled = true;
	end;
end;
l__SocialService__1.GameInvitePromptClosed:Connect(function()
	script.Parent.IconImage.ImageColor3 = Color3.new(1, 1, 1);
end);
l__Parent__1.MouseButton1Click:Connect(onButtonPressed);
l__Parent__1.TouchTap:Connect(onButtonPressed);
l__Parent__1.MouseEnter:Connect(function()
	l__Parent__1.StateOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	l__Parent__1.StateOverlay.BackgroundTransparency = 0.9;
end);
l__Parent__1.MouseLeave:Connect(function()
	l__Parent__1.StateOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	l__Parent__1.StateOverlay.BackgroundTransparency = 1;
end);
l__Parent__1.MouseButton1Down:Connect(function()
	l__Parent__1.StateOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	l__Parent__1.StateOverlay.BackgroundTransparency = 0.7;
end);
l__Parent__1.MouseButton1Up:Connect(function()
	l__Parent__1.StateOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	l__Parent__1.StateOverlay.BackgroundTransparency = 1;
end);
