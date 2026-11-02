-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v2 = v1.Player.Get("PlayerGui");
if v1.Settings.ForcedPortrait then
	v2.ScreenOrientation = Enum.ScreenOrientation.Portrait;
elseif v1.Settings.SupportsPortrait then
	v2.ScreenOrientation = Enum.ScreenOrientation.Sensor;
end;
local u1 = nil;
function Check()
	local l__CurrentScreenOrientation__3 = v2.CurrentScreenOrientation;
	v1.Variables.Orientation = l__CurrentScreenOrientation__3;
	v1.Variables.Portrait = l__CurrentScreenOrientation__3 == Enum.ScreenOrientation.Portrait;
	v1.Variables.Landscape = l__CurrentScreenOrientation__3 ~= Enum.ScreenOrientation.Portrait;
	if u1 then
		if u1 ~= l__CurrentScreenOrientation__3 then
			v1.Signal.Fire("Orientation Changed", l__CurrentScreenOrientation__3, u1);
		end;
	else
		v1.Signal.Fire("Orientation Changed", l__CurrentScreenOrientation__3, u1);
	end;
	u1 = l__CurrentScreenOrientation__3;
end;
while true do
	Check();
	v1.Heartbeat();
end;
