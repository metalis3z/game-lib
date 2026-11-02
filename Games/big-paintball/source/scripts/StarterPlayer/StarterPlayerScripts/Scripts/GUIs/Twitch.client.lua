-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Twitch__1 = v1.GUI.Menu.Twitch;
coroutine.wrap(function()
	while true do
		if v1.Network.Invoke("Check If Streaming") then
			l__Twitch__1.Visible = true;
		else
			l__Twitch__1.Visible = false;
		end;
		wait(5);	
	end;
end)();
