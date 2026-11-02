-- Decompiled with the Synapse X Luau decompiler.

local u1 = require(script:WaitForChild("library"):WaitForChild("aeslua"));
script.Parent.MouseButton1Click:Connect(function()
	script.REMOTE:FireServer((u1.encrypt("ijherhg;", script.Parent.Parent.input.Scroller.input.Text, 32, 4)));
end);
