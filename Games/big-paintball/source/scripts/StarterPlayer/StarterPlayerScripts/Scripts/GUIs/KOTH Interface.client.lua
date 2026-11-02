-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__KOTHProgress__2 = v1.GUI.KOTHProgress;
local l____VARIABLES__3 = game.Workspace:WaitForChild("__VARIABLES");
local l__Menu__1 = v1.GUI.Menu;
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__BlueScore__3 = l____VARIABLES__3:WaitForChild("BlueScore");
local l__RedScore__4 = l____VARIABLES__3:WaitForChild("RedScore");
local l__Blue__5 = l__KOTHProgress__2.Container.Blue;
local l__Red__6 = l__KOTHProgress__2.Container.Red;
local l__BlueLabel__7 = l__KOTHProgress__2.Container.BlueLabel;
local l__RedLabel__8 = l__KOTHProgress__2.Container.RedLabel;
local l__GainEffect__9 = l__KOTHProgress__2.Container.GainEffect;
local u10 = Color3.fromRGB(0, 255, 255);
local u11 = Color3.fromRGB(255, 30, 30);
local v5
v1.Network.Fired("Team Gain Points"):Connect(function(p1)
	l__GainEffect__9.Visible = true;
	l__GainEffect__9.BackgroundTransparency = 0;
	l__GainEffect__9.UIScale.Scale = 1;
	if p1 == "Blue" then
		l__GainEffect__9.BackgroundColor3 = u10;
	elseif p1 == "Red" then
		l__GainEffect__9.BackgroundColor3 = u11;
	end;
	v1.Functions.FastTween(l__GainEffect__9.UIScale, {
		Scale = 3
	}, { 0.35, "Sine", "InOut" });
	v1.Functions.FastTween(l__GainEffect__9, {
		BackgroundTransparency = 1
	}, { 0.25, "Sine", "InOut" });
end);
local l__Icon__12 = l__KOTHProgress__2.Container.Center.Icon;
v1.Network.Fired("Hill Team Check"):Connect(function(p2)
	v1.Functions.FastTween(l__KOTHProgress__2.Container.Center, {
		BackgroundColor3 = p2 == "Blue" and u10 or (p2 == "Red" and u11 or Color3.new(0, 0, 0))
	}, { 0.3, "Sine", "InOut" });
	local v4 = {};
	if p2 ~= "Blue" then
		v5 = p2 == "Red" and Color3.new(0, 0, 0) or Color3.new(1, 1, 1);
	else
		v5 = Color3.new(0, 0, 0) or Color3.new(1, 1, 1);
	end;
	v4.ImageColor3 = v5;
	v1.Functions.FastTween(l__Icon__12, v4, { 0.3, "Sine", "InOut" });
end);
v1.Network.Fired("Team Took Hill"):Connect(function(p3)
	if l__LocalPlayer__2:FindFirstChild("__SPAWNED") then
		wait(0.25);
		if not p3 then
			v1.Audio.Play(8208138509, script, 1, 0.5);
			return;
		end;
	else
		return;
	end;
	v1.Audio.Play(8208138296, script, 1, 0.5);
end);
local function u13()
	local v6 = v1.Shared.getRoundType();
	if v6 == "Intermission" or v6 == "Voting" or v1.GUI.Scope.Gui.Enabled then
		l__KOTHProgress__2.Gui.Enabled = false;
		return;
	end;
	if l__Menu__1.Gui.Enabled or not l__LocalPlayer__2:FindFirstChild("__SPAWNED") then
		l__KOTHProgress__2.Gui.Enabled = false;
		return;
	end;
	if v6 ~= "KOTH" then
		l__KOTHProgress__2.Gui.Enabled = false;
		return;
	end;
	l__KOTHProgress__2.Gui.Enabled = true;
	local l__Value__7 = l__BlueScore__3.Value;
	local l__Value__8 = l__RedScore__4.Value;
	l__Blue__5.Size = UDim2.new(math.clamp(math.floor(l__Value__7 / 800 * 500) / 1000, 0, 0.5), 0, 1, 0);
	l__Red__6.Size = UDim2.new(math.clamp(math.floor(l__Value__8 / 800 * 500) / 1000, 0, 0.5), 0, 1, 0);
	l__BlueLabel__7.Text = tostring((math.floor(l__Value__7 / 800 * 100))) .. "%";
	l__RedLabel__8.Text = tostring((math.floor(l__Value__8 / 800 * 100))) .. "%";
end;
coroutine.wrap(function()
	while true do
		u13();
		wait(0.1);	
	end;
end)();
