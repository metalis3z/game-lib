-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__UIEasingStyle__2 = u1.Settings.UIEasingStyle;
return function(p1)
	local v3 = {};
	local u3 = false;
	local u4 = u1.GUIFX.CacheProperty(p1, "Size");
	local function u5()
		if not u3 then
			u3 = not u3;
			u1.Functions.FastTween(p1, {
				Size = u4 + UDim2.new(0, 10, 0, -5)
			}, { 0.05, l__UIEasingStyle__2, "Out" });
		end;
	end;
	v3[#v3 + 1] = p1.MouseButton1Down:Connect(function()
		u5();
	end);
	local function u6()
		if u3 then
			u3 = not u3;
			u1.Functions.FastTween(p1, {
				Size = u4
			}, { 0.35, "Back", "Out" });
		end;
	end;
	v3[#v3 + 1] = p1.MouseButton1Up:Connect(function()
		u6();
	end);
	v3[#v3 + 1] = p1.MouseLeave:Connect(function()
		u6();
	end);
	local u7 = v3;
	return function()
		for v4, v5 in ipairs(u7) do
			v5:disconnect();		
		end;
		u7 = nil;
	end;
end;
