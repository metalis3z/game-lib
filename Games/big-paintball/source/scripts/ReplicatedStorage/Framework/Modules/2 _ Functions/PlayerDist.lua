--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
return function(p1, p2)
	if type(p1) == "string" then
		p1 = game.Players:FindFirstChild(p1);
	end;
	if type(p2) == "string" then
		p2 = game.Players:FindFirstChild(p2);
	end;
	if p1 and p2 and p1.Character and p2.Character then
		local l__HumanoidRootPart__1 = p1.Character:FindFirstChild("HumanoidRootPart");
		local l__HumanoidRootPart__2 = p2.Character:FindFirstChild("HumanoidRootPart");
		if l__HumanoidRootPart__1 and l__HumanoidRootPart__2 then
			return (l__HumanoidRootPart__1.CFrame.p - l__HumanoidRootPart__2.CFrame.p).Magnitude;
		end;
	end;
end;
