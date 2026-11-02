local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local v3 = require(script.Parent);
local l__UserInputService__4 = game:GetService("UserInputService");
local l__TweenService__5 = game:GetService("TweenService");
local l__TextService__6 = game:GetService("TextService");
local l__GuiService__7 = game:GetService("GuiService");
local l__Humanoid__8 = v3.char:WaitForChild("Humanoid");
local l__mouse__9 = l__LocalPlayer__2:GetMouse();
local v10 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
local v11 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("NumberConvert"));
local v12 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetProductPrice"));
local v13 = require(game:GetService("ReplicatedStorage"):WaitForChild("Products"));
local l__Healthbar__14 = v1.MainFrame.Healthbar;
l__Healthbar__14.Visible = true;
local MarketplaceService = game:GetService("MarketplaceService")
local v15 = 0;
v3.spectarget = nil;
v3.trackspec = true;
v3.dead = false;
script.Ringing:Play();
local rd = require(game.ReplicatedStorage.TextLabelScript)
local u1 = nil;
local u2 = "Blue";
game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("DeathHint").OnClientEvent:Connect(function(p1, p2)
	if p1 then
		u1 = p1;
		u2 = p2;
	end;
end);
local v16 = v1:WaitForChild("LobbyFrame"):WaitForChild("LoadingUI"):Clone();
v16.Parent = v1;
game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("Loading").OnClientEvent:Connect(function(p3)
	if not p3 then
		v16.Visible = true;
		l__TweenService__5:Create(v16, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			BackgroundTransparency = 1, 
			TextTransparency = 1
		}):Play();
		wait(1);
		v16.Visible = false;
		return;
	end;
	print("HELLO???");
	v16.Visible = true;
	l__TweenService__5:Create(v16, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
		BackgroundTransparency = 0, 
		TextTransparency = 0
	}):Play();
	wait(1);
	v16.Visible = true;
