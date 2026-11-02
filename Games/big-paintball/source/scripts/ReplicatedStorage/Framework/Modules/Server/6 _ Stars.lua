-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l____DEBRIS__2 = game.Workspace:WaitForChild("__DEBRIS");
local l__CurrentCamera__3 = game.Workspace.CurrentCamera;
local l__Assets__4 = game.ReplicatedStorage:WaitForChild("Assets");
function v1.Give(p1, p2)
	local v5 = u1.Saving.Get(p1);
	if v5 and v5.Stars then
		v5.Stars = v5.Stars + p2;
		return;
	end;
	u1.Print("Failed to get stats", true);
end;
function v1.Needed(p3)
	for v6, v7 in pairs(u1.Directory.Levels) do
		local v11 = u1.Directory.Levels[v6 + 1];
		if v7.MinLevel <= p3 and p3 <= (v11 and v11.MinLevel or 999999) then
			return v7.Stars;
		end;	
	end;
	return 7;
end;
u1.Signal.Fired("Player Added"):Connect(function(p4)
	coroutine.wrap(function()
		while p4 and p4.Parent == game.Players do
			local v12 = u1.Saving.Get(p4);
			if not v12 then
				u1.Print("Failed to get stats", true);
				return;
			end;
			local v13 = v1.Needed(v12.Level + 1);
			if v13 <= v12.Stars then
				v12.Stars = v12.Stars - v13;
				if v12.Level < 999 then
					local v14 = math.floor(833 * v12.Stars * (v12.Level + 1) ^ 0.25 / 1.35 / 500) * 500;
					v12.Level = v12.Level + 1;
					v12.Credits = v12.Credits + v14;
					u1.Network.Fire("Leveled Up", p4, v12.Level, v14);
					u1.Challenges.SetFromCategory(p4, "Killstreak", 0);
				end;
			end;
			u1.Functions.Wait(0.1);		
		end;
	end)();
end);
return v1;
