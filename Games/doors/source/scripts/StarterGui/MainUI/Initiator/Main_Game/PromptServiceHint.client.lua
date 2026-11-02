local v1 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v2 = game["Run Service"];
local l__UserInputService__3 = game:GetService("UserInputService");
local l__TweenService__4 = game:GetService("TweenService");
local l__ProximityPromptService__5 = game:GetService("ProximityPromptService");
local v6 = script:FindFirstAncestor("MainUI");
local l__Highlight__7 = script:WaitForChild("Highlight");
local u1 = require(script.Parent);
local l__HintFrame__2 = v6:WaitForChild("MainFrame"):WaitForChild("HintFrame");
local l__TextService__3 = game:GetService("TextService");
local u4 = require(script:WaitForChild("MouseIcons"));
local u5 = require(script:WaitForChild("Hint"));
local u6 = require(script:WaitForChild("HintConsole"));
local u7 = nil;
function update(p1, p2)
	task.spawn(function()
		if u1.controller == "mobile" then
			return;
		end;
		if p1.ObjectText == "Hint" then
			local v8 = l__HintFrame__2:Clone();
			v8.Parent = l__HintFrame__2.Parent;
			v8.Title.Text = p1.ObjectText;
			v8.Desc.Text = p1.ActionText;
			v8.Key.Text = p1.KeyboardKeyCode.Name;
			v8.Bar.Bar.Size = UDim2.new(0, 0, 1, 0);
			v8.Bar.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.1, true);
			local v9 = UDim.new(0.85, -10);
			local v10 = l__TextService__3:GetTextSize(v8.Desc.ContentText, v8.Desc.AbsoluteSize.Y, Enum.Font.GothamBold, v8.Desc.AbsoluteSize);
			local l__X__11 = v8.Key.AbsoluteSize.X;
			v8.CenterImage.Image = u4.getIcon(p1.ObjectText);
			if p1.KeyboardKeyCode.Name == "RightMeta" then
				if u5[p1.ActionText] == nil then
					v8.Title.Visible = false;
					v8.Back.Size = UDim2.new(0.05, math.max(v8.Desc.TextBounds.X + l__X__11, v8.Title.TextBounds.X), 0.1, 0);
					v8.Key.Text = " ";
					v8.Key.Position = UDim2.new(0.5, -(v10.X / 2) + l__X__11 / 4, v9.Scale, v9.Offset);
					v8.Desc.Position = UDim2.new(0.5, 0, v9.Scale, v9.Offset);
					v8.Key.Visible = false;
				else
					v8.Title.Visible = false;
					v8.Key.Text = u5[p1.ActionText];
					v8.Key.Visible = true;
				end;
			else
				v8.Title.Visible = false;
				v8.Key.Text = u5[p1.ActionText];
				v8.Key.Visible = true;
			end;
			if u1.controller == "console" then
				v8.Key.Visible = false;
				v8.KeyXbox.Image = u6[p1.ActionText];
				v8.KeyXbox.Size = v8.Key.Size;
				v8.KeyXbox.Position = v8.Key.Position;
				v8.KeyXbox.Visible = true;
			else
				v8.KeyXbox.Visible = false;
			end;
			({}).BackgroundColor3 = Color3.fromRGB(0, 0, 0);
			if 0 < p1.HoldDuration then
				v8.Bar.Visible = true;
			else
				v8.Bar.Visible = false;
			end;
			script.Holding:Stop();
			local l__CurrentCamera__12 = workspace.CurrentCamera;
			local l__Position__13 = l__CurrentCamera__12.CFrame.Position;
			local l__Parent__14 = p1.Parent;
			local v15 = false;
			if l__Parent__14 then
				if not l__Parent__14:IsA("BasePart") then
					if l__Parent__14:IsA("Model") then
						local l__Position__16 = l__Parent__14:GetPivot().Position;
						v15 = true;
					elseif l__Parent__14:IsA("Attachment") then
						local l__WorldPosition__17 = l__Parent__14.WorldPosition;
					end;
				else
					l__Position__16 = l__Parent__14:GetPivot().Position;
					v15 = true;
				end;
				v8.Visible = true;
				v8.Position = UDim2.new(0.5, 0, 0.5, 0);
				if not l__Parent__14:IsA("BasePart") then
					if not l__Parent__14:IsA("Model") then
						if l__Parent__14:IsA("Attachment") then
							local v18 = 1 - 1;
							while true do
								if p1 then

								else
									v8.Visible = false;
									break;
								end;
								if u7 == u7 then

								else
									v8.Visible = false;
									break;
								end;
								if u7 then

								else
									v8.Visible = false;
									break;
								end;
								if u7.Connected then

								else
									v8.Visible = false;
									break;
								end;
								if v15 then
									local v19 = l__Parent__14:GetPivot().Position;
								else
									v19 = l__Parent__14.WorldPosition;
								end;
								local v20, v21 = l__CurrentCamera__12:WorldToScreenPoint(v19 - Vector3.new(0, 0.2, 0));
								if v21 then
									v8.Visible = true;
									v8.Position = UDim2.new(0, math.clamp(v20.X, 80, v6.AbsoluteSize.X - 80), 0, math.clamp(v20.Y, 80, v6.AbsoluteSize.Y - 80));
								else
									v8.Visible = false;
								end;
								task.wait();
								if 0 <= 1 then
									if v18 < 100000000 then

									else
										break;
									end;
								elseif 100000000 < v18 then

								else
									break;
								end;
								v18 = v18 + 1;							
							end;
						end;
					else
						v18 = 1 - 1;
						while true do
							if p1 then

							else
								v8.Visible = false;
								break;
							end;
							if u7 == u7 then

							else
								v8.Visible = false;
								break;
							end;
							if u7 then

							else
								v8.Visible = false;
								break;
							end;
							if u7.Connected then

							else
								v8.Visible = false;
								break;
							end;
							if v15 then
								v19 = l__Parent__14:GetPivot().Position;
							else
								v19 = l__Parent__14.WorldPosition;
							end;
							v20, v21 = l__CurrentCamera__12:WorldToScreenPoint(v19 - Vector3.new(0, 0.2, 0));
							if v21 then
								v8.Visible = true;
								v8.Position = UDim2.new(0, math.clamp(v20.X, 80, v6.AbsoluteSize.X - 80), 0, math.clamp(v20.Y, 80, v6.AbsoluteSize.Y - 80));
							else
								v8.Visible = false;
							end;
							task.wait();
							if 0 <= 1 then
								if v18 < 100000000 then

								else
									break;
								end;
							elseif 100000000 < v18 then

							else
								break;
							end;
							v18 = v18 + 1;						
						end;
					end;
				else
					v18 = 1 - 1;
					while true do
						if p1 then

						else
							v8.Visible = false;
							break;
						end;
						if u7 == u7 then

						else
							v8.Visible = false;
							break;
						end;
						if u7 then

						else
							v8.Visible = false;
							break;
						end;
						if u7.Connected then

						else
							v8.Visible = false;
							break;
						end;
						if v15 then
							v19 = l__Parent__14:GetPivot().Position;
						else
							v19 = l__Parent__14.WorldPosition;
						end;
						v20, v21 = l__CurrentCamera__12:WorldToScreenPoint(v19 - Vector3.new(0, 0.2, 0));
						if v21 then
							v8.Visible = true;
							v8.Position = UDim2.new(0, math.clamp(v20.X, 80, v6.AbsoluteSize.X - 80), 0, math.clamp(v20.Y, 80, v6.AbsoluteSize.Y - 80));
						else
							v8.Visible = false;
						end;
						task.wait();
						if 0 <= 1 then
							if v18 < 100000000 then

							else
								break;
							end;
						elseif 100000000 < v18 then

						else
							break;
						end;
						v18 = v18 + 1;					
					end;
				end;
			end;
			v8.Visible = false;
			v8:Destroy();
		end;
	end);
end;
l__ProximityPromptService__5.PromptShown:Connect(function(p3)
	if p3.ObjectText == "Hint" then
		u7 = p3.Changed:Connect(function()
			update(p3);
		end);
		update(p3);
	end;
end);
l__ProximityPromptService__5.PromptHidden:Connect(function(p4)
	if p4.ObjectText == "Hint" then
		pcall(function()
			u7:Disconnect();
		end);
	end;
end);
l__ProximityPromptService__5.PromptTriggered:Connect(function(p5)
	if p5.ObjectText == "Hint" then
		update(p5, true);
	end;
end);
l__ProximityPromptService__5.PromptButtonHoldBegan:Connect(function(p6)
	if p6.ObjectText == "Hint" then
		update(p6);
	end;
end);
l__ProximityPromptService__5.PromptButtonHoldEnded:Connect(function(p7)
	if p7.ObjectText == "Hint" then
		update(p7);
	end;
end);
