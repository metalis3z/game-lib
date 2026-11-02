local v1 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v2 = game["Run Service"];
local l__UserInputService__3 = game:GetService("UserInputService");
local l__ProximityPromptService__4 = game:GetService("ProximityPromptService");
local l__TextService__5 = game:GetService("TextService");
local v6 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local v7 = script:FindFirstAncestor("MainUI");
local v8 = require(script:WaitForChild("Hint"));
local u1 = require(script.Parent);
local u2 = v7:WaitForChild("MainFrame"):WaitForChild("PromptFrame");
local l__PromptFrame__3 = v7:WaitForChild("MainFrame"):WaitForChild("PromptFrame");
local u4 = require(script:WaitForChild("MouseIcons"));
local u5 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("ButtonIcons"));
local l__InteractButton__6 = v7.MainFrame:WaitForChild("MobileButtons"):WaitForChild("InteractButton");
local u7 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("NumberConvert"));
local l__TweenService__8 = game:GetService("TweenService");
local u9 = nil;
local u10 = tick();
local l__Highlight__11 = script:WaitForChild("Highlight");
local u12 = Vector3.new(0, 0, 0);
local u13 = nil;
function update(p1, p2)
	task.spawn(function()
		v7.MainFrame:WaitForChild("MobileButtons").Visible = u1.platform == "mobile";
		local v9 = p1:GetAttribute("CustomFrame");
		if v9 then
			u2 = v7:WaitForChild("MainFrame"):FindFirstChild("PromptFrame" .. v9) or v7:WaitForChild("MainFrame"):WaitForChild("PromptFrame");
			l__PromptFrame__3.Visible = false;
		else
			u2 = l__PromptFrame__3;
		end;
		u2.Holder.Key.Text = p1.KeyboardKeyCode.Name;
		u2.Bar.Bar.Size = UDim2.new(0, 0, 1, 0);
		u2.Bar.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.1, true);
		u2.CenterImage.Image = u4.getIcon(p1.ActionText);
		if p1.ActionText == "Collect" then
			task.delay(0.2, function()
				p1:InputHoldBegin();
			end);
		end;
		local v10 = UDim.new(0.925, 0);
		if u1.platform ~= "pc" then
			u2.Holder.Key.Visible = false;
			u2.UIScale.Scale = 1.5;
			if u1.platform == "console" then
				u2.Holder.KeyXbox.Image = u5[p1.GamepadKeyCode.Name];
				u2.Holder.KeyXbox.Visible = true;
			elseif u1.platform == "mobile" then
				u2.Holder.KeyXbox.Visible = false;
			end;
		else
			u2.Holder.Key.Visible = true;
			u2.Holder.KeyXbox.Visible = false;
		end;
		l__InteractButton__6.Icon.Image = u2.CenterImage.Image;
		local v11 = p1.Parent:GetAttribute("Price");
		if v11 then

		else
			v11 = p1:GetAttribute("Price");
		end;
		if v11 then
			u2.Holder.Price.Text = u7(v11);
			u2.Holder.Price.Visible = true;
			u2.Holder.PriceIcon.Visible = true;
		else
			u2.Holder.Price.Visible = false;
			u2.Holder.PriceIcon.Visible = false;
		end;
		local v12 = {
			BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		};
		if p2 == true then
			u2.BackgroundColor3 = Color3.new(0.776471, 0.729412, 0.376471);
			l__TweenService__8:Create(u2, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In), v12):Play();
		else
			u2.BackgroundColor3 = Color3.new(0.337255, 0.423529, 0.533333);
			l__TweenService__8:Create(u2, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), v12):Play();
		end;
		if 0 < p1.HoldDuration then
			u2.Bar.Visible = true;
		else
			u2.Bar.Visible = false;
		end;
		script.Holding:Stop();
		local l__CurrentCamera__13 = workspace.CurrentCamera;
		local v14 = l__CurrentCamera__13.CFrame.Position;
		local l__Parent__15 = p1.Parent;
		local v16 = false;
		u10 = tick();
		if l__Parent__15 then
			if not l__Parent__15:IsA("BasePart") then
				if l__Parent__15:IsA("Model") then
					v14 = l__Parent__15:GetPivot().Position;
					v16 = true;
				elseif l__Parent__15:IsA("Attachment") then
					v14 = l__Parent__15.WorldPosition;
				end;
			else
				v14 = l__Parent__15:GetPivot().Position;
				v16 = true;
			end;
			local v17 = p1:GetAttribute("ShowOutline") ~= false;
			l__Highlight__11.Adornee = l__Parent__15;
			l__Highlight__11.Enabled = v17;
			u2.Visible = true;
			u2.Position = UDim2.new(0.5, 0, 2, 0);
			l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				FillTransparency = 0.9, 
				OutlineTransparency = 0
			}):Play();
			local v18 = nil;
			local v19 = nil;
			if u1.platform == "mobile" then
				l__InteractButton__6.Visible = true;
				l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					BackgroundTransparency = 0.35
				}):Play();
				l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Transparency = 0
				}):Play();
				l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					ImageTransparency = 0
				}):Play();
				v18 = l__InteractButton__6.InputBegan:Connect(function()
					p1:InputHoldBegin();
				end);
				v19 = l__InteractButton__6.InputEnded:Connect(function()
					p1:InputHoldEnd();
				end);
			end;
			if not l__Parent__15:IsA("BasePart") then
				if not l__Parent__15:IsA("Model") then
					if l__Parent__15:IsA("Attachment") then
						local v20 = tick();
						local v21 = 1 - 1;
						while true do
							if p1 then

							else
								pcall(function()
									if v18 then
										if v19 then
											v18:Disconnect();
											v19:Disconnect();
										end;
									end;
								end);
								if u9 == nil then
									l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										FillTransparency = 1, 
										OutlineTransparency = 1
									}):Play();
									task.wait(0.2);
									if u9 == nil then
										if u10 == u10 then
											l__Highlight__11.Adornee = nil;
											l__Highlight__11.Enabled = false;
											u2.Visible = false;
											l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												BackgroundTransparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												Transparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												ImageTransparency = 1
											}):Play();
										end;
									end;
								elseif u2.Visible then
									u13 = v14;
								end;
								break;
							end;
							if u9 == u9 then

							else
								pcall(function()
									if v18 then
										if v19 then
											v18:Disconnect();
											v19:Disconnect();
										end;
									end;
								end);
								if u9 == nil then
									l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										FillTransparency = 1, 
										OutlineTransparency = 1
									}):Play();
									task.wait(0.2);
									if u9 == nil then
										if u10 == u10 then
											l__Highlight__11.Adornee = nil;
											l__Highlight__11.Enabled = false;
											u2.Visible = false;
											l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												BackgroundTransparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												Transparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												ImageTransparency = 1
											}):Play();
										end;
									end;
								elseif u2.Visible then
									u13 = v14;
								end;
								break;
							end;
							if u9 then

							else
								pcall(function()
									if v18 then
										if v19 then
											v18:Disconnect();
											v19:Disconnect();
										end;
									end;
								end);
								if u9 == nil then
									l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										FillTransparency = 1, 
										OutlineTransparency = 1
									}):Play();
									task.wait(0.2);
									if u9 == nil then
										if u10 == u10 then
											l__Highlight__11.Adornee = nil;
											l__Highlight__11.Enabled = false;
											u2.Visible = false;
											l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												BackgroundTransparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												Transparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												ImageTransparency = 1
											}):Play();
										end;
									end;
								elseif u2.Visible then
									u13 = v14;
								end;
								break;
							end;
							if u2.Visible then

							else
								pcall(function()
									if v18 then
										if v19 then
											v18:Disconnect();
											v19:Disconnect();
										end;
									end;
								end);
								if u9 == nil then
									l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										FillTransparency = 1, 
										OutlineTransparency = 1
									}):Play();
									task.wait(0.2);
									if u9 == nil then
										if u10 == u10 then
											l__Highlight__11.Adornee = nil;
											l__Highlight__11.Enabled = false;
											u2.Visible = false;
											l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												BackgroundTransparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												Transparency = 1
											}):Play();
											l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
												ImageTransparency = 1
											}):Play();
										end;
									end;
								elseif u2.Visible then
									u13 = v14;
								end;
								break;
							end;
							if v16 then
								local v22 = l__Parent__15:GetPivot().Position;
							else
								v22 = l__Parent__15.WorldPosition;
							end;
							u12 = v14;
							local v23, v24 = l__CurrentCamera__13:WorldToScreenPoint(v14 - Vector3.new(0, 0.2, 0));
							u2.Position = UDim2.new(0, math.clamp(v23.X, 80, v7.AbsoluteSize.X - 80), 0, math.clamp(v23.Y, 80, v7.AbsoluteSize.Y - 80));
							l__Highlight__11.Adornee = l__Parent__15;
							l__Highlight__11.Enabled = v17;
							task.wait();
							if 0 <= 1 then
								if v21 < 100000000 then

								else
									break;
								end;
							elseif 100000000 < v21 then

							else
								break;
							end;
							v21 = v21 + 1;						
						end;
					end;
				else
					v20 = tick();
					v21 = 1 - 1;
					while true do
						if p1 then

						else
							pcall(function()
								if v18 then
									if v19 then
										v18:Disconnect();
										v19:Disconnect();
									end;
								end;
							end);
							if u9 == nil then
								l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
									FillTransparency = 1, 
									OutlineTransparency = 1
								}):Play();
								task.wait(0.2);
								if u9 == nil then
									if u10 == u10 then
										l__Highlight__11.Adornee = nil;
										l__Highlight__11.Enabled = false;
										u2.Visible = false;
										l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											BackgroundTransparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											Transparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											ImageTransparency = 1
										}):Play();
									end;
								end;
							elseif u2.Visible then
								u13 = v14;
							end;
							break;
						end;
						if u9 == u9 then

						else
							pcall(function()
								if v18 then
									if v19 then
										v18:Disconnect();
										v19:Disconnect();
									end;
								end;
							end);
							if u9 == nil then
								l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
									FillTransparency = 1, 
									OutlineTransparency = 1
								}):Play();
								task.wait(0.2);
								if u9 == nil then
									if u10 == u10 then
										l__Highlight__11.Adornee = nil;
										l__Highlight__11.Enabled = false;
										u2.Visible = false;
										l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											BackgroundTransparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											Transparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											ImageTransparency = 1
										}):Play();
									end;
								end;
							elseif u2.Visible then
								u13 = v14;
							end;
							break;
						end;
						if u9 then

						else
							pcall(function()
								if v18 then
									if v19 then
										v18:Disconnect();
										v19:Disconnect();
									end;
								end;
							end);
							if u9 == nil then
								l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
									FillTransparency = 1, 
									OutlineTransparency = 1
								}):Play();
								task.wait(0.2);
								if u9 == nil then
									if u10 == u10 then
										l__Highlight__11.Adornee = nil;
										l__Highlight__11.Enabled = false;
										u2.Visible = false;
										l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											BackgroundTransparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											Transparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											ImageTransparency = 1
										}):Play();
									end;
								end;
							elseif u2.Visible then
								u13 = v14;
							end;
							break;
						end;
						if u2.Visible then

						else
							pcall(function()
								if v18 then
									if v19 then
										v18:Disconnect();
										v19:Disconnect();
									end;
								end;
							end);
							if u9 == nil then
								l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
									FillTransparency = 1, 
									OutlineTransparency = 1
								}):Play();
								task.wait(0.2);
								if u9 == nil then
									if u10 == u10 then
										l__Highlight__11.Adornee = nil;
										l__Highlight__11.Enabled = false;
										u2.Visible = false;
										l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											BackgroundTransparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											Transparency = 1
										}):Play();
										l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
											ImageTransparency = 1
										}):Play();
									end;
								end;
							elseif u2.Visible then
								u13 = v14;
							end;
							break;
						end;
						if v16 then
							v22 = l__Parent__15:GetPivot().Position;
						else
							v22 = l__Parent__15.WorldPosition;
						end;
						u12 = v14;
						v23, v24 = l__CurrentCamera__13:WorldToScreenPoint(v14 - Vector3.new(0, 0.2, 0));
						u2.Position = UDim2.new(0, math.clamp(v23.X, 80, v7.AbsoluteSize.X - 80), 0, math.clamp(v23.Y, 80, v7.AbsoluteSize.Y - 80));
						l__Highlight__11.Adornee = l__Parent__15;
						l__Highlight__11.Enabled = v17;
						task.wait();
						if 0 <= 1 then
							if v21 < 100000000 then

							else
								break;
							end;
						elseif 100000000 < v21 then

						else
							break;
						end;
						v21 = v21 + 1;					
					end;
				end;
			else
				v20 = tick();
				v21 = 1 - 1;
				while true do
					if p1 then

					else
						pcall(function()
							if v18 then
								if v19 then
									v18:Disconnect();
									v19:Disconnect();
								end;
							end;
						end);
						if u9 == nil then
							l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								FillTransparency = 1, 
								OutlineTransparency = 1
							}):Play();
							task.wait(0.2);
							if u9 == nil then
								if u10 == u10 then
									l__Highlight__11.Adornee = nil;
									l__Highlight__11.Enabled = false;
									u2.Visible = false;
									l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										BackgroundTransparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										Transparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										ImageTransparency = 1
									}):Play();
								end;
							end;
						elseif u2.Visible then
							u13 = v14;
						end;
						break;
					end;
					if u9 == u9 then

					else
						pcall(function()
							if v18 then
								if v19 then
									v18:Disconnect();
									v19:Disconnect();
								end;
							end;
						end);
						if u9 == nil then
							l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								FillTransparency = 1, 
								OutlineTransparency = 1
							}):Play();
							task.wait(0.2);
							if u9 == nil then
								if u10 == u10 then
									l__Highlight__11.Adornee = nil;
									l__Highlight__11.Enabled = false;
									u2.Visible = false;
									l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										BackgroundTransparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										Transparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										ImageTransparency = 1
									}):Play();
								end;
							end;
						elseif u2.Visible then
							u13 = v14;
						end;
						break;
					end;
					if u9 then

					else
						pcall(function()
							if v18 then
								if v19 then
									v18:Disconnect();
									v19:Disconnect();
								end;
							end;
						end);
						if u9 == nil then
							l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								FillTransparency = 1, 
								OutlineTransparency = 1
							}):Play();
							task.wait(0.2);
							if u9 == nil then
								if u10 == u10 then
									l__Highlight__11.Adornee = nil;
									l__Highlight__11.Enabled = false;
									u2.Visible = false;
									l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										BackgroundTransparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										Transparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										ImageTransparency = 1
									}):Play();
								end;
							end;
						elseif u2.Visible then
							u13 = v14;
						end;
						break;
					end;
					if u2.Visible then

					else
						pcall(function()
							if v18 then
								if v19 then
									v18:Disconnect();
									v19:Disconnect();
								end;
							end;
						end);
						if u9 == nil then
							l__TweenService__8:Create(l__Highlight__11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
								FillTransparency = 1, 
								OutlineTransparency = 1
							}):Play();
							task.wait(0.2);
							if u9 == nil then
								if u10 == u10 then
									l__Highlight__11.Adornee = nil;
									l__Highlight__11.Enabled = false;
									u2.Visible = false;
									l__TweenService__8:Create(l__InteractButton__6, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										BackgroundTransparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										Transparency = 1
									}):Play();
									l__TweenService__8:Create(l__InteractButton__6.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
										ImageTransparency = 1
									}):Play();
								end;
							end;
						elseif u2.Visible then
							u13 = v14;
						end;
						break;
					end;
					if v16 then
						v22 = l__Parent__15:GetPivot().Position;
					else
						v22 = l__Parent__15.WorldPosition;
					end;
					u12 = v14;
					v23, v24 = l__CurrentCamera__13:WorldToScreenPoint(v14 - Vector3.new(0, 0.2, 0));
					u2.Position = UDim2.new(0, math.clamp(v23.X, 80, v7.AbsoluteSize.X - 80), 0, math.clamp(v23.Y, 80, v7.AbsoluteSize.Y - 80));
					l__Highlight__11.Adornee = l__Parent__15;
					l__Highlight__11.Enabled = v17;
					task.wait();
					if 0 <= 1 then
						if v21 < 100000000 then

						else
							break;
						end;
					elseif 100000000 < v21 then

					else
						break;
					end;
					v21 = v21 + 1;				
				end;
			end;
		end;
	end);
