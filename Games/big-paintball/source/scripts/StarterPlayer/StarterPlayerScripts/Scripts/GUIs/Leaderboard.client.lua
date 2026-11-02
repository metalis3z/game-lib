-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__Assets__2 = game.ReplicatedStorage:WaitForChild("Assets");
local l__RoundType__3 = game.Workspace:WaitForChild("__VARIABLES"):WaitForChild("RoundType");
local v4 = v1.Player.Get("Camera");
local l__Leaderboard__1 = v1.GUI.Leaderboard;
local u2 = v1.Player.Get();
local v21
delay(0.25, function()
	v1.ContextActionService:BindAction("Leaderboard Toggle", function(p1, p2, p3)
		if p2 ~= Enum.UserInputState.Begin then
			if p2 == Enum.UserInputState.End then
				l__Leaderboard__1.Gui.Enabled = false;
			end;
			return;
		end;
		if not u2:FindFirstChild("__SPAWNED") and not v1.GUI.Killcam.Gui.Enabled then
			return;
		end;
		l__Leaderboard__1.Gui.Enabled = true;
	end, false, Enum.KeyCode.Tab, Enum.KeyCode.ButtonX);
	v1.GUI.Mobile.Leaderboard.MouseButton1Down:Connect(function()
		if not u2:FindFirstChild("__SPAWNED") then
			return;
		end;
		l__Leaderboard__1.Gui.Enabled = true;
	end);
	v1.GUI.Mobile.Leaderboard.MouseButton1Up:Connect(function()
		if not u2:FindFirstChild("__SPAWNED") then
			return;
		end;
		l__Leaderboard__1.Gui.Enabled = false;
	end);
	v1.GUI.Mobile.Leaderboard.MouseLeave:Connect(function()
		if not u2:FindFirstChild("__SPAWNED") then
			return;
		end;
		l__Leaderboard__1.Gui.Enabled = false;
	end);
end);
local function u3()
	if not l__Leaderboard__1.Gui.Enabled then
		return;
	end;
	local v5 = v1.Shared.getRoundType();
	if v5 == "Intermission" or v5 == "Voting" then
		l__Leaderboard__1.Gui.Enabled = false;
		return;
	end;
	local v6 = {};
	local l__All__7 = l__Leaderboard__1.Main:FindFirstChild("All");
	for v8, v9 in pairs(l__All__7.Players:GetChildren()) do
		if v9:IsA("Frame") and not game.Players:FindFirstChild(v9.Name) then
			v9:Destroy();
		end;
	end;
	for v10, v11 in pairs(game.Players:GetPlayers()) do
		local v12 = v1.Entity.Get(v11);
		if v11.Kills and v11.Streak then
			local v13 = v1.Save.Get(v11);
			if v13 and v13.Level then
				table.insert(v6, {
					player = v11, 
					kills = v11.Kills, 
					streak = v11.Streak, 
					level = v13.Level
				});
			end;
		end;
	end;
	table.sort(v6, function(p4, p5)
		local v14 = p4.kills and 0;
		local v15 = p5.kills and 0;
		if p4.player.Team == u2.Team then
			v14 = v14 + 99999;
		end;
		if p5.player.Team == u2.Team then
			v15 = v15 + 99999;
		end;
		return v15 < v14;
	end);
	for v16, v17 in pairs(v6) do
		local l__player__18 = v17.player;
		local l__streak__19 = v17.streak;
		if l__player__18 and l__player__18.Name then
			local v20 = l__All__7.Players:FindFirstChild(l__player__18.Name);
			if not v20 then
				v20 = script:WaitForChild("Player"):Clone();
				v20.Name = l__player__18.Name;
			end;
			v20.Size = UDim2.new(1, 0, 0.05, 0);
			v20.Username.Text = "[LVL " .. v17.level .. "] " .. l__player__18.DisplayName;
			if l__player__18 == u2 then
				v20.Username.TextColor3 = Color3.fromRGB(255, 255, 42);
			end;
			v20.Stats.Kills.Text = v1.Functions.Commas(v17.kills);
			if l__streak__19 == 0 then
				v21 = "None";
			else
				v21 = v1.Functions.Commas(l__streak__19);
			end;
			v20.Stats.Streak.Text = v21;
			v20.LayoutOrder = v16;
			--if v1.VipCmds.IsVip(l__player__18) then
			--	v20.VIP.Visible = true;
			--else
			--	v20.VIP.Visible = false;
			--end;
			if l__player__18.Team == u2.Team and not v1.Shared.isFFA() or l__player__18 == u2 then
				v20.Team.Visible = true;
				if v20.VIP.Visible then
					v20.VIP.Position = UDim2.new(0.05, 0, 0, 0);
					v20.Username.Position = UDim2.new(0.11, 0, 0.5, 0);
				else
					v20.Username.Position = UDim2.new(0.06, 0, 0.5, 0);
				end;
			else
				v20.Team.Visible = false;
				if v20.VIP.Visible then
					v20.VIP.Position = UDim2.new(0.01, 0, 0, 0);
					v20.Username.Position = UDim2.new(0.07, 0, 0.5, 0);
				else
					v20.Username.Position = UDim2.new(0.06, 0, 0.5, 0);
				end;
			end;
			v20.Parent = l__All__7.Players;
		end;
	end;
end;
coroutine.wrap(function()
	while true do
		u3();
		v1.Heartbeat(10);	
	end;
end)();
