-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l____DEBRIS__2 = game.Workspace:WaitForChild("__DEBRIS");
local l__CurrentCamera__3 = game.Workspace.CurrentCamera;
local l__Assets__4 = game.ReplicatedStorage:WaitForChild("Assets");
function v1.GetPlayerChallenges(p1)
	local v5 = u1.Save.Get(true, p1);
	if v5 and v5.Challenges then
		return v5.Challenges;
	end;
	u1.Print("Failed to get stats", true);
end;
function v1.Get(p2)
	if not u1.Directory.Challenges[p2] then
		u1.Print(string.format("Failed to find challenge '%s'", p2), true);
		return;
	end;
	return u1.Directory.Challenges[p2];
end;
return v1;
