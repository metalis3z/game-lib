-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local u1 = nil;
local u2 = v1.Player.Get("Camera");
local u3 = nil;
function UpdateResolution()
	u1 = u2.ViewportSize;
	u3 = v1.Functions.ResolutionScale();
	v1.Variables.Resolution = u1;
	v1.Variables.ResolutionScale = u3;
	v1.Signal.Fire("Resolution Changed", u1, u3);
end;
UpdateResolution();
u2:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateResolution);
