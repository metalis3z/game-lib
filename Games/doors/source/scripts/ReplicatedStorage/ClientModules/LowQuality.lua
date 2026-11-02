-- Decompiled with the Synapse X Luau decompiler.

local u1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
return function(p1, p2)
	local v1, v2 = u1();
	if not p1 then
		p1 = 3;
	end;
	if p2 then
		if (p1 <= UserSettings().GameSettings.SavedQualityLevel.Value or UserSettings().GameSettings.SavedQualityLevel.Value == 0) and v1 ~= "mobile" then
			return true;
		else
			return false;
		end;
	end;
	if (not (UserSettings().GameSettings.SavedQualityLevel.Value <= p1) or UserSettings().GameSettings.SavedQualityLevel.Value == 0) and v1 ~= "mobile" then
		return false;
	end;
	return true;
end;
