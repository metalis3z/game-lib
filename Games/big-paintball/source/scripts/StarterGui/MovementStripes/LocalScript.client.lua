-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local u1 = Random.new();
local l__MovementStripes__2 = v1.GUI.MovementStripes;
local v8
function Make()
	local v2 = script.stripe:Clone();
	local v3 = u1:NextNumber(0.4, 0.7);
	local v4 = u1:NextNumber(0.2, 0.45);
	local v5 = u1:NextInteger(0, 1);
	local v6 = u1:NextNumber();
	local v7 = v5 == 0 and v4 / 2 or 1 - v4 / 2;
	v2.Position = UDim2.new(v6, 0, v7, 0);
	v2.Rotation = v5 == 0 and -45 + v6 * 90 or 225 - v6 * 90;
	if v5 == 0 then
		v8 = 1;
	else
		v8 = 0;
	end;
	v2.AnchorPoint = Vector2.new(0.5, v8);
	v2.Size = UDim2.new(0.1, 0, v4, 0);
	v2.ImageTransparency = u1:NextNumber(0.55, 0.8);
	v2.Parent = l__MovementStripes__2.Frame;
	v1.Functions.FastTween(v2, {
		ImageTransparency = 1, 
		Position = UDim2.new(v6, 0, v7 + (v5 == 0 and -v4 / 2 or v4 / 2), 0), 
		Size = UDim2.new(0.075, 0, v4 * 0.75, 0)
	}, { v3, "Sine", "InOut" }).Completed:Wait();
	v2:Destroy();
end;
while true do
	coroutine.wrap(function()
		Make();
	end)();
	v1.RenderStepped(5);
end;
