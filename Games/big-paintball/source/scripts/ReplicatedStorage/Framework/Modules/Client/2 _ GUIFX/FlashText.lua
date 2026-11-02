-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__UIEasingStyle__2 = u1.Settings.UIEasingStyle;
return function(p1, p2)
	p2 = p2 and 1;
	local v3 = u1.GUIFX.CacheProperty(p1, "TextColor3");
	if v3 == Color3.new(1, 1, 1) then
		p1.TextColor3 = Color3.new(v3.r / 2, v3.g / 2, v3.b / 2);
	else
		p1.TextColor3 = Color3.new(v3.r * 2, v3.g * 2, v3.b * 2);
	end;
	local v4 = u1.Functions.FastTween(p1, {
		TextColor3 = v3
	}, { p2, l__UIEasingStyle__2 });
end;
