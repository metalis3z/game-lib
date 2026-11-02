--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	if type(p1) ~= "table" then
		p1 = { p1 };
	end;
	for v1, v2 in ipairs(p1) do
		local v3 = {};
		for v4, v5 in ipairs(v2.Size.Keypoints) do
			table.insert(v3, NumberSequenceKeypoint.new(v5.Time, v5.Value * p2, v5.Envelope * p2));
		end;
		v2.Size = NumberSequence.new(v3);
		v2.Drag = v2.Drag * p2;
		v2.VelocityInheritance = v2.VelocityInheritance * p2;
		v2.Speed = NumberRange.new(v2.Speed.Min * p2, v2.Speed.Max * p2);
		v2.Acceleration = Vector3.new(v2.Acceleration.X * p2, v2.Acceleration.Y * p2, v2.Acceleration.Z * p2);
	end;
end;
