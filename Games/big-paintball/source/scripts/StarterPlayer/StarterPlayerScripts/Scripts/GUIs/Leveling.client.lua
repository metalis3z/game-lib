-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v2 = v1.Player.Get();
local v3 = {};
local l__LeveledUp__4 = v1.GUI.LeveledUp;
local v24
local u1 = {
	Main = l__LeveledUp__4.Frame.Main, 
	Reflectance = l__LeveledUp__4.Frame.Reflectance, 
	Shadow = l__LeveledUp__4.Frame.Shadow
};
local l__Menu__2 = v1.GUI.Menu;
function showLevelUp(p1, p2)
	local v5 = v1.Functions.GenerateUID();
	local v6 = Instance.new("CFrameValue");
	v6.Value = CFrame.new(0, 0, -100);
	local v7 = Instance.new("NumberValue");
	v7.Value = 720;
	for v8, v9 in pairs(u1) do
		v8.Star.Transparency = 0;	
	end;
	l__LeveledUp__4.Frame.Rank.TextTransparency = 0;
	l__LeveledUp__4.Frame.Rank.TextStrokeTransparency = 0;
	l__LeveledUp__4.Frame.Rank.shadow.TextTransparency = 0;
	l__LeveledUp__4.Frame.Rank.shadow.TextStrokeTransparency = 0;
	l__LeveledUp__4.Frame.Rank.Rotation = 0;
	l__LeveledUp__4.Frame.Rank.UIScale.Scale = 1;
	l__LeveledUp__4.Frame.BottomText.TextTransparency = 0;
	l__LeveledUp__4.Frame.BottomText.TextStrokeTransparency = 0;
	l__LeveledUp__4.Frame.BottomText.shadow.TextTransparency = 0;
	l__LeveledUp__4.Frame.BottomText.shadow.TextStrokeTransparency = 0;
	l__LeveledUp__4.Frame.BottomText.UIScale.Scale = 1;
	l__LeveledUp__4.Frame.Reflectance.UIGradient.Offset = Vector2.new(-1, 0);
	l__LeveledUp__4.Gui.Enabled = true;
	l__LeveledUp__4.Frame.Rank.Text = p1;
	l__LeveledUp__4.Frame.Rank.shadow.Text = p1;
	v1.Audio.Play(4511174462, script, 1, 1);
	v1.RunService:BindToRenderStep("Update Level Up" .. v5, Enum.RenderPriority.Last.Value, function(p3)
		for v13, v14, v15 in pairs(u1) do
			if v15 ~= "Shadow" then
				v14.Star.CFrame = v6.Value * CFrame.Angles(0, math.rad(v7.Value), 0);
			else
				v14.Star.CFrame = CFrame.new(0, 0, 2) * v6.Value * CFrame.Angles(0, math.rad(v7.Value), 0);
			end;		
		end;
	end);
	v1.Functions.FastTween(v6, {
		Value = CFrame.new(0, 0, -32)
	}, { 0.5, "Back", "Out" });
	v1.Functions.FastTween(v7, {
		Value = 0
	}, { 0.85, "Elastic", "Out" });
	wait(0.5);
	v1.Functions.FastTween(u1.Reflectance.UIGradient, {
		Offset = Vector2.new(1, 0)
	}, { 0.35, "Quad", "Out" });
	v1.Functions.FastTween(v6, {
		Value = CFrame.new(0, 0, -37.5) * CFrame.Angles(-0.4363323129985824, -0.7853981633974483, 0.5235987755982988)
	}, { 4, "Linear", "Out" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.Rank, {
		Rotation = 6
	}, { 3, "Quad", "Out" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.Rank.UIScale, {
		Scale = 1.25
	}, { 3, "Quad", "Out" });
	wait(2.75);
	for v18, v19 in pairs(u1) do
		local v23 = {};
		if v18 ~= "Shadow" then
			v24 = 0.8;
		else
			v24 = 0.65;
		end;
		v23[1] = v24;
		v23[2] = "Linear";
		v23[3] = "Out";
		v1.Functions.FastTween(v19.Star, {
			Transparency = 1
		}, v23);	
	end;
	v1.Functions.FastTween(v6, {
		Value = CFrame.new(0, 0, -250) * CFrame.Angles(-0.2617993877991494, -0.8726646259971648, 0.3490658503988659)
	}, { 0.8, "Quad", "InOut" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.Rank.UIScale, {
		Scale = 0
	}, { 0.3, "Quad", "Out" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.Rank, {
		TextTransparency = 1, 
		TextStrokeTransparency = 3
	}, { 0.8, "Quad", "Out" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.Rank.shadow, {
		TextTransparency = 2, 
		TextStrokeTransparency = 3
	}, { 0.8, "Quad", "Out" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.BottomText.UIScale, {
		Scale = 0
	}, { 0.3, "Quad", "Out" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.BottomText, {
		TextTransparency = 1, 
		TextStrokeTransparency = 3
	}, { 0.8, "Quad", "Out" });
	v1.Functions.FastTween(l__LeveledUp__4.Frame.BottomText.shadow, {
		TextTransparency = 2, 
		TextStrokeTransparency = 3
	}, { 0.8, "Quad", "Out" });
	wait(1.25);
	v1.RunService:UnbindFromRenderStep("Update Level Up" .. v5);
	l__LeveledUp__4.Gui.Enabled = false;
	l__Menu__2.Frame.Levels.Reward.Text = string.format("%s Credit Reward!", v1.Functions.Commas((v1.Shared.getRewardForLevel(v1.StarsCmds.Needed(p1), p1))));
end;
v1.Network.Fired("Leveled Up"):Connect(function(...)
	showLevelUp(...);
end);
v1.Network.Fired("Challenge Completed"):Connect(function()
	v1.Audio.Play(4511173890, script, 1, 1);
end);
local u3 = false;
v1.Signal.Fired("Menu View Changed"):Connect(function(p4)
	u3 = p4;
end);
coroutine.wrap(function()
	local l__Level__25 = l__Menu__2.Frame.Levels.Level;
	local v26 = v1.Save.Get(true); --nil;
	while wait(1) do
		l__Level__25.Text = tostring(v26.Level);
		l__Menu__2.Frame.Levels.Reward.Text = string.format("%s Credit Reward!", v1.Functions.Commas((v1.Shared.getRewardForLevel(v1.StarsCmds.Needed(v26.Level), v26.Level))));	
	end;
end)();
