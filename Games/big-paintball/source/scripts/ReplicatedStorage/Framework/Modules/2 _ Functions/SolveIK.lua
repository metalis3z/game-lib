--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2, p3, p4)
	local v1 = nil;
	local v2 = p1:pointToObjectSpace(p2);
	local l__Unit__3 = v2.Unit;
	local l__Magnitude__4 = v2.Magnitude;
	v1 = p1 * CFrame.fromAxisAngle(Vector3.new(0, 0, -1):Cross(l__Unit__3), (math.acos(-l__Unit__3.Z)));
	if l__Magnitude__4 < math.max(p4, p3) - math.min(p4, p3) then
		return v1 * CFrame.new(0, 0, math.max(p4, p3) - math.min(p4, p3) - l__Magnitude__4), -math.pi / 2, math.pi;
	end;
	if p3 + p4 < l__Magnitude__4 then
		return v1, math.pi / 2, 0;
	end;
	local v5 = -math.acos((-(p4 * p4) + p3 * p3 + l__Magnitude__4 * l__Magnitude__4) / (2 * p3 * l__Magnitude__4));
	return v1, v5 + math.pi / 2, math.acos((p4 * p4 - p3 * p3 + l__Magnitude__4 * l__Magnitude__4) / (2 * p4 * l__Magnitude__4)) - v5;
end;