end);
game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("Statistics").OnClientEvent:Connect(function(p5)
	local plrs = game:GetService("Players")
	local plr = plrs.LocalPlayer

	local death = v1.Statistics.Death
	if game.Players.LocalPlayer.Stats.Death.Value == nil or game.Players.LocalPlayer.Stats.Death.Value == "" or game.Players.LocalPlayer.Stats.Death.Value == " " then
		death.Text = "You died to Unknown"
	else
		death.Text = "You died to "..game.Players.LocalPlayer.Stats.Death.Value
	end

	local KnobsToGive
	
	local l__DeathPanel__34 = v1.DeathPanel;
	local l__DeathPanelDead__35 = v1.DeathPanelDead;
	
	-- Friends Check
	
	for i, child in ipairs(game:GetService("Players"):GetChildren()) do
		if game:GetService("Players").LocalPlayer:IsFriendsWith(child.UserId) then
			v1.Statistics:SetAttribute("FriendsCount", v1.Statistics:GetAttribute("FriendsCount") + 1)
		end
	end
	
	-- Knobs set to give
	
	local function CoinSalary(v)
		local doorreached = v1.Statistics.RoomReached
		
		local KnobsForOpenedDoors = math.floor(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)--tonumber(rd:Format(game.Workspace.CurrentRooms.CurrentRoom.Value))
		local KnobsForGold = math.floor(plr.Stats.Gold.Value / 6)--tonumber(rd:Format(plr.Stats.Gold.Value / 6)) 
		local FriendBoost = 1
		
		if v == true then
			KnobsToGive = KnobsForGold
			v1.Statistics.Frame["Escaped Floor"].Visible = true
			v1.Statistics.ContinuingSpecial.Visible = true
			v1.Statistics.Death.Visible = false
			
			l__DeathPanel__34.Visible = true
			l__TweenService__5:Create(l__DeathPanel__34, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, 0, 0.87, 0)
			}):Play();
			l__TweenService__5:Create(l__DeathPanelDead__35, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, 0, 0.87, 0)
			}):Play();
		else
			KnobsToGive = KnobsForGold + KnobsForOpenedDoors
			if game.Players.LocalPlayer.InGameStats.FloorsEscaped.Value == true then
				v1.Statistics.Escaped.Visible = true
				v1.Statistics.Death.Visible = false
				v1.Statistics.Frame["Escaped Floor"].Visible = true
			end
		end
	
		
		if KnobsForGold ~= nil and KnobsForOpenedDoors ~= nil then
			v1.Statistics.RoomReached.Visible = true
			v1.Statistics.RoomReached.Text = "Opened "..KnobsForOpenedDoors.." Doors"
			v1.Statistics.Frame["Leftover Gold"].Visible = true
			v1.Statistics.Frame["Leftover Gold"].Text = "Leftover Gold ("..plr.Stats.Gold.Value..")"
			v1.Statistics.Frame["Leftover Gold"].Amount.Text = "+ "..KnobsForGold
			
			FriendBoost = v1.Statistics:GetAttribute("FriendsCount")
			v1.Statistics.Knobs.Text = KnobsToGive
			wait()
			
			if FriendBoost > 0 then
				v1.Statistics.Frame["Playing with Friends"].Visible = true
				v1.Statistics.Frame["Playing with Friends"].Text = "Playing with Friends ("..FriendBoost..")"
				if FriendBoost == 1 then
					v1.Statistics.Knobs.Multiplier.Text = "× 0.25 ="
					KnobsToGive = KnobsToGive * 1.25
					v1.Statistics.Frame["Playing with Friends"].Amount.Text = "+ 0.25%"
				elseif FriendBoost == 2 then
					v1.Statistics.Knobs.Multiplier.Text = "× 0.50 ="
					KnobsToGive = KnobsToGive * 1.5
					v1.Statistics.Frame["Playing with Friends"].Amount.Text = "+ 0.50%"
				elseif FriendBoost == 3 then
					v1.Statistics.Knobs.Multiplier.Text = "× 0.75 ="
					KnobsToGive = KnobsToGive * 1.75
					v1.Statistics.Frame["Playing with Friends"].Amount.Text = "+ 0.75%"
				end
			else
				v1.Statistics.Knobs.Multiplier.Text = "× 1.00 ="
				v1.Statistics.Frame["Playing with Friends"].Visible = true
				v1.Statistics.Frame["Playing with Friends"].Text = "Playing with Friends (0)"
				v1.Statistics.Frame["Playing with Friends"].Amount.Text = "+ 0%"
			end
		end

		wait()
		if v == true then
			v1.Statistics.Frame["Rooms Survived"].Visible = false
		end
		if v1.Statistics.Frame["Escaped Floor"].Visible == true then
			KnobsToGive = KnobsToGive + 50
		end
		wait()
		if game.Players.LocalPlayer.Stats.BoostState.Value == true then
			KnobsToGive = KnobsToGive * 5
		end
		wait()
		
		if l__LocalPlayer__2.PlayerStats.AdminPanel.Value == true and l__LocalPlayer__2.PlayerStats.TypeRun.Value ~= "HardHotel" then
			for i = 1, 1 do
				local Temple = v1.Statistics.Mods.Template:Clone()
				
				Temple.Parent = v1.Statistics.Mods
				Temple.Visible = true
				Temple.Text = "No Progress"

				local Temple1 = v1.Statistics.Mods.Template:Clone()

				Temple1.Parent = v1.Statistics.Mods
				Temple1.Visible = true
				Temple1.Text = "Rift Disabled"
			end
		end
		
		v1.Statistics.Knobs.Size = UDim2.new(0, l__TextService__6:GetTextSize(KnobsToGive, 45, "Oswald", Vector2.new(999, 999)).X, 0.1, 0)
		v1.Statistics.KnobsFinal.Text = rd:Format(KnobsToGive)
		game.ReplicatedStorage.ExplosionShake:FireServer(FriendBoost)
	end

	if p5 == "Secret" then
		CoinSalary(true)
		v3.spectarget = nil
		v3.dead = true;
		v1.MainFrame.Visible = false;
		v1.Statistics.CloseButton.Visible = false;
		v1.Statistics.PlayAgain.Visible = true;
		if v3.controller == "console" then
			delay(0.5, function()
				l__GuiService__7.SelectedObject = v1.Statistics.PlayAgain;
			end);
		end;
		for v27, v28 in pairs(v1.Statistics.PlayAgain.Players:GetChildren()) do
			if v28:IsA("ImageLabel") and v28.Visible then
				v28:Destroy();
			end;
		end;
		v1.Statistics.Visible = true;
		for v29, v30 in pairs(game.Players:GetChildren()) do
			local v31 = v1.Statistics.PlayAgain.Players.Template:Clone();
			v31.Name = v30.Name;
			v31.Image = game.Players:GetUserThumbnailAsync(v30.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
			v31.Visible = true;
			v31.Parent = v1.Statistics.PlayAgain.Players;
			task.spawn(function()
				for v32 = 1, 100000 do
					task.wait(0.2);
					if v31 and v31.Parent == v1.Statistics.PlayAgain.Players and v30 and v30.Parent == game.Players then
						v31.Ready.Visible = v30:GetAttribute("Ready") or false;
					else
						v31.Disconnected.Visible = true;
					end;
				end;
			end);
		end;
		game.ReplicatedStorage.EntityInfo.HuntEnd:FireServer()
		v1.Statistics.PlayAgain.MouseButton1Down:Connect(function()
			game.ReplicatedStorage.EntityInfo.PlayAgain:FireServer("Secret", "HuntExit");
		end);
		for v33 = 1, 2000 do
			wait(0.1);
			v1.Statistics.PlayAgain.Timer.Text = game.ReplicatedStorage.GameData.PlayAgainText.Value;
		end;
	elseif p5 == "Basic" then
		
		if l__DeathPanelDead__35.Visible == true then
			l__DeathPanel__34.Visible = false
		end
		
		l__DeathPanel__34.Visible = true
		CoinSalary(false)
		l__TweenService__5:Create(l__DeathPanel__34, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.87, 0)
		}):Play();
		l__TweenService__5:Create(l__DeathPanelDead__35, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.87, 0)
		}):Play();
	else
		
		if l__DeathPanelDead__35.Visible == true then
			l__DeathPanel__34.Visible = false
		end
		
		l__DeathPanel__34.Visible = true
		CoinSalary(false)
		l__TweenService__5:Create(l__DeathPanel__34, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.87, 0)
		}):Play();
		l__TweenService__5:Create(l__DeathPanelDead__35, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.87, 0)
		}):Play();
	end;
	v1.Statistics.Visible = true;
	v1.Statistics.CloseButton.MouseButton1Down:Connect(function()
		v1.Statistics.Visible = false;
		if v3.controller == "console" then
			if not v1.DeathPanel.Visible then
				l__GuiService__7.SelectedObject = nil;
				wait(0.5);
				l__GuiService__7.SelectedObject = v1.DeathPanelDead.PlayAgain;
				return;
			end;
		else
			return;
		end;
		l__GuiService__7.SelectedObject = v1.DeathPanel.Spectate;
	end);
