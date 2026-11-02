-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local v3 = v1.Player.Get();
local v4 = v1.Player.Get("Camera");
local l__Menu__1 = v1.GUI.Menu;
local l__Challenges__2 = v1.GUI.Challenges;
local function v5()
	local v6 = v1.Save.Get();
	if not (not v6) and not (not v6.Stars) and not (not v6.Level) and not (not v6.Challenges) then
		for v7, v8 in pairs(l__Menu__1.Levels.Stars:GetChildren()) do
			if v8:IsA("ImageLabel") then
				v8:Destroy();
			end;
		end;
		for v9, v10 in pairs(l__Menu__1.Levels.Challenges:GetChildren()) do
			if v10:IsA("Frame") then
				v10:Destroy();
			end;
		end;
		for v11 = 1, v6.Stars do
			script:WaitForChild("Filled"):Clone().Parent = l__Menu__1.Levels.Stars;
		end;
		for v12 = 1, v1.StarsCmds.Needed(v6.Level + 1) - v6.Stars do
			script:WaitForChild("Unfilled"):Clone().Parent = l__Menu__1.Levels.Stars;
		end;
		for v13, v14 in pairs(v6.Challenges) do
			local v18 = v14[1];
			local v19 = v14[2];
			local v20 = v14[3];
			local v21 = v1.ChallengeCmds.Get(v18);
			if v18 and v19 and v20 and v14[4] and v21 then
				local v22 = script:WaitForChild("ChallengeItem"):Clone();
				v22:WaitForChild("Title").Text = v21.Display;
				v22:WaitForChild("Count").Text = tostring(math.clamp(v19, 0, v20)) .. "/" .. tostring(v20);
				for v23 = 1, v21.Reward do
					local v24 = script:WaitForChild("Filled"):Clone();
					v24.Size = UDim2.new(0.15, 0, 1, 0);
					v24.Parent = v22.Frame;
				end;
				v22.LayoutOrder = 3 - v21.Reward;
				v22.Parent = l__Menu__1.Levels.Challenges;
			else
				v1.Print(string.format("Invalid challenge '%s'", tostring(v18)), true);
			end;		
		end;
		for v25, v26 in pairs(l__Challenges__2.Frame:GetChildren()) do
			if v26:IsA("ImageLabel") then
				local v27 = false;
				for v28, v29 in pairs(v6.Challenges) do
					local v30 = v29[1];
					local v31 = v29[2];
					local v32 = v29[3];
					if v29[4] == v26.Name then
						v27 = true;
					end;
				end;
				if not v27 then
					v1.Functions.FastTween(v26, {
						Size = UDim2.new(0, 0, 0, 0)
					}, { 0.3, "Back", "In" });
					wait(0.3);
					v26:Destroy();
				end;
			end;
		end;
		for v33, v34 in pairs(v6.Challenges) do
			local v35 = v34[1];
			local v36 = v34[2];
			local v37 = v34[3];
			local v38 = v34[4];
			local v39 = v1.ChallengeCmds.Get(v35);
			if v35 and v36 and v37 and v38 and v39 then
				local v40 = l__Challenges__2.Frame:FindFirstChild(v38) or script:WaitForChild("ChallengeItemSide"):Clone();
				v40:WaitForChild("Title").Text = v39.Display;
				v40:WaitForChild("Count").Text = tostring(math.clamp(v36, 0, v37)) .. "/" .. tostring(v1.Functions.NumberShorten(v37));
				if v40.Parent ~= l__Challenges__2.Frame then
					v40.Name = v38;
					v40.LayoutOrder = 999 - v39.Reward;
					v40.ImageColor3 = Color3.fromRGB(255, 255, 255);
					v40.Parent = l__Challenges__2.Frame;
					v1.Functions.FastTween(v40, {
						ImageColor3 = Color3.fromRGB(0, 0, 0)
					}, { 1, "Quad", "Out" });
				end;
			else
				v1.Print(string.format("Invalid challenge '%s'", tostring(v35)), true);
			end;
		end;
		return;
	end;
end;
v5();
v1.Signal.Fired("Stat Changed"):Connect(function(p1, p2)
	if p1 == "Challenges" then
		v5();
	end;
end);
