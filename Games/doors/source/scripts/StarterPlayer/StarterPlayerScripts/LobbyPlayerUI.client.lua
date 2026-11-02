if not game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("InGame").Value then
	local u1 = {};
	local u2 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
	local u3 = require(game.ReplicatedStorage.Achievements);
	local l__TweenService__4 = game:GetService("TweenService");
	local function v1(p1)
		if u1[p1] then
			return;
		end;
		if not p1.Character or not u2.players[p1] then
			for v2 = 1, 100 do
				wait(0.1);
				if p1.Character and u2.players[p1] then
					break;
				end;
			end;
		end;
		if not p1.Character or not u2.players[p1] then
			warn("No data!");
			print(u2.players);
			return;
		end;
		local v3 = game:GetService("ReplicatedStorage"):WaitForChild("NameUI"):Clone();
		v3.Name = "NameUI" .. p1.Name;
		u1[p1] = v3;
		local l__HumanoidRootPart__4 = p1.Character:WaitForChild("HumanoidRootPart");
		v3.Adornee = l__HumanoidRootPart__4:WaitForChild("Billybobjohnson");
		v3.Parent = game.Players.LocalPlayer.PlayerGui;
		v3.Username.Text = p1.Character:WaitForChild("Humanoid").DisplayName;
		local u5 = u2.players[p1];
		local l__Frame__6 = v3.Stuff.Frame;
		local function v5()
			local v6 = u3[u5.data.FlexAchievement];
			if v6 then
				local v7 = v6:GetInfo();
				l__Frame__6.IconBadge.Image = v7.Image;
				l__Frame__6.TextBadge.Text = v7.Title;
				l__Frame__6.IconBadge.Visible = true;
				l__Frame__6.TextBadge.Visible = true;
				for v8, v9 in pairs(v3:GetDescendants()) do
					if v9.Name == "ThemeGradient" then
						v9:Destroy();
					end;
				end;
				local v10 = game.ReplicatedStorage.BadgeGradients.Default;
				local v11 = game.ReplicatedStorage.BadgeGradients:FindFirstChild(v7.Theme);
				if v11 then
					v10 = v11;
				end;
				local v12 = v10:Clone();
				v12.Name = "ThemeGradient";
				v12.Parent = l__Frame__6.IconBadge.UIStroke;
				local v13 = v10:Clone();
				v13.Name = "ThemeGradient";
				v13.Parent = l__Frame__6.TextBadge;
				local l__Deaths__14 = u5.data.Stats.Deaths;
				if l__Deaths__14 and l__Deaths__14 > 0 then
					l__Frame__6.SeparatorDeaths.Visible = true;
					l__Frame__6.IconDeathHolder.Visible = true;
					l__Frame__6.TextDeaths.Text = l__Deaths__14;
					l__Frame__6.TextDeaths.Visible = true;
				end;
			end;
		end;
		v5();
		u5.event.FlexAchievement.Event:Connect(v5);
		local v15 = true;
		while true do
			wait(0.6);
			if l__HumanoidRootPart__4 and l__HumanoidRootPart__4.Parent then
				local v16 = (l__HumanoidRootPart__4.Position - workspace.CurrentCamera.CFrame.Position).Magnitude;
				if p1 ~= game.Players.LocalPlayer then
					v16 = math.min(v16, (l__HumanoidRootPart__4.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude);
				end;
				if v16 > 25 then
					if not v15 then
						l__TweenService__4:Create(v3.Stuff, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 0)
						}):Play();
						v15 = true;
					end;
				elseif v15 then
					l__TweenService__4:Create(v3.Stuff, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, 0, 0, 35)
					}):Play();
					v15 = false;
				end;
			end;		
		end;
	end;
	for v17, v18 in pairs(game.Players:GetChildren()) do
		task.spawn(function()
			v1(v18);
		end);
	end;
	game.Players.PlayerAdded:Connect(v1);
end;
