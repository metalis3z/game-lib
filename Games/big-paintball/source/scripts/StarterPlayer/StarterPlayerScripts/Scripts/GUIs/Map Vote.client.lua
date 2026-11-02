-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local l____VARIABLES__2 = game.Workspace:WaitForChild("__VARIABLES");
local l__RoundType__3 = l____VARIABLES__2:WaitForChild("RoundType");
local v4 = v1.Player.Get("Camera");
local u1 = Random.new();
function getNeonColor()
	local v5 = Color3.fromHSV(u1:NextNumber(), 1, 1);
	return v5.r, v5.g, v5.b;
end;
local l__MapVote__2 = v1.GUI.MapVote;
local u3 = v1.Player.Get();
local l__Top__4 = v1.GUI.Top;
local l__Menu__5 = v1.GUI.Menu;
local u6 = v1.Network.Invoke("update map vote");
local function u7()
	local v6 = {
		mapName = "", 
		position = { u1:NextNumber(), u1:NextNumber() }
	};
	if v1.Variables.MessageOpen then
		while true do
			v1.Heartbeat();
			if not v1.Variables.MessageOpen then
				break;
			end;		
		end;
		if not l__MapVote__2.Gui.Enabled then
			return;
		end;
	end;
	for v7, v8 in pairs(l__MapVote__2.Maps:GetChildren()) do
		if v8:IsA("ImageButton") and v8:FindFirstChild("Avatars") then
			v8:Destroy();
		end;
	end;
	v1.GUI.SpawnGlow.Gui.Enabled = false;
	v1.GUIFX.BubbleScale(l__MapVote__2.Main);
	v1.InfoOverlay.Remove();
	local u8 = {};
	local function u9(p1, p2)
		local v9, v10 = pcall(function()
			local v11 = p1 == u3;
			if not v11 then
				v1.Audio.Play(5732358733, script, u1:NextInteger(95, 105) / 100, 0.1);
			end;
			for v12, v13 in pairs(l__MapVote__2.Maps:GetChildren()) do
				if v13:IsA("ImageButton") and v13:FindFirstChild("Avatars") then
					for v14, v15 in pairs(v13.Avatars:GetChildren()) do
						local v16
						if v15.ClassName == "ImageLabel" then
							if v11 then
								local v16 = "Me";
							else
								v16 = p1.Name;
							end;
							if v15.Name == v16 then
								v15:Destroy();
							end;
						end;
					end;
				end;
			end;
			local v17 = script.Avatar:Clone();
			local v18
			if v11 then
				local v18 = "Me";
			else
				v18 = p1.Name;
			end;
			v17.Name = v18;
			v17.Position = UDim2.new(p2.position[1], 0, p2.position[2], 0);
			local v19
			if v11 then
				local v19 = 2;
			else
				v19 = 0;
			end;
			v17.ZIndex = v17.ZIndex + v19;
			if v11 then
				v17.back.BackgroundColor3 = Color3.fromRGB(62, 255, 139);
			end;
			coroutine.wrap(function()
				if v1.VipCmds.IsVip(p1) then
					v17.VIP.Visible = true;
				end;
			end)();
			v17.Size = UDim2.new(0.45, 0, 0.8, 0);
			v1.Functions.FastTween(v17, {
				Size = UDim2.new(0.3, 0, 0.5, 0)
			}, { 0.25, "Quad", "Out" }).Completed:Connect(function()
				v17.Size = UDim2.new(0.3, 0, 0.5, 0);
			end);
			v17.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. p1.userId .. "&width=100&height=100&format=png";
			v17.Parent = l__MapVote__2.Maps[p2.mapName].Avatars;
		end);
		if not v9 then
			v1.Print(string.format("Failed to update vote for player '%s'", p1.Name), true);
		end;
	end;
	u8.updatePlayerVote = v1.Network.Fired("update player vote"):Connect(function(p3, p4)
		if p3 == u3 then
			return;
		end;
		u9(p3, p4);
	end);
	for v20, v21 in pairs(game.Players:GetPlayers()) do
		local v22 = v1.Entity.Get(v21);
		if v22.CurrentVote and v21 ~= u3 then
			u9(v21, v22.CurrentVote);
		end;
	end;
	l__Top__4.Gui.Enabled = false;
	l__MapVote__2.TimeLeft.Bar.Size = UDim2.new(0, 0, 1, 0);
	coroutine.wrap(function()
		local v23 = 0;
		while v1.Shared.getRoundType() == "Voting" do
			l__Menu__5.Gui.Enabled = false;
			v1.GUI.Challenges.Gui.Enabled = false;
			l__MapVote__2.Gui.Enabled = true;
			local v24 = u6 - l____VARIABLES__2:WaitForChild("SecondsRemaining").Value;
			local v25 = math.clamp(v24 / u6, 0, 1);
			if v24 ~= v23 then
				v23 = v24;
				v1.Functions.FastTween(l__MapVote__2.TimeLeft.Bar, {
					Size = UDim2.new(v25, 0, 1, 0)
				}, { 1, "Linear", "Out" });
			end;
			v1.Heartbeat();		
		end;
		v1.Functions.FastTween(l__MapVote__2.TimeLeft.Bar, {
			Size = UDim2.new(1, 0, 1, 0)
		}, { 0.35, "Quad", "Out" });
		if not u3:FindFirstChild("__SPAWNED") then

		end;
		l__Menu__5.Gui.Enabled = true;
		l__MapVote__2.Gui.Enabled = false;
	end)();
	local v26, v27 = v1.Network.Invoke("get vote maps");
	for v28, v29 in pairs(v26) do
		local l__Type__33 = v1.Directory.Maps[v28].Type;
		local v34 = script:FindFirstChild("Map"):Clone();
		v34.Image = v29.ImageId;
		v34.Title.Text = v29.Display;
		v34.Title.shadow.Text = v34.Title.Text;
		v34.Name = v28;
		local v35 = v27 == v28;
		v34.PreviousMap.Visible = v35;
		local v36
		if v35 then
			local v36 = 0;
		else
			v36 = 1;
		end;
		v34.LayoutOrder = v36;
		if l__Type__33 == "FFA" then
			v34.Gamemode.Text = "FFA";
			v34.GamemodeIcon.Image = "rbxassetid://5694615393";
		elseif l__Type__33 == "TDM" then
			v34.Gamemode.Text = "TDM";
			v34.GamemodeIcon.Image = "rbxassetid://5694615468";
		elseif l__Type__33 == "KOTH" then
			v34.Gamemode.Text = "KOTH";
			v34.GamemodeIcon.Image = "rbxassetid://7596166308";
		end;
		v34.Parent = l__MapVote__2.Maps;
		v34.MouseButton1Click:Connect(function()
			v1.Audio.Play(v1.Settings.MouseDownSound, script);
			v1.Audio.Play(5732358733, script);
			if v28 == v6.mapName then
				return;
			end;
			if not v1.Directory.Maps[v28] then
				return;
			end;
			v6.mapName = v28;
			v6.position = { u1:NextNumber(), u1:NextNumber() };
			for v37, v38 in ipairs(l__MapVote__2.Maps:GetChildren()) do
				if v38:FindFirstChild("SelectedGradient") then
					local v40 = v38.Name == v28;
					local v41 = v40 and Color3.new(0, 0, 0) or Color3.new(1, 1, 1);
					v38.SelectedGradient.Enabled = not v40;
					v38.Gamemode.TextColor3 = v41;
					v38.GamemodeIcon.ImageColor3 = v41;
					v38.Title.TextColor3 = v40 and Color3.fromRGB(62, 255, 139) or Color3.new(1, 1, 1);
				end;			
			end;
			v1.Network.Fire("Finish Map Vote", v6);
			u9(u3, v6);
		end);
		if v1.Variables.Console then
			coroutine.wrap(function()
				wait(0.5);
				v1.GuiService.SelectedObject = v34;
			end)();
		end;	
	end;
end;
local u10 = true;
l__RoundType__3:GetPropertyChangedSignal("Value"):Connect(function()
	if l__RoundType__3.Value == "Voting" then
		u7();
		if u10 then
			u10 = false;
		end;
	end;
end);
if l__RoundType__3.Value == "Voting" then
	u10 = false;
	u7();
end;
