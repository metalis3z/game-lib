-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
return function(p1)
	local v3 = {};
	if p1:FindFirstChild("ButtonFX UIScale") then
		return;
	end;
	local v4 = Instance.new("UIScale");
	v4.Name = "ButtonFX UIScale";
	v4.Parent = p1;
	local u2 = false;
	local function u3()
		if not u2 then
			u2 = not u2;
			u1.Functions.FastTween(v4, {
				Scale = 0.93
			}, { 0.05, "Quad", "Out" });
		end;
	end;
	v3[#v3 + 1] = p1.MouseButton1Down:Connect(function()
		u3();
	end);
	local function u4()
		if u2 then
			u2 = not u2;
			u1.Functions.FastTween(v4, {
				Scale = 1
			}, { 0.065, "Sine", "Out" });
		end;
	end;
	v3[#v3 + 1] = p1.MouseButton1Up:Connect(function()
		u4();
	end);
	v3[#v3 + 1] = p1.MouseLeave:Connect(function()
		u4();
	end);
	local u5 = v3;
	return function()
		for v5, v6 in ipairs(u5) do
			v6:disconnect();		
		end;
		u5 = nil;
	end;
end;
