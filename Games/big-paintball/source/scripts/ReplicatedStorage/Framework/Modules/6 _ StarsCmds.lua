-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l____DEBRIS__2 = game.Workspace:WaitForChild("__DEBRIS");
local l__CurrentCamera__3 = game.Workspace.CurrentCamera;
local l__Assets__4 = game.ReplicatedStorage:WaitForChild("Assets");
function v1.Needed(p1)
	for v5, v6 in pairs(u1.Directory.Levels) do
		local v10 = u1.Directory.Levels[v5 + 1];
		if v6.MinLevel <= p1 and p1 <= (v10 and v10.MinLevel or 999999) then
			return v6.Stars;
		end;	
	end;
	return 7;
end;
return v1;