end);
local u3 = function()
	print("I don't exist yet! :D");
end;
local u4 = 0;
local u5 = 0;
local u6 = nil;
local u7 = game["Run Service"];
function v3.spectate(p6, s)
	local l__DeathPanel__34 = v1.DeathPanel;
	local l__DeathPanelDead__35 = v1.DeathPanelDead;
	script.Parent.Parent.Parent.Parent.PermUI.Enabled = true
	wait()
	v1.Statistics.Visible = true;
	if p6 then
		v3.dead = true;
		v1.MainFrame.Visible = false;
	end;
	local u8 = false;
	local u9 = nil;
	u3 = function(p7)
		if not p7 then
			p7 = 1;
		end;
		local v36 = {};
		for v37, v38 in pairs(game.Players:GetChildren()) do
			if v38 and v38.Character and (v38.Character:FindFirstChild("Humanoid") and v38.Character.Humanoid.Health > 0.1) then
				table.insert(v36, v38);
			end;
		end;
		u4 = #v36;
		u5 = u5 + p7;
		if v36[u5] ~= nil then
			u6 = v36[u5];
			l__DeathPanel__34.Spectate.Text = u6.DisplayName;
		elseif v36[u5] == nil and #v36 >= 1 then
			u5 = 1;
			u6 = v36[u5];
			l__DeathPanel__34.Spectate.Text = u6.DisplayName;
		elseif l__DeathPanelDead__35.Visible ~= true then
			
			if v1.Statistics.PlayAgain.Visible == true then
				if v3.controller == "console" then
					delay(0.5, function()
						l__GuiService__7.SelectedObject = v1.Statistics.PlayAgain;
					end);
				end;
				return;
			end;
			u6 = nil;
			l__DeathPanel__34.Spectate.Text = "";
			l__DeathPanel__34.Visible = false;
			l__DeathPanelDead__35.Visible = true;
			if v3.controller == "console" then
				delay(0.5, function()
					if l__GuiService__7.SelectedObject == nil or l__GuiService__7.SelectedObject.Parent ~= v1.DeathPanelDead and l__GuiService__7.SelectedObject.Parent ~= v1.Statistics then
						l__GuiService__7.SelectedObject = v1.DeathPanelDead.PlayAgain;
					end;
				end);
			end;
			u8 = true;
			pcall(function()
				u9:Disconnect();
			end);
			for v39, v40 in pairs(l__DeathPanelDead__35.PlayAgain.Players:GetChildren()) do
				if v40:IsA("ImageLabel") and v40.Visible then
					v40:Destroy();
				end;
			end;
			local v41 = false;
			for v42, v43 in pairs(game.Players:GetChildren()) do
				local v44 = l__DeathPanelDead__35.PlayAgain.Players.Template:Clone();
				v44.Name = v43.Name;
				v44.Image = game.Players:GetUserThumbnailAsync(v43.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
				v44.Visible = true;
				v44.Parent = l__DeathPanelDead__35.PlayAgain.Players;
				local u10 = v41;
				task.spawn(function()
					for v45 = 1, 100000 do
						task.wait(0.2);
						if v44 and v44.Parent == l__DeathPanelDead__35.PlayAgain.Players and v43 and v43.Parent == game.Players then
							v44.Ready.Visible = v43:GetAttribute("Ready") or false;
							v44.Revived.Visible = v43:GetAttribute("Alive") or false;
						else
							v44.Disconnected.Visible = true;
						end;
						if v43:GetAttribute("Alive") and not u10 then
							u10 = true;
							l__DeathPanelDead__35.Spectate.Visible = true;
							l__DeathPanelDead__35.Leave.Visible = false;
						end;
					end;
				end);
			end;
			for v46 = 1, 2000 do
				wait(0.1);
				l__DeathPanelDead__35.PlayAgain.Timer.Text = game.ReplicatedStorage.GameData.PlayAgainText.Value;
			end;
		end;
		if u6 then
			pcall(function()
				v3.spectarget = u6.Character:FindFirstChild("HumanoidRootPart");
				if u6.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("SpecLight") == nil then
					local v47 = Instance.new("PointLight");
					v47.Color = Color3.fromRGB(120, 122, 138);
					v47.Range = 10;
					v47.Brightness = 0.55;
					v47.Shadows = false;
					v47.Name = "SpecLight";
					v47.Parent = u6.Character:FindFirstChild("HumanoidRootPart");
				end;
			end);
		else
			u6 = nil;
		end;
		v3.trackspec = true;
	end;
	
	if s then
		game.ReplicatedStorage.EntityInfo.SetStats:FireServer("Secret", game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
	elseif s == false then
		game.ReplicatedStorage.EntityInfo.SetStats:FireServer("Basic", game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
	else
		game.ReplicatedStorage.EntityInfo.SetStats:FireServer("Basic", game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer())
	end
	
	local u11 = false;
	l__DeathPanel__34.Spectate.MouseButton1Down:Connect(function()
		local v48 = 1;
		if l__mouse__9.X < v1.AbsoluteSize.X / 2 then
			v48 = -1;
		end;
		u3(v48);
	end);
	l__DeathPanel__34.Stats.MouseButton1Down:Connect(function()
		v1.Statistics.Visible = not v1.Statistics.Visible;
	end);
	l__DeathPanelDead__35.Stats.MouseButton1Down:Connect(function()
		v1.Statistics.Visible = not v1.Statistics.Visible;
	end);
	local function u12()
		if u11 == false then
			u11 = true;
			
			l__DeathPanelDead__35.Leave.UIStroke.Color = Color3.fromRGB(198, 255, 188)
			l__DeathPanelDead__35.Leave.ImageLabel.ImageColor3 = Color3.fromRGB(198, 255, 188)
			
			if math.random(1, 8000) == 5 then
				script.Leave:Play();
				v1.Drip.Visible = true;
				v1.Drip.ImageTransparency = 0;
				l__TweenService__5:Create(v1.Drip, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					ImageTransparency = 1
				}):Play();
			end;
			game.ReplicatedStorage.Bricks.ReturingToLobby:FireServer();
		end;
	end;
	l__DeathPanel__34.Leave.MouseButton1Down:Connect(function()
		u12();
	end);
	l__DeathPanelDead__35.Leave.MouseButton1Down:Connect(function()
		u12();
	end);
	l__DeathPanelDead__35.PlayAgain.MouseButton1Down:Connect(function()
		game.ReplicatedStorage.EntityInfo.PlayAgain:FireServer();
	end);
	l__DeathPanelDead__35.Spectate.MouseButton1Down:Connect(function()
		for v49, v50 in pairs(game.Players:GetChildren()) do
			if v50:GetAttribute("Alive") then
				u6 = nil;
				l__DeathPanel__34.Visible = true;
				l__DeathPanelDead__35.Visible = false;
				l__DeathPanelDead__35.Spectate.Visible = false;
				l__DeathPanelDead__35.PlayAgain.Visible = false;
				u8 = false;
				u9 = u7.Heartbeat:Connect(function()
					if u6 and u6:IsA("Player") and u6.Character and u6.Character:FindFirstChild("Humanoid") and u6.Character:FindFirstChild("Humanoid").Health > 0.01 and u6.Character:FindFirstChild("Humanoid"):GetAttribute("Stunned") ~= true then
						return;
					end;
					v3.trackspec = false;
					wait(1);
					if u6 == u6 then
						u3();
					end;
				end);
				return;
			end;
		end;
	end);
	v1.LeaveFull.MouseButton1Down:Connect(function()
		u12();
	end);
	u3();
	u9 = u7.Heartbeat:Connect(function()
		if u6 and u6:IsA("Player") and u6.Character and u6.Character:FindFirstChild("Humanoid") and u6.Character:FindFirstChild("Humanoid").Health > 0.01 and u6.Character:FindFirstChild("Humanoid"):GetAttribute("Stunned") ~= true then
			return;
		end;
		v3.trackspec = false;
		wait(1);
		if u6 == u6 then
			u3();
		end;
	end);
end;
local u13 = l__Humanoid__8.Health;
local u14 = false;
local u15 = false;
l__Humanoid__8.HealthChanged:connect(function(p8)
	if v3.dead then
		return;
	end;
	if p8 < u13 then
		local v51 = u13 - p8;
		local v52 = 1 + v51 / 10 + (l__Humanoid__8.MaxHealth - l__Humanoid__8.Health) / l__Humanoid__8.MaxHealth * 5;
		v3.spring:Impulse(Vector3.new(math.random(-v51, v51) * 2, v51 * 3, math.random(-v51, v51) * 2));
		local v53 = v1.MainFrame.DamageVignette:Clone();
		v53.Name = "lvignette";
		v53.Visible = true;
		v53.ImageTransparency = 1 - v51 / 30;
		v53.Parent = v1;
		v53:TweenSize(UDim2.new(1, 1000, 1, 1000), "In", "Quart", v51 / 50);
		game.Debris:AddItem(v53, v51 / 40);
		if v1:FindFirstChild("LongVignette") then
			v1:FindFirstChild("LongVignette"):Destroy();
		end;
		local v54 = v1.MainFrame.DamageVignette:Clone();
		v54.Name = "LongVignette";
		v54.Visible = true;
		v54.ImageTransparency = math.clamp(1 - v51 / 50 - v52 / 10, 0.5, 1);
		v54.Parent = v1;
		v54:TweenSize(UDim2.new(1, 1000, 1, 1000), "In", "Quart", v52 + 0.5);
		game.Debris:AddItem(v54, v52 + 0.5);
		script.Hit.Pitch = 2 - v51 / 100;
		script.Hit:Play();
		script.Ringing.Volume = math.clamp(script.Ringing.Volume / 2 + v51 / 50 + (l__Humanoid__8.MaxHealth - l__Humanoid__8.Health) / l__Humanoid__8.MaxHealth / 2, 0.1, 0.3);
		l__TweenService__5:Create(script.Ringing, TweenInfo.new(v52, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Volume = 0
		}):Play();
		v1.Event_Stress:Fire(math.clamp(v51 * 5, 10, 100));
	end;
	u13 = p8;
	if l__Humanoid__8.MaxHealth <= p8 then
		l__Healthbar__14.Visible = true
		l__Healthbar__14.Bar.Visible = false;
		l__Healthbar__14.Effects.Position = UDim2.new(0.08, 0, 0.5, 0);
		l__Healthbar__14.Effects.Size = UDim2.new(0.8, 0, 1.2, 0);
	else
		l__Healthbar__14.Visible = true
		l__Healthbar__14.Bar.Visible = true;
		l__Healthbar__14.Effects.Position = UDim2.new(0.08, 0, -0.4, 0);
		l__Healthbar__14.Effects.Size = UDim2.new(0.8, 0, 0.8, 0);
		l__Healthbar__14.Bar.Bar:TweenSize(UDim2.new(l__Humanoid__8.Health / l__Humanoid__8.MaxHealth, 0, 1, 0), "Out", "Quart", 0.4, true);
		l__Healthbar__14.Bar.HurtBar:TweenSize(UDim2.new(l__Humanoid__8.Health / l__Humanoid__8.MaxHealth, 0, 1, 0), "In", "Quart", 1, true);
	end;
	if p8 <= 0.001 and v3.dead == false and u14 == false then
		script.Kill:Play()
		script.Ringing:Stop();
		u14 = true;
		wait(0.2);
		v3.update();
		l__UserInputService__4.InputBegan:Connect(function(p9, p10)
			if p9.UserInputType == Enum.UserInputType.MouseButton1 or p9.UserInputType == Enum.UserInputType.Touch then
				if p10 then
					return;
				else
					u15 = true;
					return;
				end;
			end;
			if p9.KeyCode == Enum.KeyCode.ButtonB or p9.KeyCode == Enum.KeyCode.ButtonA or p9.KeyCode == Enum.KeyCode.ButtonX then
				u15 = true;
				return;
			end;
			if p9.KeyCode == Enum.KeyCode.ButtonL1 or p9.KeyCode == Enum.KeyCode.Q then
				u3(-1);
				return;
			end;
			if p9.KeyCode == Enum.KeyCode.ButtonR2 or p9.KeyCode == Enum.KeyCode.E then
				u3(1);
			end;
		end);
		local v55 = 120;
		for v56 = 1, math.huge do
			u7.Heartbeat:wait();
			if v3.deathtick <= tick() then
				v3.update();
				local l__Revive__57 = v1.HodlerRevive.Revive;
				v1.HodlerRevive.Visible = true;
				if v10 and v10.data then
					local u16 = game.ReplicatedStorage.EntityInfo.CheckRevive:InvokeServer();
					local u17 = v55;
					local l__ReviveEmpty__18 = v1.HodlerRevive.ReviveEmpty;
					local function v58()
						if game.Players.LocalPlayer.PlayerStats.Revives.Value > 0 then
							local l__Revives__59 = game.Players.LocalPlayer.PlayerStats.Revives.Value;
							l__Revive__57.AmountLabel.Text = "x" .. tostring(l__Revives__59);
							if l__Revives__59 == 0 then
								l__Revive__57.AmountLabel.Visible = false;
							else
								l__Revive__57.AmountLabel.Visible = true;
							end;
						end
						l__Revive__57.RobuxLabel.Text = 20;
						l__Revive__57.RobuxLabel.Visible = not l__Revive__57.AmountLabel.Visible;
						if not (not u16) or u17 <= 0 or l__LocalPlayer__2:GetAttribute("CantRevive") then
							l__Revive__57.Visible = false;
						else
							l__Revive__57.Visible = true;
						end;
						l__ReviveEmpty__18.Visible = not l__Revive__57.Visible;
						if game.Workspace.CurrentRooms.CurrentRoom.Value >= 90 then
							l__ReviveEmpty__18.ReasonLabel.Text = "You cannot revive past this point.";
						end;
						if game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("TimerOver").Value then
							l__ReviveEmpty__18.ReasonLabel.Text = "Floor timer is over";
						end;
						if game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("SecretFloor").Value then
							l__ReviveEmpty__18.ReasonLabel.Text = "You cannot revive here.";
						end;
						if u17 <= 0 then
							l__ReviveEmpty__18.ReasonLabel.Text = "Your time to revive ran out.";
						end;
						if l__LocalPlayer__2:GetAttribute("CantRevive") then
							l__ReviveEmpty__18.ReasonLabel.Text = "You can only revive in a run once.";
						end;
					end;
					v58();
					v10.event.Revives.Event:Connect(v58);
					
					l__Revive__57.MouseButton1Down:Connect(function()
						
						if game.Players.LocalPlayer.PlayerStats.Revives.Value > 0 then
							game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo").Revive:FireServer(game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer());
						else
							if not game.ReplicatedStorage.EntityInfo.CheckRevive:InvokeServer() and u17 > 0 then
								MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, 1792229995)
							end;
						end
					end);
					MarketplaceService.PromptProductPurchaseFinished:Connect(function(playerd, assetID, isPurchased)
						local player = game.Players:GetPlayerByUserId(playerd)
						if isPurchased then 
							if assetID == 1792229995 then
								game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo").Revive:FireServer(game.ReplicatedStorage.EntityInfo.GetLimbs:InvokeServer());
							end
						end
					end)
					spawn(function()
						local v60 = tick();
						local v61 = tick();
						for v62 = 1, 1200000000000 do
							task.wait();
							local v63 = tick() - v60;
							if v61 + 1 <= tick() then
								v61 = tick();
								v60 = tick();
								u16 = game.ReplicatedStorage.EntityInfo.CheckRevive:InvokeServer();
								if not u16 then
									u17 = u17 - v63;
								end;
								l__Revive__57.TimerLabel.Text = math.ceil(u17);
								v58();
								if u17 <= 0 then
									break;
								end;
							end;
						end;
					end);
				end;
				l__TweenService__5:Create(game.SoundService.Main, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Volume = 0
				}):Play();
				v3.freemouse = true
				script.Parent.Parent.Parent.MainFrame.Hotbar.Visible = false
				script.Parent.Parent.Parent.MainFrame.Healthbar.Visible = false
				script.Parent.Parent.Parent.MainFrame.Crosshair.Visible = false
				script.Death:Play();
				v1.MainFrame.Heartbeat.Visible = false;
				script.Parent.Heartbeat.Disabled = true;
				local l__Death__19 = v1.Death;
				spawn(function()
					local v64 = tick();
					for v65 = 1, math.huge do
						local v66 = math.clamp(v64 + 1.5 - tick(), 0, 1.5);
						local v67 = math.clamp(v64 + 3 - tick(), 0, 3);
						l__Death__19.Static.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0);
						l__Death__19.Hodler.Position = UDim2.new(0.5 + math.random(-10, 10) / 500 * v66, 0, 0.5 + math.random(-10, 10) / 400 * v66, 0);
						l__Death__19.Hodler.Rotation = math.random(-v66 * 6, v66 * 6);
						l__Revive__57.Position = UDim2.new(0.5 + math.random(-10, 10) / 200 * v67, 0, 0.5 + math.random(-10, 10) / 140 * v67, 0);
						l__Revive__57.Rotation = math.random(-v67 * 4, v67 * 4);
						u7.Heartbeat:wait();
						if v64 + 3 <= tick() then
							if u1 == nil then
								break;
							end;
							if u1 == {} then
								break;
							end;
						end;
					end;
				end);
				l__Death__19.Visible = true;
				l__TweenService__5:Create(l__Death__19, TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.In), {
					ImageTransparency = 0
				}):Play();
				l__Death__19.Hodler.Label.Visible = true;
				l__TweenService__5:Create(l__Death__19.Hodler.Label, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					ImageTransparency = 0, 
					Size = UDim2.new(0.5, 0, 0.5, 0), 
					Position = UDim2.new(0.5, 0, 0.5, 0)
				}):Play();
				v3.dead = true;
				wait(0.5);
				pcall(function()
					v1.MainFrame.Visible = false;
					v1.Jumpscare.Visible = false;
				end);
				l__TweenService__5:Create(l__Death__19, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					ImageTransparency = 0, 
					ImageColor3 = Color3.fromRGB(0, 0, 0)
				}):Play();
				l__TweenService__5:Create(l__Death__19.Hodler.Label, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Size = UDim2.new(0.525, 0, 0.525, 0)
				}):Play();

				if u1 ~= nil then
					local v68 = nil
					if script.Music:FindFirstChild(u2) then
					    v68 = script.Music:FindFirstChild(u2);
					elseif not script.Music:FindFirstChild(u2) then
						v68 = script.Music.Yellow
					end
					local l__End__69 = v68.End;
					v68:Play();
					local v70 = { Color3.fromRGB(19, 48, 57), Color3.fromRGB(55, 235, 255), Color3.fromRGB(42, 151, 175), Color3.fromRGB(4, 16, 30), Color3.fromRGB(201, 237, 255), Color3.fromRGB(124, 209, 255), Color3.fromRGB(0, 141, 206), Color3.fromRGB(158, 239, 255) };
					if u2 == "Yellow" then
						v70 = { Color3.fromRGB(57, 42, 17), Color3.fromRGB(255, 242, 53), Color3.fromRGB(175, 142, 44), Color3.fromRGB(30, 17, 4), Color3.fromRGB(255, 253, 174), Color3.fromRGB(255, 239, 117), Color3.fromRGB(206, 155, 0), Color3.fromRGB(255, 243, 152) };
					end;
					if u2 == "Red" then
						v70 = { Color3.fromRGB(57, 19, 19), Color3.fromRGB(255, 52, 52), Color3.fromRGB(175, 48, 48), Color3.fromRGB(30, 4, 4), Color3.fromRGB(255, 174, 174), Color3.fromRGB(255, 119, 119), Color3.fromRGB(206, 0, 0), Color3.fromRGB(255, 155, 155) };	
					end;
					if u2 == "Green" then
						v70 = { Color3.fromRGB(16, 57, 16), Color3.fromRGB(52, 255, 52), Color3.fromRGB(48, 175, 48), Color3.fromRGB(4, 30, 4), Color3.fromRGB(174, 255, 174), Color3.fromRGB(119, 255, 119), Color3.fromRGB(0, 206, 0), Color3.fromRGB(155, 255, 155) };	
					end
					if u2 == "Green" then
						v70 = { Color3.fromRGB(16, 57, 16), Color3.fromRGB(52, 255, 52), Color3.fromRGB(48, 175, 48), Color3.fromRGB(4, 30, 4), Color3.fromRGB(174, 255, 174), Color3.fromRGB(119, 255, 119), Color3.fromRGB(0, 206, 0), Color3.fromRGB(155, 255, 155) };	
					end
					if u2 == "Orange" then
						v70 = { Color3.fromRGB(57, 37, 17), Color3.fromRGB(255, 154, 52), Color3.fromRGB(175, 112, 48), Color3.fromRGB(30, 17, 4), Color3.fromRGB(255, 215, 174), Color3.fromRGB(255, 187, 119), Color3.fromRGB(206, 103, 0), Color3.fromRGB(255, 205, 155) };	
					end
					if u2 == "Purple" then
						v70 = { Color3.fromRGB(57, 17, 54), Color3.fromRGB(255, 52, 238), Color3.fromRGB(175, 48, 164), Color3.fromRGB(30, 4, 28), Color3.fromRGB(255, 174, 248), Color3.fromRGB(255, 119, 244), Color3.fromRGB(206, 0, 189), Color3.fromRGB(255, 155, 247) };	
					end
					if u2 == "Grey" then
						v70 = { Color3.fromRGB(57, 57, 57), Color3.fromRGB(255, 255, 255), Color3.fromRGB(175, 175, 175), Color3.fromRGB(30, 30, 30), Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255), Color3.fromRGB(206, 206, 206), Color3.fromRGB(255, 255, 255) };		
					end
					l__Death__19.HelpfulDialogue.TextColor3 = v70[8];
					l__TweenService__5:Create(l__Death__19.Static, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						BackgroundColor3 = v70[1], 
						BackgroundTransparency = 0
					}):Play();
					l__TweenService__5:Create(l__Death__19.Static, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						ImageTransparency = 0.8, 
						ImageColor3 = v70[2]
					}):Play();
					l__TweenService__5:Create(l__Death__19.Static.Static, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						ImageTransparency = 0.8, 
						ImageColor3 = v70[3]
					}):Play();
					l__TweenService__5:Create(l__Death__19, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						ImageTransparency = 0, 
						ImageColor3 = v70[4]
					}):Play();
					l__TweenService__5:Create(l__Death__19.Hodler.Label, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						ImageTransparency = 1, 
						ImageColor3 = v70[5]
					}):Play();
					l__TweenService__5:Create(l__Death__19.Hodler.Label.Label, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
						ImageTransparency = 0, 
						ImageColor3 = v70[6]
					}):Play();
					wait(1);
					l__TweenService__5:Create(l__Death__19.Hodler.Label.Label, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
						ImageTransparency = 1, 
						ImageColor3 = v70[7]
					}):Play();
					wait(0.5);
					l__TweenService__5:Create(l__Death__19.Hodler.Label, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
						Size = UDim2.new(3, 0, 3, 0)
						--Position = UDim2.new(0.7, 0, 0.5, 0),
						--Size = UDim2.new(9, 0, 9, 0)
					}):Play();
					l__Death__19.HelpfulDialogue.TextTransparency = 1;
					l__Death__19.HelpfulDialogue.Visible = true;
					local v71 = v3.camShakerModule.new(200, function(p11)
						local l__Position__72 = p11.Position;
						l__Death__19.HelpfulDialogue.Position = UDim2.new(0.5 + l__Position__72.X / 10, 0, 0.5 + l__Position__72.Y / 10, 0);
						l__Death__19.HelpfulDialogue.Rotation = l__Position__72.X * 5;
					end);
					v71:Start();
					v71:StartShake(0.1, 0.5, 1, Vector3.new(1, 1, 1));
					v71:StartShake(0.5, 0.25, 1, Vector3.new(1, 1, 1));
					v71:StartShake(1, 0.05, 1, Vector3.new(1, 1, 1));
					u15 = false;
					wait(1);
					for v73 = 1, #u1 do
						l__Death__19.HelpfulDialogue.Text = u1[v73];
						if u15 then
							l__Death__19.HelpfulDialogue.TextTransparency = 0;
						else
							l__TweenService__5:Create(l__Death__19.HelpfulDialogue, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
								TextTransparency = 0
							}):Play();
						end;
						local v74 = tick();
						local v75 = tick() + 5 + utf8.len(l__Death__19.HelpfulDialogue.ContentText) / 30;
						if v73 == 1 or not u15 then
							wait(0.5);
						else
							wait(0.1);
						end;
						u15 = false;
						for v76 = 1, 10000000000000 do
							task.wait();
							if v75 <= tick() then
								break;
							end;
							if u15 then
								break;
							end;
						end;
						local v77 = 0.4;
						if u15 then
							v77 = 0.25;
						end;
						l__TweenService__5:Create(l__Death__19.HelpfulDialogue, TweenInfo.new(v77, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
							TextTransparency = 1
						}):Play();
						wait(v77 + 0.01);
					end;
					l__TweenService__5:Create(v68, TweenInfo.new(8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Volume = 0
					}):Play();
					l__TweenService__5:Create(l__End__69, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Volume = 1
					}):Play();
					l__End__69:Play();
					l__End__69.TimePosition = 55;
					delay(1, function()
					--	v68:Stop();
					end);
				else
					wait(2);
				end;
				l__TweenService__5:Create(v1.HodlerRevive, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Position = UDim2.new(0.5, 0, 0.17, 0)
				}):Play();
				l__TweenService__5:Create(l__Death__19.Static, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					ImageTransparency = 1, 
					ImageColor3 = Color3.fromRGB(226, 42, 67), 
					BackgroundTransparency = 1
				}):Play();
				l__TweenService__5:Create(l__Death__19, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					ImageTransparency = 1, 
					ImageColor3 = Color3.fromRGB(89, 0, 1)
				}):Play();
				l__TweenService__5:Create(l__Death__19.Static.Static, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					ImageTransparency = 1, 
					ImageColor3 = Color3.fromRGB(255, 0, 4)
				}):Play();
				l__TweenService__5:Create(game.SoundService.Main, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					Volume = 1
				}):Play();
				l__TweenService__5:Create(l__Death__19.Hodler.Label, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					ImageTransparency = 1, 
					ImageColor3 = Color3.fromRGB(218, 121, 126), 
					Size = UDim2.new(0.6, 0, 0.6, 0)
				}):Play();
				l__TweenService__5:Create(l__Death__19.Hodler.Label.Label, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					ImageTransparency = 1, 
					ImageColor3 = Color3.fromRGB(97, 0, 1)
				}):Play();
				wait(1);
				v3.spectate();
				break;
			end;
		end;
	end;
