-- Decompiled with the Synapse X Luau decompiler.

local l__Parent__1 = script.Parent.Parent.Parent.Parent.Parent.Parent;
local l__Parent__1 = script.Parent;
local function u2(p1)
	l__Parent__1:SetAttribute("AnimatedText", p1);
	if p1 ~= "" then
		script.Parent.Parent.ReaverChat:Fire();
	end;
end;
local u3 = { "\"Welcome to the event...\"", "\"Welcome to the event...\"", "\"Welcome to the event...\"", "\"Boo! Scared you!\"", "\"Back again?\"", "\"What will you unlock next?\"" };
l__Parent__1:GetPropertyChangedSignal("Visible"):connect(function()
	if l__Parent__1.Visible == true then
		if math.random(1, 3) ~= 1 then
			u2("");
			return;
		end;
	else
		return;
	end;
	u2(u3[math.random(1, #u3)]);
end);
script.Parent.Parent.Parent.List.MouseLeave:Connect(function()

end);
local v2 = os.clock();
for v3, v4 in pairs(script.Parent.Parent.Parent.List:GetChildren()) do
	if v4:IsA("Frame") then
		local u4 = v2;
		v4.MouseEnter:connect(function()
			if os.clock() - u4 >= 4 then
				if math.random(1, 5) ~= 5 then
					u2("");
					return;
				end;
			else
				return;
			end;
			u2(v4:GetAttribute("ChatText"));
			u4 = os.clock();
		end);
	end;
end;
