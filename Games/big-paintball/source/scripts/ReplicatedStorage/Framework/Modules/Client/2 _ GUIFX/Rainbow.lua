-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__UIEasingStyle__3 = u1.Settings.UIEasingStyle;
return function(p1, p2, p3)
	p3 = p3 and 1;
	local u2 = true;
	coroutine.wrap(function()
		local v4 = tick();
		while p1 and p1.Parent and u2 do
			p1[p2] = Color3.fromHSV((tick() - v4) * p3 % 1, 1, 1);
			u1.Stepped();		
		end;
	end)();
	return function()
		u2 = false;
	end;
end;
