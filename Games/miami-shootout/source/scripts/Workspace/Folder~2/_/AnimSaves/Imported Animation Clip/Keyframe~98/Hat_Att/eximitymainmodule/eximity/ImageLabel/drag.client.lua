-- Decompiled with the Synapse X Luau decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local u1 = nil;
local l__Parent__2 = script.Parent;
local u3 = nil;
local u4 = nil;
l__Parent__2.InputBegan:Connect(function(p1)
	if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then
		u4 = true;
		u1 = p1.Position;
		u3 = l__Parent__2.Position;
		p1.Changed:Connect(function()
			if p1.UserInputState == Enum.UserInputState.End then
				u4 = false;
			end;
		end);
	end;
end);
local u5 = nil;
l__Parent__2.InputChanged:Connect(function(p2)
	if p2.UserInputType == Enum.UserInputType.MouseMovement or p2.UserInputType == Enum.UserInputType.Touch then
		u5 = p2;
	end;
end);
l__UserInputService__1.InputChanged:Connect(function(p3)
	if p3 == u5 and u4 then
		local v2 = p3.Position - u1;
		l__Parent__2.Position = UDim2.new(u3.X.Scale, u3.X.Offset + v2.X, u3.Y.Scale, u3.Y.Offset + v2.Y);
	end;
end);
