-- Decompiled with the Synapse X Luau decompiler.

local u1 = nil;
local u2 = false;
local u3 = game.Players:GetPlayerFromCharacter(script:FindFirstAncestorOfClass("Model"));
task.spawn(function()
	for v1 = 1, 10000000000000 do
		wait(1);
		if u2 and u1 and u1.Health > 0.1 and u3:GetAttribute("Alive") == true then
			u1.Health = math.clamp(u1.Health + 1, 0, u1.MaxHealth);
		elseif u3:GetAttribute("Alive") ~= true then

		end;
	end;
end);
return function(p1, p2)
	u1 = p1;
	u2 = p2;
end;
