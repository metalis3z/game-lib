-- Decompiled with the Synapse X Luau decompiler.

local l__Parent__1 = script.Parent.Parent.Parent.Parent.Parent.Parent;
local l__Parent__1 = script.Parent;
local u2 = { "\"Merry Christmas!...\"", "\"Welcome to the event...\"", "\"Welcome to the event...\"", "\"Sup!\"", "\"Back again?\"", "\"What will you unlock next?\"" };
l__Parent__1:GetPropertyChangedSignal("Visible"):connect(function()
	if l__Parent__1.Visible == true then
		if math.random(1, 3) == 1 then
			local v2 = u2[math.random(1, #u2)];
			l__Parent__1:SetAttribute("AnimatedText", v2);
			if v2 == "" then
				return;
			end;
		else
			l__Parent__1:SetAttribute("AnimatedText", "");
			return;
		end;
	else
		return;
	end;
	script.Parent.Parent.ReaverChat:Fire();
end);
script.Parent.Parent.Parent.List.MouseLeave:Connect(function()

end);
local v3 = os.clock();
for v4, v5 in pairs(script.Parent.Parent.Parent.List:GetChildren()) do
	if v5:IsA("Frame") then
		local u3 = v3;
		v5.MouseEnter:connect(function()
			if os.clock() - u3 >= 4 then
				if math.random(1, 5) ~= 5 then
					l__Parent__1:SetAttribute("AnimatedText", "");
					return;
				end;
			else
				return;
			end;
			local v6 = v5:GetAttribute("ChatText");
			l__Parent__1:SetAttribute("AnimatedText", v6);
			if v6 ~= "" then
				script.Parent.Parent.ReaverChat:Fire();
			end;
			u3 = os.clock();
		end);
	end;
end;
