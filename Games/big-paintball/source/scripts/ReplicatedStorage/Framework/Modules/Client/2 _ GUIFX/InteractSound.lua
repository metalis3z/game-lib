-- OneX Was Here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__UIEasingStyle__3 = u1.Settings.UIEasingStyle;
return function(p1, p2, p3, p4, p5)
	p2 = string.lower(p2);
	p4 = p4 and 0.15;
	p5 = p5 and false;
	local v4 = {};
	if p2 == "mousedown" then
		v4[#v4 + 1] = p1.MouseButton1Down:Connect(function()
			u1.Audio.Play(p3, script, p5 and math.random(95, 105) / 100 or 1, p4 * 2);
		end);
	elseif p2 == "mouseup" then
		v4[#v4 + 1] = p1.MouseButton1Up:Connect(function()
			u1.Audio.Play(p3, script, p5 and math.random(95, 105) / 100 or 1, p4 * 2);
		end);
	elseif p2 == "mouseenter" then
		v4[#v4 + 1] = p1.MouseEnter:Connect(function()
			u1.Audio.Play(p3, script, p5 and math.random(95, 105) / 100 or 1, p4);
		end);
	elseif p2 == "mouseleave" then
		v4[#v4 + 1] = p1.MouseLeave:Connect(function()
			u1.Audio.Play(p3, script, p5 and math.random(95, 105) / 100 or 1, p4);
		end);
	elseif p2 == "mouseclick" then
		v4[#v4 + 1] = p1.Activated:Connect(function()
			u1.Audio.Play(p3, script, p5 and math.random(95, 105) / 100 or 1, p4);
		end);
	end;
	local u2 = v4;
	return function()
		for v5, v6 in ipairs(u2) do
			v6:disconnect();		
		end;
		u2 = nil;
	end;
end;
