-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local v2 = v1.Player.Get("Camera");
local u1 = v1.Player.Get();
local l__TeamIndicator__2 = game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("TeamIndicator");
local function u3(p1)
	if not p1 or not p1.Character or not p1.Character:FindFirstChild("Head") then
		return;
	end;
	if p1.Character.Head:FindFirstChild("TeamIndicator") then
		p1.Character.Head:FindFirstChild("TeamIndicator"):Destroy();
	end;
	if v1.Shared.isFFA() then
		return;
	end;
	if p1.Team == u1.Team and p1.TeamColor == u1.TeamColor and p1:FindFirstChild("__SPAWNED") then
		l__TeamIndicator__2:Clone().Parent = p1.Character.Head;
	end;
end;
coroutine.wrap(function()
	while wait(0.25) do
		for v3, v4 in pairs(game.Players:GetPlayers()) do
			if v4 ~= u1 then
				u3(v4);
			end;
		end;	
	end;
end)();
