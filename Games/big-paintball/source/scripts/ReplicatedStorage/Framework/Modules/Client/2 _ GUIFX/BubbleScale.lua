-- OneX Was Here
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__PlayerGui__1 = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = Random.new();
return function(p1)
	if not p1:IsA("GuiObject") then
		u1.Print("Not a GuiObject!", true);
		return;
	end;
	local v4 
	if not p1:FindFirstChild("__BUBBLESCALE") then
		v4 = Instance.new("UIScale");
		v4.Name = "__BUBBLESCALE";
		v4.Scale = 0.925;
		v4.Parent = p1;
	else
		v4 = p1:FindFirstChild("__BUBBLESCALE");
		v4.Scale = 0.925;
	end;
	local u2 = nil;
	u2 = u1.Functions.FastTween(v4, {
		Scale = 1
	}, { 0.125, "Sine", "Out" }).Completed:Connect(function(p2)
		if p2 == Enum.PlaybackState.Completed then
			v4:Destroy();
			u2:Disconnect();
		end;
	end);
end;
