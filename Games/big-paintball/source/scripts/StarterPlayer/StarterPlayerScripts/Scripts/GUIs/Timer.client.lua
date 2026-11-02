-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l____VARIABLES__3 = game.Workspace:WaitForChild("__VARIABLES");
local v4 = v1.Player.Get("Camera");
local l__RoundType__1 = l____VARIABLES__3:WaitForChild("RoundType");
local u2 = v1.Player.Get();
local l__Top__3 = v1.GUI.Top;
local l__SecondsRemaining__4 = l____VARIABLES__3:WaitForChild("SecondsRemaining");
local u5 = "";
local v7
local function v5()
	if l__RoundType__1.Value ~= "Intermission" and l__RoundType__1.Value ~= "Voting" and (not (not u2:FindFirstChild("__SPAWNED")) and not v1.GUI.Scope.Gui.Enabled or v1.GUI.Menu.Gui.Enabled and not v1.Variables.Mobile) then
		l__Top__3.Gui.Enabled = true;
		local v6 = os.date("!*t", l__SecondsRemaining__4.Value);
		if v6.sec < 10 then
			v7 = "0";
		else
			v7 = "";
		end;
		l__Top__3.Timer.TextLabel.Text = string.format("%s:%s", tostring(v6.min), v7 .. tostring(v6.sec));
		l__Top__3.RoundType.TextLabel.Text = l__RoundType__1.Value;
		if v6.min <= 0 and v6.sec <= 15 and v6.sec > 0 and l__Top__3.Timer.TextLabel.Text ~= u5 then
			v1.Audio.Play(3976627745, script, 1, 0.7);
		end;
		u5 = l__Top__3.Timer.TextLabel.Text;
		return;
	end;
	if l__Top__3.Gui.Enabled then
		l__Top__3.Gui.Enabled = false;
	end;
end;
while true do
	v5();
	v1.Heartbeat();
end;
