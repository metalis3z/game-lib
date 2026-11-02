-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l__SkillLeaderboard__1 = v1.GUI.SkillLeaderboard;
local l__Menu__2 = v1.GUI.Menu;
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local function u4()
	local v2 = v1.Shared.getRoundType();
	if v2 == "Intermission" or v2 == "Voting" or v1.GUI.Scope.Gui.Enabled then
		l__SkillLeaderboard__1.Gui.Enabled = false;
		return;
	end;
	if l__Menu__2.Gui.Enabled or not l__LocalPlayer__3:FindFirstChild("__SPAWNED") then
		l__SkillLeaderboard__1.Gui.Enabled = false;
		return;
	end;
	if v2 == "KOTH" then
		l__SkillLeaderboard__1.Gui.Enabled = false;
		return;
	end;
	l__SkillLeaderboard__1.Gui.Enabled = true;
	local v3 = {};
	for v4, v5 in pairs(game.Players:GetPlayers()) do
		local v6 = v1.Entity.Get(game.Players:GetPlayers());
		if v5.Kills then
			local l__Kills__7 = v5;
			if l__Kills__7 then
				table.insert(v3, {
					player = v5, 
					kills = l__Kills__7
				});
			end;
		end;
	end;
	for v8, v9 in pairs(l__SkillLeaderboard__1.Frame.Players:GetChildren()) do
		if v9:IsA("ImageLabel") and not v3[v8] then
			v9:Destroy();
		end;
	end;
	table.sort(v3, function(p1, p2)
		return p2.kills < p1.kills;
	end);
	for v10, v11 in pairs(v3) do
		if v10 <= 8 then
			local v12 = l__SkillLeaderboard__1.Frame.Players:FindFirstChild(v10);
			if not v12 then
				v12 = script:WaitForChild("Player"):Clone();
				v12.Name = tostring(v10);
				v12.Parent = l__SkillLeaderboard__1.Frame.Players;
			end;
			v12:WaitForChild("PlayerImg").Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=100&height=100&format=png true", tostring(v11.player.userId));
			v12:WaitForChild("Rank").Text = tostring(v10);
			v12.Rank:WaitForChild("shadow").Text = tostring(v10);
			v12:WaitForChild("Tags").Text = tostring(v11.kills);
			v12.Tags:WaitForChild("shadow").Text = tostring(v11.kills);
			v12.LayoutOrder = v10;
			if v10 == 1 then
				v12.Rank.TextColor3 = Color3.fromRGB(255, 243, 71);
				v12.Sidetitle.TextColor3 = Color3.fromRGB(255, 243, 71);
			end;
			if not v1.Shared.isFFA() then
				if v11.player.Team == game.Teams:FindFirstChild("Blue") then
					v12.Tags.TextColor3 = Color3.fromRGB(24, 255, 255);
				elseif v11.player.Team == game.Teams:FindFirstChild("Red") then
					v12.Tags.TextColor3 = Color3.fromRGB(255, 34, 119);
				end;
			else
				v12.Tags.TextColor3 = Color3.fromRGB(255, 255, 255);
			end;
		end;
	end;
end;
coroutine.wrap(function()
	while true do
		u4();
		wait(0.1);	
	end;
end)();
