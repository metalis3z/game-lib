-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local u1 = {};
local u2 = nil;
local u3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Nevermore"))("Promise");
local function u4(p1)
	return u3.new(function(p2)
		local v2 = nil;
		for v3, v4 in pairs(u1) do
			if v3:lower() == p1 or v3:lower():find(p1) then
				v2 = v4;
			end;
		end;
		p2(v2);
	end);
end;
local u5 = nil;
l__LocalPlayer__1.Chatted:Connect(function(p3)
	if string.match(string.lower(p3), "/e ") then
		local u6 = nil;
		u4((p3:sub(string.len("/e ") + 1):lower())):Then(function(p4)
			u6 = p4;
		end):Wait();
		if u6 == nil then
			return;
		end;
		if u5 ~= u6 then
			u5 = u6;
			u5:Play();
			return;
		end;
	else
		return;
	end;
	u5:Stop();
	u5 = nil;
end);
local u7 = nil;
local function u8()
	for v5, v6 in pairs(script:GetChildren()) do
		if v6:IsA("Animation") then
			u1[v6.Name] = u2:LoadAnimation(v6);
		end;
	end;
end;
task.spawn(function()
	while true do
		wait();
		if l__LocalPlayer__1.Character then
			break;
		end;	
	end;
	u7 = l__LocalPlayer__1.Character;
	u2 = u7:WaitForChild("Humanoid");
	u8();
end);
l__LocalPlayer__1.CharacterAdded:Connect(function()
	u7 = l__LocalPlayer__1.Character;
	u2 = u7:WaitForChild("Humanoid");
	u8();
end);
local function u9()
	for v7, v8 in pairs(u1) do
		u1[v7]:Stop();
		u1[v7] = nil;
	end;
end;
l__LocalPlayer__1.CharacterRemoving:Connect(function()
	u9();
end);
return {};
