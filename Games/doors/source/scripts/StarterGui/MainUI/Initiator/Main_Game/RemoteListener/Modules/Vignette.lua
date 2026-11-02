-- Decompiled with the Synapse X Luau decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local v2 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__3 = game.Players.LocalPlayer;
return function(p1, p2, ...)
	if script.Modules:FindFirstChild(p2) then
		local v4 = require(script.Modules:FindFirstChild(p2));
	else
		v4 = nil;
	end;
	if not v4 then
		return;
	end;
	v4(p1, ...);
end;
