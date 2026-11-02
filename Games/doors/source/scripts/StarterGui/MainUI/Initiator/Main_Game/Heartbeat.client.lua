-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local v2 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v3 = game["Run Service"];
local l__UserInputService__4 = game:GetService("UserInputService");
local v5 = {};
local u1 = require(script.Parent);
local u2 = 0;
local u3 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local u4 = true;
local l__Heart__5 = script.Parent.Parent.Parent:WaitForChild("MainFrame"):WaitForChild("Heartbeat"):WaitForChild("Heart");
local l__TweenService__6 = game:GetService("TweenService");
local u7 = tick();
local u8 = false;
local u9 = tick();
local l__UserInputService__10 = game:GetService("UserInputService");
game:GetService("ReplicatedStorage").EntityInfo.ClutchHeartbeat.OnClientEvent:Connect(function(p1, p2)
	if u1.dead == true then
		return;
	end;
	if not p1 or type(p1) ~= "number" then
		p1 = 2;
	end;
	u2 = 0;
	local v6, v7 = u3();
	if u4 == true then
		u4 = false;
		u2 = 2.5;
		l__Heart__5.Parent.Visible = true;
		u1.ce.ToggleInventory:Fire(false);
		l__TweenService__6:Create(l__Heart__5.Parent, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, true), {
			BackgroundColor3 = Color3.fromRGB(26, 37, 66), 
			BackgroundTransparency = 0.2
		}):Play();
		local v8 = "TapIcon";
		if v7 == "mobile" then
			v8 = "TapIconMobile";
		end;
		if v7 ~= "console" then
			spawn(function()
				for v9 = 1, 1 do
					for v10, v11 in pairs(l__Heart__5.Parent:GetDescendants()) do
						if v11.Name == v8 then
							v11.Visible = true;
							delay(1, function()
								v11.Left.ImageTransparency = 0;
								l__TweenService__6:Create(v11.Left, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
									ImageTransparency = 1
								}):Play();
							end);
							delay(2, function()
								v11.Right.ImageTransparency = 0;
								l__TweenService__6:Create(v11.Right, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
									ImageTransparency = 1
								}):Play();
							end);
						elseif v11.Name == "HalfExampleLeft" then
							local v12 = v11:Clone();
							v12.Name = "DamnDaniel";
							v12.Parent = v11.Parent;
							game.Debris:AddItem(v12, 2);
							l__TweenService__6:Create(v12, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
								ImageTransparency = 0
							}):Play();
							l__TweenService__6:Create(v12, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
								Position = UDim2.new(0.5, 0, 0.5, 0)
							}):Play();
							delay(1, function()
								l__TweenService__6:Create(v12, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
									ImageTransparency = 1, 
									ImageColor3 = Color3.fromRGB(205, 227, 255), 
									Size = UDim2.new(1.5, 0, 1.5, 0)
								}):Play();
							end);
						elseif v11.Name == "HalfExampleRight" then
							local v13 = v11:Clone();
							v13.Name = "DamnDaniel";
							v13.Parent = v11.Parent;
							game.Debris:AddItem(v13, 3);
							delay(1, function()
								l__TweenService__6:Create(v13, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
									ImageTransparency = 0
								}):Play();
								l__TweenService__6:Create(v13, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
									Position = UDim2.new(0.5, 0, 0.5, 0)
								}):Play();
								delay(1, function()
									l__TweenService__6:Create(v13, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										ImageTransparency = 1, 
										ImageColor3 = Color3.fromRGB(205, 227, 255), 
										Size = UDim2.new(1.5, 0, 1.5, 0)
									}):Play();
								end);
							end);
						elseif (v11.Name == "ButtonTapLeft" or v11.Name == "ButtonTapRight") and v7 == "mobile" then
							v11.Visible = true;
							l__TweenService__6:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								BackgroundTransparency = 0.85
							}):Play();
							l__TweenService__6:Create(v11.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								Thickness = 5
							}):Play();
						end;
					end;
					wait(2);
				end;
				wait(2);
				for v14, v15 in pairs(l__Heart__5.Parent:GetDescendants()) do
					if v15.Name == v8 then
						v15.Visible = false;
					end;
				end;
			end);
		end;
		l__Heart__5.Engage:Play();
		if p1 >= 4 then
			p1 = p1 - 1;
			wait(1);
		end;
	end;
	coroutine.wrap(function()
		u7 = tick() + p1;
		if u8 == false then
			u8 = true;
			l__Heart__5.Position = UDim2.new(0.5, 0, 2, 0);
			l__Heart__5.Visible = true;
			l__Heart__5.Parent.TapIconConsole.Visible = u1.controller == "console";
			l__TweenService__6:Create(l__Heart__5, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, 0, 0.95, 0)
			}):Play();
			u1.camShaker:ShakeOnce(1, 2, 0.6, 10);
			u9 = tick();
		end;
		local v16 = true;
		local v17 = 1 - 1;
		while true do
			local v18 = math.random(1, 2);
			local v19 = l__Heart__5:WaitForChild("Half_Left");
			local v20 = "left";
			if v18 == 2 then
				v19 = l__Heart__5:WaitForChild("Half_Right");
				v20 = "right";
			end;
			local v21 = v19:Clone();
			v21.Name = "LiveHalf";
			v21.Visible = true;
			if v18 == 2 then
				v21.Position = v21.Position + UDim2.new(1.5 * p1, 0, 0, 0);
			else
				v21.Position = v21.Position - UDim2.new(1.5 * p1, 0, 0, 0);
			end;
			v21.Parent = l__Heart__5;
			l__TweenService__6:Create(v21, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				ImageTransparency = 0
			}):Play();
			l__TweenService__6:Create(v21, TweenInfo.new(p1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Position = UDim2.new(0.5, 0, 0.5, 0)
			}):Play();
			local v22 = tick() + p1;
			local u11 = false;
			local u12 = v16;
			local function u13()
				if u1.dead == true then
					l__TweenService__6:Create(l__Heart__5, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Position = UDim2.new(0.5, 0, 1.3, 0)
					}):Play();
				end;
				if u11 == false then
					u11 = true;
					u12 = false;
					l__Heart__5.Messup:Play();
					game:GetService("ReplicatedStorage").EntityInfo.ClutchHeartbeat:FireServer(p2, false);
					u1.camShaker:ShakeOnce(1, 55, 0, 0.8);
					u1.camShaker:ShakeOnce(7, 2, 1, 1);
					l__Heart__5.ActualHeart.ImageColor3 = Color3.fromRGB(165, 27, 27);
					l__TweenService__6:Create(l__Heart__5.ActualHeart, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						ImageColor3 = Color3.fromRGB(255, 231, 183)
					}):Play();
					l__TweenService__6:Create(v21, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 1, 
						ImageColor3 = Color3.fromRGB(165, 27, 27), 
						Size = UDim2.new(1.5, 0, 1.5, 0)
					}):Play();
					v21.Name = "Jeffery";
				end;
			end;
			task.delay(p1, function()
				local v23 = l__Heart__5.Hit:Clone();
				v23.Name = "LiveSound";
				v23.Parent = l__Heart__5;
				v23:Play();
				game.Debris:AddItem(v23, 3);
				l__Heart__5.ActualHeart.Size = UDim2.new(1.2, 8, 1.2, 8);
				l__TweenService__6:Create(l__Heart__5.ActualHeart, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Size = UDim2.new(1, 0, 1, 0)
				}):Play();
				u1.camShaker:ShakeOnce(1, 15, 0.03, 0.1);
				game.Debris:AddItem(v21, 1);
				task.wait(0.199);
				u13();
			end);
			local u14 = nil;
			local u15 = nil;
			local u16 = nil;
			local u17 = v17;
			local function u18(p3)
				local v24 = 99999;
				local v25 = nil;
				for v26, v27 in pairs(l__Heart__5:GetChildren()) do
					if v27.Name == "LiveHalf" then
						local v28 = math.abs(v27.AbsolutePosition.X - l__Heart__5.AbsolutePosition.X);
						if v28 < v24 then
							v24 = v28;
							v25 = v27;
						end;
					end;
				end;
				if v25 == v21 then
					if p3 == v20 and math.abs(tick() - v22) < 0.2 then
						pcall(function()
							u14:Disconnect();
							u15:Disconnect();
							u16:Disconnect();
						end);
						if u12 == true and u17 == 2 then
							game:GetService("ReplicatedStorage").EntityInfo.ClutchHeartbeat:FireServer(p2, true);
						end;
						if u1.dead == true then
							l__TweenService__6:Create(l__Heart__5, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								Position = UDim2.new(0.5, 0, 1.3, 0)
							}):Play();
						end;
						l__TweenService__6:Create(v21, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
							ImageTransparency = 1, 
							ImageColor3 = Color3.fromRGB(126, 245, 255), 
							Size = UDim2.new(1.5, 0, 1.5, 0)
						}):Play();
						u11 = true;
					else
						u13();
					end;
					v21.Name = "Jeffery";
				end;
			end;
			task.delay(u2, function()
				u14 = l__UserInputService__10.InputBegan:Connect(function(p4, p5)
					if u8 and (p4.UserInputType == Enum.UserInputType.MouseButton1 or p4.UserInputType == Enum.UserInputType.MouseButton2 or p4.KeyCode == Enum.KeyCode.ButtonL1 or p4.KeyCode == Enum.KeyCode.ButtonL2 or p4.KeyCode == Enum.KeyCode.ButtonR1 or p4.KeyCode == Enum.KeyCode.ButtonR2 or p4.KeyCode == Enum.KeyCode.Q or p4.KeyCode == Enum.KeyCode.E) then
						local v29 = "amongus";
						if p4.UserInputType == Enum.UserInputType.MouseButton1 or p4.KeyCode == Enum.KeyCode.ButtonL1 or p4.KeyCode == Enum.KeyCode.ButtonL2 or p4.KeyCode == Enum.KeyCode.Q then
							v29 = "left";
						elseif p4.UserInputType == Enum.UserInputType.MouseButton2 or p4.KeyCode == Enum.KeyCode.ButtonR1 or p4.KeyCode == Enum.KeyCode.ButtonR2 or p4.KeyCode == Enum.KeyCode.E then
							v29 = "right";
						end;
						u18(v29);
					end;
				end);
				u15 = l__Heart__5.Parent.ButtonTapLeft.MouseButton1Down:Connect(function()
					u18("left");
				end);
				u16 = l__Heart__5.Parent.ButtonTapRight.MouseButton1Down:Connect(function()
					u18("right");
				end);
			end);
			wait(0.25 + p1 / 20);
			if 0 <= 1 then
				if not (u17 < 2) then
					break;
				end;
			elseif not (u17 > 2) then
				break;
			end;
			u17 = u17 + 1;		
		end;
		delay(p1 + 2.5, function()
			if u7 == u7 then
				l__TweenService__6:Create(l__Heart__5, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Position = UDim2.new(0.5, 0, 2, 0)
				}):Play();
				for v30, v31 in pairs(l__Heart__5.Parent:GetDescendants()) do
					if v31.Name == "ButtonTapLeft" or v31.Name == "ButtonTapRight" then
						delay(1, function()
							v31.Visible = false;
						end);
						l__TweenService__6:Create(v31, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							BackgroundTransparency = 1
						}):Play();
						l__TweenService__6:Create(v31.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							Thickness = 0
						}):Play();
					end;
				end;
				u8 = false;
				l__Heart__5.Parent.TapIconConsole.Visible = false;
				wait(1);
				l__Heart__5.Parent.Visible = false;
				u1.ce.ToggleInventory:Fire(true);
				u4 = true;
			end;
		end);
	end)();
end);
