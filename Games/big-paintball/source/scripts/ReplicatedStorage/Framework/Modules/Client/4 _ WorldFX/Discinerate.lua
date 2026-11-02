-- Firebase sez: 404: Not Found (Retrying until success)

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local l__Assets__1 = game.ReplicatedStorage:WaitForChild("Assets");
return function(p1)
	if not p1 or not p1:IsA("Model") then
		u1.Print("Unable to Discinerate. Invalid model provided.");
		return;
	end;
	for v2, v3 in pairs(p1:GetDescendants()) do
		if v3:IsA("BasePart") then
			v3.CanCollide = false;
			v3.Anchored = true;
			u1.Functions.FastTween(v3, {
				Transparency = 1, 
				CFrame = v3.CFrame * CFrame.new(math.random(-3, 3) / 4, math.random(-3, 3) / 4, math.random(-3, 3) / 4) * CFrame.Angles(math.rad(math.random(-5, 5)), math.rad(math.random(-5, 5)), math.rad(math.random(-5, 5)))
			}, { 0.35, "Quad", "Out" });
		end;
	end;
end;
