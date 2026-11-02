-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l____VARIABLES__3 = game.Workspace:WaitForChild("__VARIABLES");
local v4 = v1.Player.Get("Camera");
local l__MatchResults__1 = v1.GUI.MatchResults;
local u2 = v1.Player.Get();
local v19
local function u3(p1, p2, p3)
	l__MatchResults__1.Gui.Enabled = true;
	table.sort(p1, function(p4, p5)
		return p4.Order < p5.Order;
	end);
	local v5 = {};
	local l__All__6 = l__MatchResults__1.Leaderboard:FindFirstChild("All");
	for v7, v8 in pairs(game.Players:GetPlayers()) do
		local v9 = v1.Entity.Get(v8);
		if v9.Kills and v9.Streak then
			local v10 = v1.Save.Get(v8);
			if v10 and v10.Level then
				table.insert(v5, {
					player = v8, 
					kills = v9.Kills, 
					streak = v9.Streak, 
					level = v10.Level
				});
			end;
		end;
	end;
	v1.InfoOverlay.Remove();
	table.sort(v5, function(p6, p7)
		return p7.kills < p6.kills;
	end);
	local v11 = 0;
	for v12, v13 in pairs(v5) do
		local l__player__17 = v12.player;
		local v18 = script:WaitForChild("Player"):Clone();
		if v11 + 1 <= 3 then
			v19 = 0.075;
		else
			v19 = 0.05;
		end;
		v18.Size = UDim2.new(1, 0, v19, 0);
		v18:WaitForChild("Username").Text = "[LVL " .. v12.level .. "] " .. l__player__17.DisplayName;
		if l__player__17 == u2 then
			v18:WaitForChild("Username").TextColor3 = Color3.fromRGB(255, 255, 42);
		end;
		v18:WaitForChild("Stats"):WaitForChild("Kills").Text = v1.Functions.Commas(v12.kills);
		v18:WaitForChild("Stats"):WaitForChild("Streak").Text = v1.Functions.Commas(v12.streak);
		if p3 ~= "FFA" and l__player__17.Team and l__player__17.Team.Name and (l__player__17.Team == u2.Team or l__player__17 == u2) then
			v18:WaitForChild("Team").Visible = true;
			v18.Team.ImageColor3 = l__player__17.Team.Name == "Blue" and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(255, 30, 30);
		else
			v18:WaitForChild("Team").Visible = false;
		end;
		v18.Parent = l__All__6.Players;	
	end;
	local l__Team__20 = l__MatchResults__1.Results.Container.Team;
	if p3 and p3 == "KOTH" and p2 and p2 ~= "" and (p2 == "Blue" or p2 == "Red") then
		if p2 == "Blue" then
			l__Team__20.BackgroundColor3 = Color3.fromRGB(0, 255, 255);
			l__Team__20.TextLabel.Text = "Blue won the game!";
		else
			l__Team__20.BackgroundColor3 = Color3.fromRGB(255, 30, 30);
			l__Team__20.TextLabel.Text = "Red won the game!";
		end;
		l__Team__20.UIScale.Scale = 0;
		l__Team__20.Visible = true;
		v1.Functions.FastTween(l__Team__20.UIScale, {
			Scale = 1
		}, { 0.3, "Back", "Out" });
	else
		l__Team__20.Visible = false;
	end;
	wait(0.5);
	for v21, v22 in pairs(p1) do
		if script:FindFirstChild(v22.Type) then
			local v23 = script:WaitForChild(v22.Type):Clone();
			v23:WaitForChild("Details"):WaitForChild("Amount").Text = type(v22.Value) == "number" and v1.Functions.Commas(v22.Value) or v22.Value;
			v23.Size = UDim2.new(0.5, 0, 0, 0);
			v23.LayoutOrder = v22.Order;
			v23.Parent = l__MatchResults__1.Results.Container.List;
			l__MatchResults__1.Results.Container.List.UIListLayout:ApplyLayout();
			v1.Functions.FastTween(v23, {
				Size = v23.Size
			}, { 0.5, "Back", "Out" });
			if v22.Type == "TotalCredits" then
				coroutine.wrap(function()
					while v23.Parent == l__MatchResults__1.Results.Container.List do
						v23.Details.Amount.Size = UDim2.new(0, game:GetService("TextService"):GetTextSize(v23.Details.Amount.Text, v23.Details.Amount.AbsoluteSize.Y - 4, v23.Details.Amount.Font, Vector2.new(v23.Details.AbsoluteSize.X - v23.Details.Icon.AbsoluteSize.X, v23.Details.AbsoluteSize.Y * 0.8)).X, 1, 0);
						v1.Heartbeat();					
					end;
				end)();
			end;
			v1.Audio.Play(v1.Settings.MouseDownSound, script);
			wait(0.4);
		else
			v1.Print("Failed to find object with type: " .. v22.Type, true);
		end;
	end;
end;
v1.Network.Fired("Show Match Results"):Connect(function(...)
	u3(...);
	wait(20);
	if l__MatchResults__1.Gui.Enabled then
		l__MatchResults__1.Gui.Enabled = false;
		for v24, v25 in pairs(l__MatchResults__1.Results.Container.List:GetChildren()) do
			if v25:IsA("Frame") then
				v25:Destroy();
			end;
		end;
		for v26, v27 in pairs(l__MatchResults__1.Leaderboard.All.Players:GetChildren()) do
			if v27:IsA("Frame") then
				v27:Destroy();
			end;
		end;
	end;
end);
v1.Network.Fired("Hide Match Results"):Connect(function()
	l__MatchResults__1.Gui.Enabled = false;
	for v28, v29 in pairs(l__MatchResults__1.Results.Container.List:GetChildren()) do
		if v29:IsA("Frame") then
			v29:Destroy();
		end;
	end;
	for v30, v31 in pairs(l__MatchResults__1.Leaderboard.All.Players:GetChildren()) do
		if v31:IsA("Frame") then
			v31:Destroy();
		end;
	end;
end);
