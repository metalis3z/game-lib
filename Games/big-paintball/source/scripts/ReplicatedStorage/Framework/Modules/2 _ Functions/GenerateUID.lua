--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local v1 = Random.new();
return function()
	return string.gsub(u1.HttpService:GenerateGUID(false), "-", "");
end;
