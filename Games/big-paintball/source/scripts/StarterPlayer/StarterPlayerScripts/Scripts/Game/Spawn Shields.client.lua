-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = v1.Player.Get("Camera");
local u1 = v1.Player.Get();
local function u2(p1)
	if p1:FindFirstChild("SpawnShields") then
		for v4, v5 in pairs(p1.SpawnShields:GetDescendants()) do
			if v5.Name == "Texture" then
				coroutine.wrap(function()
					while game.Workspace:FindFirstChild("__MAP") == game.Workspace:FindFirstChild("__MAP") and game.Workspace:FindFirstChild("__MAP"):FindFirstChild("SpawnShields") do
						v5.OffsetStudsU = v5.OffsetStudsU + 0.01;
						v5.OffsetStudsV = v5.OffsetStudsV + 0.01;
						v1.Heartbeat();					
					end;
				end)();
			end;
		end;
		wait(3);
		coroutine.wrap(function()
			while p1 and p1.Parent == game.Workspace and p1:FindFirstChild("SpawnShields") do
				for v6, v7 in pairs(p1:FindFirstChild("SpawnShields"):GetDescendants()) do
					if v7:IsA("BasePart") then
						v7.CanCollide = true;
					end;
				end;
				if u1 and u1.Team and p1:FindFirstChild("SpawnShields"):FindFirstChild(u1.Team.Name) then
					for v8, v9 in pairs(p1:FindFirstChild("SpawnShields"):FindFirstChild(u1.Team.Name):GetDescendants()) do
						if v9:IsA("BasePart") then
							v9.CanCollide = false;
						end;
					end;
				end;
				wait(1);			
			end;
		end)();
	end;
end;
game.Workspace.ChildAdded:Connect(function(p2)
	wait(1);
	if p2.Name == "__MAP" then
		u2(game.Workspace:FindFirstChild("__MAP"));
	end;
end);
wait(1);
if game.Workspace:FindFirstChild("__MAP") then
	u2(game.Workspace:FindFirstChild("__MAP"));
end;