end);
for v78, v79 in pairs({ "HerbGreenEffect" }) do
	local u20 = v15;
	local function v80()
		local v81 = l__Humanoid__8:GetAttribute(v79);
		if type(v81) == "number" then
			l__Healthbar__14.Visible = true
			l__Healthbar__14.Effects[v79].Visible = v81 > 0;
		else
			l__Healthbar__14.Visible = true
			l__Healthbar__14.Effects[v79].Visible = v81 or false;
		end;
		u20 = 0;
		for v82, v83 in pairs(l__Healthbar__14.Effects:GetChildren()) do
			if v83:IsA("ImageLabel") and v83.Visible then
				u20 = u20 + 1;
				l__Healthbar__14.Visible = true;
			end;
		end;
		if script.EffectModules:FindFirstChild(v79) then
			local u21 = require(script.EffectModules:FindFirstChild(v79));
			task.spawn(function()
				u21();
			end);
		end;
	end;
	if l__Humanoid__8:GetAttribute(v79) then
		v80();
	end;
	l__Humanoid__8:GetAttributeChangedSignal(v79):Connect(function()
		v80();
	end);
end;
local l__Shield__85 = l__Humanoid__8:WaitForChild("Shield", 3);
if l__Shield__85 then
	local u22 = l__Shield__85.Value;
	l__Shield__85.Changed:Connect(function()
		local l__Value__86 = l__Shield__85.Value;
		if l__Shield__85.Value > 0 then
			l__Healthbar__14.Visible = true
			l__Healthbar__14.Bar.Visible = true;
			l__Healthbar__14.Effects.Position = UDim2.new(0.08, 0, -0.4, 0);
			l__Healthbar__14.Effects.Size = UDim2.new(0.8, 0, 0.8, 0);
			l__Healthbar__14.ShieldBar.Visible = true;
		end;
		l__Healthbar__14.ShieldBar.Bar:TweenSize(UDim2.new(l__Value__86 / 100, 0, 1, 0), "Out", "Quart", 0.4, true);
		l__Healthbar__14.ShieldBar.HurtBar:TweenSize(UDim2.new(l__Value__86 / 100, 0, 1, 0), "In", "Quart", 1, true);
		if l__Value__86 < u22 then
			local v87 = v1.MainFrame.DamageVignette:Clone();
			v87.ImageColor3 = Color3.fromRGB(146, 195, 255);
			v87.Name = "lvignette";
			v87.Visible = true;
			v87.ImageTransparency = 0.5;
			v87.Parent = v1;
			v87:TweenSize(UDim2.new(1, 1000, 1, 1000), "In", "Quart", 0.25);
			game.Debris:AddItem(v87, 0.3);
			script.HitShield:Play();
		end;
		u22 = l__Value__86;
	end);
end;

while true do
	wait(1)
	
	local l__DeathPanel__34 = v1.DeathPanel;
	local l__DeathPanelDead__35 = v1.DeathPanelDead;
	if l__DeathPanelDead__35.Visible == true then
		l__DeathPanel__34.Visible = false
	end
end