-- Decompiled with the Synapse X Luau decompiler.

game:GetService("SocialService").GameInvitePromptClosed:Connect(function()
	require(script.Parent.Parent.ConfettiModule).Explode(script.Parent.Parent.ConfettiPosAndSizeFrame.AbsolutePosition + script.Parent.Parent.ConfettiPosAndSizeFrame.AbsoluteSize * 0.5, 30, 300, Vector2.new(0, -100));
end);
