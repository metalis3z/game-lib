-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
function update()
	if v1.Variables.Console == true then
		v1.Controller.UpdateSelections();
	end;
end;
while true do
	update();
	wait(0.5);
end;