end;
local u14 = 0;
l__ProximityPromptService__4.PromptShown:Connect(function(p3)
	if p3.ObjectText ~= "Hint" then
		u9 = p3.Changed:Connect(function()
			update(p3);
		end);
		u14 = u14 + 1;
		update(p3);
		script.Notification:Play();
	end;
end);
l__ProximityPromptService__4.PromptHidden:Connect(function(p4)
	if p4.ObjectText ~= "Hint" then
		u2.Bar.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.1, true);
		u2.Visible = false;
		pcall(function()
			u9:Disconnect();
		end);
		u9 = nil;
		u14 = u14 - 1;
	end;
end);
l__ProximityPromptService__4.PromptTriggered:Connect(function(p5)
	if p5.ObjectText ~= "Hint" then
		update(p5, true);
		u2.Bar.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.1, true);
		script.Triggered:Play();
		script.Holding:Stop();
		u2.CenterImage.Position = UDim2.new(0.5, 0, 0.52, 0);
		l__TweenService__8:Create(u2.CenterImage, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ImageTransparency = 0
		}):Play();
	end;
end);
local u15 = nil;
l__ProximityPromptService__4.PromptButtonHoldBegan:Connect(function(p6)
	if p6.ObjectText ~= "Hint" then
		update(p6);
		u2.Bar.Bar:TweenSize(UDim2.new(1, 0, 1, 0), "In", "Linear", p6.HoldDuration, true);
		script.Holding:Play();
		l__TweenService__8:Create(u2.CenterImage, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.52, 0), 
			ImageTransparency = 0
		}):Play();
		if p6.Name == "RiftPrompt" then
			u15 = u1.camShaker:ShakeOnce(2, 8, p6.HoldDuration, 0);
			local l__ParticlesIn__25 = p6.Parent.Parent:FindFirstChild("ParticlesIn", true);
			if l__ParticlesIn__25 then
				for v26, v27 in pairs(l__ParticlesIn__25:GetChildren()) do
					if v27:IsA("ParticleEmitter") then
						l__TweenService__8:Create(v27, TweenInfo.new(p6.HoldDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
							TimeScale = 1
						}):Play();
					end;
				end;
			end;
		end;
	end;
end);
l__ProximityPromptService__4.PromptButtonHoldEnded:Connect(function(p7)
	if p7.ObjectText ~= "Hint" then
		update(p7);
		script.Holding:Stop();
		l__TweenService__8:Create(u2.CenterImage, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5, 0, 0.5, 0), 
			ImageTransparency = 0
		}):Play();
		pcall(function()
			if u15 then
				u15:StartFadeOut(0.1);
				u15 = nil;
				local l__ParticlesIn__28 = p7.Parent.Parent:FindFirstChild("ParticlesIn", true);
				if l__ParticlesIn__28 then
					for v29, v30 in pairs(l__ParticlesIn__28:GetChildren()) do
						if v30:IsA("ParticleEmitter") then
							l__TweenService__8:Create(v30, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								TimeScale = 0.1
							}):Play();
						end;
					end;
				end;
			end;
		end);
	end;
end);
