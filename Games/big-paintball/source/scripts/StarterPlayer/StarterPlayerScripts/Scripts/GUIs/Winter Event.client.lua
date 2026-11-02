-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l____VARIABLES__3 = game.Workspace:WaitForChild("__VARIABLES");
local v4 = v1.Player.Get();
local v5 = v1.Player.Get("Camera");
local l__Menu__1 = v1.GUI.Menu;
local function u2()
	local v6 = v1.Save.Get();
	if not v6 or not v6.WinterKillsPartThree then
		return;
	end;
	l__Menu__1.Frame.Event.Visible = true;
	if not (v6.WinterKillsPartThree < 5000) then
		l__Menu__1.Frame.Event.Amount.Text = "COMPLETED!";
		l__Menu__1.Frame.Event.Progress.Bar.Size = UDim2.new(1, 0, 1, 0);
		l__Menu__1.Frame.Event.Icon.ImageColor3 = Color3.fromRGB(247, 250, 13);
		return;
	end;
	l__Menu__1.Frame.Event.Progress.Bar.Size = UDim2.new(math.clamp(v6.WinterKillsPartThree / 5000, 0, 1), 0, 1, 0);
	l__Menu__1.Frame.Event.Amount.Text = tostring(math.clamp(v6.WinterKillsPartThree, 0, 5000)) .. "/5000";
end;
coroutine.wrap(function()
	while true do
		if l__Menu__1.Gui.Enabled then
			u2();
		end;
		wait();	
	end;
end)();
