local v1 = game:getService("RunService");
local u1 = 0.076;
local function u2(p1, p2, p3)
	return p1 + (p2 - p1) * p3;
end;
local u3 = 0.00075;
local u4 = 0.062;
local u5 = 0.00075;
local u6 = 0;
local u7 = math.pi * 2;
local u8 = 0;
local l__CurrentCamera__9 = workspace.CurrentCamera;
local l__math_sin__10 = math.sin;
v1:BindToRenderStep("Swaying", 201, function()
	u1 = u2(u1, 0.0452, 0.21);
	u3 = u2(u3, 0.00045, 0.11);
	u4 = u2(u4, 0.0424, 0.031);
	u5 = u2(u5, 0.00045, 0.061);
	u6 = (u6 + u1) % u7;
	u8 = (u8 + u4) % u7;
	l__CurrentCamera__9.CFrame = l__CurrentCamera__9.CFrame * CFrame.Angles(l__math_sin__10(u6) * u3, l__math_sin__10(u8) * u5, 0);
end);
