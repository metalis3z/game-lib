--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	local v1 = nil;
	if type(p1) == "boolean" then
		v1 = "BoolValue";
	elseif type(p1) == "number" then
		v1 = "NumberValue";
	elseif type(p1) == "string" then
		v1 = "StringValue";
	elseif typeof(p1) == "BrickColor" then
		v1 = "BrickColorValue";
	elseif typeof(p1) == "CFrame" then
		v1 = "CFrameValue";
	elseif typeof(p1) == "Color3" then
		v1 = "Color3Value";
	elseif typeof(p1) == "Ray" then
		v1 = "RayValue";
	elseif typeof(p1) == "Vector3" then
		v1 = "Vector3Value";
	elseif typeof(p1) == "Instance" then
		v1 = "ObjectValue";
	end;
	if not v1 then
		u1.Print("Value type not supported", true);
		return;
	end;
	local v2 = Instance.new(v1);
	v2.Value = p1;
	if p2 then
		v2.Parent = p2;
	end;
	return v2;
end;
