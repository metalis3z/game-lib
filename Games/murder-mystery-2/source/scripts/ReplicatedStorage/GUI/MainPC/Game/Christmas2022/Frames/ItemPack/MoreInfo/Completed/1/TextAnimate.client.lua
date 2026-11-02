-- Decompiled with the Synapse X Luau decompiler.

TextJump = 4;
local u1 = 0;
local u2 = 0;
local u3 = "";
script.Parent:GetAttributeChangedSignal("AnimatedText"):connect(function()
	u1 = os.clock() - 0.011;
	u2 = 0;
	u3 = script.Parent:GetAttribute("AnimatedText");
end);
script.Parent.Parent.ResetAnimation.Event:Connect(function()
	script.Parent.Text = "";
	u3 = script.Parent:GetAttribute("AnimatedText");
	u1 = os.clock() - 0.011;
	u2 = 0;
	script.Parent.Parent.Parent.ViewportFrame.ReaverChat:Fire();
end);
local u4 = 0;
game:GetService("RunService").Stepped:Connect(function()
	if os.clock() - u4 >= 0.011 then
		u4 = os.clock();
		u2 = u2 + TextJump;
	end;
	script.Parent.Text = string.sub(u3, 1, u2);
end);
